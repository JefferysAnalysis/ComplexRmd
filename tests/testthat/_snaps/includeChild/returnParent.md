## Parent start

#### Before calling child:

    parent <- "parent"
    grandNparent <- "parent"
    parentNchild <- "parent"
    all <- "parent"

    ##              Variable WantBeforeParent WantBeforeGrand
    ## child                                                 
    ## parent         parent           parent          parent
    ## grand                                            grand
    ## grandNchild                                      grand
    ## grandNparent   parent           parent          parent
    ## parentNchild   parent           parent          parent
    ## all            parent           parent          parent

#### Calling child:

    ComplexRmd::includeChild( "returnChild.Rmd",
        import = c("child", "grandNchild", "parentNchild", "all" ))

### Child START

    ##              Variable WantDirect WantParent WantGrand
    ## child           child      child      child     child
    ## parent         parent                parent    parent
    ## grand                                           grand
    ## grandNchild     child      child      child     child
    ## grandNparent   parent                parent    parent
    ## parentNchild    child      child      child     child
    ## all             child      child      child     child

### Child END

#### After calling child

##### Variables

    ##              Variable WantAfterParent WantAfterGrand
    ## child           child           child          child
    ## parent         parent          parent         parent
    ## grand                                          grand
    ## grandNchild     child           child          child
    ## grandNparent   parent          parent         parent
    ## parentNchild    child           child          child
    ## all             child           child          child

## Parent end
