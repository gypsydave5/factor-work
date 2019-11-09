! Copyright (C) 2019 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel arrays combinators fry sequences locals math math.combinatorics sequences.generalizations math.matrices ;
IN: gol

: grid ( m n -- seq ) 0 <array> <array> ;

: change-nth ( seq n val -- seq ) '[ swap = [ drop _ ] [ ] if ] curry map-index ;

: fry-nth ( seq n q -- 'seq ) '[ swap = _  [ ] if ] curry map-index ; inline
: locals-lnth ( seq n q -- 'seq ) [| n q | [ n = q [ ] if ] ] call map-index ; inline
: no-inline-nth ( seq n q -- 'seq ) [| n q | [ n = [ q call( s -- 's ) ] [ ] if ] ] call map-index ;
:: ::llnth ( seq n q: ( s -- 's ) -- 'seq ) seq [ n = q [ ] if ] map-index ; inline
: stack-nth ( seq n q -- 'seq ) -rot cut-slice rot swap unclip rot call( s -- 's ) prefix append ;
: apply-nth ( seq n q -- 'seq ) stack-nth ;

: 2d ( seq n m q -- 'seq ) '[ _ apply-nth ] curry apply-nth ;

: matrix-fnth ( seq coords q -- 'seq ) swap dup length 1 >
    [ unclip rot '[ _ apply-nth ] curry matrix-fnth ]
    [ unclip swap drop swap apply-nth ]
    if ; recursive flushable

: map-coords ( grid coords q -- 'grid ) rot swap [ matrix-fnth ] curry reduce ;

: live ( grid x y -- 'grid ) 2array 1array [ drop 1 ] map-coords ;
: die ( grid x y -- 'grid ) 2array 1array [ drop 0 ] map-coords ;

: rotate+ ( array -- 'array ) unclip suffix ;
: rotate- ( array -- 'array ) unclip-last prefix ;

: nrotate ( array n -- 'array ) {
        { [ dup 0 > ] [ [ rotate+ ] dip 1 - nrotate ] }
        { [ dup 0 < ] [ [ rotate- ] dip 1 + nrotate ] }
        [ drop ]
    } cond ; recursive

: nrotate-d ( grid rots -- 'grid ) dup empty?
    [ drop ]
    [ unclip swap [ nrotate ] dip [ nrotate-d ] curry map ]
    if ; recursive

! : rotations ( grid xforms -- grids ) [ [ nrotate-d ] curry ] map cleave ; inline foldable

: all-rotations ( grid --  'grid ) {
        [ { 1 1 } nrotate-d ]
        [ { 1 0 } nrotate-d ]
        [ { 1 -1 } nrotate-d ]
        [ { 0 1 } nrotate-d ]
        [ { 0 0 } nrotate-d ]
        [ { 0 -1 } nrotate-d ]
        [ { -1 1 } nrotate-d ]
        [ { -1 0 } nrotate-d ]
        [ { -1 -1 } nrotate-d ]
} cleave 9 narray ; foldable

: m+ms ( ms -- m ) unclip [ m+ ] reduce ;

: next-state-cell ( current neighbours -- next ) {
        { [ dup 4 = ] [ drop ] }
        { [ dup 3 = ] [ 2drop 1 ] }
        [ 2drop 0 ]
    } cond ;

: next-state ( grid -- grid )
    dup all-rotations m+ms
    [ [ next-state-cell ] 2map ] 2map ;
