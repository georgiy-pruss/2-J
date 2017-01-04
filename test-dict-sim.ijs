
t1 =: 3 : 0 NB. unordered array, search by e. and insert by ,
  v =. ,0
  w =. ,0
  m =. <.0.25*y
  for_i. i.y do.
    n =. ? m
    z =. -n
    if. -. n e. v do.
      w =. w,z [ v =. v,n end. end.
  NB. v =. v{~ o =. /: v
  NB. w =. w{~ o
  (#v), ({&v , {&w) <.-:#v
)

t2 =: 3 : 0 NB. ordered array, search by I. and insert by {.,,}.
  v =. ,0
  w =. ,0
  m =. <.0.25*y
  for_i. i.y do.
    n =. ? m
    z =. -n
    p =. v I. n
    if. p<#v do. toadd =. n~:p{v else. toadd =. 1 end.
    if. toadd do.
      if. p<#v do. w =. (p{.w),z,(p}.w) [ v =. (p{.v),n,(p}.v)
      else. w =. w,z [ v =. v,n end. end. end.
  (#v), ({&v , {&w) <.-:#v
)

3 : 0 (3)
for_n. ,5 10 20*/~100 1000 10000 do.
  tm1 =: y 6!:2 't1 ',":n NB. t1 is faster till 5000 and after 150000 items
  tm2 =: y 6!:2 't2 ',":n NB. t2 is faster between 5000 and 150000 items
  echo n,tm1,tm2
end.
)
0 : 0 NB. for q=0.7 i.e. 70% unique, 30% already there; and 0.25/0.75 on right
500     0.671 ms  1.162 ms   .548  .832
1000    1.521 ms  2.595 ms   1.17  1.76
2000    3.924 ms  5.942 ms   2.62  3.75
5000    20.23 ms  19.23 ms   10.2  10.6
10000   0.0765 s  0.0580 s   40.3  24.2
20000   0.2969    0.1647     .162  .067
50000   1.838     0.879      1.00  .248
100000  7.46      3.86       3.97  .828
200000  36.5      45.5       15.9  4.14
)
exit 0
