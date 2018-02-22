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
        install.packages(new.pkg, repos = "https://cloud.r-project.org")
    foo <- function(a, ...) suppressMessages(require(a, ...))
    sapply(pkg, foo, character.only = TRUE)
    invisible(NULL)
}


##' Return formatted code for package names
##'
##' The function returns formatted code for possible LaTeX output.
##'
##' @param pkgName Name of the package.
##' @param outFormat Optional output format.
##' @param ... Other arguments for future usage.
##' @return A character vector.
pkg <- function(pkgName, outFormat, ...)
{
    if (missing(outFormat))
        outFormat <- if (knitr::is_html_output()) {
                         "html"
                     } else if (knitr::is_latex_output()) {
                         "latex"
                     } else {
                         knitr::opts_knit$get("rmarkdown.pandoc.to")
                     }
    if (outFormat == "html")
        return(paste0("**", pkgName, "**"))
    else if (outFormat == "latex")
        return(paste0("\\pkg{", pkgName, "}"))
    else
        warning("Not applicable.  Please double check the output.")
    pkgName
}


##' Return Formatted Code for Programming Language
##'
##' The function returns formatted code for possible LaTeX output.
##'
##' @param langName Name of the programming language.
##' @param outFormat Optional output format.
##' @param ... Other arguments for future usage.
##' @return A character vector.
proglang <- function(langName, outFormat, ...)
{
    if (missing(outFormat))
        outFormat <- if (knitr::is_latex_output())
                         "latex"
                     else
                         knitr::opts_knit$get("rmarkdown.pandoc.to")
    if (outFormat == "latex")
        return(paste0("\\proglang{", langName, "}"))
    langName
}
