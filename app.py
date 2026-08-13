'Zeabur entrypoint: run Nowhere in web-only (HTTP API) mode.
"""
import runpy
import sys

if __name__ == "__main__":
    sys.argv = ["nowhere.server", "--web-only", "8080"]
    runpy.run_module("nowhere.server", run_name="__main__")
