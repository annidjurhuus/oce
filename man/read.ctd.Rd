\name{read.ctd}

\alias{read.ctd}
\alias{read.ctd.sbe}
\alias{read.ctd.woce}
\alias{read.ctd.woce.other}
\alias{read.ctd.odf}
\alias{read.ctd.itp}

\title{Read a CTD data file}

\description{Read a CTD data file, producing an object of type \code{ctd}.}

\usage{
read.ctd(file, type=NULL, columns=NULL, station=NULL, 
  monitor=FALSE, debug=getOption("oceDebug"), processingLog, \dots)
read.ctd.sbe(file, columns=NULL, station=NULL, missing.value,
  monitor=FALSE, debug=getOption("oceDebug"), processingLog, \dots)
read.ctd.woce(file, columns=NULL, station=NULL, missing.value=-999, 
  monitor=FALSE, debug=getOption("oceDebug"), processingLog, \dots)
read.ctd.woce.other(file, columns=NULL, station=NULL, missing.value=-999, 
  monitor=FALSE, debug=getOption("oceDebug"), processingLog, \dots)
read.ctd.odf(file, columns=NULL, station=NULL, missing.value=-999, 
  monitor=FALSE, debug=getOption("oceDebug"), processingLog, \dots)
read.ctd.itp(file, columns=NULL, station=NULL, missing.value=-999, 
  monitor=FALSE, debug=getOption("oceDebug"), processingLog, \dots)
}

\arguments{

  \item{file}{a connection or a character string giving the name of the file to
      load.  For \code{read.ctd.sbe()} and \code{read.ctd.woce()}, this may be
      a wildcard (e.g.  \code{"*.cnv"} or \code{"*.csv"}) in which case the
      return value is a vector containing CTD objects created by reading the
      files from \code{\link{list.files}} with \code{pattern} set to the
      specified wildcard pattern.}

  \item{type}{if \code{NULL}, then the first line is studied, in order to
      determine the file type.  If \code{type="SBE19"}, then a \emph{Seabird
          19} (or similar) CTD format is assumed. If \code{type="WOCE"} then a
      WOCE-exchange file is assumed.  If \code{type="ITP"} then an ice-tethered
      profiler file is assumed.}
  \item{debug}{a flag that turns on debugging.  Set to 1 to get a
    moderate amount of debugging information, or to 2 to get more.} 

  \item{columns}{if \code{NULL}, then \code{read.ctd} tries to infer column
      names from the header.  For SBE files only, the \code{column} argument
      can control the column selection.  It is a list that names data types and
      the columns containing them, starting at 1.  The list must include
      \code{"pressure"}, \code{"temperature"} and \code{"salinity"}, with any
      other values being ignored (in this version of the function).  Note that
      SBE headers count the "name" from zero, e.g. if the header line says
      \code{# name 1 = prDM: Pressure, Digiquartz [db]} then the correct
      specification to get this pressure would be
      \code{columns=list(pressure=2, ...)}.}

  \item{station}{optional character string containing an identifying name (or
    number) for the station. (This can be useful if the routine cannot determine
    the name automatically, or if another name is preferred.)}
  \item{missing.value}{optional missing-value flag; data matching this value will
    be set to \code{NA} upon reading.}
  \item{monitor}{boolean, set to \code{TRUE} to provide an indication
    of progress.  This is useful if \code{filename} is a wildcard.}
  \item{processingLog}{if provided, the action item to be stored in the
    log.  (Typically only provided for internal calls; the default that
    it provides is better for normal calls by a user.)}
  \item{\dots}{additional arguments, passed to called routines.}
}

\details{These functions read CTD datasets that have been stored in common
    formats, and could be extended to accommodate other formats if needed.  The
    basic function is \code{read.ctd}, which analyzes some of the file
    contents, and then calls one of the following, any of which can be called
    directly.
    \itemize{
        \item \code{read.ctd.sbe()} reads files files created by Seabird CTD
        instruments.  These are recognized by a first line with first ten
        characters ``\code{* Sea-Bird}.''
        \item \code{read.ctd.woce()} reads files stored in the exchange format
        used by the World Ocean Circulation Experiment (WOCE) (first 4
        characters of the first line being ``\code{CTD,}''), and also in a
        rarer format with the first 3 characters being ``\code{CTD}'' followed by
        a blank or the end of the line).
        \item \code{read.ctd.woce.other()} reads the format called ``CTD''
        in the section of the archive websites named ``Other formats.''  These
        data are stored in filenames ending \code{.WCT}, and they do not have 
        a great deal of metadata (e.g. longitude), so the user is forced to infer
        such things from a separate file.  Support for this data type is limited,
        e.g. requiring a header of a certain length and data columns in a certain order. 
        Improvements are unlikely to be added to the function, since
        this data type seems to offer no advantages
        over the type handled by \code{read.ctd.woce()}.
        \item \code{read.ctd.odf()} reads files stored in Ocean Data Format,
        used in some Canadian hydrographic databases.
    }

    Different file types provide different meta-information.  For example, the
    WOCE exchange format binds together the institute name and the initials of
    the chief scientist into a single string that \code{read.ctd} cannot parse,
    so both \code{object@metadata$institute} and
    \code{object@metadata$scientist} are left blank for WOCE files.
}

