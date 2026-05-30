#!/usr/bin/env Rscript
# Metropolis MCMC sampling the Bayesian posterior of a Poisson regression.
# Faithful reproduction of the math392 final's sampler (Taqi-Final.Rmd):
#   gamma priors, independent normal proposals, log-posterior accept ratio.
# The library thesis-checkout data lived at a now-stale Dropbox URL, so we
# simulate count data of the same structure (n = 85, age -> checkouts) and run
# the ORIGINAL sampler verbatim. The algorithm — not the dataset — is the point.

suppressPackageStartupMessages({
  library(ggplot2)
  library(gganimate)
})

# --- Simulated thesis-checkout data (same shape as the original) ----------------
set.seed(141)
n <- 85
age <- round(runif(n, 1, 60))
beta_true <- c(0.5, 0.02)
checkouts <- rpois(n, exp(cbind(1, age) %*% beta_true))
X <- cbind(1, age)
Y <- checkouts

# --- Priors, likelihood, posterior (verbatim from the final) --------------------
a0 <- 0.05; b0 <- 3
a1 <- 0.10; b1 <- 2
prior <- function(theta) {
  sum(dgamma(theta[1], a0, b0, log = TRUE),
      dgamma(theta[2], a1, b1, log = TRUE))
}
likelihood <- function(theta) {
  lambdas <- exp(X %*% theta)               # link function
  sum(-lambdas + Y * log(lambdas) - log(factorial(Y)))
}
posterior <- function(theta) sum(prior(theta), likelihood(theta))

# --- The Metropolis algorithm (structure verbatim; proposal SDs tuned to this
#     simulated data, per the exam's own instruction to target ~0.4 acceptance) -
set.seed(92)
it <- 50000
chain <- matrix(rep(NA, (it + 1) * 2), ncol = 2)
chain[1, ] <- c(0.25, 0.5)                  # theta_0
for (i in 1:it) {
  proposal <- c(rnorm(1, chain[i, 1], 0.05),
                rnorm(1, chain[i, 2], 0.0020))
  p_move <- exp(posterior(proposal) - posterior(chain[i, 1:2]))
  if (runif(1) < p_move) chain[i + 1, ] <- proposal
  else                   chain[i + 1, ] <- chain[i, ]
}
burn_in <- 5000
acc <- 1 - mean(duplicated(chain[-(1:burn_in), ]))
cat("acceptance rate:", round(acc, 3), "\n")

# --- Thin the post-burn-in chain into an accumulating point cloud ---------------
post <- chain[(burn_in + 1):it, ]
keep <- round(seq(1, nrow(post), length.out = 1100))
samp <- data.frame(beta0 = post[keep, 1], beta1 = post[keep, 2],
                   t = seq_along(keep))

navy  <- "#215e99"
amber <- "#c2410c"
ink   <- "#1f2937"

pmean <- c(mean(samp$beta0), mean(samp$beta1))   # posterior mean (the estimate)
qx <- quantile(samp$beta0, c(0.004, 0.992))
qy <- quantile(samp$beta1, c(0.004, 0.996))
padx <- diff(qx) * 0.06; pady <- diff(qy) * 0.06

p <- ggplot(samp, aes(x = beta0, y = beta1)) +
  geom_point(colour = navy, alpha = 0.60, size = 1.6, stroke = 0) +
  geom_point(data = data.frame(beta0 = pmean[1], beta1 = pmean[2]),
             inherit.aes = FALSE, aes(beta0, beta1),
             shape = 18, size = 4.4, colour = amber) +
  coord_cartesian(xlim = c(qx[1] - padx, qx[2] + padx),
                  ylim = c(qy[1] - pady, qy[2] + pady), expand = FALSE) +
  labs(
    title = "Metropolis MCMC",
    subtitle = "Each point is a draw from the Bayesian posterior of a Poisson regression",
    x = "intercept  (beta 0)",
    y = "age slope  (beta 1)"
  ) +
  theme_minimal(base_size = 15) +
  theme(
    text = element_text(colour = ink),
    plot.title = element_text(face = "bold", size = 18),
    plot.subtitle = element_text(size = 12, margin = margin(b = 10)),
    axis.title = element_text(size = 12),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", colour = NA),
    panel.background = element_rect(fill = "white", colour = NA),
    plot.margin = margin(14, 18, 10, 12)
  ) +
  transition_time(t) +
  shadow_mark(past = TRUE, future = FALSE, colour = navy, alpha = 0.22, size = 1.2)

outdir <- "/Users/Erdos/Developer/portfolio-website/scripts/anim/frames/mcmc"
if (dir.exists(outdir)) unlink(outdir, recursive = TRUE)
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

t0 <- Sys.time()
animate(
  p, nframes = 150, fps = 24, width = 760, height = 620, res = 110,
  renderer = file_renderer(outdir, prefix = "frame", overwrite = TRUE),
  end_pause = 12
)
cat("mcmc frames written in",
    round(as.numeric(Sys.time() - t0, units = "secs"), 1), "s\n")
cat("frame count:", length(list.files(outdir, pattern = "\\.png$")), "\n")
