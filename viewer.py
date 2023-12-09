import os
import sys

import lxml.etree as ET
import webview


def resource(path):
    if hasattr(sys, "_MEIPASS"):
        return os.path.join(sys._MEIPASS, path)

    else:
        return os.path.abspath(path)


xslt = ET.parse(resource("basic.xsl"))
transformed = ET.XSLT(xslt)(ET.parse(sys.argv[1]))

with open(resource("style.css")) as fp:
    transformed.getroot().xpath("/html/head/style")[0].text = fp.read()

generated = ET.tostring(transformed, pretty_print=True).decode("utf-8")
webview.create_window("Character Sheet", html=generated)
webview.start()
