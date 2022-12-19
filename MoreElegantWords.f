( more elegant 8 seg words )

0 value numsAdr
0 value alphaAdr
0 value gpiosAdr

( the following are in autoexec.fs )
( : >INPUT   ( pin# -- )  input  pinMode ; )
( : >OUTPUT  ( pin# -- )  output pinMode ; )
( : pin>High ( pin# -- )  high digitalWrite ; )
( : pin>Low  ( pin# -- )  low  digitalWrite ; )

: makeNumbers create   ( -- )
  ( bit patterns for digits 0 to 9 corresponding to segments 1-8 in sequence )
  ( Top=bit 7 TL=6 BL=5 B=4 BR=3 TR=2 M=1 Pt=0 )
  ( so a 0 has ON T,TL,BL,B,BR,TR OFF M,Pt = 0b11111100 $FC )
  $fc c, $0c c, $b6 c, $9e c, $4e c, $da c, $7a c, $8c c, $fe c, $ce c, 
;  
: makeGPIOList create  ( -- )
  ( Pos 0=GPIO20 ie Pt, 1=19 ie middle segment ... 7=13 ie Top segment )
  21 c, 19 c, 14 c, 15 c, 16 c, 17 c, 18 c, 13 c, 
;
: makeAlphas create  ( -- )
  $ee c, $fe c, $f0 c, $fc c, $f2 c, $e2 c,  
  ( A B C D E F  for hex numbers)
;  

: pointOn   ( -- )  21 pin>low ;
: pointOff  ( -- )  21 pin>high ;
: getDigitBitPattern  ( n -- bp   where 0<=n<=9 and bp is bit pattern )
  numsAdr + c@
;
: getAlphaBitPattern  ( n -- bp )
  alphaAdr + c@
;  
: addPoint  ( n -- n' ) 1 or ;  ( sets bit 0 to 1 )

: getIthBitFromByte  ( bitpat I -- f|t )
  1 swap           \ bp 1 I 
  lshift and       \ f|t
;  
: invertLogic  ( t|f -- f|t ) 0= ;

: decodeIthBit  ( bp I -- bp )
  ( save bp, get Ith bit in bp, get Ith GPIOpin, set pin )
  2dup              \ bp I bp I
  getIthBitFromByte \ bp I t|f
  invertLogic       \ bp I f|t  as a low turns segment ON
  ( now find Ith GPIO pin  and set to this f|t value )
  swap             \ bp t|f I
  gpiosAdr + c@    \ bp t|f pin#
  swap digitalWrite \ bp  left on stack for next bit
;

: DecodeBitPattern  ( bp -- )
  ( look at each of the 8 bits which map to 1 of 8 GPIO pins )
  ( bit 0 is pt, bit 7 is top segment )
  8 0 DO I          \ bp I  where I is both bit position and gpio index in GPIOList 
        decodeIthBit   ( bp I -- bp )
      LOOP       \ bp
	  drop       \  --
;  
  
: setGPIOModes  ( -- )
  20 13 DO
          I >OUTPUT
		  I pin>low 200 ms
		  I pin>high 200 ms
        LOOP
  21 >OUTPUT
  21 pin>low 200 ms
  21 pin>high   
;

: allOFF  ( -- ) 20 13 DO I high digitalWrite LOOP 21 high digitalWrite ;   \ using GPIO pins 13 to 19
: allON   ( -- ) 20 13 DO I low  digitalWrite LOOP 21 low digitalWrite ;

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

: .digit ( n -- ) getDigitBitPattern DecodeBitPattern ; 
: .0 0  .digit ;
: .1 1  .digit ; 
: .2 2  .digit ; 
: .3 3  .digit ; 
: .4 4  .digit ; 
: .5 5  .digit ; 
: .6 6  .digit ; 
: .7 7  .digit ;
: .8 8  .digit ; 
: .9 9  .digit ; 
: .alpha ( n -- ) getAlphaBitPattern addPoint DecodeBitPattern ; 
( at this time using point to indicate an alpha character )
: .A 0 .alpha ;
: .B 1 .alpha ;
: .C 2 .alpha ;
: .D 3 .alpha ;
: .E 4 .alpha ;
: .F 5 .alpha ;
