#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import os
import json

# {
#     "quickPath":"/Users/triangle/Workspace/Quick-Cocos2dx-Community",
#     "projPath":"../mj",
#     "srcPath" : "../mj/src",
#     "etKey" : "f008e930d39c521e"
# }

def main():
    config = getCfgInfo()
    quickPath = os.path.abspath(config["quickPath"])
    projPath = os.path.abspath(config["projPath"])
    srcPath = os.path.abspath(config["srcPath"])
    etKey = config["etKey"]

    # os.system("{0}/quick/bin/PackageScripts.py -p {1} -b {2}".format(quickPath,projPath,32))
    # os.system("{0}/quick/bin/PackageScripts.py -p {1} -b {2}".format(quickPath,projPath,64))

def getCfgInfo():
    '''get config data'''
    config_file = open("./compile_src.json", "r")
    json_data = json.load(config_file)
    config_file.close()

    return json_data


if __name__ == '__main__':
    main()