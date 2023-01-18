# mockr.onload

Package contains an example of mockr not working when running interactively in package with .onLoad

## To recreate issue

Install current CRAN version of mockr

```
install.packages("mockr")
```

1. Running `testthat::test_file("tests/testthat/test-mockr.R")` fails with

    ```
    [ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]

    ── Error (test-mockr.R:6): x and y work ────────────────────────────────────────
    Error: value for '.onLoad' not found
    Backtrace:
     1. with_mock(...)
          at test-mockr.R:6:2
     2. mockr::with_mock(..., .parent = .parent, .env = "mockr.onload")
          at tests/testthat/helper-mockr.R:2:2
     3. mockr:::create_mock_env(mock_funs, .env = .env, .parent = .parent)
     4. mockr:::create_mock_env_with_old_funcs(new_funcs, .env, .parent)
     5. base::mget(names(old_funcs), .parent, inherits = TRUE)
     6. base (local) `<fn>`(".onLoad")

    [ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
    ```
    
1. Running the test interactively, Ctrl + Enter on entire `test_that` block

    ```
    ── Error (Line 6): x and y work ────────────────────────────────────────────────
    Error: value for '.onLoad' not found
    Backtrace:
     1. with_mock(...)
     2. mockr::with_mock(..., .parent = .parent, .env = "mockr.onload")
          at tests/testthat/helper-mockr.R:2:2
     3. mockr:::create_mock_env(mock_funs, .env = .env, .parent = .parent)
     4. mockr:::create_mock_env_with_old_funcs(new_funcs, .env, .parent)
     5. base::mget(names(old_funcs), .parent, inherits = TRUE)
     6. base (local) `<fn>`(".onLoad")

    Error in reporter$stop_if_needed() : Test failed
    ```
    
1. Running the test interactively line by line, Ctrl + Enter on test body

    ```
    >   mock_x <- function() {
    +     message("executing mock x")
    +     "mock_x"
    +   }
    >   with_mock(x = mock_x, {
    +     expect_equal(y(), "mock_x")
    +   })
    Error: value for ‘.onLoad’ not found
    ```
    
1. `devtools::test()` works as expected
