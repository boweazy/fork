#!/usr/bin/env bash
set -euo pipefail

# 1) Clean deps (OVERWRITE)
cat > requirements.txt <<'EOF'
Flask~=3.0
flask-cors~=4.0
gunicorn~=21.2
EOF

# 2) Make Run button install deps then start app (OVERWRITE)
if [ -f .replit ]; then cp .replit .replit.bak || true; fi
cat > .replit <<'EOF'
run = "pip install -r requirements.txt && python3 app.py"
EOF

# 3) Install & verify versions
pip install -r requirements.txt
python - <<'PY'
import flask, flask_cors
print("Flask OK:", flask.__version__)
print("Flask-CORS OK:", flask_cors.__version__)
PY

echo "Now click Run (Console) and then test /health."
