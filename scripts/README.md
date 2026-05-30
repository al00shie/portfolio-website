# `scripts/` — asset-generation pipeline

The site's expressive artifacts — the animations, the interactive datasets, and the
live Shiny app — are **generated from R**, then served as static files. This folder
holds the generators; the Astro build (`npm run build`) just assembles the results.
Each generator is adapted from the underlying academic project's own code.

```
scripts/
├── anim/
│   ├── semicircle.R   # Wigner semicircle animation → PNG frames
│   ├── mcmc.R         # Metropolis MCMC animation → PNG frames
│   └── encode.sh      # PNG frames → WebM + MP4 + JPG poster (ffmpeg)
├── data/
│   └── export.R       # interactive-plot datasets → public/data/*.json
└── shinylive-app/
    └── app.R          # serverless Shiny app (exported to WebAssembly)
```

## Prerequisites

- **R** ≥ 4.4 with: `ggplot2`, `gganimate`, `dplyr`, `survival`, `jsonlite`, `shiny`, `shinylive`
- **ffmpeg** (for `encode.sh`)
- **Node** ≥ 18 + `npm` (for the Astro build)

## Pipeline

### 1 · Animations → `public/anim/`

Each `*.R` renders PNG frames (deliberately *not* GIF — avoids 256-colour banding);
`encode.sh` turns a frame folder into web-delivered video.

```bash
Rscript scripts/anim/semicircle.R && bash scripts/anim/encode.sh semicircle
Rscript scripts/anim/mcmc.R        && bash scripts/anim/encode.sh mcmc
```

Outputs `<name>.webm` (VP9), `<name>.mp4` (H.264), `<name>-poster.jpg`. `semicircle.R`
reproduces the thesis's GOE eigenvalue simulation; `mcmc.R` runs the Math 392 final's
Metropolis sampler verbatim. Rendered by `src/components/Animation.astro`.

### 2 · Interactive datasets → `public/data/`

```bash
Rscript scripts/data/export.R
```

Writes `semicircle-density.json` (density vs N), `composers.json` (stylometry features),
and `tonality-survival.json` (Kaplan–Meier curves via `survival::survfit` over 527
languages). Consumed by the Observable Plot islands in `src/components/*Explorer.astro`.

### 3 · Shinylive app → `public/live/mcmc-app/`

```bash
Rscript -e 'shinylive::export("scripts/shinylive-app", "public/live/mcmc-app")'
```

Exports `app.R` to a self-contained ~59 MB WebAssembly bundle (real R, in the browser),
embedded behind a click-to-launch facade at `/live/mcmc`. Relies on the `/live/*`
COOP/COEP headers in `public/_headers` for the cross-origin isolation Shinylive needs.

### 4 · Build the site

```bash
npm run build      # → dist/
```

> The other live-R page, `/live/random-matrix` (WebR), needs **no** build step — it loads
> the R-on-WebAssembly runtime from a CDN at runtime; its code lives directly in
> `src/pages/live/random-matrix.astro`.

## Committed vs. regenerable

- **Committed** (small, in git): `public/anim/*`, `public/data/*.json`
- **Git-ignored** (regenerable from the scripts above): `scripts/anim/frames/`,
  `public/live/mcmc-app/`, `dist/`

## Deploy

Static direct-upload to Cloudflare Pages (project `alitaqi`):

```bash
npm run build
npx wrangler pages deploy dist --project-name alitaqi --branch main
```
