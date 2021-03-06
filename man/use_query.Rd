% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sql.R
\name{use_query}
\alias{use_query}
\title{Load SQL Query}
\usage{
use_query(module, query, prefix = "mdl_", ...)
}
\arguments{
\item{module}{Which module}

\item{query}{Query}

\item{prefix}{Defaults to \code{"mdl_"}}

\item{...}{Further arguments to match sql query fields}
}
\description{
Load SQL query template and replace given fields with values.
}
