


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' HTMLDocument Class
#'
#' This is a slightly specialized subclass of \code{HTMLElement} which includes
#' a \code{$show()} method, and includes the HTML DOCTYPE by default.
#'
#'
#' @import R6
#' @importFrom glue glue
#' @importFrom utils browseURL
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
HTMLDocument <- R6::R6Class(
  "HTMLDocument", inherit = HTMLElement,

  public = list(

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Initialise HTMLDocument
    #' @param ... Further arguments passed to \code{HTMLElement$new()}
    #' @param name name of node. default: 'html'
    #' @return self
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    initialize = function(..., name = 'html') {
      super$initialize(name = name, ...)
      invisible(self)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Save HTML fragment
    #' @param filename filename
    #' @param include_declaration Include \code{DOCTYPE} declaration? default: TRUE
    #' @param ... Further arguments passed to \code{HTMLElement$save()}
    #' @return self
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    save = function(filename, include_declaration = TRUE, ...) {
      super$save(filename, include_declaration = include_declaration)
      invisible(self)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Print HTMLDocument
    #' @param include_declaration Include \code{DOCTYPE} declaration? default: TRUE
    #' @return self
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    print = function(include_declaration = TRUE) {
      super$print(include_declaration = include_declaration)
      invisible(self)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Convert to character representation
    #' @param include_declaration Include \code{DOCTYPE} declaration? default: TRUE
    #' @return single character string representing the HTML
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    as_character = function(include_declaration = TRUE) {
      super$as_character(include_declaration = include_declaration)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description View HTML in whatever viewer is available
    #' @details only tested in MacOS and Rstudio
    #' @param viewer viewer to use
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    show = function(viewer = getOption("viewer", utils::browseURL)) {
      www_dir <- tempfile("viewhtml")
      dir.create(www_dir)
      index_html <- file.path(www_dir, "index.html")
      self$save(index_html, include_declaration = TRUE)

      if (!is.null(viewer)) {
        viewer(index_html)
      } else {
        warning("No viewer available.")
      }
      invisible(index_html)
    }
  )
)




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Retrieve character representation of HTMLElement
#'
#' @param x HTMLElement object
#' @param include_declaration Include the HTML5 DOCTYPE declaration at the top? Default: TRUE
#' @param ... other arguments
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
as.character.HTMLDocument <- function(x, include_declaration = TRUE, ...) {
  x$as_character(..., include_declaration = include_declaration)
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname HTMLDocument
#' @usage NULL
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
html_doc <- function(...) {
  HTMLDocument$new(...)
}

