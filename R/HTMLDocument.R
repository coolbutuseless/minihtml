


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

    initialize = function(...) {
      super$initialize(name = 'html', ...)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Save HTML fragment
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    save = function(filename, include_declaration = TRUE, ...) {
      super$save(filename, include_declaration = include_declaration)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # Print
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    print = function(include_declaration = TRUE) {
      super$print(include_declaration = include_declaration)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # As character
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    as_character = function(include_declaration = TRUE) {
      super$as_character(include_declaration = include_declaration)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # View HTML in whatever viewer is available
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

