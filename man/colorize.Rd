\name{colorizeAlpha}

\alias{colorize}
\alias{colorizeAlpha}

\title{Calculate colors (Draft Alpha Version)}

\description{Calculate colors for use in palettes and plots}

\usage{colorizeAlpha(z, breaks, col=oceColorsJet, colormap, segments=1)}

\arguments{

  \item{z}{an optional vector or other set of numerical values to be examined.}

  \item{breaks}{an optional vector of numerical values for break points between
      color levels (see \code{\link{image}}).  If this is not provided, and if
      \code{colormap} is missing, then \code{pretty(z,n=10)} is used.  If
      \code{breaks} is provided but consists of only a single number, then
      again \code{\link{pretty}} is called, but with \code{n} set to that
      number.}
  
  \item{col}{either a vector of colors or a function taking a numerical value
      as its single argument and returning a vector of colors (see
      \code{\link{image}}.  The value of \code{col} is ignored if
      \code{palette} is provided.}

  \item{colormap}{a character string naming a built-in colormap, or a colormap
      that was created with \code{\link{colormapAlpha}}.  If \code{colormap} is
      given, then it takes precedence over both \code{breaks} and
      \code{colors}.  The only built-in choices are \code{"gmt_relief"},
      \code{"gmt_ocean"} and \code{"gmt_globe"}.  See \sQuote{References} for
      more about these GMT-based schemes.}
  
  \item{segments}{number of segments between any two \code{breaks} This is only
      used if \code{colormap} is given.  The default value of 1 yields uniform
      color between breakpoints, and higher values yield more sub-steps, with
      \code{segments} exceeding 10 or so yielding reasonably smooth blending of
      colors between breaks.}

}

\details{This function may be used to calculate \code{breaks} and \code{col}
    for \code{\link{image}}, \code{\link{imagep}} or \code{\link{drawPalette}},
    at the same time as calculating \code{col} that might be used with
    \code{\link{plot}}.  Using this function together with
    \code{\link{drawPalette}} and \code{\link{plot}} provides an assurance of
    color matching between the palette and scatter-plot.

    There are two modes of use.  If \code{colormap} is not supplied, this
    function uses \code{breaks} and/or \code{colors} to construct a color
    scheme; the meaning of these values is the same as for \code{\link{image}}.

    However, if \code{colormap} is supplied, it takes precedence over
    \code{breaks} and \code{colors}.  Colormaps can be convenient because they
    provide standardized linkage between value and colour, which is helpful
    when certain values are naturally linked with certain colours, e.g. zero
    elevation or current velocity.}

\value{A list containing \code{breaks} and \code{col}, as used by e.g.
    \code{\link{image}} or \code{\link{imagep}}.}

\section{Development status}{Devised in April 2014, this function is likely to
    be somewhat unstable until mid-summer 2014.  In particular, the argument
    list may change, because there is a possibility of combining this with the
    existing (and again, preliminary) function \code{\link{colormapAlpha}}.}

\examples{
library(oce)
x <- seq(0, 1, length.out=40)
y <- sin(2 * pi * x)

## 1. scatterplot
mar <- par('mar') # prevent margin creep by drawPalette()
c <- colorizeAlpha(y)
drawPalette(c$zlim, col=c$col, breaks=c$breaks)
plot(x, y, bg=c$zcol, pch=21, cex=1)
grid()
par(mar=mar)

## 2. images, showing two colourmaps
data(topoWorld)
cm1 <- colormapAlpha(name='gmt_relief')
cm2 <- colormapAlpha(file='http://www.beamreach.org/maps/gmt/share/cpt/GMT_globe.cpt')
c1 <- colorizeAlpha(colormap=cm1)
c2 <- colorizeAlpha(colormap=cm2)
par(mfrow=c(2,1))
imagep(topoWorld, breaks=c1$breaks, col=c1$col)
imagep(topoWorld, breaks=c2$breaks, col=c2$col)
}

\references{Information on GMT software is given at
    \url{http://gmt.soest.hawaii.edu}.  Diagrams showing the GMT color schemes
    are at \url{http://www.geos.ed.ac.uk/it/howto/GMT/CPT/palettes.html}, and
    their numerical specifications are at e.g.
    \url{http://www.beamreach.org/maps/gmt/share/cpt}.}

\author{Dan Kelley}

\keyword{misc}
