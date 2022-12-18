( bits in each byte sets a segment on or off )
( a 1 sets it on, a 0 sets it off )
( bit 7 is top bar, 6 - top/left, 5 - bot/left, 4 - bottom, 3 - bot/right, 2 - top/right, 1 - middle, 0 - point )
( so $FC = 0b11111100 or top, tl, bl, bot, br,tr, ON and mid, point OFF )
: makeNumbers create  $fc c, $0c c, $b6 c, $9e c, $4e c, $da c, $7a c, $8c c, $fe c, $ce c, DOES> + c@ ;
( usage  :-makeNumbers <name> )
( runtime:- n0 <name> will leave the byte tos )
