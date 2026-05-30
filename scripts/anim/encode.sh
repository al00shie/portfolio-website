#!/usr/bin/env bash
# Encode a directory of PNG frames into web-delivered video: WebM (VP9) + MP4
# (H.264) + a JPG poster taken from a near-converged frame. No GIF intermediate
# -> no 256-color palette banding. Usage: encode.sh <name> [fps]
set -euo pipefail

NAME="$1"
FPS="${2:-24}"
ROOT="/Users/Erdos/Developer/portfolio-website"
FRAMES="$ROOT/scripts/anim/frames/$NAME"
OUT="$ROOT/public/anim"
mkdir -p "$OUT"

# MP4 (H.264) — yuv420p + even dimensions for broad browser support; faststart
ffmpeg -y -hide_banner -loglevel error -framerate "$FPS" \
  -pattern_type glob -i "$FRAMES/frame*.png" \
  -movflags +faststart -pix_fmt yuv420p \
  -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
  -crf 23 -c:v libx264 "$OUT/$NAME.mp4"

# WebM (VP9) — constant-quality (-b:v 0 -crf), no audio
ffmpeg -y -hide_banner -loglevel error -framerate "$FPS" \
  -pattern_type glob -i "$FRAMES/frame*.png" \
  -c:v libvpx-vp9 -b:v 0 -crf 33 -pix_fmt yuv420p -an "$OUT/$NAME.webm"

# Poster: a frame ~82% through (near-converged), as a small JPG
COUNT=$(ls "$FRAMES"/frame*.png | wc -l | tr -d ' ')
IDX=$(( (COUNT * 82) / 100 )); [ "$IDX" -lt 1 ] && IDX=1
POSTER_SRC=$(printf "%s/frame%04d.png" "$FRAMES" "$IDX")
sips -s format jpeg -s formatOptions 72 "$POSTER_SRC" --out "$OUT/$NAME-poster.jpg" >/dev/null 2>&1

echo "=== $NAME ==="
du -h "$OUT/$NAME.webm" "$OUT/$NAME.mp4" "$OUT/$NAME-poster.jpg"
