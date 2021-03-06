\name{drifter-class}

\docType{class}

\alias{drifter-class}
\alias{[[,drifter-method}

\title{Class for drifter data}

\description{Class to store drifter data, with standard slots \code{metadata},
    \code{data} and \code{processingLog}.}

\section{Methods}{Data may be accessed as e.g. \code{pt[["time"]]}, where the
    string could also be \code{"longitude"} or \code{"latitude"}.  The profile
    data are available in \code{"salinity"}, \code{"temperature"} and
    \code{"pressure"}, each of which is a matrix with first index corresponding
    to depth and second index corresponding to profile number.  Assignment to
    these can be made with e.g. \code{drifter[["latitude"]] <- value}, etc.
    Indeed, any quantity in the \code{metadata} slot or the \code{data} slot
    can be retrieved or updated in this way.}

\seealso{A \code{drifter} object may be read with \code{\link{read.drifter}} or
    created with \code{\link{as.drifter}}.  Plots can be made with
    \code{\link{plot.drifter}}, while \code{\link{summary.drifter}} produces
    statistical summaries and \code{show} produces overviews.}

\author{Dan Kelley}

\keyword{classes}
\keyword{oce}

