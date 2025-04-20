#!/usr/bin/env bash
#
# Sinhala Wijesekara keyboard – lightweight installer for macOS
# -------------------------------------------------------------
# • Downloads sinhala‑wije.keylayout  +  sinhala‑wije.icns from this GitHub repo
# • Copies/updates them in ~/Library/Keyboard Layouts/
# • Prints a quick next‑steps reminder (log out / add keyboard)
#
# Usage (no root required):
#   bash <(curl -fsSL https://raw.githubusercontent.com/sdasun/mac-wijesekara/main/install-wijesekara.sh)
# -------------------------------------------------------------

set -euo pipefail

REPO="sdasun/mac-wijesekara"
BRANCH="master"                        # change if you use a different default branch
DEST="$HOME/Library/Keyboard Layouts"
FILES=(sinhala-wije.keylayout sinhala-wije.icns)

blue() { printf "\033[1;34m%s\033[0m\n" "$*"; }
err()  { printf "\033[1;31mERR:\033[0m %s\n" "$*" >&2; exit 1; }

mkdir -p "$DEST"

blue "Downloading Sinhala Wijesekara files…"
for f in "${FILES[@]}"; do
  URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/${f}"
  blue "  • $f"
  curl -fsSL "$URL" -o "$DEST/$f" || err "Failed to download $f"
done

blue "✅  Installed to: $DEST"
echo
echo "Next steps:"
echo "  1. Log out and log back in (or reboot)."
echo "  2. System Settings → Keyboard → Input Sources → “+”"
echo "     → locate **Sinhala ▸ Sinhala Wijesekara** and add it."
echo
echo "Enjoy typing in Sinhala!  (If you already had an older copy,"
echo "just log out/in to refresh macOS caches.)"
