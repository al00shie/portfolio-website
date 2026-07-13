---
title: Spectral Statistics of Random Matrices
order: 1
featured: true
tagline: My senior thesis in mathematics — and an R package to go with it.
summary: A 109-page senior thesis on the eigenvalue distributions of classical random-matrix ensembles, paired with RMAT — an R package I wrote to simulate the ensembles and study their spectra.
school: Reed College
credential: B.A. Mathematics
course: Senior Thesis · Math 470
year: "2021"
role: Solo thesis · advised by Nate Wells
collaborators: []
methods:
  - Probability theory
  - Eigenvalue distributions
  - Monte Carlo simulation
  - R package development
  - Markov chains
  - LaTeX
repo: https://github.com/al00shie/thesis-taqi
repoLabel: al00shie/thesis-taqi
liveCode: /live/random-matrix
interactive: semicircle
paper: /papers/random-matrices.pdf
images:
  - src: /figures/random-matrices.jpg
    alt: Norm-ordered spectral densities of 15×15 Beta-2 and Beta-4 random-matrix ensembles, colored by eigenvalue order.
    thumbnail: true
animation:
  webm: /anim/semicircle.webm
  mp4: /anim/semicircle.mp4
  poster: /anim/semicircle-poster.jpg
  alt: "Eigenvalue density of an N-by-N random symmetric matrix converging to the Wigner semicircle as N grows."
  caption: "Wigner's semicircle law, simulated with the thesis's own matrix routines: as N grows, the eigenvalue density of a random symmetric matrix locks onto a fixed semicircle (amber)."
  width: 900
  height: 560
---

My senior thesis studies **random matrices** — matrices whose entries are drawn at random — and the statistics of their eigenvalues. As the matrices grow, their eigenvalues settle into strikingly predictable shapes (Wigner's semicircle law is the classic example). The thesis surveys these results across the Gaussian, Wishart, and Hermite β-ensembles, with the Dyson index tying the families together.

Alongside the exposition I wrote **RMAT**, an R package that generates each ensemble, computes its spectrum, and visualizes two statistics: the distribution of the eigenvalues themselves and the spacings between them. The package handles the matrix generation, spectral computation, plotting, and parallelization used throughout the thesis.

The result is a 109-page document that pairs rigorous mathematical exposition — with appendices on linear algebra, probability, and Markov chains — against a reusable computational toolkit. It's the most sustained piece of mathematical work I've done, and the closest in spirit to the probability that sits underneath risk and insurance work.
