# Interactive Metropolis MCMC — Bayesian Poisson regression.
# Same hand-coded sampler as the math392 final; sliders let you explore how the
# prior and proposal width shape the posterior. Base-R graphics keep the
# Shinylive export lean (no ggplot2 WebAssembly download).
library(shiny)

set.seed(141)
n <- 85
age <- round(runif(n, 1, 60))
checkouts <- rpois(n, exp(cbind(1, age) %*% c(0.5, 0.02)))
X <- cbind(1, age); Y <- checkouts
navy <- "#215e99"; amber <- "#c2410c"

ui <- fluidPage(
  tags$h3("Metropolis MCMC — Bayesian Poisson regression"),
  tags$p(
    "A hand-coded Metropolis sampler exploring the joint posterior of a Poisson GLM's",
    "intercept and age-slope. Move the sliders and press Sample — it all runs in your browser."
  ),
  sidebarLayout(
    sidebarPanel(
      width = 4,
      sliderInput("iters", "MCMC iterations", 2000, 40000, 15000, step = 1000),
      sliderInput("propsd", HTML("Proposal SD for &beta;<sub>0</sub>"), 0.01, 0.15, 0.05, step = 0.005),
      sliderInput("pm1", HTML("Prior mean for age-slope &beta;<sub>1</sub>"), 0.005, 0.1, 0.05, step = 0.005),
      actionButton("go", "Sample", class = "btn-primary")
    ),
    mainPanel(
      width = 8,
      plotOutput("cloud", height = "420px"),
      verbatimTextOutput("summary")
    )
  )
)

server <- function(input, output) {
  draws <- eventReactive(input$go, {
    a0 <- 0.05; b0 <- 3
    a1 <- 0.10; b1 <- a1 / max(input$pm1, 1e-3)   # gamma prior with chosen mean
    lpost <- function(th) {
      lp <- dgamma(th[1], a0, b0, log = TRUE) + dgamma(th[2], a1, b1, log = TRUE)
      lam <- exp(X %*% th)
      lp + sum(-lam + Y * log(lam) - lgamma(Y + 1))
    }
    it <- input$iters
    ch <- matrix(NA_real_, it + 1, 2); ch[1, ] <- c(0.25, 0.5)
    for (i in 1:it) {
      pr <- c(rnorm(1, ch[i, 1], input$propsd), rnorm(1, ch[i, 2], 0.002))
      ch[i + 1, ] <- if (runif(1) < exp(lpost(pr) - lpost(ch[i, ]))) pr else ch[i, ]
    }
    burn <- min(5000, floor(it / 3))
    ch[(burn + 1):(it + 1), , drop = FALSE]
  }, ignoreNULL = FALSE)

  output$cloud <- renderPlot({
    d <- draws()
    par(mar = c(4.4, 4.4, 2.2, 1))
    plot(d[, 1], d[, 2], pch = 19, cex = 0.5, col = adjustcolor(navy, 0.22),
         xlab = expression(beta[0] ~ "  (intercept)"),
         ylab = expression(beta[1] ~ "  (age slope)"),
         main = "Posterior draws")
    points(mean(d[, 1]), mean(d[, 2]), pch = 18, col = amber, cex = 2.8)
  })
  output$summary <- renderPrint({
    d <- draws()
    acc <- 1 - mean(duplicated(d))
    cat(sprintf("Posterior mean:   beta0 = %.4f,   beta1 = %.4f\n", mean(d[, 1]), mean(d[, 2])))
    cat(sprintf("Acceptance rate:  %.1f%%   (%d draws after burn-in)\n", 100 * acc, nrow(d)))
  })
}

shinyApp(ui, server)
