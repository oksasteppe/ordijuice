\name{draw.nmds}
\alias{draw.nmds}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
draw.nmds
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
draw.nmds(display.in.diagram = c("sites"), display.species = c("none"), display.sites = c("points"), axes.shown = c(1, 2), display.EIV = FALSE, display.header = FALSE, display.envelope = FALSE, header.name = "env", display.header.style = c("arrow"), display.spider, display.group.center = FALSE, three.dim = FALSE, resolution = c(1280, 768), bw = FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{display.in.diagram}{
%%     ~~Describe \code{display.in.diagram} here~~
}
  \item{display.species}{
%%     ~~Describe \code{display.species} here~~
}
  \item{display.sites}{
%%     ~~Describe \code{display.sites} here~~
}
  \item{axes.shown}{
%%     ~~Describe \code{axes.shown} here~~
}
  \item{display.EIV}{
%%     ~~Describe \code{display.EIV} here~~
}
  \item{display.header}{
%%     ~~Describe \code{display.header} here~~
}
  \item{display.envelope}{
%%     ~~Describe \code{display.envelope} here~~
}
  \item{header.name}{
%%     ~~Describe \code{header.name} here~~
}
  \item{display.header.style}{
%%     ~~Describe \code{display.header.style} here~~
}
  \item{display.spider}{
%%     ~~Describe \code{display.spider} here~~
}
  \item{display.group.center}{
%%     ~~Describe \code{display.group.center} here~~
}
  \item{three.dim}{
%%     ~~Describe \code{three.dim} here~~
}
  \item{resolution}{
%%     ~~Describe \code{resolution} here~~
}
  \item{bw}{
%%     ~~Describe \code{bw} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(display.in.diagram = c('sites'),
                     display.species = c('none'),
                     display.sites = c('points'),
                     axes.shown = c(1,2),
                     display.EIV = FALSE,
                     display.header = FALSE,
                     display.envelope = FALSE,
                     header.name = 'env',
                     display.header.style = c('arrow'),
                     display.spider,
                     display.group.center = FALSE,
                     three.dim = FALSE,
                     resolution = c(1280, 768),
                     bw = FALSE,
                     ...) 
{
  newRversion <- check.install (display.spider)
  open.r.window(three.dim, resolution)
  if (newRversion) pb <- myTkProgressBar (paste (ifelse (three.dim, '3D', '2D'),'NMDS - Analysis progress'), 'Importing data from JUICE', 0, 100, 20) else pb <- NULL
  
  if (three.dim) axes.shown <- c(1,2,3) else axes.shown <- c(1,2)
  k <- ifelse (three.dim, 3, 2)
  write ('End of ordination', file='result.txt')
  library (vegan)
  input.data <- read.check.data (display.sites = display.sites, display.EIV = display.EIV, display.header = display.header, display.envelope = display.envelope, display.spider = display.spider, display.group.center = display.group.center)

## 2. update progress bar
if (newRversion) setTkProgressBar (pb, label = 'Calculation of ordination', value = 40)

## calculation of ordination
  last.result <-  use.last (input.data, 'nmds', setting = list (k = k))
  if (last.result$use.last.result) spec.data.ord <- last.result$last.data.result  else
  spec.data.ord <- metaMDS(input.data$spec.data, distance = 'bray', k = k, trymax=0, autotransform = FALSE, zerodist = "add")

# 3. update progress  bar
  if (newRversion) setTkProgressBar (pb, label = 'Saving results', value = 60)

  save.ord.result (spec.data.ord, last.result$use.last.result, 'nmds', input.data$deleted.plots)  

# 4. update progress  bar
  if (newRversion) setTkProgressBar (pb, label = 'Drawing the figure', value = 80)

  if (three.dim)  
    draw.3d(input.data = input.data, spec.data.ord = spec.data.ord, display.in.diagram = display.in.diagram, display.species = display.species, display.sites = display.sites, axes.shown = axes.shown, display.EIV = display.EIV, display.header = display.header, display.envelope = display.envelope, header.name = header.name, display.header.style = display.header.style, display.spider = display.spider, display.group.center = display.group.center, pb = pb) else
    draw.2d(input.data = input.data, spec.data.ord = spec.data.ord, display.in.diagram = display.in.diagram, display.species = display.species, display.sites = display.sites, axes.shown = axes.shown, display.EIV = display.EIV, display.header = display.header, display.envelope = display.envelope, header.name = header.name, display.header.style = display.header.style, display.spider = display.spider, display.group.center = display.group.center, bw = bw, pb = pb)
  
  if (!last.result$use.last.result)
    {
    last.data <- list (last.matrix.sum = sum(input.data$spec.data), last.matrix.species = colnames (input.data$spec.data), last.matrix.sites = rownames (input.data$spec.data), last.result = spec.data.ord)
    save (last.data, file = 'nmds_lfa.r')
    last.data.quick <- list (type.of.analysis = 'nmds', size.of.matrix = dim (input.data$spec.data), setting = list (k = k))
    save (last.data.quick, file = 'nmds_lfq.r')
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
