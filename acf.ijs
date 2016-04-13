NB. analyze cat food data

use 'colors'
echo =: 4 : '0 0 $ y 1!:2(2) [ sc x' NB. color echo value

T =: 200 NB. target for one day

C =: 'C:\Users\Geo\AppData\Roaming\PowerPro\Notes\2-CatFood.txt'
N =: 39 NB. full lines are 39 chars 0..35 + total at 36 37 38

run =: 3 : 0 NB. prints unfinished lines, then table: total/mean for months, and grand total
  fmt=. 4 : 'x,'' '',(":+/y),'' '',5j1":(+/ % #)y' NB. format table row
  sum =. 3 : '+/+/&(". :: 0:)&> }.;: y' NB. sum of numbers in line
  t=.s=.0$0
  r=.0$< d=.''
  for_l. y do.
    k=.#l=.>l
    if. (k<7) +. '#'={.l do. continue. end. NB. empty/comment line
    if. k<9 do. NB. yyyy/mm
      if. 0<#d do. s=.0$0 [ t=.t,s [ r=.r,< d fmt s end.
      d=.l
    elseif. k>:N do. NB. full line, 39 actually
      lft =. sum (N-3){.l [ ttl =. ".(N+_3+i.3){l NB. check if sum is correct
      if. lft~:ttl do. 'RW'echo 'error in: "',l,'", gives: ',(":lft),' total: ',":ttl end.
      s=.s,ttl
    elseif. do. NB. daily total not calculated, do it
      n=. sum l
      if. n<T do. 'M'echo l,' ---> ',(":n),' (till ',(":T),': ',(":T-n),')'
      else. 'R'echo l,' ---> ',(":n),' (>=',(":T),')' end.
    end.
  end.
  'w'echo >r,< d fmt s
  'W'echo 'total ' fmt t,s
  sc'w'
)
         NB. remove UTF8 marker X'EF BB BF' if present
run (< (3* 239 187 191 -: a.i. 3{.h) }.h=.>{.t) 0} t=. cutLF CR-.~ fread C
exit 0
