test_that("`mpe()` works", {
  set.seed(1812)
  df <- data.frame(obs = rnorm(50))
  df$pred <- .2 + 1.1 * df$obs + rnorm(50, sd = 0.5)

  expect_identical(
    mpe(df, truth = "obs", estimate = "pred")[[".estimate"]],
    mean((df$obs - df$pred) / df$obs) * 100
  )

  ind <- c(10, 20, 30, 40, 50)
  df$pred[ind] <- NA

  expect_identical(
    mpe(df, obs, pred)[[".estimate"]],
    mean((df$obs[-ind] - df$pred[-ind]) / df$obs[-ind]) * 100
  )
})

test_that("`mpe()` computes expected values when singular `truth` is `0`", {
  expect_identical(
    mpe_vec(truth = 0, estimate = 1),
    -Inf
  )

  expect_identical(
    mpe_vec(truth = 0, estimate = -1),
    Inf
  )

  expect_identical(
    mpe_vec(truth = 0, estimate = 0),
    NaN
  )
})
