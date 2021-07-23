describe( "hello()", {
    it( "Prints a hello", {
        wantOutRE <- "Hello, world!"
        expect_output( hello(), wantOutRE )
    })
})
