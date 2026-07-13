#!/usr/bin/env bash
# Pad figure images onto a white 16:10 canvas so the homepage cards'
# aspect-[16/10] object-cover crop shows the ENTIRE figure.
#
# How: add a small white margin on every side, then extend the shorter
# dimension with white until the canvas is exactly 16:10 (never crops,
# never scales — pixels are only added, so the output is deterministic).
#
# Idempotent: files already at 16:10 (within 1%) are skipped, so re-running
# never pads twice. Pre-pad originals live in git history.
#
# Usage:  scripts/pad-figures.sh
set -euo pipefail

DIR="$(cd "$(dirname "$0")/.." && pwd)/public/figures"
RATIO_NUM=16 RATIO_DEN=10   # must match aspect-[16/10] in ProjectCard.astro
MARGIN_PCT=4                # white breathing room, % of the longer side

# Figures that read well under the card crop stay untouched.
EXCLUDE=("bike-share2.png" "kl-anomaly-detection.jpg")

for f in "$DIR"/*.jpg "$DIR"/*.png; do
  [ -e "$f" ] || continue
  base=$(basename "$f")
  for x in "${EXCLUDE[@]}"; do
    [ "$base" = "$x" ] && { echo "excluded              $base"; continue 2; }
  done

  w=$(sips -g pixelWidth  "$f" | awk '/pixelWidth/{print $2}')
  h=$(sips -g pixelHeight "$f" | awk '/pixelHeight/{print $2}')

  # already 16:10 within 1% → nothing to do
  if [ $((w * RATIO_DEN * 100)) -ge $((h * RATIO_NUM * 99)) ] &&
     [ $((w * RATIO_DEN * 100)) -le $((h * RATIO_NUM * 101)) ]; then
    echo "skip (already 16:10)  $base"
    continue
  fi

  m=$(( (w > h ? w : h) * MARGIN_PCT / 100 ))
  w2=$((w + 2 * m)); h2=$((h + 2 * m))

  # grow the short direction out to 16:10
  if [ $((w2 * RATIO_DEN)) -ge $((h2 * RATIO_NUM)) ]; then
    W=$w2; H=$((w2 * RATIO_DEN / RATIO_NUM))
  else
    H=$h2; W=$((h2 * RATIO_NUM / RATIO_DEN))
  fi

  sips --padToHeightWidth "$H" "$W" --padColor FFFFFF \
       -s formatOptions best "$f" >/dev/null
  echo "padded ${w}x${h} -> ${W}x${H}  $base"
done
