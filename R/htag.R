

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Manually converting the HtmlTags.json info to an inline R list for
# easier hacking and tweaking.
# HtmlTags.json source: https://github.com/adobe/brackets
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# js <- jsonlite::read_json("./working/HtmlTags.json")
# jsnames <- names(js)
#
# for (i in seq_along(js)) {
#   name <- jsnames[i]
#   attr <- unlist(js[[i]], use.names = FALSE)
#
#   cat(sprintf("  list(name = %13s, attribs = %s)", paste0("'", name, "'"), deparse(attr, width.cutoff = 500)))
#   if (i == length(js)) {
#     cat("\n\n")
#   } else {
#     cat(",\n")
#   }
#
# }





all_html_tags <- list(
  list(name =           'a', attribs = c("href", "hreflang", "media", "rel", "target", "type")),
  list(name =        'abbr', attribs = NULL),
  list(name =     'address', attribs = NULL),
  list(name =        'area', attribs = c("alt", "coords", "href", "hreflang", "media", "rel", "shape", "target", "type")),
  list(name =     'article', attribs = NULL),
  list(name =       'aside', attribs = NULL),
  list(name =       'audio', attribs = c("autoplay", "controls", "loop", "mediagroup", "muted", "preload", "src")),
  list(name =           'b', attribs = NULL),
  list(name =        'base', attribs = c("href", "target")),
  list(name =         'bdi', attribs = NULL),
  list(name =         'bdo', attribs = NULL),
  list(name =         'big', attribs = NULL),
  list(name =  'blockquote', attribs = "cite"),
  list(name =        'body', attribs = c("onafterprint", "onbeforeprint", "onbeforeunload", "onhashchange", "onmessage", "onoffline", "ononline", "onpagehide", "onpageshow", "onpopstate", "onredo", "onresize", "onstorage", "onundo", "onunload")),
  list(name =          'br', attribs = NULL),
  list(name =      'button', attribs = c("autofocus", "disabled", "form", "formaction", "formenctype", "formmethod", "formnovalidate", "formtarget", "name", "type", "value")),
  list(name =      'canvas', attribs = c("height", "width")),
  list(name =     'caption', attribs = NULL),
  list(name =        'cite', attribs = NULL),
  list(name =        'code', attribs = NULL),
  list(name =         'col', attribs = "span"),
  list(name =    'colgroup', attribs = "span"),
  list(name =     'command', attribs = c("checked", "disabled", "icon", "label", "radiogroup", "type")),
  list(name =    'datalist', attribs = NULL),
  list(name =          'dd', attribs = NULL),
  list(name =         'del', attribs = c("cite", "datetime")),
  list(name =     'details', attribs = "open"),
  list(name =         'dfn', attribs = NULL),
  list(name =      'dialog', attribs = "open"),
  list(name =         'div', attribs = NULL),
  list(name =          'dl', attribs = NULL),
  list(name =          'dt', attribs = NULL),
  list(name =          'em', attribs = NULL),
  list(name =       'embed', attribs = c("height", "src", "type", "width")),
  list(name =    'fieldset', attribs = c("disabled", "form", "name")),
  list(name =  'figcaption', attribs = NULL),
  list(name =      'figure', attribs = NULL),
  list(name =      'footer', attribs = NULL),
  list(name =        'form', attribs = c("accept-charset", "action", "autocomplete", "enctype", "method", "name", "novalidate", "target")),
  list(name =          'h1', attribs = NULL),
  list(name =          'h2', attribs = NULL),
  list(name =          'h3', attribs = NULL),
  list(name =          'h4', attribs = NULL),
  list(name =          'h5', attribs = NULL),
  list(name =          'h6', attribs = NULL),
  list(name =        'head', attribs = NULL),
  list(name =      'header', attribs = NULL),
  list(name =      'hgroup', attribs = NULL),
  list(name =          'hr', attribs = NULL),
  list(name =        'html', attribs = c("manifest", "xml:lang", "xmlns")),
  list(name =           'i', attribs = NULL),
  list(name =      'iframe', attribs = c("height", "name", "sandbox", "seamless", "src", "srcdoc", "width")),
  list(name =      'ilayer', attribs = NULL),
  list(name =         'img', attribs = c("alt", "height", "ismap", "longdesc", "src", "usemap", "width")),
  list(name =       'input', attribs = c("accept", "alt", "autocomplete", "autofocus", "checked", "dirname", "disabled", "form", "formaction", "formenctype", "formmethod", "formnovalidate", "formtarget", "height", "list", "max", "maxlength", "min", "multiple", "name", "pattern", "placeholder", "readonly", "required", "size", "src", "step", "type", "value", "width")),
  list(name =         'ins', attribs = c("cite", "datetime")),
  list(name =         'kbd', attribs = NULL),
  list(name =      'keygen', attribs = c("autofocus", "challenge", "disabled", "form", "keytype", "name")),
  list(name =       'label', attribs = c("for", "form")),
  list(name =      'legend', attribs = NULL),
  list(name =          'li', attribs = "value"),
  list(name =        'link', attribs = c("disabled", "href", "hreflang", "media", "rel", "sizes", "type")),
  list(name =        'main', attribs = NULL),
  list(name =         'map', attribs = "name"),
  list(name =        'mark', attribs = NULL),
  list(name =     'marquee', attribs = c("align", "behavior", "bgcolor", "direction", "height", "hspace", "loop", "scrollamount", "scrolldelay", "truespeed", "vspace", "width")),
  list(name =        'menu', attribs = c("label", "type")),
  list(name =        'meta', attribs = c("charset", "content", "http-equiv", "name")),
  list(name =       'meter', attribs = c("form", "high", "low", "max", "min", "optimum", "value")),
  list(name =         'nav', attribs = NULL),
  list(name =    'noscript', attribs = NULL),
  list(name =      'object', attribs = c("archive", "codebase", "codetype", "data", "declare", "form", "height", "name", "standby", "type", "usemap", "width")),
  list(name =          'ol', attribs = c("reversed", "start", "type")),
  list(name =    'optgroup', attribs = c("disabled", "label")),
  list(name =      'option', attribs = c("disabled", "label", "selected", "value")),
  list(name =      'output', attribs = c("for", "form", "name")),
  list(name =           'p', attribs = NULL),
  list(name =       'param', attribs = c("name", "value")),
  list(name =         'pre', attribs = NULL),
  list(name =    'progress', attribs = c("form", "max", "value")),
  list(name =           'q', attribs = "cite"),
  list(name =          'rp', attribs = NULL),
  list(name =          'rt', attribs = NULL),
  list(name =        'ruby', attribs = NULL),
  list(name =        'samp', attribs = NULL),
  list(name =      'script', attribs = c("async", "charset", "defer", "src", "type")),
  list(name =     'section', attribs = NULL),
  list(name =      'select', attribs = c("autofocus", "disabled", "form", "multiple", "name", "required", "size")),
  list(name =       'small', attribs = NULL),
  list(name =      'source', attribs = c("media", "src", "type")),
  list(name =        'span', attribs = NULL),
  list(name =      'strong', attribs = NULL),
  list(name =       'style', attribs = c("disabled", "media", "scoped", "type")),
  list(name =         'sub', attribs = NULL),
  list(name =     'summary', attribs = NULL),
  list(name =         'sup', attribs = NULL),
  list(name =       'table', attribs = "border"),
  list(name =       'tbody', attribs = NULL),
  list(name =          'td', attribs = c("colspan", "headers", "rowspan")),
  list(name =    'template', attribs = "content"),
  list(name =    'textarea', attribs = c("autofocus", "cols", "dirname", "disabled", "form", "label", "maxlength", "name", "placeholder", "readonly", "required", "rows", "wrap")),
  list(name =       'tfoot', attribs = NULL),
  list(name =          'th', attribs = c("colspan", "headers", "rowspan", "scope")),
  list(name =       'thead', attribs = NULL),
  list(name =        'time', attribs = c("datetime", "pubdate")),
  list(name =       'title', attribs = NULL),
  list(name =          'tr', attribs = NULL),
  list(name =       'track', attribs = c("default", "kind", "label", "src", "srclang")),
  list(name =          'tt', attribs = NULL),
  list(name =          'ul', attribs = NULL),
  list(name =         'var', attribs = NULL),
  list(name =       'video', attribs = c("autoplay", "controls", "height", "loop", "mediagroup", "muted", "poster", "preload", "src", "width")),
  list(name =         'wbr', attribs = NULL)
)





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create a custom func for the given HTML tag name and attributes.
# This custom func will instantiate a new HTMLElement with the given
# name and arguments.
#
# Due to naming standards the following attribute characters will be renamed
#  - '-' will become '_'
#  - ':' will become '..'
#  - 'for' will become 'for.'
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
create_htag_func <- function(spec) {

  name    <- spec$name
  attribs <- spec$attribs

  attribs <- c('...', attribs)
  attribs <- gsub("-", "_", attribs)
  attribs <- gsub(":", "..", attribs)
  attribs[attribs == 'for'] <- 'for.'

  func_text <- glue("
function({paste(attribs, collapse = ', ')}) {{
  named_args <- find_args(...)

  args <- c(list(name = '{as.name(name)}'), list(...), named_args)
  do.call(HTMLElement$new, args)
}}")

  eval(parse(text = func_text))
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create a datastructure to help create all the standard html tags.
# Each element in the list is a function to create that particular HTML tag.
# Use 'create_htag_func()' to create the functions so that the attributes exist
# as arguments for use with autocomplete
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
htag <- list()

for (spec in all_html_tags) {
  func <- create_htag_func(spec)
  htag[[spec$name]] <- func
}




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @name htag
#' @title HTML Builder functions
#' @description HTML builder functions.  Similar in purpose to \code{shiny::tags},
#' but with auto-complete of attribute names as part of the function call. Also
#' based upon \code{HTMLElement} at its core (rather than a list, as in \code{shiny})
#'
#' \code{htag} is a dreadful portmanteau of \emph{html} and \emph{tag}.
#'
#' The simpler name of \code{tag} was rejected to avoid a name clash with the
#' \code{shiny} package.
#'
#' Wrapper functions (around \code{HTMLElement$new()}) to assist in building
#' HTML documents
#'
#' @examples
#' \dontrun{
#' htag$a(href = 'hello', "greeting")
#' # <a href="hello">greeting</a>
#' }
#'
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NULL




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create a custom func for the given HTML tag name and attributes.
# This custom func will instantiate a new HTMLElement with the given
# name and arguments.
#
# Due to naming standards the following attribute characters will be renamed
#  - '-' will become '_'
#  - ':' will become '..'
#  - 'for' will become 'for.'
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
create_htag_method <- function(spec) {

  name    <- spec$name
  attribs <- spec$attribs

  attribs <- c('...', attribs)
  attribs <- gsub("-", "_", attribs)
  attribs <- gsub(":", "..", attribs)
  attribs[attribs == 'for'] <- 'for.'

  self <- NULL

  func_text <- glue("
function({paste(attribs, collapse = ', ')}) {{
  named_args <- find_args(...)

  args <- c(list(name = '{as.name(name)}'), list(...), named_args)
  node <- do.call(HTMLElement$new, args)

  self$append(node)
  invisible(node)
}}")

  eval(parse(text = func_text))
}


for (spec in all_html_tags) {
  method <- create_htag_method(spec)
  HTMLElement$set('public', spec$name, method)
}








