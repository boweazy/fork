# SmartFlow Systems — Agent Handoff Pack
_Last updated: 2025-09-19 18:52 UTC_

## 0) Who/What
- **Owner:** Gareth (SmartFlow Systems / SmartFlowSite et al.)
- **Mission:** Build a lean multi‑repo SaaS stack (e‑com, bots, VPN/security, marketing automation), ship fast with CI + Replit, keep brand + pricing consistent.
- **Differentiator:** AI bots for social media engagement/automation tailored to small service businesses.

## 1) Brand & Pricing
- **Palette:** Black `#0D0D0D`, Brown `#3B2F2F`, Gold `#FFD700` (hover `#E6C200`), Beige `#F5F5DC`, White `#FFFFFF`.
- **CSS tokens:** `--sf-black --sf-brown --sf-gold --sf-gold-2 --sf-beige --sf-white`.
- **Logo rule:** Transparent + gold glow on dark; mono‑white on gold sections.
- **Tiers:** Basic £9.99 / Standard £39.99 / Premium £149.99.
- **Tone:** Smooth, Street‑Smart, Futuristic.

## 2) Repos (canonical)
- **Control repo:** `smartflow-systems/SmartFlowSite` (brand/theme, reusable CI, docs).
- **Other active repos:** `boweazy/SocialScaleBoosterAIbot`, `smartflow-systems/SFSDataQueryEngine`, `smartflow-systems/SFSAPDemoCRM`, `boweazy/sfs-marketing-and-growth`.
- **Reusable CI workflow path:** `smartflow-systems/SmartFlowSite/.github/workflows/sfs-ci-deploy.yml@main`.

## 3) Environments
- **GitHub org:** `smartflow-systems` (org‑wide secrets used across repos).
- **Replit:** main dev surface; prefers Bash one‑shot scripts and paste‑over files.
- **Windows/WSL:** installing WSL; occasionally stuck on kernel install. PowerShell used for file ops.

## 4) Secrets & Integrations (org‑wide)
- **Secrets (required):** `SFS_PAT` (GitHub PAT with repo+workflow), `REPLIT_TOKEN` (optional), `SFS_SYNC_URL` (optional webhook).
- **Where:** GitHub → Organization → Settings → Secrets and variables → Actions.
- **Convention:** Other repos _use_ the reusable workflow via `uses:` and rely on the same secrets.

## 5) Current Baseline (confirmed from recent sessions)
- **Setup kit run on Replit (12–13 Sep 2025):** created CI/diagnose scripts; committed `chore: Smartflow setup kit`.
- **CI files present:** in SmartFlowSite [ .github/workflows ], including `sfs-ci-deploy.yml`, `sfs-diagnose.yml`, `sfs-health.yml`.
- **Org created & repo transferred:** `smartflow-systems` exists; SmartFlowSite under org.
- **Open checks:** Connection/health not fully verified; one smoke test to `:5000` failed in Replit session. Custom `SFS` shell alias/command not yet installed.

## 6) Product Roadmap
- **v0.2 (stabilise public demo):** `/api/boost` JSON, CORS, Copy button, counter, landing copy, public link.
- **v0.3 (1 week):** SmartFlow presets, save 10 boosts, webhook.
- **v0.4 (2–3 weeks):** Content calendar, CSV export, analytics, pricing page, barber case study.
- **Backlog:** hashtags, rate‑limit/auth, error handling, tests, marketing clips/outreach.

## 7) Marketing Engine
- **Cadence:** short reels weekly + 1 longform video; push landing copy with tiered pricing.
- **Targets:** TikTok, LinkedIn, Reddit (communities), partners/affiliates.
- **Case studies:** barber shop, freelancers, SMBs (template library).

## 8) Agent Output Contract (non‑negotiable)
1. **Goal** (one‑liner).
2. **Apply‑All Bash** (single block, `set -euo pipefail`, safe/idempotent).
3. **Files** (full paste‑over with exact paths in **[square brackets]**, mark (OVERWRITE) when replacing).
4. **Verify** (curl/url checks, CI badges, logs).
5. **Undo** (exact commands).
6. **Callouts** (secrets, settings pages with direct links).
7. Keep answers ≤1500 chars **unless** attaching a file.
8. Europe/London timezone and brand tokens by default.

## 9) ST Triggers
- `ST: CONSOLIDATE` → end‑to‑end steps + Apply‑All + Verify + Undo.
- `ST: STATUS` → what changed vs `main`, what’s next.
- `ST: FULL FILE [path]` → print full file for paste‑over.
- `ST: ROLLBACK` → undo/cleanup steps.
- `ST: REWIND FROM HERE` → treat quoted snippet as new baseline and re‑explain.

## 10) Session Checklist (run each session)
1) Replit: file tree, uncommitted diffs, app logs/port.  
2) GitHub: commits, issues, PRs across listed repos.  
3) Compare to Roadmap; pick 3 tiny wins.  
4) Scan new AI tools/APIs/marketing tactics.

## 11) Known Rough Edges
- Replit health check to `http://127.0.0.1:5000` failed in logs; verify server start/port binding.
- `SFS` shell command not recognized; needs install (bin path update) if desired.
- WSL install friction on Windows; kernel update may be pending.

## 12) Immediate Next Steps (tiny wins for v0.3)
1) Add `/api/presets` + seed `data/presets.json` in SocialScaleBooster.  
2) Simple local storage “save 10 boosts” UI toggle.  
3) Webhook stub + logs (receive & echo).

## 13) Verify/Undo Pattern (template)
- **Verify:** `curl -sS -m 6 -w "%{http_code}\n" URL` → expect `200`; check Actions badge and last run logs.  
- **Undo:** `git restore -SW .` or `git revert -m 1 <commit>`; remove created files; delete temp branches.

## 14) Links (placeholders — replace OWNER/REPO)
- Org: https://github.com/smartflow-systems
- SmartFlowSite: https://github.com/smartflow-systems/SmartFlowSite
- Actions (repo): https://github.com/OWNER/REPO/actions
- Org Secrets: https://github.com/organizations/smartflow-systems/settings/secrets/actions
- Replit workspace: (add your project URL here)

---

### One‑liner summary for humans
Lean brand‑tight SaaS with reusable CI, Replit dev, and AI social bots. Ship v0.3 features (presets, save‑10, webhook), lock secrets/org CI, and push a public demo with pricing & case studies.