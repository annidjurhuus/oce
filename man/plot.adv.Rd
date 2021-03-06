\name{plot.adv}

\alias{plot.adv}
\alias{plot,adv,missing-method}
\alias{plot,adv-method}

\title{Plot ADV data}

\description{Plot ADV data}

\usage{\S4method{plot}{adv}(x,
    which=c(1:3,14,15),
    col,
    titles,
    type="l",
    lwd=par('lwd'),
    adorn=NULL,
    drawTimeRange=getOption("oceDrawTimeRange"),
    drawZeroLine=FALSE,
    useSmoothScatter,
    mgp=getOption("oceMgp"),
    mar=c(mgp[1]+1.5,mgp[1]+1.5,1.5,1.5),
    tformat,
    marginsAsImage=FALSE,
    cex=par("cex"), cex.axis=par("cex.axis"), cex.main=par("cex.main"),
    xlim, ylim,
    brushCorrelation, colBrush="red",
    main="",
    debug=getOption("oceDebug"),
    \dots)
}

\arguments{
    \item{x}{an \code{adv} object, e.g. as read by \code{\link{read.adv}}.}
    \item{which}{list of desired plot types.  These are graphed in
        panels running down from the top of the page.  See
        \dQuote{Details} for the meanings of various values of
        \code{which}.}
    \item{col}{optional indication of colour(s) to use.  If not provided,
        the default for images is \code{oceColorsPalette(128,1)}, and for
        lines and points is black.}
    \item{titles}{optional vector of character strings to be used as
        labels for the plot panels.  For images, these strings will be
        placed in the right hand side of the top margin.  For timeseries,
        these strings are ignored.
        If this is provided, its length must equal that of \code{which}.}
    \item{lwd}{if the plot is of a time-series or scattergraph format with lines,
        this is used in the usual way; otherwise, e.g. for image formats, this is ignored.}
    \item{type}{type of plot, as for \code{\link{plot}}.}
    \item{adorn}{optional list of \code{\link{expression}}s to be performed
        immediately after drawing the panels. (See \code{\link{plot.adp}} for
        an example.)}
    \item{drawTimeRange}{boolean that applies to panels with time as the
        horizontal axis, indicating whether to draw the time range in 
        the top-left margin of the plot.}
    \item{drawZeroLine}{boolean that indicates whether to draw zero
        lines on velocities.}
    \item{useSmoothScatter}{boolean that indicates whether to use
      \code{\link{smoothScatter}} in various plots, such as \code{which="uv"}.
      If not provided a default is used, with \code{\link{smoothScatter}} being
      used if there are more than 2000 points to plot.},
    \item{mgp}{3-element numerical vector to use for \code{par(mgp)}, and
        also for \code{par(mar)}, computed from this.  The default is
        tighter than the R default, in order to use more space for the data
        and less for the axes.}
    \item{mar}{value to be used with \code{\link{par}("mar")}.}
    \item{tformat}{optional argument passed to \code{\link{oce.plot.ts}}, for
        plot types that call that function.  (See \code{\link{strptime}} for the
        format used.)}
    \item{marginsAsImage}{boolean, \code{TRUE} to put a wide margin to the
        right of time-series plots, matching the space used up by a palette
        in an \code{\link{imagep}} plot.}
    \item{cex}{size of labels on axes; see \code{\link[graphics]{par}}("cex").}
    \item{cex.axis}{see \code{\link[graphics]{par}}("cex.axis").}
    \item{cex.main}{see \code{\link[graphics]{par}}("cex.main").}
    \item{xlim}{optional 2-element list for \code{xlim}, or 2-column matrix, in which case
        the rows are used, in order, for the panels of the graph.}
    \item{ylim}{optional 2-element list for \code{ylim}, or 2-column matrix, in which case
        the rows are used, in order, for the panels of the graph.}
    \item{brushCorrelation}{optional number between 0 and 100, indicating
        a per-beam correlation threshhold below which data are to be
        considered suspect.  If the plot type is \code{p}, the suspect
        points (velocity, backscatter amplitude, or correlation) will be
        coloured red; otherwise, this argument is ignored.}
    \item{colBrush}{colour to use for brushed (bad) data, if
        \code{brushCorrelation} is active.}
    \item{main}{main title for plot, used just on the top panel, if there are several panels.}
    \item{debug}{a flag that turns on debugging.  Set to 1 to get a
        moderate amount of debugging information, or to 2 to get more.} 
    \item{\dots}{optional arguments passed to plotting functions.}
}

