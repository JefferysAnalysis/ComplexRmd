describe( "includeChild()", {

    testDemo <- function( demo ) {
        sourceFile <- system.file( "Demo", paste0( demo, ".Rmd" ),
            package= "ComplexRmd"
        )
        expect_true( file.exists( sourceFile ))
        outputDir <- tempfile( demo )
        renderedFile <- rmarkdown::render( sourceFile,
            output_format= "md_document", output_dir= outputDir, quiet= TRUE
        )
        expect_true( file.exists( outputDir ))
        expect_snapshot_file( renderedFile, binary = FALSE )
    }

    describe( "Kniting without parameters", {
        it( "Simple child doucments can be knit directly", {
            testDemo( "simpleChild" )
        })
        it( "Parent documents can include children", {
            testDemo( "simpleParent" )
        })
        it( "Children can be included recursively", {
            testDemo( "simpleGrand" )
        })
    })
    describe( "Kniting with parameters", {
        describe( "param= 'parent' (default) - parent overrides child", {
            it( "Child doucment knit directly sees its own parameters", {
                testDemo( "paramChild" )
            })
            it( "child documents knit by parent sees parents overwriting child parameters", {
                testDemo( "paramParent" )
            })
            it( "child documents knit revursively sees grandparents over parents over child parameters", {
                testDemo( "paramGrand" )
            })
        })
    })
})