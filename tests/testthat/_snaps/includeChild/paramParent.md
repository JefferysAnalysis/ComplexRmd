## Parent start

Before calling child:

    ##               Param WantDirect WantFromGrand
    ## child                                       
    ## parent       parent     parent        parent
    ## grand                                  grand
    ## grandNchild                            grand
    ## grandNparent parent     parent         grand
    ## parentNchild parent     parent        parent
    ## all          parent     parent         grand

Calling child:

    ComplexRmd::includeChild( "paramChild.Rmd" )

### Child START

    ##               Param WantDirect WantFromParent WantFromGrandFromParent
    ## child         child      child          child                   child
    ## parent       parent                    parent                  parent
    ## grand                                                           grand
    ## grandNchild   child      child          child                   grand
    ## grandNparent parent                    parent                   grand
    ## parentNchild parent      child         parent                  parent
    ## all          parent      child         parent                   grand

### Child END

After calling child, back to parent starting parameters:

    ##               Param WantDirect WantFromGrand
    ## child                                       
    ## parent       parent     parent        parent
    ## grand                                  grand
    ## grandNchild                            grand
    ## grandNparent parent     parent         grand
    ## parentNchild parent     parent        parent
    ## all          parent     parent         grand

## Parent end
