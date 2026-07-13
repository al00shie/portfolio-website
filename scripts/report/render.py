"""Render the music-stylometry report HTML to public/papers/music-stylometry.pdf.

Usage: python3 scripts/report/render.py  (from anywhere; paths are script-relative)
Requires: pip install playwright && playwright install chromium
"""

import pathlib

from playwright.sync_api import sync_playwright

HERE = pathlib.Path(__file__).resolve().parent
SRC = HERE / "music-stylometry-report.html"
OUT = HERE.parent.parent / "public" / "papers" / "music-stylometry.pdf"

FOOTER = """
<div style="width:100%; font-family:'Helvetica Neue',Helvetica,Arial,sans-serif; font-size:7.5pt;
            color:#8a93a0; padding:0 0.75in; display:flex; justify-content:space-between;">
  <span>Fingerprinting Composers &mdash; Ali Taqi</span>
  <span><span class="pageNumber"></span> / <span class="totalPages"></span></span>
</div>
"""

with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page()
    page.goto(SRC.as_uri(), wait_until="networkidle")
    page.pdf(
        path=str(OUT),
        format="Letter",
        print_background=True,
        margin={"top": "0.75in", "bottom": "0.85in", "left": "0.85in", "right": "0.85in"},
        display_header_footer=True,
        header_template="<span></span>",
        footer_template=FOOTER,
    )
    browser.close()

print(f"Wrote {OUT}")
