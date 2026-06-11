#!/usr/bin/env python3
import subprocess, json, os
from http.server import HTTPServer, BaseHTTPRequestHandler

SESSIONS = {1: 6081, 2: 6082, 3: 6083}

def is_busy(port):
    result = subprocess.run(['ss', '-tnp'], capture_output=True, text=True)
    connections = [l for l in result.stdout.splitlines()
                   if str(port) in l and 'ESTAB' in l]
    return len(connections) > 1

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path.startswith('/status'):
            status = {i: is_busy(p) for i, p in SESSIONS.items()}
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps(status).encode())
        else:
            portal = '/usr/share/novnc/portal.html'
            if os.path.exists(portal):
                self.send_response(200)
                self.send_header('Content-Type', 'text/html')
                self.end_headers()
                self.wfile.write(open(portal, 'rb').read())
            else:
                self.send_response(404)
                self.end_headers()
    def log_message(self, *args): pass

HTTPServer(('0.0.0.0', 8765), Handler).serve_forever()