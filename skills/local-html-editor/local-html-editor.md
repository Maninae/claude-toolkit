# Local HTML Editor

A pattern for adding in-browser contenteditable editing to static HTML websites during local development. Safe for production: only activates on localhost.

## Architecture

Two components:

1. **Client-side editor script** (`dev-editor.js`) — injected into HTML pages via `<script>` tag
2. **Save server** (`dev-server.py`) — tiny Python HTTP server that writes edits back to disk

## Gotchas (learned the hard way)

1. **Backslashes in HTML crash regex replacement.** KaTeX math like `\varepsilon`, `\text{}` gets interpreted as regex backreferences if you use `re.sub(r'\1...\2', ...)`. Always use a **function replacement** instead of a string replacement:
   ```python
   # BAD — crashes on backslashes in new_html
   updated = pattern.sub(rf"\1\n{new_html}\n\3", original)

   # GOOD — function replacement, backslash-safe
   def replacer(m):
       return m.group(1) + "\n" + new_html + "\n" + m.group(3)
   updated = pattern.sub(replacer, original, count=1)
   ```

2. **Path prefix mismatch.** If you serve from the repo root (e.g. `python3 -m http.server 8080`), the browser sends `pathname = /site/lectures/lecture09.html`, but the save server's `SITE_ROOT` is already `site/`. Strip the prefix:
   ```python
   page_path = re.sub(r"^/?site/", "", page_path)
   ```

3. **Don't strip the leading `/` before the prefix regex.** `page_path.lstrip("/")` followed by `re.sub(r"^/site/", ...)` won't match because the slash is already gone. Use `r"^/?site/"` to handle both cases.

## Client Script Pattern

```javascript
// dev-editor.js — only activates on localhost
(function() {
  const host = window.location.hostname;
  if (host !== 'localhost' && host !== '127.0.0.1' && host !== '0.0.0.0') return;

  const SAVE_URL = 'http://localhost:8081/save';
  const EDITABLE_SELECTORS = 'article p, article li, article h2, article h3, article h4, .callout, .callout-label';

  // Create floating Edit/Save toggle button (fixed, bottom-right)
  const btn = document.createElement('button');
  btn.textContent = 'Edit';
  Object.assign(btn.style, {
    position: 'fixed', bottom: '24px', right: '24px',
    zIndex: '9999', padding: '10px 20px',
    borderRadius: '8px', border: 'none', cursor: 'pointer',
    fontFamily: 'monospace', fontSize: '13px', fontWeight: '600',
    background: '#2dd4bf', color: '#0f172a'
  });
  document.body.appendChild(btn);

  let editing = false;

  btn.addEventListener('click', async () => {
    if (!editing) {
      // Enter edit mode
      document.querySelectorAll(EDITABLE_SELECTORS).forEach(el => {
        el.contentEditable = 'true';
        el.style.outline = '1px dashed rgba(96, 165, 250, 0.45)';
      });
      btn.textContent = 'Save';
      btn.style.background = '#f97316';
      editing = true;
    } else {
      // Save: POST article innerHTML to save server
      const article = document.querySelector('article');
      try {
        const res = await fetch(SAVE_URL, {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({ path: window.location.pathname, html: article.innerHTML })
        });
        if (res.ok) {
          btn.textContent = 'Saved!';
          btn.style.background = '#4ade80';
          setTimeout(() => { btn.textContent = 'Edit'; btn.style.background = '#2dd4bf'; }, 1500);
        } else {
          throw new Error(`Server returned ${res.status}`);
        }
      } catch (e) {
        btn.textContent = 'Error: ' + e.message;
        btn.style.background = '#ef4444';
        setTimeout(() => { btn.textContent = 'Edit'; btn.style.background = '#2dd4bf'; }, 2000);
      }
      // Exit edit mode
      document.querySelectorAll(EDITABLE_SELECTORS).forEach(el => {
        el.contentEditable = 'false';
        el.style.outline = '';
      });
      editing = false;
    }
  });
})();
```

## Save Server Pattern

```python
#!/usr/bin/env python3
"""Local save server for contenteditable HTML editing. Run alongside your file server."""
import json, re, shutil
from http.server import HTTPServer, BaseHTTPRequestHandler
from pathlib import Path

SITE_ROOT = Path(__file__).resolve().parent.parent  # adjust to your site root

class SaveHandler(BaseHTTPRequestHandler):
    def do_OPTIONS(self):
        self.send_response(204)
        self._cors()
        self.end_headers()

    def do_POST(self):
        if self.path != '/save':
            self.send_error(404)
            return

        body = json.loads(self.rfile.read(int(self.headers['Content-Length'])))
        page_path = re.sub(r"^/?site/", "", body['path'])  # strip site/ prefix
        file_path = (SITE_ROOT / page_path.lstrip('/')).resolve()

        # Safety: must be under SITE_ROOT
        if not str(file_path).startswith(str(SITE_ROOT)):
            self.send_error(403, 'Path traversal blocked')
            return

        if not file_path.exists():
            self.send_error(404, f'File not found: {file_path}')
            return

        # Backup original
        shutil.copy2(file_path, str(file_path) + '.bak')

        # Replace article content — use function replacement (backslash-safe)
        original = file_path.read_text('utf-8')
        pattern = re.compile(r'(<article[^>]*>)(.*?)(</article>)', re.DOTALL)

        if not pattern.search(original):
            self.send_error(400, 'No <article> tag found')
            return

        new_html = body['html']
        def replacer(m):
            return m.group(1) + "\n" + new_html + "\n" + m.group(3)
        updated = pattern.sub(replacer, original, count=1)

        file_path.write_text(updated, 'utf-8')
        self.send_response(200)
        self._cors()
        self.end_headers()
        self.wfile.write(b'OK')
        print(f'  Saved {file_path.name} ({len(new_html)} chars)')

    def _cors(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')

if __name__ == '__main__':
    server = HTTPServer(('localhost', 8081), SaveHandler)
    print(f'Save server on http://localhost:8081  (site root: {SITE_ROOT})')
    server.serve_forever()
```

## Setup Steps

1. Add the client script to your HTML pages: `<script src="path/to/dev-editor.js"></script>` before `</body>`
2. Start the save server: `python3 dev-server.py`
3. Serve the site: `python3 -m http.server 8080` from the repo root (or any local server)
4. Open the page in browser — "Edit" button appears on localhost only

## How It Works

- **Edit button** toggles `contenteditable` on prose elements (p, li, headings, callouts)
- Editable elements get a subtle blue dashed outline
- **Save** POSTs the full `article.innerHTML` to the save server
- Server backs up original (`.html.bak`), replaces content between `<article>` tags using function-based regex replacement
- Only works on localhost — the hostname check in JS means the button never renders in production

## Customization

- **EDITABLE_SELECTORS**: Adjust which elements become editable
- **SAVE_URL port**: Change 8081 if needed
- **SITE_ROOT**: Point the server at your site directory
- **Path prefix stripping**: Adjust the `re.sub(r"^/?site/", ...)` to match your URL structure
- **Backup strategy**: Currently `.bak` overwrite; change to timestamped if needed
- **Container element**: Uses `<article>` tags; adapt regex for different container elements
