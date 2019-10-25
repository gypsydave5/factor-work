! Copyright (C) 2019 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel sequences unicode ;
IN: palindrome

: normalize ( string -- string' ) [ Letter? ] filter >lower ;

: palindrome? ( string -- ? ) normalize dup reverse = ;
