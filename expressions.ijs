NB. Simple expressions compiler (to RPN) and interpreter

OPS=: '( ) + - * / % ^ | & ~ < > =' -.' '
pr=: 0 0 0 3 3 4 4 4 5 3 4 5 2 2 2 0 {~ ]
END=: 15

parse=: 3 : 0
  t=. 0$<0
  for_c. ;: y-.' ' do.
    if. _ = n=._".>c do.  t=.t,<1+OPS i. >c else.  t=.t,<0,n end.
  end.
  t, <END
)

toRPN=: 3 : 0
  o=. 0$0 [ r=. 0$<0
  for_c. y do.
    select. a=. {.>c case. 0 do. r=.r,c case. 1 do. o=.o,a
    case. 2 do. while. (1~:{:o) *. 0<#o do. o=.}:o [ r=. r,<{:o end. o=.}:o
    case. do. while. ((pr a)<:pr{:o) *. 0<#o do. o=.}:o [ r=.r,<{:o end. o=.o,a
    end.
  end. r
)

'`AND OR XOR'=: (17 b.)`(23 b.)`(22 b.)

calcRPN=: 3 : 0
  s=.0$0
  for_c. y do.
    select. {.>c case. 0 do. s=.s,{:>c
    case. 3 do. s=.(_2}.s),+/_2 _1{s  case. 4 do. s=.(_2}.s),-/_2 _1{s
    case. 5 do. s=.(_2}.s),*/_2 _1{s  case. 6 do. s=.(_2}.s),%/_2 _1{s
    case. 7 do. s=.(_2}.s),|~/_2 _1{s  case. 8 do. s=.(_2}.s),^/_2 _1{s
    case. 9 do. s=.(_2}.s),OR/_2 _1{s  case. 10 do. s=.(_2}.s),AND/_2 _1{s
    case. 11 do. s=.(_2}.s),XOR/_2 _1{s  case. 14 do. s=.(_2}.s),=/_2 _1{s
    case. 12 do. s=.(_2}.s),</_2 _1{s  case. 13 do. s=.(_2}.s),>/_2 _1{s
    end.
  end. s
)

echo calcRPN toRPN parse {:ARGV

exit 0 NB. TODO: https://en.wikipedia.org/wiki/Shunting-yard_algorithm
