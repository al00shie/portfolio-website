---
title: Poisson Regression, Three Ways
order: 1.5
featured: true
tagline: One count model, seen through frequentist, penalized, and Bayesian lenses.
summary: A standalone report that fits a single Poisson GLM to library checkout counts three ways — maximum likelihood, ridge-penalized estimation, and full Bayesian inference via a hand-coded Metropolis MCMC sampler — and compares what each one says.
school: Reed College
credential: B.A. Mathematics
course: Math 392 · Mathematical Statistics
year: "2021"
role: Solo · report, revised from course final
collaborators: []
methods:
  - Bayesian inference
  - Metropolis MCMC
  - Poisson GLM
  - Maximum likelihood
  - Ridge regularization
  - R
liveCode: /live/mcmc
paper: /papers/poisson-three-ways.pdf
images:
  - src: /figures/poisson-three-ways.jpg
    alt: Side-by-side plots of the broad independent Gaussian joint prior and the tight, negatively correlated joint posterior over the two Poisson-GLM coefficients, with the posterior mean marked by a diamond.
    thumbnail: true
animation:
  webm: /anim/mcmc.webm
  mp4: /anim/mcmc.mp4
  poster: /anim/mcmc-poster.jpg
  alt: "Metropolis MCMC draws filling in the joint posterior of a Poisson regression's two coefficients."
  caption: "The hand-coded Metropolis sampler exploring the joint posterior of the intercept and age-slope coefficients. Each point is one accepted draw; the diagonal spread is their negative correlation, and the amber diamond marks the posterior mean."
  width: 760
  height: 620
---

This report takes a deliberately simple model — a Poisson generalized linear model for count data, fit to library book-checkout counts — and works it through three different statistical philosophies to see where they agree and where they diverge. The problem originated on my mathematical-statistics final; the report is its revised, standalone treatment, with every derivation re-validated, the sampler re-tuned, and the figures rebuilt.

The **frequentist** pass derives the likelihood, finds the maximum-likelihood estimates, and builds confidence intervals two ways — from asymptotic theory and from a 5,000-resample bootstrap. The **penalized** pass adds ridge regularization to the slope and traces the full shrinkage path. The **Bayesian** pass specifies Gaussian priors over the coefficients and samples the posterior with a hand-written **Metropolis MCMC** algorithm — two chains, trace-plot and effective-sample-size diagnostics — then reads off credible intervals and posterior summaries.

Setting all three side by side is the whole point — a compact tour of how maximum likelihood, regularization, and Bayesian inference each frame the same uncertainty (and, under weak priors, how closely their answers coincide). The MCMC sampler and the Bayesian machinery here are exactly the tools that resurface in insurance and financial risk modeling.
