( more elegant 8 seg words )

: makeNumbers create   ( -- )
  ( bit patterns for digits 0 to 9 corresponding to segments 1-8 in sequence )
  ( Top=bit 7 TL=6 BL=5 B=4 BR=3 TR=2 M=1 Pt=0 )
  ( so a 0 has ON T,TL,BL,B,BR,TR OFF M,Pt = 0b11111100 $FC )
  $fc c, $0c c, $b6 c, $9e c, $4e c, $da c, $7a c, $8c c, $fe c, $ce c, 
;  
: makeGPIOList create  ( -- )
  ( Pos 0=GPIO20 ie Pt, 1=19 ie middle segment ... 7=13 ie Top segment )
  20 c, 19 c, 14 c, 15 c, 16 c, 17 c, 18 c, 13 c, 
;

: getBitPattern  ( n addr -- bp   where 0<=n<=9 and bp is bit pattern )
  + c@
;

: DecodeBitPattern  ( bp -- )
  ( look at each of the 8 bits which map to 1 of 8 GPIO pins )
  
;  
  
makeNumbers nums
makeGPIOList gpios

: .1  ( -- )
  1 getBitPattern   \ bp
  DecodeBitPattern  \ --
;  
