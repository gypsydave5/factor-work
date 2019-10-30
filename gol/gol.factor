! Copyright (C) 2019 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel arrays fry sequences locals math ;
IN: gol

: grid ( m n -- seq ) 0 <array> <array> ;

: change-nth ( seq n val -- seq ) '[ swap = [ drop _ ] [ ] if ] curry map-index ;

: fry-nth ( seq n q -- 'seq ) '[ swap = _  [ ] if ] curry map-index ; inline
: locals-lnth ( seq n q -- 'seq ) [| n q | [ n = q [ ] if ] ] call map-index ; inline
: no-inline-nth ( seq n q -- 'seq ) [| n q | [ n = [ q call( s -- 's ) ] [ ] if ] ] call map-index ;
:: ::llnth ( seq n q: ( s -- 's ) -- 'seq ) seq [ n = q [ ] if ] map-index ; inline
: stack-nth ( seq n q -- 'seq ) -rot cut-slice rot swap unclip rot call( s -- 's ) prefix append ;

: 2d ( seq n m q -- 'seq ) '[ _ stack-nth ] curry stack-nth ;

: matrix-fnth ( seq coords q -- 'seq ) swap dup length 1 >
    [ unclip rot '[ _ stack-nth ] curry matrix-fnth ]
    [ unclip swap drop swap stack-nth ]
    if ; recursive flushable

: live ( grid x y -- 'grid ) 2array [ drop 1 ] matrix-fnth ;