\section{Implementation and extension}{The functions attempt to infer a wide range of
    meta-information from file headers, but variations in these headers limit
    general application.  For example, \code{read.ctd.sbe} handles water depths
    in any of the following forms, but ostensibly similar forms may not work.
    \itemize{
        \item \preformatted{"** DEPTH = 100"}
        \item \preformatted{"** Water Depth:   40 m"}
        \item \preformatted{"** Depth (m): 3447 "}
        \item \preformatted{"** Depth: 16"}
        \item \preformatted{"** Profondeur: 92"}
    }
    If water depth cannot be inferred from the header, \code{read.ctd} sets it
    to the maximum recorded pressure, and issues a warning to that effect.

    Similar issues come up for essentially everything stored in CTD headers,
    and so if odd values are found (e.g. a station in the wrong hemisphere),
    there is a good chance that the format is not being handled correctly.
    Given the expense of collecting data, users are well-advised to check
    inferred values against the values in the data files, for at least on
    profile within a given cruise.  Modifying the \code{read.ctd} code is not
    particularly difficult, and users are encouraged to examine the source code
    (in \code{R/ctd.R}) to see whether modification can help.  Some experience
    with regular expressions and string manipulation may be needed; see
    \code{\link{regexpr}} and \code{\link{sub}}.
    Three sample files are provided with the package, in
    \itemize{\item \code{system.file("extdata", "ctd.cnv", package="oce")}
    \item \code{system.file("extdata", "d200321-001.ctd", package="oce")}
    \item \code{system.file("extdata", "CTD_BCD2010666_01_01_DN.ODF", package="oce")}}
    and an examination of these in relationship with the existing code should help
    users to understand the present implementation, providing insights on extending it
    for their own data.

    In many cases, CTD instruments are set up to report dates in English.  This
    can cause a problem for users running in different locales, since e.g month
    names differ.  Therefore, if you know your datafile is written in
    American-English notation, you might want to do
    \code{Sys.setlocale("LC_TIME", "en_US")} before you try to read the data.

}

