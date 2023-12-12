import json
import os
import sys

import lxml.etree
import webview


def resource(path):
    if hasattr(sys, "_MEIPASS"):
        return os.path.join(sys._MEIPASS, path)

    else:
        return os.path.abspath(path)


config_dir = os.path.expanduser("~/.characters")
if not os.path.exists(config_dir):
    os.mkdir(config_dir)

if not os.path.exists(f"{config_dir}/config.json"):
    theme = "themes/light.xsl"
    with open(f"{config_dir}/config.json", "w+") as config_file:
        json.dump(
            {
                "default_theme": theme,
            },
            config_file,
        )

else:
    with open(f"{config_dir}/config.json", "r") as config_file:
        config = json.load(config_file)
        theme = config["default_theme"]


xslt = lxml.etree.parse(resource("style.xsl"))
if os.path.exists(theme):
    imp = lxml.etree.Element(
        "{http://www.w3.org/1999/XSL/Transform}import", {"href": theme}
    )
    xslt.getroot().insert(1, imp)

transformed = lxml.etree.XSLT(xslt)(lxml.etree.parse(sys.argv[1]))
generated = lxml.etree.tostring(transformed, pretty_print=True).decode()

webview.create_window("Character Sheet", html=generated)
webview.start()
