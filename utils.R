##' Check, Install and Attach Multiple R packages Specified
##'
##' The function first Checks whether the packages given were installed. Then
##' install them if they are not, then attach them to the search path.
##'
##' @usage need.packages(pkg)
##' @param pkg A character vector specifying the packages needed to reproduce
##'     this document.
##' @param ... Other arguments passed to function \code{\link[base]require}.
##' @return NULL invisibly.
##' @examples
##' need.pacakges(c("ggplot2", "geepack"))
need.packages <- function(pkg, ...)
{
    new.pkg <- pkg[! (pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg)
    foo <- function(a, ...) suppressMessages(require(a, ...))
    sapply(pkg, foo, character.only = TRUE)
    invisible(NULL)
}
