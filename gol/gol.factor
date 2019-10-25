! Copyright (C) 2019 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel arrays ;
IN: gol

: grid ( m n -- seq ) 0 <array> <array> ;

: live ( grid x y -- grid )  ;
