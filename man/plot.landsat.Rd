\name{plot.landsat}

\alias{plot.landsat}
\alias{plot,landsat,missing-method}
\alias{plot,landsat-method}

\title{Plot landsat data}

\description{Plot landsat data.}

\usage{\S4method{plot}{landsat}(x, which=1, band, decimate=1, zlim, col=oceColorsPalette,
    debug=getOption("oceDebug"), \dots)
}
\arguments{

  \item{x}{A \code{landsat} object, e.g. as read by
      \code{\link{read.landsat}}.}

  \item{which}{desired plot type; 1=image, 2=histogram.}

  \item{zlim}{either a pair of numbers giving the limits for the colourscale,
      or \code{"histogram"} to have a flattened histogram (i.e. to maximally
      increase contrast throughout the domain.)  If not given, the 1 and 99
      percent quantiles are calculated and used as limits.}

  \item{col}{a function yielding colours, taking a single integer argument with
      the desired number of colours.}

  \item{band}{if given, the number of the band to plot (between 1 and 11 for
      Landsat-8).  If not given, 8 will be used if band8 exists in the object
      data, or otherwise the first band will be used.}
      
  \item{decimate}{decimation interval for images plots; e.g. setting to 10
      means to show only every 10-th point in both directions, for a plot
      simplification by a factor 100.  The purpose is mainly to speed up
      plotting, which can be slow on large landsat images.}

  \item{debug}{set to a positive value to get debugging information during
      processing.}

  \item{\dots}{optional arguments passed to plotting functions.}

}

\details{Since landsat images are very detailed, it is sensible to use a fast
    plotting device, e.g. \code{\link{x11}}, and to use perhaps
    \code{decimate=10} for initial images.  The histogram plot can be handy in
    setting scales, e.g. when an image has a fair bit of land, the histogram
    will be double-lobed, and so quick examination can help in setting a good
    value for \code{zlim}.  Using \code{zlim="histogram"} is probably the
    fastest way to explore an image for detail, but it is important to bear in
    mind that it yields a nonlinear colourscale.}

\seealso{The documentation for \code{\link{landsat-class}} explains the
    structure of landsat objects, and also outlines the other functions dealing
    with them.  The \code{ocedata} package provides a dataset named
    \code{landsat}.}

\examples{
\dontrun{
library(oce)
library(ocedata)
data(landsat)
plot(landsat, which=1, band=8, xlim=c(0.10, 0.15), breaks=200) # suggests z limits
plot(landsat, which=2)
plot(landsat, which=2, zlim=c(0.105, 0.130))
plot(landsat, which=2, zlim="histogram") # ugly but shows details best
}
}

\author{Dan Kelley}

\keyword{hplot}
