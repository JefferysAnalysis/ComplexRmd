describe( "merge.list()", {

    listA <- list(1, nameInA=2, nameInAAndB=3, 4)
    listB <- list("one", nameInB="two", nameInAAndB="three", "four")
    notList <- c('x', "y")
    dupNameList <- list(1, nameInA=2, nameInA=3, 4)
    listEmpty <- list()

    describe( "preconditions on lists being merged and the names of their elements", {
        it( "If second element is not a list, it is converted", {
            wantList <- list(1, nameInA=2, nameInAAndB=3, 4, "x", "y")
            expect_equal( merge(listA, notList ), wantList )
        })
        it( "Errors when either list has duplicated element names", {
            errorRE = "'x' contains elements with duplicated names\\."
            expect_error( merge(dupNameList, listA), errorRE )
            errorRE = "'y' contains elements with duplicated names\\."
            expect_error( merge(listA, dupNameList), errorRE )
        })
    })
    describe( "merging lists", {
        it( "Merges two non-empty lists", {
            wantList <- list(1,     nameInA=2,     nameInAAndB=3, 4,
                             "one", nameInB="two",                "four" )
            expect_equal (merge(listA, listB), wantList)
        })
        it( "merges empty lists", {
            expect_equal(merge( listEmpty, listEmpty), listEmpty)
        })
        it( "merges non-empty and empty lists", {
            expect_equal(merge( listA, listEmpty), listA)
        })
        it( "merges non-empty and empty lists", {
            expect_equal(merge( listEmpty, listA), listA)
        })
    })
})
