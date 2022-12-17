( 17Dec22  for ESP32forth )
: .A  ( S7 GPIO13 LOW )  low 13 pin ; 
: .B  ( S6 GP14 ) low 14 pin ;
: .C  ( S4 GP15 ) low 15 pin ;
: .D  ( S2 GP16 ) low 16 pin ;
: .E  ( S1 GP17 ) low 17 pin ;
: .F  ( S9 GP18 ) low 18 pin ;
: .G  ( S10 GP19 ) low 19 pin ;

: one  ( -- ) allSegmentsOff .c .b ;
: two  ( -- ) allSegmentsOff .a .b .g .e .d ;
: three  ( -- ) allSegmentsOff .a .b .g .c .d ;
: four  ( -- ) allSegmentsOff .f .g .b .c ;
: five  ( -- ) allSegmentsOff .a .f .g .c .d ;
: six  ( -- ) allSegmentsOff .a .f .e .d .c .g ;
: seven  ( -- ) allSegmentsOff .a .b .c ;
: eight  ( -- ) allSegmentsOn ;
: nine  ( -- ) allSegmentsOff .a .f .g .b .c ; 

: .1 ( -- ) one ;
: .2 two ;
: .3 three ;
: .4 four ;
: .5 five ;
: .6 six ;
: .7 seven ;
: .8 eight ;
: .9 nine ;

: setPinHigh  ( n -- ) high digitalWrite ;
: setPinLow   ( n -- ) low  digitalWrite ;  
: allSegmentsOff  ( -- )  \ set all except 3,8 to HIGH
  20 13 DO I setPinHigh LOOP ;
;
: allSegmentsOn   ( -- )  \ set all except 3.8 to LOW
  20 13 DO I setPinLow LOOP ;
;