\details{Creates a multi-panel summary plot of data measured by an ADV.
    The panels are controlled by the \code{which} argument.  (Note the
    gaps in the sequence, e.g. 4 and 8 are not used.)

    \itemize{ 
        \item \code{which=1} to \code{3} (or \code{"u1"} to \code{"u3"})

        yield timeseries of the first, second, and third components of
        velocity (in beam, xyz or enu coordinates).

        \item \code{which=4} is not permitted (since ADV are 3-beam devices)

        \item \code{which=5} to \code{7} (or \code{"a1"} to \code{"a3"})
        yield timeseries of the amplitudes of beams 1 to 3.  (Note that
        the data are called \code{data$a[,1]}, \code{data$a[,2]} and
        \code{data$a[,3]}, for these three timeseries.)

        \item \code{which=8} is not permitted (since ADV are 3-beam devices)

        \item \code{which=9} to \code{11} (or \code{"q1"} to \code{"q3"})
        yield timeseries of correlation for beams 1 to 3.  (Note that the
        data are called \code{data$c[,1]}, \code{data$c[,2]} and
        \code{data$c[,3]}, for these three timeseries.)

        \item \code{which=12} is not permitted (since ADVs are 3-beam devices)

        \item \code{which=13} is not permitted (since ADVs do not measure salinity)

        \item \code{which=14} or \code{which="temperature"} yields a timeseries of temperature.

        \item \code{which=15} or \code{which="pressure"} yields a timeseries of pressure.

        \item \code{which=16} or \code{which="heading"} yields a timeseries of heading.

        \item \code{which=17} or \code{which="pitch"}yields a timeseries of pitch.

        \item \code{which=18} or \code{which="roll"}yields a timeseries of roll.

        \item \code{which=19} to \code{21} yields plots of correlation versus
        amplitude, for beams 1 through 3, using \code{\link{smoothScatter}}.

        \item \code{which=22} is not permitted (since ADVs are 3-beam devices)

        \item \code{which=23} or \code{"progressive vector"} yields a
        progressive-vector diagram in the horizontal plane, plotted with
        \code{asp=1}, and taking beam1 and beam2 as the eastward and
        northward components of velocity, respectively.

        \item \code{which=28} or \code{"uv"} yields velocity plot in the
        horizontal plane, i.e. u[2] versus u[1].  If the number of data
        points is small, a scattergraph is used, but if it is large,
        \code{\link{smoothScatter}} is used.

        \item \code{which=29} or \code{"uv+ellipse"} as the \code{"uv"}
        case, but with an added indication of the tidal ellipse,
        calculated from the eigen vectors of the covariance matrix.

        \item \code{which=30} or \code{"uv+ellipse+arrow"} as the
        \code{"uv+ellipse"} case, but with an added arrow indicating the
        mean current.

        \item \code{which=50} or \code{"analog1"} plots a time series of the
        analog1 signal, if there is one.

        \item \code{which=51} or \code{"analog2"} plots a time series of the
        analog2 signal, if there is one.

        \item \code{which=100} or \code{"voltage"} plots the voltage as a
        timeseries, if voltage exists in the dataset.
    }
    In addition to the above, there are some groupings defined:
    \itemize{ 
        \item \code{which="velocity"} equivalent to \code{which=1:3} (three velocity components)
        \item \code{which="amplitude"} equivalent to \code{which=5:7} (three amplitude components)
        \item \code{which="backscatter"} equivalent to \code{which=9:11} (three backscatter components)
        \item \code{which="hydrography"} equivalent to \code{which=14:15} (temperature and pressure)
        \item \code{which="angles"} equivalent to \code{which=16:18} (heading, pitch and roll)
    }
}

\seealso{The documentation for \code{\link{adv-class}} explains the structure
    of ADV objects, and also outlines the other functions dealing with them.}

\examples{
library(oce)
data(adv)
plot(adv)
}

\author{Dan Kelley}

\keyword{hplot}

