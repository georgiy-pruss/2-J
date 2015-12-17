NB. Simple expression compiler (to RPN) and interpreter

OPS=: '( ) + - * / % ^ | & ~ < > =' -.' '
pr=: 0 0 0 3 3 4 4 4 5 3 4 5 2 2 2 0 {~ ]
ops=: [`[`]`+`-`*`%`(|~)`^`(23 b.)`(17 b.)`(22 b.)`<`>`=

parse=: 3 : 0 NB. returns sequence of tokens [op] or [0 number]
  t=. 0$<0
  for_c. ;: y-.' ' do. if. _=n=._".>c do. t=.t,<>:OPS i.>c else. t=.t,<0,n end. end.
  t,<>:#OPS NB. append 'END' token
)

rpn=: 3 : 0 NB. reorder tokens into RPN sequence, no '(' ')' of course
  o=. 0$0 [ r=. 0$<0
  for_c. y do.
    select. a=. {.>c case. 0 do. r=.r,c case. 1 do. o=.o,a
    case. 2 do. while. (1~:{:o) *. 0<#o do. o=.}:o [ r=. r,<{:o end. o=.}:o
    case. do. while. ((pr a)<:pr{:o) *. 0<#o do. o=.}:o [ r=.r,<{:o end. o=.o,a
    end.
  end. r NB. e.g. |0 1|0 10|0 100|0 1|3|5|3|0 _200|0 2|0 3|8|0 4|6|6|4|
)

calculate=: 3 : 0 NB. interpret RPN 'program'
  s=.0$0
  for_c. y do. a=.>c if. 0={.a do. s=.s,{:a else. s=.(_2}.s),(a{ops)/_2 _1{s end. end.
  (":s),' (#',(('0123456789abcdef'{~16#.^:_1])<.{.s),')'
)

echo calculate rpn parse >{:ARGV NB. e.g. 1+10*(100+1)-_200/(2^3/4) --> 1111

exit 0 NB. TODO: https://en.wikipedia.org/wiki/Shunting-yard_algorithm
