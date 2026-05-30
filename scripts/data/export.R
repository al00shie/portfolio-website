#!/usr/bin/env Rscript
# Export small JSON datasets for the Observable Plot interactives.
#   1. semicircle-density.json — empirical eigenvalue density vs N (drag-N explorer)
#   2. composers.json          — harmonic stylometry features per piece (scatter)

suppressPackageStartupMessages(library(jsonlite))

outdir <- "/Users/Erdos/Developer/portfolio-website/public/data"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

# ---- 1. Wigner semicircle: empirical density across matrix sizes N -------------
set.seed(23)
wigner_eigs <- function(N) {
  A <- matrix(rnorm(N * N), N, N)
  H <- (A + t(A)) / sqrt(2)
  eigen(H / sqrt(N), symmetric = TRUE, only.values = TRUE)$values
}
Ns <- c(2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377)
xlo <- -2.6; xhi <- 2.6; ng <- 161
grid <- seq(xlo, xhi, length.out = ng)
curves <- lapply(Ns, function(N) {
  ens <- max(1L, ceiling(5000 / N))
  ev <- unlist(lapply(seq_len(ens), function(i) wigner_eigs(N)))
  d <- density(ev, from = xlo, to = xhi, n = ng, bw = 0.08)
  list(N = N, y = round(d$y, 4))
})
semic <- round(sqrt(pmax(0, 4 - grid^2)) / (2 * pi), 4)
write_json(
  list(x = round(grid, 3), semicircle = semic, curves = curves),
  file.path(outdir, "semicircle-density.json"),
  auto_unbox = TRUE, digits = 5
)
cat("wrote semicircle-density.json (", length(Ns), "values of N )\n")

# ---- 2. Stylometry: harmonic features per piece, labelled by composer ----------
comp <- read.csv(
  "/Users/Erdos/Developer/~School Projects/musicStylometry241/analysis/COMPOSERS.csv",
  stringsAsFactors = FALSE
)
# round numeric feature columns
isnum <- sapply(comp, is.numeric)
comp[isnum] <- lapply(comp[isnum], function(x) round(x, 4))
# keep it snappy: at most ~120 pieces per composer
set.seed(1)
comp <- do.call(rbind, lapply(split(comp, comp$composer), function(df) {
  if (nrow(df) > 120) df[sample(nrow(df), 120), ] else df
}))
comp$composer <- tools::toTitleCase(comp$composer)
write_json(comp, file.path(outdir, "composers.json"), auto_unbox = TRUE, digits = 5)
cat("wrote composers.json (", nrow(comp), "pieces,",
    length(unique(comp$composer)), "composers )\n")
