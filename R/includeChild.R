readRmdParams <- function( file ) {
    file %>%
    readLines() %>%
    knitr::knit_params() %>%
    lapply( function(x) { x[[ "value" ]]  } )
}

#' Include a child document with parameters
#'
#' Includes a child document (as raw markdown text) where called. The parameters
#' from the parent and child will be collected as specified by `param` and made
#' available for use by the child. The parent document parameters are unchanged.
#' The child runs in its own environment as if it was a function,
#' but one or more objects can be passed back from the child (independent of
#' parameter) for use in the parent environment (where the child was called).
#' This parent environment can be specified if desired, controlling both what
#' is seen by the child and capturing returned variables separate from the
#' parent documents "global" scope.
#'
#' @param file The child file to knit. Path is relative to the parent.
#' @param param What is visible to the child document as the `params` variable.
#'
#'  * NULL - No parameters (an empty list).
#'  * \<list\> - Only the explicit list provided.
#'  * "parent" - (DEFAULT) Merges parameters, parent over child.
#'  * "child" - Merges parameters, child over parent.
#'  * "onlyParent' - Ignores child parameters.
#'  * "onlyChild' - Ignores parent parameters.
#'
#' @param envir The parent environment to the environment the child runs in.
#'   By default this is just where this function is called, its parent.frame().
#'   Anything defined in this environment (or its parents) will be visible to
#'   the child as normal, except for the modified `params` variable which is
#'   injected into the environment the child runs in to hide the parent `params`
#'   variable. Everything defined in the child will be cleaned up when this
#'   function exits, except for variables or functions named in `import`. These
#'   will be injected into this environment, by default making them visible in
#'   the parent R markdown following this function call.
#' @param import A variable name or names used for communicating between the
#'   child. Must be a character vector. After child inclusion, these variables
#'   will exist and will have the value it was assigned in the child, if any.
#'   Otherwise it will have the value it had before the child was knitted. Note
#'   that these can be function names, allowing importing child-defined
#'   functions into the parent scope as well as data.
#' @param ... Other parameters passed to knitr::knit_child and hence on to
#'   knitr::knit
#'
#' @return Returns the knitted child as markdown text to be processed here as
#'   the parent knit continues. It is text but with the the class `knit_asis`.
#'   This avoids the need to have this function called in an R code chunk using
#'   the `result= "asis"` option. It will be interpreted as any other literal
#'   markdown text would be if included where called, either from inside a chunk
#'   (with the chunk setting `include=TRUE`), or inline if called outside a
#'   chunk.
#'
#' @export
includeChild <- function( file, param="parent", import="RET_VAL", envir= parent.frame(), ... ) {

    # param is either NULL, an explicit list, or a string from a set.
    if (is.null(param)) {
        # Clear all parameters
        params <- list()
    }
    else if (is.list(param)) {
        # Use provided list as parameters
        params <- param
    }
    else {
        param <- match.arg(param, c( "parent", "child", "onlyParent", "onlyChild" ))
        if (param == "onlyParent") {
            # Nothing to do; set by knitr for parent automatically, or if not
            # set above to be an empty list.
        }
        else {
            # Will need the child document parameters for all other cases.
            # Have to read and load these manually as knitr ignores the header
            # when reading a document as a child.
            childParams <- readRmdParams( file )

            if (param == "onlyChild") {
                # just want the child parameters, discard anything from parent
                params <- childParams
            }
            else if (param == "parent") {
                # Only use child params not set in parent.
                if (! exists( "params" )) {
                    params <- childParams
                }
                else {
                    params <- merge( params, childParams )
                }
            }
            else if (param == "child") {
                # Only use parent params not set in child
                params <- merge( childParams, params )
            }
        }
    }

    # knit_child() defaults to the global env knitr_global(), need to pass
    # a new environment to supply "params" without changing the current "params"
    # value. Generally want the calling environment as the parent.
    childEnv <- new.env(parent= envir)
    assign("params", params, envir = childEnv)
    mdText <- knitr::asis_output(
        knitr::knit_child( file , quiet= TRUE, envir= childEnv, ... )
    )

    # Extract specified variables (including functions) from the child
    # environment and inject them back, generally into the calling environment.
    # Assuming a for loop is efficient enough as environments use pointers.
    for (var in import) {
        if (exists( var, envir= childEnv )) {
            assign(var, get(var, envir = childEnv), envir = envir)
        }
    }

    mdText
}