\value{An object of \code{\link[base]{class}} \code{"ctd"}, which is a
  list with elements detailed below. 
  The most important elements are the station name and position, along
  with the profile data that are contained in the data frame named \code{data}.
  (Other elements in the list may be deleted in future versions of the
  package, if they prove to be of little use in practice, or if they prove
  to have been idiosyncratic features of the particular files used in
  early development of \code{oce}.)
  \item{data}{a data table containing the profile data.  The column
    names are discovered from the header, and may differ from file
    to file.  For example, some CTD instruments may have a fluorometer
    connected, others may not.  The order of the columns may vary from
    case to case, and so it is important to refer to them by name.
    The following vectors are normally present: \code{data$pressure},
    \code{data$salinity}, \code{data$temperature}, and
    \code{data$sigmatheta}. (\eqn{\sigma_\theta}{sigma-theta} is calculated
    using \code{\link{swSigmaTheta}}.)}
  \item{metadata}{a list containing the following items
    \describe{
      \item{\code{header}}{the header itself, normally containing
	several dozen lines of information.}
      \item{\code{filename}}{name of the file passed to \code{read.ctd}.}
      \item{\code{filename.orig}}{name of the original file saved by the
	instrument (normally a hex file).}
      \item{\code{system.upload.time}}{system upload time.}
      \item{\code{ship}}{name of vessel from which the CTD was deployed.}
      \item{\code{scientist}}{name of the scientist leading the work at sea.}
      \item{\code{institute}}{name of the institute behind the work.}
      \item{\code{address}}{the address of the institute where the
	scientist works.}
      \item{\code{cruise}}{name of cruise.}
      \item{\code{station}}{station number or name.}
      \item{\code{date}}{date of lowering of CTD into the water.}
      \item{\code{startTime}}{time when instrument started recording data.}
      \item{\code{latitude}}{latitude, in decimal degrees, positive
	north of equator.}
      \item{\code{longitude}}{longitude, in decimal degrees, positive if
	east of Greenwich and west of dateline.}
      \item{\code{recovery}}{date of recovery of CTD.}
      \item{\code{waterDepth}}{the water depth at the site.}
      \item{\code{sampleInterval}}{time interval between samples, in
	seconds.}
    }
  }
  \item{processingLog}{a processingLog of processing, in the standard \code{oce} format.}
}

\seealso{The documentation for \code{\link{ctd-class}} explains the structure
    of \code{ctd} objects, and also outlines the other functions dealing with
    them.}

\examples{
library(oce)
\dontrun{
## Labrador Sea data, file 0001919.tar.gz from website
## http://www.nodc.noaa.gov/cgi-bin/OAS/prd/accession/download
d <- read.ctd.woce("*.csv")
data(coastlineWorld)
plot(coastlineWorld, clat=55, clon=-50, span=5000)
longitude <- sapply(d, function(stn) stn[['longitude']])
latitude <- sapply(d, function(stn) stn[['latitude']])
points(longitude, latitude, col='red')
}
}

\references{The Sea-Bird SBE 19plus profiler is described at
    \url{http://www.seabird.com/products/spec_sheets/19plusdata.htm}.  The
    company recommends the use of their own software, and perhaps for this
    reason it is difficult to find a specification for the data files.
    Inspection of data files led to most of the code used in Oce.  If the
    company ever publishes standards for the data formats, of course Oce will
    be adjusted.  In the meantime, it does a reasonable job in many instances.

    The WOCE-exchange format is described at
    \url{http://woce.nodc.noaa.gov/woce_v3/wocedata_1/whp/exchange/exchange_format_desc.htm},
    and a sample file is at
    \url{http://woce.nodc.noaa.gov/woce_v3/wocedata_1/whp/exchange/example_ct1.csv}

    The ODF format, used by the Canadian Department of Fisheries and Oceans, is
    described at
    \url{http://slgo.ca/app-sgdo/en/docs_reference/documents.html}, and this
    was used as a base for \code{read.ctd.odf}.  However, it was only a
    starting point, for examination of data files revealed many variants in the
    names of the data columns.  If anything odd happens with ODF files (e.g. if
    they cannot be plotted), the first thing to do is to reread the files with
    \code{debug=1}, to see if column names were converted properly.

    Ice-tethered profile (ITF) data are available at \url{www.whoi.edu/itf};
    note that the present version only handles data in profiler-mode, not
    fixed-depth mode.

}


\author{Dan Kelley}

\keyword{misc}
