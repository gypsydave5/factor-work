! Copyright (C) 2019 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test palindrome ;
IN: palindrome.tests

{ t } [ "racecar" palindrome? ] unit-test
{ f } [ "hello" palindrome? ] unit-test
{ t } [ "a man, a plan, a canal: Panama" palindrome? ] unit-test
