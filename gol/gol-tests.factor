! Copyright (C) 2019 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test gol ;
FROM: kernel => drop ;
IN: gol.tests

{ { } } [ 0 0 grid ] unit-test
{ { { 0 } } } [ 1 1 grid ] unit-test
{ { { 0 0 } { 0 0 } } }  [ 2 2 grid ] unit-test
{ { { 0 0 0 0 } { 0 0 0 0 } } }  [ 2 4 grid ] unit-test

{ { { 0 0 } { 0 1 } } } [ 2 2 grid { { 1 1 } } [ drop 1 ] map-coords ] unit-test

{ { 1 "bob" 2 3 } } [ { 1 1 2 3 } 1 [ drop "bob" ] apply-nth ] unit-test

{ { { 1 } } }  [ 1 1 grid 0 0 live ]  unit-test
{ { { 1 0 } { 0 0 } } }  [ 2 2 grid 0 0 live ]  unit-test

{ { { 1 1 } { 1 0 } } }  [ { { 1 1 } { 1 1 } } 1 1 die ]  unit-test

{ 0 } [ 0 4 next-state-cell ] unit-test
{ 1 } [ 1 4 next-state-cell ] unit-test
{ 1 } [ 1 3 next-state-cell ] unit-test
{ 1 } [ 0 3 next-state-cell ] unit-test
{ 0 } [ 0 2 next-state-cell ] unit-test
{ 0 } [ 0 1 next-state-cell ] unit-test
{ 0 } [ 0 0 next-state-cell ] unit-test
