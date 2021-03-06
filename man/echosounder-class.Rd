\name{echosounder-class}

\docType{class}

\alias{echosounder-class}
\alias{[[,echosounder-method}
\alias{[[<-,echosounder-method}
\alias{show,echosounder-method}

\title{Class to store echosounder data}

\description{Class to store echosounder data, with standard slots
    \code{metadata}, \code{data} and \code{processingLog}. The \code{data} slot
    is a list containing

    \itemize{

        \item An infrequently updated record of the intrument position, in
        \code{timeSlow}, \code{longitudeSlow} and \code{latitudeSlow}.   These
        are used in plotting maps with \code{\link{plot.echosounder}}.
      
        \item An interpolated record of the instrument position, in
        \code{time}, \code{longitude}, and \code{latitude}.  Linear
        interpolation is used to infer the longitude and latitude from the
        variables listed above.
        
        \item \code{depth}, vector of depths of echo samples (measured positive
        downwards in the water column).  This is calculated from the
        inter-sample time interval and the sound speed provided as the
        \code{soundSpeed} argument to \code{\link{read.echosounder}}, so
        altering the value of the latter will alter the echosounder plots
        provided by \code{\link{plot.echosounder}}.

        \item The echosounder signal amplitude \code{a}, a matrix whose number
        of rows matches the length of \code{time}, etc., and number of columns
        equal to the length of \code{depth}.  Thus, for example, \code{a[100,]}
        represents the depth-dependent amplitude at the time of the 100th ping.

        \item A matrix named \code{b} exists for dual-beam and split-beam
        cases.  For dual-beam data, this is the wide-beam data, whereas
        \code{a} is the narrow-beam data.  For split-beam data, this is the
        x-angle data.

        \item A matrix named \code{c} exists for split-beam data, containing
        the y-angle data.

        \item In addition to these matrices, ad-hoc calculated matrices named
        \code{Sv} and \code{TS} may be accessed as explained in the next
        section.

    }
}

\section{Methods}{

    \emph{Accessing values.} Data may be accessed as e.g.
    \code{echosounder[["time"]]}, where the string could also be e.g.  FIXME
    (add more).  The names of the columns are displayed with \code{show().} The
    name of the source file is found with \code{"filename"}.

    Derived data are also available: \code{"distance"} calls
    \code{\link{geodDist}} to compute locations, and calculates distance along
    the ship track, \code{"Sv"} returns a matrix of backscatter strength in DB,
    and \code{"TS"} returns a matrix of target strength in dB.

    \emph{Assigning values.} Everything that may be accessed may also be
    assigned, e.g.  \code{echosounder[["time"]] <- 3600 +
        echosounder[["time"]]} adds an hour to time.

    \emph{Overview of contents.} The \code{show} method (e.g.
    \code{show(echosounder)}) displays information about the object.
}

\seealso{A file containing echosounder data may be read with
    \code{\link{read.echosounder}}, and a echosounder object can also be
    created with \code{\link{as.echosounder}}.
  
  Statistical summaries are provided by \code{\link{summary.echosounder}},
  while \code{\link{show}} displays an overview.  The \code{\link{findBottom}}
  function infers the ocean bottom from tracing the strongest reflector from
  ping to ping.
  
  Echosounder objects may be plotted with \code{\link{plot.echosounder}}.

  The contents of \code{echosounder} objects may be altered with
  \code{\link{subset.echosounder}}, or with the the \code{[[]]} scheme
  discussed in the previous section; skilled users may also manipulate the
  contents directly, but this is not recommended because it is brittle to
  changes in the data structure.
}

\author{Dan Kelley}
\keyword{classes}
\keyword{oce}

