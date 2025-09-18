
#!/usr/bin/env bash
set -euo pipefail
FILE="${1:-SFS-Gareth-Mode.txt}"
[ -f "$FILE" ] || echo "# SmartFlow – Gareth Mode" > "$FILE"

# Prefer $EDITOR; then common editors; fallback: print path.
if [ -n "${EDITOR:-}" ] && command -v "${EDITOR%% *}" >/dev/null 2>&1; then exec $EDITOR "$FILE"
elif command -v code >/dev/null 2>&1;   then exec code -r "$FILE"
elif command -v micro >/dev/null 2>&1;  then exec micro "$FILE"
elif command -v vim >/dev/null 2>&1;    then exec vim "$FILE"
elif command -v nano >/dev/null 2>&1;   then exec nano "$FILE"
else echo "No CLI editor found. Open in IDE: $(pwd)/$FILE"; fi
