import json
import pathlib
import shutil
import sys

import lxml.etree
import webview


def resource(path):
    # resolve resource paths
    return (
        pathlib.Path(sys._MEIPASS) / path
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


def load_sheet(file, *css):
    # load xslt stylesheet
    xslt = lxml.etree.parse(resource("pages/style.xsl").absolute())
    transformed = lxml.etree.XSLT(xslt)(lxml.etree.parse(file))
    transformed.xpath("/html/head")[0].extend(css)
    return lxml.etree.tostring(transformed).decode()


def load():
    css = []
    with resource("pages/base.css").open() as fp:
        elem = lxml.etree.Element("style")
        elem.text = fp.read()
        css.append(elem)

    if theme.exists():
        with theme.open() as fp:
            elem = lxml.etree.Element("style")
            elem.text = fp.read()
            css.append(elem)

    try:
        g = load_sheet(sys.argv[1], *css)
        window.load_html(g)

    except IndexError:
        home = lxml.etree.parse(resource("pages/home.html").absolute())
        home.xpath("/html/head")[0].extend(css)
        window.load_html(lxml.etree.tostring(home).decode())


if __name__ == "__main__":
    # ensure paths exist
    config_dir = pathlib.Path("~/.characters").expanduser()
    config_dir.mkdir(exist_ok=True)
    config_file = config_dir / "config.json"

    if not config_file.exists():
        write_default()

    # read config
    with config_file.open() as fp:
        config = json.load(fp)
        theme = config_dir / pathlib.Path(config["theme"])

    # create window
    window = webview.create_window("Character Sheet Viewer")

    webview.start(load)
