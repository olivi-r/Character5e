import json
import pathlib
import shutil
import sys

import lxml.etree
import webview


def resource(path):
    # resolve resource paths
    return (
        sys._MEIPASS / path
        if hasattr(sys, "_MEIPASS")
        else pathlib.Path(__file__).parent / path
    )


def write_default():
    # copy default themes
    shutil.copytree(
        pathlib.Path(__file__).parent / "bundled",
        config_dir,
        dirs_exist_ok=True,
    )


# ensure paths exist
config_dir = pathlib.Path("~/.characters").expanduser()
config_dir.mkdir(exist_ok=True)
config_file = config_dir / "config.json"

if not config_file.exists():
    write_default()

# read config
with config_file.open() as fp:
    config = json.load(fp)
    theme = config_dir / pathlib.Path(config["default_theme"])


xslt = lxml.etree.parse(resource("style.xsl").absolute())

# load theme
theme /= "theme.xsl"
if theme.exists():
    imp = lxml.etree.Element(
        "{http://www.w3.org/1999/XSL/Transform}import",
        {"href": theme.absolute().as_uri()},
    )
    xslt.getroot().insert(1, imp)

transformed = lxml.etree.XSLT(xslt)(lxml.etree.parse(sys.argv[1]))

# remove corrupted theme empty style tag otherwise wont render
for style in transformed.xpath("//style[not(text())]"):
    style.getparent().remove(style)

generated = lxml.etree.tostring(transformed, pretty_print=True).decode()
webview.create_window("Character Sheet", html=generated)
webview.start()
