describe( "includeChild()", {

    testDemo <- function( demo ) {
        sourceFile <- system.file( "Demo", paste0( demo, ".Rmd" ),
            package= "ComplexRmd"
        )
        outputDir <- tempfile( demo )
        renderedFile <- rmarkdown::render( sourceFile,
            output_format= "md_document", output_dir= outputDir, quiet= TRUE
        )
        expect_snapshot_file( renderedFile, binary = FALSE )
    }

    describe( "Demo Rmd scripts generate correct output", {
        it( "simpleChild.Rmd is created correctly", {
            testDemo( "simpleChild" )
        })
        it( "simpleChild.Rmd is created correctly", {
            testDemo( "simpleParent" )
        })
    })
})