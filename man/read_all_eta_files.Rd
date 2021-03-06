% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/machine_functions.R
\name{read_all_eta_files}
\alias{read_all_eta_files}
\title{Create a data frame containing machine Eta.fu and Phi.u values.}
\usage{
read_all_eta_files(eta_fin_paths)
}
\arguments{
\item{eta_fin_paths}{A list of the file paths to machine excel files containing
FIN_ETA frontsheets, and therefore usable data.
Created by calling the \code{get_eta_filepaths} function.}
}
\value{
A data frame containing all Eta.fu and Phi.u values present
in all Machine excel files, with the following column names:
"Country", "Machine", "Eu.product", "Metric", "Year", "Value".
}
\description{
Create a data frame containing machine Eta.fu and Phi.u values.
}
