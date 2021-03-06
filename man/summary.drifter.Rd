\name{summary.drifter}

\alias{summary.drifter}
\alias{summary,drifter,missing-method}
\alias{summary,drifter-method}

\title{Summarize a drifter object}

\description{Summarizes some of the data in a \code{drifter} object.}

\usage{\S4method{summary}{drifter}(object, \dots)}

\arguments{
  \item{object}{an object of class \code{"drifter"}, usually, a result of a
    call to \code{\link{read.drifter}}.}
  \item{\dots}{further arguments passed to or from other methods.}
}

\details{Pertinent summary information is presented.}

\value{An object of class \code{"summary.drifter"}, which contains
  pertinent information about the CTD record and its processing.}

\seealso{The documentation for \code{\link{drifter-class}} explains the
    structure of drifter objects, and also outlines the other functions dealing
    with them.}

\examples{
library(oce)
data(drifter)
summary(drifter)
}

\references{\url{http://www.argo.ucsd.edu/}}

\author{Dan Kelley}

\keyword{misc}
