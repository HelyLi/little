#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import os
import re
import shutil
import json


def main():
    config = getCfgInfo()
    etKey = config["etKey"]
    pngPath = os.path.abspath(config["pngPath"])
    outPath = os.path.abspath(config["outPath"])

    deleteCCZ(pngPath)
    deleteCCZ(outPath)
    createCZZ(pngPath, etKey)
    copyCCZ(pngPath, outPath)


def deleteCCZ(curPath):

    for root, _, filenames in os.walk(curPath):
        if root.find(".svn") == -1:
            for filename in filenames:
                if filename.endswith(".plist")or filename.endswith(".tps") or filename.endswith(".ccz"):
                    os.remove(os.path.join(root, filename))


def createCZZ(curPath, etKey):

    for root, subfolders, _ in os.walk(curPath):
        if root.find(".svn") == -1 :
            for subfolder in subfolders:
                # print(root)
                if subfolder.find("BigRes") >= 0:
                    continue
                if os.path.exists(root):
                    os.chdir(os.path.join(root, subfolder))
                # print(os.getcwd())
                command = "TexturePacker --sheet {0}.pvr.ccz --texture-format pvr3ccz --format cocos2d-x --data {0}.plist --opt RGBA8888 --alpha-handling PremultiplyAlpha --content-protection {1} --algorithm MaxRects --size-constraints AnySize .".format(
                    subfolder, etKey)
                print(command)
                os.system(command)


def copyCCZ(curPath, outPath):
    print('''---copy ccz to outPath''')
    for root, subfolders, filenames in os.walk(curPath):
        if root.find(".svn") == -1:
            for filename in filenames:
                if filename.endswith(".plist"):
                    print("\"{0}\",".format(os.path.splitext(filename)[0]))
                if filename.endswith(".plist") or filename.endswith(".ccz"):
                    shutil.copy(os.path.join(root, filename), outPath)
        # if root.find("BigRes") != -1 :
            for subfolder in subfolders:
                if subfolder.find("BigRes") >= 0:
                    if os.path.exists(os.path.join(outPath, subfolder)):
                        shutil.rmtree(os.path.join(outPath, subfolder))
                    shutil.copytree(os.path.join(root, subfolder), os.path.join(outPath, subfolder))
                #     continue
                # for filename in filenames:
                #     print(os.path.join(root, filename))

def getCfgInfo():
    '''get config data'''
    config_file = open("./create_sheets_cfg.json", "r")
    json_data = json.load(config_file)
    config_file.close()

    return json_data


if __name__ == '__main__':
    main()
