test_that("%||% works", {
  mock_x <- function() {
    message("executing mock x")
    "mock_x"
  }
  with_mock(x = mock_x, {
    expect_equal(y(), "mock_x")
  })
})
