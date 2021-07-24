#' Merge a list with another object
#'
#' Concatenates two lists, preserving order but dropping elements with
#' duplicated names from the second list. If the second parameter is not a list,
#' it will be converted to one with `as.list`. Names must be unique within each
#' list but may be (and probably are) duplicated between them. Unnamed elements
#' are allowed and are always kept.
#'
#' @param x A list
#' @param y A value to merge, general a list but if not it will be converted to
#' a list using `as.list`
#' @param ... Unused, present only for compatibility with the generic.
#'
#' @return A list equal to the first list followed by the second list without
#' any of its named elements already included in the first list.
#'
#' @examples
#' first  <- list( "x1", x2name="x2", shared3="in x", "x4" )
#' second <- list( "y1", y2name="y2", shared3="in y", "y4" )
#' combined <- merge( first, second )
#' want <- list( "x1", x2name="x2", shared3="in x", "x4",
#'               "y1", y2name="y2",                 "y4" )
#' all.equal( combined, want )
#' #> TRUE
#'
#' charVec <- c( "y1", y2name="y2", shared3="in y", "y4" )
#' combinedWithVec <- merge( first, charVec )
#' all.equal( combinedWithVec, want )
#' #> TRUE
#'
#' @export
merge.list <- function( x, y, ... ) {

    if (length(y) < 1) {
        x
    }
    else {
        if (! is.list(y)) {
            y <- as.list(y)
        }

        if ( anyDuplicated( names(x)[ nzchar( names(x) )] )){
            stop( "'x' contains elements with duplicated names." )
        }
        if ( anyDuplicated( names(y)[ nzchar(names(y) )] )) {
            stop( "'y' contains elements with duplicated names." )
        }

        y[ nzchar( names(y) ) & names(y) %in% names(x) ] <- NULL
        c( x, y )
    }
}
