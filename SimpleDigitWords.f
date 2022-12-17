( 17Dec22  for ESP32forth )
: .A  ( S7 GPIO13 LOW )  low 13 pin ; 
: .B  ( S6 GP14 ) low 14 pin ;
: .C  ( S4 GP15 ) low 15 pin ;
: .D  ( S2 GP16 ) low 16 pin ;
: .E  ( S1 GP17 ) low 17 pin ;
: .F  ( S9 GP18 ) low 18 pin ;
: .G  ( S10 GP19 ) low 19 pin ;

: one
: two
: three
: four
: five
: six
: seven
: eight
: nine

: allSegmentsOn   ( -- )  \ set all except 3.8 to LOW
;
: allSegmentsOff  ( -- )  \ set all except 3,8 to HIGH
;
