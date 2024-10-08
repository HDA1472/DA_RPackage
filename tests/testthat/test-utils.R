# Test create_dir --------------------------------------------------------------
test_that("Directory creation without date", {
  dir_name <- "test_directory_without_date"
  create_dir(dir_name)
  expect_true(dir.exists(dir_name), "Directory should be created")
  unlink(dir_name, recursive = TRUE)
})

test_that("Directory creation with date", {
  dir_prefix <- "test_directory_with_date"
  result <- create_dir(dir_prefix, date = T)

  # List all directories that match the prefix
  expected <- file.path(dir_prefix, format(Sys.Date(), "%Y_%m_%d"))

  # Check that at least one directory with the expected prefix and date format exists
  expect_true(dir.exists(expected), "Directory with date should be created")

  unlink(result, recursive = TRUE)
})

test_that("Handling existing directory", {
  dir_name <- "existing_directory"
  create_dir(dir_name)
  create_dir(dir_name)  # Attempt to create again
  expect_true(dir.exists(dir_name), "Existing directory should still exist")
  unlink(dir_name, recursive = TRUE)
})


# Test save_df -----------------------------------------------------------------
test_that("save_df creates directory and saves CSV", {
  df <- data.frame(x = 1:10, y = rnorm(10))
  dir_name <- "test_csv_dir"
  file_name <- "test_csv_file"

  if (dir.exists(dir_name)) {
    unlink(dir_name, recursive = TRUE)
  }

  save_df(df, file_name, dir_name, file_type = "csv")
  expect_true(dir.exists(dir_name))
  expect_true(file.exists(file.path(dir_name, paste0(file_name, ".csv"))))
  unlink(dir_name, recursive = TRUE)
})


test_that("save_df saves TSV", {
  df <- data.frame(x = 1:10, y = rnorm(10))
  dir_name <- "test_tsv_dir"
  file_name <- "test_tsv_file"

  if (dir.exists(dir_name)) {
    unlink(dir_name, recursive = TRUE)
  }

  save_df(df, file_name, dir_name, file_type = "tsv")
  expect_true(dir.exists(dir_name))
  expect_true(file.exists(file.path(dir_name, paste0(file_name, ".tsv"))))
  unlink(dir_name, recursive = TRUE)
})

test_that("save_df saves RDA", {
  df <- data.frame(x = 1:10, y = rnorm(10))
  dir_name <- "test_rda_dir"
  file_name <- "test_rda_file"

  if (dir.exists(dir_name)) {
    unlink(dir_name, recursive = TRUE)
  }

  save_df(df, file_name, dir_name, file_type = "rda")
  expect_true(dir.exists(dir_name))
  expect_true(file.exists(file.path(dir_name, paste0(file_name, ".rda"))))
  unlink(dir_name, recursive = TRUE)
})

test_that("save_df works with existing directory", {
  df <- data.frame(x = 1:10, y = rnorm(10))
  dir_name <- "existing_dir"
  file_name <- "test_existing_file"

  if (!dir.exists(dir_name)) {
    dir.create(dir_name)
  }

  save_df(df, file_name, dir_name, file_type = "csv")
  expect_true(file.exists(file.path(dir_name, paste0(file_name, ".csv"))))
  unlink(dir_name, recursive = TRUE)
})

test_that("save_df handles invalid file type", {
  df <- data.frame(x = 1:10, y = rnorm(10))
  dir_name <- "test_invalid_dir"
  file_name <- "test_invalid_file"
  invalid_file_type <- "invalid"

  if (dir.exists(dir_name)) {
    unlink(dir_name, recursive = TRUE)
  }

  expected_error_message <- paste("Unsupported file type:", invalid_file_type)
  expect_error(save_df(df, file_name, dir_name, file_type = invalid_file_type), expected_error_message)
  expect_false(dir.exists(dir_name))
})


# Test import_df ---------------------------------------------------------------
test_that("import_df handles CSV files", {
  df_out <- data.frame(x = 1:10, y = rnorm(10))
  file_name <- "test_file.csv"
  utils::write.csv(df_out, file_name, row.names = FALSE)
  expect_true(file.exists(file_name))

  if (file.exists(file_name)) {
    df_in <- import_df(file_name)
    expect_true(tibble::is_tibble(df_in))
  } else {
    skip("Test skipped: File not found.")
  }

  unlink(file_name, recursive = TRUE)
})


test_that("import_df handles TSV files", {
  df_out <- data.frame(x = 1:10, y = rnorm(10))
  file_name <- "test_file.tsv"
  utils::write.table(df_out, file_name, sep='\t', row.names = FALSE, col.names = TRUE)
  expect_true(file.exists(file_name))

  if (file.exists(file_name)) {
    df_in <- import_df(file_name)
    expect_true(tibble::is_tibble(df_in))
  } else {
    skip("Test skipped: File not found.")
  }

  unlink(file_name, recursive = TRUE)
})


test_that("import_df handles TXT files", {
  df_out <- data.frame(x = 1:10, y = rnorm(10))
  file_name <- "test_file.txt"
  utils::write.table(df_out, file_name, row.names = FALSE, col.names = TRUE)
  expect_true(file.exists(file_name))

  if (file.exists(file_name)) {
    df_in <- import_df(file_name)
    expect_true(tibble::is_tibble(df_in))
  } else {
    skip("Test skipped: File not found.")
  }

  unlink(file_name, recursive = TRUE)
})


test_that("import_df handles RDS files", {
  df_out <- data.frame(x = 1:10, y = rnorm(10))
  file_name <- "test_file.rds"
  saveRDS(df_out, file = file_name)
  expect_true(file.exists(file_name))

  if (file.exists(file_name)) {
    df_in <- import_df(file_name)
    expect_true(tibble::is_tibble(df_in))
  } else {
    skip("Test skipped: File not found.")
  }

  unlink(file_name, recursive = TRUE)
})


test_that("import_df handles RDA files", {
  df_out <- data.frame(x = 1:10, y = rnorm(10))
  file_name <- "test_file.rda"
  save(df_out, file = file_name)
  expect_true(file.exists(file_name))

  if (file.exists(file_name)) {
    df_in <- import_df(file_name)
    expect_true(tibble::is_tibble(df_in))
  } else {
    skip("Test skipped: File not found.")
  }

  unlink(file_name, recursive = TRUE)
})


test_that("import_df handles XLSX files", {
  df_out <- data.frame(x = 1:10, y = rnorm(10))
  file_name <- "test_file.xlsx"
  writexl::write_xlsx(df_out, file_name)
  expect_true(file.exists(file_name))

  if (file.exists(file_name)) {
    df_in <- import_df(file_name)
    expect_true(tibble::is_tibble(df_in))
  } else {
    skip("Test skipped: File not found.")
  }

  unlink(file_name, recursive = TRUE)
})


test_that("import_df handles Parquet files", {
  file_name <- "../testdata/test_parquet.parquet"
  expect_true(file.exists(file_name))

  if (file.exists(file_name)) {
    df_in <- import_df(file_name)
    expect_true(tibble::is_tibble(df_in))
  } else {
    skip("Test skipped: File not found.")
  }
})


# Test widen_data --------------------------------------------------------------
test_that("widen_data widens data properly", {
  result <- widen_data(example_data)
  expected <- example_data |>
    dplyr::select(DAid, Assay, NPX) |>
    tidyr::pivot_wider(names_from = Assay, values_from = NPX)
  expect_equal(result, expected)
})
