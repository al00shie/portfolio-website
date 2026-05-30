---
title: Climate and the Evolution of Complex Tone
order: 2
featured: true
tagline: Do dry climates hold tonal languages back? A survival-analysis take.
summary: A graduate statistics project testing — and extending — the hypothesis that ambient humidity predicts where complex tonal languages emerge, joining 527 languages to 75 years of global climate data.
school: Boston University
credential: M.A. Statistics
course: MA 576
year: "2023"
role: Solo project
collaborators: []
methods:
  - Survival analysis
  - Logistic regression (GLM)
  - Geospatial joins
  - Large-data wrangling (~16M rows)
  - R · tidyverse
repo: https://github.com/al00shie/tonality576
repoLabel: al00shie/tonality576
paper: /papers/tonality.pdf
image: /figures/tonality.jpg
imageAlt: World map of 527 languages overlaid on a global mean-humidity heatmap, points colored by tonality type.
---

Why are tonal languages — where pitch alone can change a word's meaning — common in the humid tropics but rare in dry climates? This project recreates and extends Everett & Moran's (2015) hypothesis that arid air, which makes precise control of vocal pitch harder, suppresses the emergence of **complex** tone.

I joined the World Atlas of Linguistic Structures (527 languages) to 75 years of global humidity data from the American Meteorological Society — roughly 16 million rows — using a nearest-coordinate match to attach a climate profile to every language. On top of the original analysis I tested whether the *upper quantiles* of humidity predict complex tonality better than the mean (they do), fit logistic GLMs on those predictors, and built survival-style models showing how tonality "drops out" as climates dry.

The honest wrinkle: a handful of language families cut against the climate signal — a reminder that phylogeny and culture confound a purely ecological story. A solo project, and the one where I spent the most time turning messy, mismatched sources into a single clean modeling table.
