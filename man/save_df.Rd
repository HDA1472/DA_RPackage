% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{save_df}
\alias{save_df}
\title{Save tibble as CSV, TSV, Excel or RDA file}
\usage{
save_df(
  df,
  file_name,
  dir_name,
  date = FALSE,
  file_type = c("csv", "tsv", "rda", "xlsx")
)
}
\arguments{
\item{df}{The dataframe to save.}

\item{file_name}{The name of the file to save.}

\item{dir_name}{The directory where the file will be saved.}

\item{date}{If TRUE, a directory with the current date as name will be created in the directory with \code{dir_name}.}

\item{file_type}{The type of file to save the dataframe as. Options are "csv", "tsv", "rda", or "xlsx".}
}
\description{
\code{save_df()} saves a dataframe in the specified format (csv, tsv, rda, or xlsx) in a
specified directory. If the directory does not exist, it will be created.
The recommended file type is RDA.
}
\examples{
# Save a metadata dataframe as an RDA file
save_df(example_metadata, "metadata", "my_data", file_type = "rda")

file.exists("my_data/metadata.rda")  # Check if the file exists
unlink("my_data", recursive = TRUE)  # Clean up the created directory
}
