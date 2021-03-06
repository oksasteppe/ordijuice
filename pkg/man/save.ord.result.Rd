\name{save.ord.result}
\alias{save.ord.result}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
save.ord.result
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
save.ord.result(ord.result, use.last.result, type, deleted.plots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ord.result}{
%%     ~~Describe \code{ord.result} here~~
}
  \item{use.last.result}{
%%     ~~Describe \code{use.last.result} here~~
}
  \item{type}{
%%     ~~Describe \code{type} here~~
}
  \item{deleted.plots}{
%%     ~~Describe \code{deleted.plots} here~~
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
function (ord.result, use.last.result, type, deleted.plots)
{
if (type == 'dca')
{
dca <- ord.result
cat ('Results of Dentrended correspondence analysis\n\n', sep = '\t', file = 'ordi-result.txt')
if (use.last.result) cat ('PREVIOUSLY SAVED RESULTS USED FOR VISUALIZATION (e.g. as the data are the same as in previous ', type, ' analysis, also the results of previous analysis are used for visualization; this is intendet to save some time for calculation ...)\n\n', append = T, file = 'ordi-result.txt')
cat('           ','DCA1  ', 'DCA2  ','DCA3  ', 'DCA4  ', '\n', sep = '\t', append = T, file = 'ordi-result.txt')
cat('Eigenvalues', formatC(dca$evals, digits = 4, format = 'f'), '\n', sep = '\t', append = T, file = 'ordi-result.txt')
cat('Decorana values', formatC (dca$evals.decorana, digits = 4, format = 'f'),'\n', sep = '\t', append = T, file = 'ordi-result.txt')
cat('Axis length', formatC (apply(dca$rproj, 2, max), digits = 4, format = 'f'), '\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
cat('There are two versions of eigenvalues - the first (Eigenvalues) are the values calculated by the function "decorana" in vegan, the second (Decorana values) are the values calculated by the original DECORANA program of Mark Hill - these are included only for reference and should not be used. For more details see manual of vegan.\n\n', sep = '\t', append = T, file = 'ordi-result.txt')

cat('Species scores\n\n', sep = '\t', append = T, file = 'ordi-result.txt')

cat('        ','DCA1  ', 'DCA2  ','DCA3  ', 'DCA4  ', '\n', sep = '\t', append = T, file = 'ordi-result.txt')
format.cproj <- formatC (dca$cproj, digits = 4, format = 'f')
for (r in seq (1, dim (dca$cproj)[1]))
cat (rownames (dca$cproj)[r], format.cproj[r,], '\n', sep = '\t', append = T, file = 'ordi-result.txt') 

cat('\nSite scores\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
cat('  ','DCA1  ', 'DCA2  ','DCA3  ', 'DCA4  ', '\n', sep = '\t', append = T, file = 'ordi-result.txt')
format.rproj <- formatC (dca$rproj, digits = 4, format = 'f')
for (r in seq (1, dim (dca$rproj)[1]))
cat (formatC(rownames (dca$rproj)[r], format = 'd'), format.rproj[r,], '\n', sep = '\t', append = T, file = 'ordi-result.txt') 

if (!is.null (deleted.plots))
  {
  cat('\nPlots deleted due to incomplete header data:\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
  cat(deleted.plots, append = T, file = 'ordi-result.txt')
  }
  }
if (type == 'nmds')
{
nmds <- ord.result
cat ('Results of Nonmetric Multidimensional Scaling using isoMDS (MASS package)\n\n', sep = '\t', file = 'ordi-result.txt')
if (use.last.result) cat ('PREVIOUSLY SAVED RESULTS USED FOR VISUALIZATION (e.g. as the data are the same as in previous ', type, ' analysis, also the results of previous analysis are used for visualization; this is intended to save some time for calculation ...)\n\n', append = T, file = 'ordi-result.txt')

    cat("Distance:", nmds$distance, "\n", append = T, file = 'ordi-result.txt')
    cat("Dimensions:", nmds$dims, "\n", append = T, file = 'ordi-result.txt')
    cat("Stress:    ", nmds$stress, "\n", append = T, file = 'ordi-result.txt')
    if (nmds$converged) cat("Two convergent solutions found after", x$tries, 
            "tries\n", append = T, file = 'ordi-result.txt') else cat("No convergent solutions - best solution after", nmds$tries, "tries\n", append = T, file = 'ordi-result.txt')

cat('\nSpecies scores\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
if (nmds$dims == 2)  cat('        ','NMDS1 ', 'NMDS2 ', '\n', sep = '\t', append = T, file = 'ordi-result.txt') else
  cat('        ','NMDS1 ', 'NMDS2 ', 'NMDS3 ', '\n', sep = '\t', append = T, file = 'ordi-result.txt')
  format.cproj <- formatC (nmds$species, digits = 4, format = 'f')
for (r in seq (1, dim (nmds$species)[1])) cat (rownames (nmds$species)[r], format.cproj[r,], '\n', sep = '\t', append = T, file = 'ordi-result.txt') 

cat('\nSite scores\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
if (nmds$dims == 2)  cat('       ','NMDS1 ', 'NMDS2 ', '\n', sep = '\t', append = T, file = 'ordi-result.txt') else
  cat('    ','NMDS1 ', 'NMDS2 ', 'NMDS3 ', '\n', sep = '\t', append = T, file = 'ordi-result.txt')
  format.rproj <- formatC (nmds$points, digits = 4, format = 'f')
for (r in seq (1, dim (nmds$points)[1])) cat (rownames (nmds$points)[r], format.rproj[r,], '\n', sep = '\t', append = T, file = 'ordi-result.txt') 

if (!is.null (deleted.plots))
  {
  cat('\nPlots deleted due to incomplete header data:\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
  cat(deleted.plots, append = T, file = 'ordi-result.txt')
  }
  }

if (type == 'pca')
{
pca <- ord.result
cat ('Results of Principal Components Analysis\n\n', sep = '\t', file = 'ordi-result.txt')
if (use.last.result) cat ('PREVIOUSLY SAVED RESULTS USED FOR VISUALIZATION (e.g. as the data are the same as in previous ', type, ' analysis, also the results of previous analysis are used for visualization; this is intended to save some time for calculation ...)\n\n', append = T, file = 'ordi-result.txt')
    cat('                  ','PC1   ', 'PC2   ', 'PC3   ', 'PC4   ', '\n', sep = '\t', append = T, file = 'ordi-result.txt')
    cat("Standard deviation:", formatC (pca$sdev[1:4], digits = 4, format = 'f'), "\n", sep = '\t', append = T, file = 'ordi-result.txt')

cat('\nSpecies scores\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
cat('        ','PC1 ', 'PC2 ', 'PC3', 'PC4', '\n', sep = '\t', append = T, file = 'ordi-result.txt')
format.cproj <- formatC (pca$rotation[,1:4], digits = 4, format = 'f')
for (r in seq (1, dim (format.cproj)[1])) cat (rownames (format.cproj)[r], format.cproj[r,], '\n', sep = '\t', append = T, file = 'ordi-result.txt') 

cat('\nSite scores\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
cat('      ','PC1   ', 'PC2   ', 'PC3   ', 'PC4   ', '\n', sep = '\t', append = T, file = 'ordi-result.txt')
format.rproj <- formatC (scores (pca, display = 'sites')[,1:4], digits = 4, format = 'f')
for (r in seq (1, dim (format.rproj)[1])) cat (rownames (format.rproj)[r], format.rproj[r,], '\n', sep = '\t', append = T, file = 'ordi-result.txt') 

if (!is.null (deleted.plots))
  {
  cat('\nPlots deleted due to incomplete header data:\n\n', sep = '\t', append = T, file = 'ordi-result.txt')
  cat(deleted.plots, append = T, file = 'ordi-result.txt')
  }
  }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
