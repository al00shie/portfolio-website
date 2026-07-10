---
title: Forecasting Bike-Share Demand
order: 4
featured: true
tagline: Regression models that hold up against a growing user base.
summary: A linear-modeling study predicting daily Capital Bikeshare ridership from weather and season — and correcting for the year-over-year user growth that quietly breaks a naïve forecast.
school: Boston University
credential: M.A. Statistics
course: MA 575 · Linear Models
year: "2021"
role: Team project
collaborators: []
methods:
  - Multiple linear regression
  - Model selection
  - Cross-validation (LOOCV)
  - Residual diagnostics
  - R · tidyverse
repo: https://github.com/al00shie/bikes575
repoLabel: al00shie/bikes575
paper: /papers/bike-share.pdf
images:
  - src: /figures/bike-share.jpg
    alt: Fitted versus actual daily registered ridership across 2011, with weekday and holiday observations marked.
    thumbnail: true
  - src: /figures/bike-share2.png
    alt: Growth ratio estimates for 2011 and 2012.
---

Given a day's weather and season, how many people will rent a bike? Working from two years of Capital Bikeshare data, our team built multiple-regression models predicting daily ridership from temperature, humidity, windspeed, weather, and calendar features — with interaction terms for how a hot day plays differently on a workday than on a weekend.

The interesting failure showed up at validation: models fit on 2011 systematically **under-predicted** 2012. The cause wasn't the weather — it was a growing user base. We estimated a year-over-year **growth ratio** (via an environmental-loss-function approach, plus a simpler windowed estimate) to rescale the forecasts, recovering roughly a 10% improvement in prediction error and turning a biased model into an honest one.

Built in R with leave-one-out cross-validation and residual diagnostics throughout. A team project, and a clean lesson in how a model can be locally right and globally wrong.
