from pathlib import Path
import os
from flask import Flask, jsonify, send_from_directory, abort
from werkzeug.utils import safe_join  # <-- add this

app = Flask(__name__)

BASE = Path(__file__).resolve().parent
DATA_ROOT = (BASE / "data").resolve()

@app.route("/")
def home():
    return jsonify({"ok": True, "site": "SmartFlowSite"})

# REPLACE your existing /data route with this:
@app.route("/data/<path:fname>")
def data_files(fname: str):
    """
    Safely serve files from DATA_ROOT only:
    - Use werkzeug.utils.safe_join to block traversal
    - Restrict to allowed extensions
    - Serve via send_from_directory
    """
    try:
        safe_path = safe_join(DATA_ROOT.as_posix(), fname)  # returns normalized path or None
    except Exception:
        abort(400)  # bad input

    if not safe_path:
        abort(403)  # attempted traversal outside DATA_ROOT

    candidate = Path(safe_path)

    allowed_ext = {
        ".json", ".csv", ".txt", ".md",
        ".png", ".jpg", ".jpeg", ".gif", ".webp",
        ".pdf"
    }
    if candidate.suffix.lower() not in allowed_ext:
        abort(415)

    if not candidate.exists() or not candidate.is_file():
        abort(404)

    rel = candidate.relative_to(DATA_ROOT)
    return send_from_directory(
        DATA_ROOT.as_posix(),
        rel.as_posix(),
        as_attachment=False,
        etag=True,
        conditional=True,
        max_age=0,
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
