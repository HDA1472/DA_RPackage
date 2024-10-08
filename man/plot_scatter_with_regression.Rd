% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualize.R
\name{plot_scatter_with_regression}
\alias{plot_scatter_with_regression}
\title{Plot a scatter plot with regression line}
\usage{
plot_scatter_with_regression(
  plot_data,
  x,
  y,
  se = FALSE,
  line_color = "black",
  r_2 = TRUE
)
}
\arguments{
\item{plot_data}{The wide dataset containing the data to plot as cols.}

\item{x}{The column name of the x-axis variable.}

\item{y}{The column name of the y-axis variable.}

\item{se}{Whether to add the standard error of the regression line. Default is FALSE.}

\item{line_color}{The color of the regression line.}

\item{r_2}{Whether to add the R-squared and p-value to the plot. Default is TRUE.}
}
\value{
The scatter plot with the regression line.
}
\description{
\code{plot_scatter_with_regression} plots a scatter plot with a linear regression line.
It is possible to add the standard error of the regression line, as well as the
R-squared and p-value.
}
\examples{
# Prepare the data
wide_data <- widen_data(example_data)

# Scatter plot for AARSD1 and ABL1
plot_scatter_with_regression(wide_data, "AARSD1", "ABL1", line_color = "red3")
}
