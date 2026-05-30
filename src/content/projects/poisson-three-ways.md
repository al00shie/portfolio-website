---
title: Poisson Regression, Three Ways
order: 1.5
featured: true
tagline: One count model, seen through frequentist, penalized, and Bayesian lenses.
summary: A mathematical-statistics final that fits a single Poisson GLM to library checkout counts three ways — maximum likelihood, ridge-penalized estimation, and full Bayesian inference via a hand-coded Metropolis MCMC sampler — and compares what each one says.
school: Reed College
credential: B.A. Mathematics
course: Math 392 · Mathematical Statistics
year: "2021"
role: Solo · course final
collaborators: []
methods:
  - Bayesian inference
  - Metropolis MCMC
  - Poisson GLM
  - Maximum likelihood
  - Ridge regularization
  - R
paper: /papers/poisson-three-ways.pdf
image: /figures/poisson-three-ways.jpg
imageAlt: Three-dimensional surface of the joint prior density over the two Poisson-GLM coefficients.
---

This final took a deliberately simple model — a Poisson generalized linear model for count data, fit to library book-checkout counts — and worked it through three different statistical philosophies to see where they agree and where they diverge.

The **frequentist** pass derives the likelihood, finds the maximum-likelihood estimates, and builds analytical confidence intervals. The **penalized** pass adds ridge regularization to watch how shrinkage moves the coefficients. The **Bayesian** pass specifies priors over the coefficients and samples the posterior with a hand-written **Metropolis MCMC** algorithm, then reads off credible intervals and posterior summaries.

Setting all three side by side is the whole point — a compact tour of how maximum likelihood, regularization, and Bayesian inference each frame the same uncertainty. The MCMC sampler and the Bayesian machinery here are exactly the tools that resurface in actuarial modeling.
