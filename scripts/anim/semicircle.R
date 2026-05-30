#!/usr/bin/env Rscript
# Wigner's semicircle law — eigenvalue density of an NxN random symmetric matrix
# emerging toward the semicircle as N grows. Faithful to thesis-taqi-470:
# RM_norm(symm=TRUE) builds a GOE matrix; spectrum() takes eigen() of it.
# Here, self-contained base-R reproduction, normalized so the bulk lands on [-2, 2].

suppressPackageStartupMessages({
  library(ggplot2)
  library(gganimate)
  library(dplyr)
})

set.seed(23) # the thesis's seed

# --- GOE (Gaussian Orthogonal Ensemble) eigenvalues, scaled to [-2, 2] ----------
# A has iid N(0,1) entries; H = (A + A^T)/sqrt(2) is symmetric (GOE);
# eigenvalues of H/sqrt(N) converge to the semicircle of radius 2.
wigner_eigs <- function(N) {
  A <- matrix(rnorm(N * N), N, N)
  H <- (A + t(A)) / sqrt(2)
  eigen(H / sqrt(N), symmetric = TRUE, only.values = TRUE)$values
}

Ns <- c(2, 3, 4, 5, 6, 8, 10, 13, 16, 20, 25, 32, 40, 50,
        64, 80, 100, 130, 160, 200, 260, 340)
target_pts <- 6000   # pool an ensemble at each N for a smooth empirical density
grid_n <- 220
xlo <- -2.6; xhi <- 2.6

dens <- bind_rows(lapply(Ns, function(N) {
  ens <- max(1L, ceiling(target_pts / N))
  ev <- unlist(lapply(seq_len(ens), function(i) wigner_eigs(N)))
  d <- density(ev, from = xlo, to = xhi, n = grid_n, bw = 0.07)
  data.frame(N = N, x = d$x, y = d$y)
}))
dens$Nf <- factor(dens$N, levels = Ns)

# Limiting semicircle density: rho(x) = sqrt(4 - x^2) / (2*pi) on [-2, 2]
sc <- data.frame(x = seq(-2, 2, length.out = 400))
sc$y <- sqrt(pmax(0, 4 - sc$x^2)) / (2 * pi)

navy  <- "#215e99"
amber <- "#c2410c"
ink   <- "#1f2937"

p <- ggplot(dens, aes(x = x, y = y)) +
  geom_area(fill = navy, alpha = 0.85) +
  geom_line(data = sc, aes(x = x, y = y), inherit.aes = FALSE,
            colour = amber, linewidth = 1.2) +
  coord_cartesian(xlim = c(xlo, xhi), ylim = c(0, 0.40), expand = FALSE) +
  labs(
    title = "Wigner's semicircle law",
    subtitle = "Eigenvalue density of an N-by-N random symmetric matrix      (N = {closest_state})",
    x = "eigenvalue  (scaled)", y = "density"
  ) +
  theme_minimal(base_size = 15) +
  theme(
    text = element_text(colour = ink),
    plot.title = element_text(face = "bold", size = 18),
    plot.subtitle = element_text(size = 12, margin = margin(b = 10)),
    axis.title = element_text(size = 11),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.background = element_rect(fill = "white", colour = NA),
    panel.background = element_rect(fill = "white", colour = NA),
    plot.margin = margin(14, 18, 10, 12)
  ) +
  transition_states(Nf, transition_length = 3, state_length = 1, wrap = TRUE) +
  ease_aes("cubic-in-out")

outdir <- "/Users/Erdos/Developer/portfolio-website/scripts/anim/frames/semicircle"
if (dir.exists(outdir)) unlink(outdir, recursive = TRUE)
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

t0 <- Sys.time()
animate(
  p, nframes = 180, fps = 24, width = 900, height = 560, res = 110,
  renderer = file_renderer(outdir, prefix = "frame", overwrite = TRUE)
)
cat("semicircle frames written to", outdir, "in",
    round(as.numeric(Sys.time() - t0, units = "secs"), 1), "s\n")
cat("frame count:", length(list.files(outdir, pattern = "\\.png$")), "\n")
