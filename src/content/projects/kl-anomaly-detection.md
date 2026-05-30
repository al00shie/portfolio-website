---
title: Anomaly Detection with Karhunen–Loève Expansions
order: 3
featured: true
tagline: Boosting a classifier by projecting outside the reference eigenspace.
summary: A graduate machine-learning project re-implementing and extending a Karhunen–Loève approach to anomaly detection — train an eigenspace on one class, then feed the energy outside it into an SVM.
school: Boston University
credential: M.A. Statistics
course: MA 751 · Machine Learning
year: "2022"
role: Team of four
collaborators:
  - Yulin Li
  - Travis Yang
  - Luke Zheng
methods:
  - Karhunen–Loève / functional PCA
  - Support Vector Machines
  - Greedy-tree multiclass
  - Dimensionality reduction
  - MATLAB
repo: https://github.com/yulinl2/Change_Detection_Machine_Learning
repoLabel: yulinl2/Change_Detection_Machine_Learning
paper: /papers/kl-anomaly-detection.pdf
image: /figures/kl-anomaly-detection.jpg
imageAlt: Multiclass SVM decision boundaries separating three labeled point clusters in the plane.
---

This project tackles a recurring machine-learning problem: spotting anomalous signals — data that doesn't belong to a known reference class. The idea borrows from functional analysis. A **Karhunen–Loève expansion** (the function-space generalization of PCA) is trained on a single reference class to estimate its eigenspace; new observations are then projected onto the subspaces *outside* that eigenspace, and the energy in those projections becomes a feature vector for a support-vector-machine classifier.

Our team re-derived the framework from Castrillón-Candás et al. and wrote it up with a deliberate pedagogical build-up — from ordinary PCA, to KL expansions, to the anomaly-detection application — so a reader without a functional-analysis background could follow it. We then proposed a **Greedy Tree Multiclass SVM** to extend the originally two-class method to three or more classes, and demonstrated the full pipeline on cancer-diagnosis data, separating tumor from healthy tissue.

Implemented in MATLAB, with the report doubling as a teaching document for the method. A four-person team project.
