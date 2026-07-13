---
title: Harmonic Stylometry of Classical Composers
order: 6
featured: true
tagline: Fingerprinting composers by their harmony alone.
summary: Adapting stylometry from text to music — extracting harmonic features from symbolic scores to characterize and compare Bach, Beethoven, Chopin, Joplin, and Vivaldi.
school: Reed College
credential: B.A. Mathematics
course: Math 241 · Data Science
year: "2020"
role: Team of two
collaborators:
  - Lucas Yong
methods:
  - Feature engineering
  - Symbolic-music (Kern) parsing
  - Data visualization
  - R · ggplot2 · purrr
repo: https://github.com/Reed-Math241/music_stylo
repoLabel: Reed-Math241/music_stylo
images:
  - src: /figures/music-stylometry.jpg
    alt: Boxplots of average composition consonance by composer for Bach, Beethoven, Chopin, Joplin, and Vivaldi.
    thumbnail: true
interactive: stylometry
---

Stylometry is the statistical fingerprinting of authorship — the tools that can tell Shakespeare from Marlowe by counting function words. This project asks whether the same idea works on *music*: can harmony alone fingerprint a composer?

Working from symbolic scores in the Kern format, we wrote parsers to extract five harmonic features — consonance, dissonance, modal interchange, subdominant borrowing, and "bluesiness" — and turned each composition into a feature vector. Comparing the distributions across Bach, Beethoven, Chopin, Joplin, and Vivaldi surfaces genuine stylistic separation (Beethoven's consonance, for instance, runs higher and tighter than Chopin's) that lines up with the genres each composer worked in.

Built in R with a functional-programming pipeline (purrr, ggplot2). A two-person project that let me point quantitative tools at something I care about outside of math — it grew out of the same interest in music that I still build side projects around.

I've also written up the full story — the enharmonic problem, the findings, and what I'd do differently now — as [a blog post](/blog/music-stylometry).
