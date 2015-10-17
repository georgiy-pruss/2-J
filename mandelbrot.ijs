mcf=. (<: 2:)@|@(] ((*:@] + [)^:((<: 2:)@|@])^:1000) 0:) NB. 1000 iterations test
domain=. |.@|:@({.@[ + ] *~ j./&i.&>/@+.@(1j1 + ] %~ -~/@[))&>/

'.#'{~ mcf"0 @ domain (_2j_1 1j1) ; 0.1

NB. load'viewmat'
NB. viewmat mcf"0 @ domain (_2j_1 1j1) ; 0.01 NB. Complex interval and resolution

hd=: 3 : '''P2'',LF,(":|.$y),LF,''255'',LF'
t=: 255*mcf"0 @ domain (_2j_1 1j1) ; 0.01  NB. 201 301 = $t
((hd t),,LF,"1~":t) (1!:2) <'C:\MB',((":|.$t)rplc' ';'x'),'.pgm' NB. See C:\MB301x201.pgm
