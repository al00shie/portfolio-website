---
title: The MLB Luxury Tax and the Players It Left Behind
order: 5
featured: true
tagline: Did baseball's salary cap push capable players into early retirement?
summary: A statistical-inference project testing whether MLB's 2003 competitive-balance tax raised the rate of "couldabeens" — players who retired while still outperforming the average rookie — while controlling for the Moneyball revolution.
school: Reed College
credential: B.A. Mathematics
course: Math 243 · Statistics
year: "2020"
role: Team of three
collaborators:
  - Grant Dunlavey
  - William Ren
methods:
  - Linear regression
  - Hypothesis testing
  - Confounding control
  - Cohort matching (WAR)
  - R · dplyr
repo: https://github.com/al00shie/couldabeens
repoLabel: al00shie/couldabeens
paper: /papers/luxury-tax.pdf
images:
  - src: /figures/luxury-tax.jpg
    alt: Scatterplot of the yearly proportion of "couldabeen" retirees from 1970 to 2020 with a fitted trend line.
    thumbnail: true
---

In 2003 Major League Baseball introduced a competitive-balance ("luxury") tax to rein in team payrolls. We asked whether it carried an unintended cost: did it push still-capable players into early retirement? We define a **"couldabeen"** as a player who retired in a season when he was still outperforming the average rookie — measured by Wins Above Replacement — and tracked the yearly proportion of such retirements across roughly fifty seasons.

The real difficulty is confounding. 2003 also sits at the dawn of the *Moneyball* era, when sharper player evaluation independently reshaped who stayed in the league. We separated the two effects by partitioning the data into pre- and post-Moneyball eras and running a hypothesis test on the difference in means (≈0.16 vs ≈0.12, p ≈ 0.045), so the tax's effect could be read against the Moneyball baseline rather than mistaken for it.

Built in R. A three-person team project — and my first real exercise in defending a causal claim against an obvious alternative explanation.
