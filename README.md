# alitaqi.pages.dev — portfolio

Personal portfolio of Ali Taqi (quantitative analyst / actuarial candidate), built with
[Astro](https://astro.build) + Tailwind and deployed to Cloudflare Pages.
Live at **https://alitaqi.pages.dev**.

## ✏️ Editing the content

Almost all of the site's text lives in two easy-to-edit places — you never need to touch a
component to tweak wording:

| To change… | Edit |
|---|---|
| Homepage copy & résumé — about, skills, exams, education, experience — plus nav and SEO | **`content.yaml`** (repo root) |
| A project write-up — title, summary, methods, body, links | `src/content/projects/<project>.md` |
| A project's figure / animation / interactive data | see **[`scripts/README.md`](scripts/README.md)** |

After editing, run `npm run dev` to preview live, or `npm run build` to rebuild.

## Develop · build · deploy

```bash
npm install
npm run dev        # local preview at http://localhost:4321
npm run build      # static site → dist/
npx wrangler pages deploy dist --project-name alitaqi --branch main   # deploy to Cloudflare Pages
```

## Layout

- **`content.yaml`** — all homepage + global text (the file to tinker with)
- `src/content/projects/*.md` — one markdown file per project
- `src/pages/`, `src/components/`, `src/layouts/` — the Astro site itself
- `src/pages/live/` — the in-browser R demos (a live WebR cell + a Shinylive app)
- `scripts/` — R + shell that generate the animations, interactive datasets, and live app
  (see [`scripts/README.md`](scripts/README.md))
- `public/` — static assets (figures, reports, generated videos and data)
