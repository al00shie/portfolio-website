# alitaqi.pages.dev — portfolio

Personal portfolio of Ali Taqi (quantitative analyst / actuarial candidate), built with
[Astro](https://astro.build) + Tailwind and deployed to Cloudflare Pages.
Live at **https://alitaqi.pages.dev**.

## ✏️ Editing the content

Almost all of the site's text lives in two easy-to-edit places — you never need to touch a
component to tweak wording:

| To change… | Edit |
|---|---|
| Site copy & résumé — hero, about, skills, exams, education, experience, contact — plus nav and SEO | **`content.yaml`** (repo root) |
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

- **`content.yaml`** — all site text (the file to tinker with)
- `src/content/projects/*.md` — one markdown file per project
- `src/pages/` — the subpages: `index` (hero + two feature panels + coda), `about`
  (bio, education, experience, toolkit), `work` (full project grid), `contact`
  (email buttons + a backend-free form that composes a mail in the visitor's own
  app), `projects/[slug]` (write-ups), `404`. The ← / → keys page through the nav
  (and through neighbouring projects on a project page).
- `src/components/`, `src/layouts/` — shared shell (header chips, clock, theme,
  motion) and cards
- `src/pages/live/` — the in-browser R demos (a live WebR cell + a Shinylive app)
- `scripts/` — R + shell that generate the animations, interactive datasets, and live app
  (see [`scripts/README.md`](scripts/README.md))
- `public/` — static assets (figures, reports, generated videos and data)
