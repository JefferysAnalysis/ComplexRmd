# Grand parent start

Before calling child:

    ##              Param WantDirect
    ## child                        
    ## parent                       
    ## grand        grand      grand
    ## grandNchild  grand      grand
    ## grandNparent grand      grand
    ## parentNchild                 
    ## all          grand      grand

Calling parent as child:

    ComplexRmd::includeChild( "paramParent.Rmd" )

## Parent start

Before calling child:

    ##               Param WantDirect WantFromGrand
    ## child                                       
    ## parent       parent     parent        parent
    ## grand         grand                    grand
    ## grandNchild   grand                    grand
    ## grandNparent  grand     parent         grand
    ## parentNchild parent     parent        parent
    ## all           grand     parent         grand

Calling child:

    ComplexRmd::includeChild( "paramChild.Rmd" )

### Child START

    ##               Param WantDirect WantFromParent WantFromGrandFromParent
    ## child         child      child          child                   child
    ## parent       parent                    parent                  parent
    ## grand         grand                                             grand
    ## grandNchild   grand      child          child                   grand
    ## grandNparent  grand                    parent                   grand
    ## parentNchild parent      child         parent                  parent
    ## all           grand      child         parent                   grand

### Child END

After calling child, back to parent starting parameters:

    ##               Param WantDirect WantFromGrand
    ## child                                       
    ## parent       parent     parent        parent
    ## grand         grand                    grand
    ## grandNchild   grand                    grand
    ## grandNparent  grand     parent         grand
    ## parentNchild parent     parent        parent
    ## all           grand     parent         grand

## Parent end

After calling parent as child, back to starting grand parameters:

    ##              Param WantDirect
    ## child                        
    ## parent                       
    ## grand        grand      grand
    ## grandNchild  grand      grand
    ## grandNparent grand      grand
    ## parentNchild                 
    ## all          grand      grand

# Grand parent end
