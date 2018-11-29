#!/usr/bin/env python
# -*- coding:UTF-8 -*-

from optparse import OptionParser
import kubernetes
  
def parse_opts(parser):
    parser.add_option("-p","--pod",action="store",type="string",dest="pod",default="",help="the pod to watch")
    parser.add_option("-n","--namespace",action="store",type="string",dest="namespace",default="default",help="the namespace of the pod")
    parser.add_option("-m","--msg",action="store",type="string",dest="msg",default="",help="the msg to watch")
    (options,args) = parser.parse_args()
    return options
options = parse_opts(OptionParser(usage="%prog [options]"))
          
def main():
    kubernetes.config.load_kube_config()
    api_instance = kubernetes.client.CoreV1Api()
    name = options.pod
    namespace = options.namespace
    msg = options.msg
    try:
        api_response = api_instance.read_namespaced_pod_log(name,namespace)
        if msg in api_response:
            print(api_response)
            body = kubernetes.client.V1DeleteOptions()
            api_response = api_instance.delete_namespaced_pod(name,namespace,body)
    except kubernetes.client.rest.ApiException as e:
        print("Exception when calling CoreV1Api->read_namespaced_pod_log: %s\n" % e)
        
if __name__ == "__main__":
    main()
