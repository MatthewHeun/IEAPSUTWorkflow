% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/table_functions.R
\name{assemble_eta_fu_tables}
\alias{assemble_eta_fu_tables}
\title{Assemble completed final-to-useful efficiency tables}
\usage{
assemble_eta_fu_tables(
  incomplete_eta_fu_tables,
  exemplar_lists,
  completed_fu_allocation_tables,
  countries,
  max_year = NULL,
  which_quantity = c(IEATools::template_cols$eta_fu, IEATools::template_cols$phi_u),
  country = IEATools::iea_cols$country,
  year = IEATools::iea_cols$year,
  exemplars = SEAPSUTWorkflow::exemplar_names$exemplars,
  exemplar_tables = SEAPSUTWorkflow::exemplar_names$exemplar_tables,
  alloc_data = SEAPSUTWorkflow::exemplar_names$alloc_data,
  incomplete_eta_tables = SEAPSUTWorkflow::exemplar_names$incomplete_eta_table,
  complete_eta_tables = SEAPSUTWorkflow::exemplar_names$complete_eta_table
)
}
\arguments{
\item{incomplete_eta_fu_tables}{An incomplete data frame of final-to-useful efficiencies for all Machines in \code{completed_fu_allocation_tables}.}

\item{exemplar_lists}{A data frame containing \code{country} and \code{year} columns along with a column of ordered vectors of strings
telling which countries should be considered exemplars for the country and year of this row.}

\item{completed_fu_allocation_tables}{A data frame containing completed final-to-useful allocation data,
typically the result of calling \code{assemble_fu_allocation_tables}.}

\item{countries}{A vector of countries for which completed final-to-useful allocation tables are to be assembled.}

\item{max_year}{The latest year for which analysis is desired. Default is \code{NULL}, meaning analyze all years.}

\item{which_quantity}{A vector of quantities to be completed in the eta_FU table.
Default is \code{c(IEATools::template_cols$eta_fu, IEATools::template_cols$phi_u)}.
Must be one or both of the default values.}

\item{country, year}{See \code{IEATools::iea_cols}.}

\item{exemplars, exemplar_tables, alloc_data, incomplete_eta_tables, complete_eta_tables}{See \code{SEAPSUTWorkflows::exemplar_names}.}
}
\value{
A tidy data frame containing completed final-to-useful efficiency tables.
}
\description{
This function is used in a drake workflow to assemble completed final-to-useful efficiency tables
given a set of incomplete efficiency tables.
Information from exemplar countries is used to complete incomplete final-to-useful efficiency tables.
See examples for how to construct \code{exemplar_lists}.
}
\details{
Note that this function can accept tidy or wide by year data frames.
The return value is a tidy data frame.
}
\examples{
# Make some incomplete efficiency tables for GHA by removing Wood cookstoves.
# Information from the exemplar, ZAF, will supply efficiency for Wood cookstoves.
incomplete_eta_fu_tables <- IEATools::load_eta_fu_data() \%>\%
  dplyr::filter(! (Country == "GHA" & Machine == "Wood cookstoves"))
# The rows for Wood cookstoves are missing.
incomplete_eta_fu_tables \%>\%
  dplyr::filter(Country == "GHA", Machine == "Wood cookstoves")
# Set up exemplar list
el <- tibble::tribble(
  ~Country, ~Year, ~Exemplars,
  "GHA", 1971, c("ZAF"),
  "GHA", 2000, c("ZAF"))
# Load FU allocation data.
# An efficiency is needed for each machine in FU allocation data.
fu_allocation_data <- IEATools::load_fu_allocation_data()
# Assemble complete allocation tables
completed <- assemble_eta_fu_tables(incomplete_eta_fu_tables = incomplete_eta_fu_tables,
                                    exemplar_lists = el,
                                    completed_fu_allocation_tables = fu_allocation_data,
                                    countries = "GHA")
# Show that the missing rows have been picked up from the exemplar country, ZAF.
completed \%>\%
  dplyr::filter(Country == "GHA", Machine == "Wood cookstoves")
}
