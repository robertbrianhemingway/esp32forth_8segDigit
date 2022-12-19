: abort ( -- ) -1 throw ;
: count ( adr -- adr n ) dup c@ swap 1+ swap + ;

: >INPUT   ( pin# -- )  input  pinMode ;
: >OUTPUT  ( pin# -- )  output pinMode ;
: pin>High ( pin# -- )  high digitalWrite ;
: pin>Low  ( pin# -- )  low  digitalWrite ;

: loadtest ( -- ) s" /spiffs/test.f" included ;
