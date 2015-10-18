NB. C:\Users\gpruss\j64-804-user\config\startup.ijs

extendijs =: 3 : 0
 if. -.'.ijs'-:_4{. nn=.nm=.>y do. nn=.nm,'.ijs' end.
 if. isfile_j_ nn=.'C:\BIN\',nn do. nn else. nm end.
)

NB. 'use' can be used instead of 'require' and it looks first in 'C:\BIN'
use =: 3 : 'require (extendijs&.>) cutnames_j_ y'
