\name{detrend}

\alias{detrend}

\title{Detrend a set of observations}

\description{Detrend a set of observations, which can be useful in operations
    that are thrown off by endpoints, e.g. digital filtering.}

\usage{detrend(x, y)}

\arguments{
  \item{x}{a vector of numerical values.  If \code{y} is not given, then \code{x} is taken for
      \code{y}.}
  \item{y}{an optional vector}
}

\details{Detrends \code{y} by subtracting a linear trend in \code{x}, to create
    \code{Y} that has \code{Y[1]=0} and \code{Y[length(Y)]=0}.  If \code{y} is
    not given, then y is taken from x, and x is set to the series of integers
    from 1 to \code{length{x}}.}
    
\value{A list containing \code{Y}, the detrended version of \code{y}, and the
    intercept \code{a} and slope \code{b} of the linear function of \code{x}
    that is subtracted from \code{y} to yield \code{Y}.}

\examples{
x <- seq(0, 0.9 * pi, length.out=50)
y <- sin(x)
plot(x, y)
d <- detrend(x, y)
points(x, d$Y, pch=20)
abline(h=0, lty='dotted')
abline(d$a, d$b, col='red')
points(x, d$Y + d$a + d$b * x, col='blue', pch='+')
}

\author{Dan Kelley}

\keyword{misc}
