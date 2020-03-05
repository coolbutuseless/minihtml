

# An empty element cannot have any child nodes and should not be closed
#. e.g.
#    <input></input> is invalid HTML5
#    <br /> is invalid HTML5
#
# https://developer.mozilla.org/en-US/docs/Glossary/Empty_element
empty_tags <- c("area", "base", "br", "col", "embed", "hr", "img", "input",
                "link", "meta", "param", "source", "track", "wbr")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Escape HTML text
#'
#' @param x string to escape
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
esc <- function(x) {
  x <- gsub('&', '&amp;', x, useBytes = TRUE, fixed = TRUE)
  x <- gsub('<', '&lt;' , x, useBytes = TRUE, fixed = TRUE)
  x <- gsub('>', '&gt;' , x, useBytes = TRUE, fixed = TRUE)
  x
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Escape attribute text
#'
#' @param x string to escape
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
attesc <- function(x) {
  x <- esc(x)
  x <- gsub("'", '&#39;' , x, useBytes = TRUE, fixed = TRUE)
  x <- gsub('"', '&quot;', x, useBytes = TRUE, fixed = TRUE)
  x
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' HTML element builder
#'
#' It is up to the user to escape text if necessary. See \code{esc()} and \code{attesc()}
#' functions to help with this, although if you are working within shiny,
#' then this should happen automatically.
#'
#' @examples
#' \dontrun{
#' HTMLElement$new('div', class = ".big", "DIV contents")
#' }
#'
#'
#' @import R6
#' @import glue
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
HTMLElement <- R6::R6Class(
  "HTMLElement",

  public = list(

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @field name name of node e.g. "div"
    #' @field attribs named list of attributes of this node
    #' @field children list of immediate children of this node
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    name     = NULL,
    attribs  = NULL,
    children = NULL,

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Initialise HTMLElement
    #' @param ... Further arguments are attributes and children of this node. See \code{HTMLElement$update()}
    #' @param name name of node. e.g. "div"
    #' @return self
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    initialize = function(name, ...) {
      self$name     <- name
      self$attribs  <- list()
      self$children <- list()

      self$update(...)


      class(self) <- unique(c(class(self), "shiny.tag"))

      self
    },


    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Updates the attributes and children.
    #'
    #' @details
    #' Named arguments are considered attributes and will overwrite
    #' existing attributes with the same name. Set to NULL to delete the attribute.
    #' Set to NA to make this a bare attribute without a value.
    #'
    #' Unnamed arguments are appended to the list of child nodes.  These
    #' should be text, other HTMLElements or any ojbect that can be represented
    #' as a single text string using "as.character()".  To be specific about
    #' where in the child list a node will be placed, use \code{$append()}
    #'
    #' @param ... attributes and children to add to this node
    #' @return self
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    update = function(...) {
      varargs      <- list(...)
      vararg_names <- names(varargs)
      if (is.null(vararg_names)) {
        vararg_names <- character(length = length(varargs))
      }
      has_name   <- nzchar(vararg_names)

      children <- varargs[!has_name]
      attribs  <- varargs[ has_name]

      self$attribs  <- modifyList(self$attribs, attribs, keep.null = FALSE)
      do.call(self$append, children)

      invisible(self)
    },


    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Append a child node at the specified position
    #' @param position by default at the end of the list of children nodes
    #'        can be used to set location index
    #' @return self
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    append = function(..., position = NULL) {
      child_objects <- list(...)
      if (is.null(position)) {
        self$children <- append(self$children, child_objects)
      } else {
        self$children <- append(self$children, child_objects, after = position - 1)
      }

      invisible(self)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Simultaneous create an HTML element and add it as a child node
    #' @param name name of node to create
    #' @param ... attributes and children of this newly created node
    #' @return In contrast to most other methods, \code{$add()} returns
    #' the newly created element, \emph{not} the document
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    add = function(name, ...) {
      if (!is.character(name)) {
        stop("HTMLElement$add(): 'name' must be a character string")
      }
      new_elem <- HTMLElement$new(name, ...)
      self$append(new_elem)
      invisible(new_elem)
    },


    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Remove child objects at the given indicies
    #'
    #' @param indicies indicies of the children to remove
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    remove = function(indicies) {
      self$children[indices] <- NULL
      invisible(self)
    },


    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description  Recursively convert this HTMLElement and children to text
    #' @param ... ignored
    #' @param depth recursion depth
    #' @return single character string
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    as_character_inner = function(..., depth = 0) {
      indent1   <- create_indent(depth)
      indent2   <- create_indent(depth + 1)

      na_attribs    <- Filter(       is.na , self$attribs)
      value_attribs <- Filter(Negate(is.na), self$attribs)

      if (length(na_attribs) > 0) {
        na_attribs  <- names(na_attribs)
        na_attribs  <- paste(na_attribs, sep = " ")
        na_attribs  <- paste0(" ", na_attribs)
      } else {
        na_attribs <- NULL
      }

      if (length(value_attribs) > 0) {
        value_attribs <- paste(names(value_attribs),
                               paste0('"', unlist(value_attribs), '"'),
                               sep = "=", collapse = " ")
        value_attribs <- paste0(" ", value_attribs)
      } else {
        value_attribs <- NULL
      }

      attribs <- paste0(c(value_attribs, na_attribs), sep = "")
      open    <- glue::glue("{indent1}<{self$name}{attribs}>")
      close   <- glue::glue("{indent1}</{self$name}>")

      if (length(self$children) > 0) {
        children <- lapply(
          self$children,
          function(x, depth) {
            if (is.character(x)) {
              paste0(indent2, x)
            } else {
              x$as_character_inner(depth = depth)
            }
          }
          , depth = depth + 1)
        children <- unlist(children, use.names = FALSE)
      } else {
        children = NULL
      }

      # Strictly speaking, empty tags should not have any children. and should
      # not have a closing tag. But because 'minihtml' is a bit relaxed,
      # it's going to allow you to shoot yourself in the foot and have child elements
      # for an empty tag. Most browssers should deal with it.
      # only if the empty tag has no children will it be self-closing
      if (tolower(self$name) %in% empty_tags & length(self$children) == 0) {
        children <- NULL
        close    <- NULL
        open     <- glue::glue("{indent1}<{self$name}{attribs} />")
      }

      c(open, children, close)
    },


    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Recursively convert this HTMLElement and children to text
    #' @param ... ignored
    #' @param depth recursion depth. default: 0
    #' @param include_declaration Include the leading XML declaration? default: FALSE
    #' @return single character string
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    as_character = function(..., depth = 0, include_declaration = FALSE) {
      html_string <- paste0(self$as_character_inner(depth = depth), collapse = "\n")

      if (include_declaration) {
        html_string <- paste("<!DOCTYPE html>", html_string, sep = "\n")
      }

      # attr(html_string, "html") <- TRUE
      # class(html_string) <- unique(c("html", "character", class(html_string)))
      html_string
    },


    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Print the HTML string to the terminal
    #' @param ... Extra arguments passed to \code{HTMLElement$as_character()}
    #' @param include_declaration Include \code{DOCTYPE} declaration? default: FALSE
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    print = function(..., include_declaration = FALSE) {
      cat(self$as_character(..., include_declaration = include_declaration))
      invisible(self)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Save HTML
    #' @param filename filename
    #' @param include_declaration Include \code{DOCTYPE} declaration? default: FALSE
    #' @param ... Extra arguments passed to \code{HTMLElement$as_character()}
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    save = function(filename, include_declaration = FALSE, ...) {
      writeLines(self$as_character(..., include_declaration = include_declaration), filename)
      invisible(self)
    },

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Make a deep copy of this node and its children
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    copy = function() {
      self$clone(deep = TRUE)
    }
  ),

  private = list(
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # When called with `$clone(deep = TRUE)`, the 'deep_clone' function is
    # called for every name/value pair in the object.
    # See: https://r6.r-lib.org/articles/Introduction.html
    # Need special handling for:
    #   - 'children' is a list of R6 objects
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    deep_clone = function(name, value) {
      if (name %in% c('children')) {
        lapply(value, function(x) {if (inherits(x, "R6")) x$clone(deep = TRUE) else x})
      } else {
        value
      }
    }
  )

)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Retrieve character representation of HTMLElement
#'
#' @param x HTMLElement object
#' @param include_declaration Include the HTML5 DOCTYPE declaration at the top? Default: FALSE
#' @param ... other arguments
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
as.character.HTMLElement <- function(x, include_declaration = FALSE, ...) {
  x$as_character(..., include_declaration = include_declaration)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname HTMLElement
#' @usage NULL
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
html_elem <- function(name, ...) {
  HTMLElement$new(name = name, ...)
}




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' knitr/rmarkdown compatibility/output
#'
#' @param x HTMLElement
#' @param ... other arguments
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
knit_print.HTMLElement <- function(x, ...) {
  string <- as.character(x, include_declaration = FALSE)
  # Need to be careful when trying to use the string in Rmarkdown.
  # If there are 4(?) leading spaces then the HTML gets turned into a
  # pre-formatted/quoted section.
  string <- gsub("\\s+", " ", string)
  knitr::asis_output(string)
}
