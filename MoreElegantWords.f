( more elegant 8 seg words )

0 value numsAdr
0 value alphaAdr
0 value gpiosAdr

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
: makeAlphas create  ( -- )
  $ee.3
  c, $fe c, $f0 c,  ( A B C )
;  

: getBitPattern  ( n -- bp   where 0<=n<=9 and bp is bit pattern )
  numsAdr + c@
;
: getAlphaBitPattern  ( n -- bp )
  alphaAdr + c@
;  

: decodeIthBit  ( bp I -- bp )
  ( save bp, get Ith bit in bp, get Ith GPIOpin, set pin )
  2dup             \ bp I bp I
  1 swap           \ bp I bp 1 I
  lshift and       \ bp I t|f
  0=               \ bp I f|t  as a Low is ON for segment
  ( now find Ith GPIO pin )
  swap             \ bp t|f I
  gpiosAdr + c@    \ bp t|f pin#
  swap digitalWrite \ bp
;

: DecodeBitPattern  ( bp -- )
  ( look at each of the 8 bits which map to 1 of 8 GPIO pins )
  ( bit 0 is pt, bit 7 is top segment )
  8 0 DO I          \ bp I  where I is both bit position and gpio index in GPIOList 
        decodeIthBit   ( bp I -- bp )
      LOOP
	  drop          \ drop bp
;  
  
: setGPIOModes  ( -- )
  20 13 DO
          I OUTPUT pinMode
		  I low digitalWrite 200 ms
		  I high digitalWrite 200 ms
        LOOP
;

: allOFF  ( -- ) 20 13 DO I high digitalWrite LOOP ;   \ using GPIO pins 13 to 19
: allON   ( -- ) 20 13 DO I low  digitalWrite LOOP ;

( make bit pattern byte arrays )  
makeNumbers nums
makeGPIOList gpios
makeAlphas alphas
( store array addresses )
nums to numsAdr
gpios to gpiosAdr
alphas to alphaAdr
( set GPIO pints to OUTPUT )
setGPIOModes

: .0 0 getBitPattern DecodeBitPattern ;
: .1 1 getBitPattern DecodeBitPattern ; 
: .2 2 getBitPattern DecodeBitPattern ; 
: .3 3 getBitPattern DecodeBitPattern ; 
: .4 4 getBitPattern DecodeBitPattern ; 
: .5 5 getBitPattern DecodeBitPattern ; 
: .6 6 getBitPattern DecodeBitPattern ; 
: .7 7 getBitPattern DecodeBitPattern ; 
: .8 8 getBitPattern DecodeBitPattern ; 
: .9 9 getBitPattern DecodeBitPattern ; 
: .A 0 getAlphaBitPattern DecodeBitPattern ;
: .B 1 getAlphaBitPattern DecodeBitPattern ;
: .C 2 getAlphaBitPattern DecodeBitPattern ;
