\name{echosounder}

\docType{data}

\alias{echosounder}

\title{echosounder dataset}

\description{This is degraded subsample of measurements that were made with a
    Biosonics scientific echousounder, as part of the St Lawrence Internal Wave
    Experiment (SLEIWEX).}

\examples{
\dontrun{
library(oce)
data(echosounder)
plot(echosounder)
plot(echosounder, drawBottom=TRUE)
plot(echosounder, which=2, drawBottom=TRUE, atTop=pretty(echosounder[["time"]]))
}
}

\usage{data(echosounder)}

\source{This file came from the SLEIWEX-2008 experiment.}

\seealso{The documentation for \code{echosounder-class} in the Oce package
    explains the structure of echosounder objects, and also outlines the other
    functions dealing with them.}

\author{Dan Kelley}

\keyword{datasets}
