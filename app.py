"""Nowhere: web observer + MCP over HTTP, merged on one port."""
import os, sys
import uvicorn

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from nowhere.server import mcp
from nowhere.web import app as web_app

# MCP streamable-http at /mcp
mcp_http = mcp.http_app(path="/mcp", transport="streamable-http")

# REST routes first, then MCP routes (/open_door etc. stay alive)
mcp_http.router.routes = list(web_app.routes) + list(mcp_http.router.routes)

port = int(os.environ.get("PORT", "8080"))
uvicorn.run(mcp_http, host="0.0.0.0", port=port, log_level="info")
