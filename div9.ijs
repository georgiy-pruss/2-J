NB. find permutation of '123456789' where the number formed
NB. of first n digits is divisible by n, e.g.:
NB. 1 - div by 1
NB. 12 - div by 2
NB. 123 - div by 3
NB. 1236 - div by 4
NB. etc

d =: 4 : '0=y|".y{.x'          NB. 'xxxxxxx' d k - test divisibility
a =: 4 : '*/ y d"(_ 0) >:i.x'  NB. n a 'xxxxxxx' - test for all lengths 1 to n
p =: 3 : 0
  echo ')',~":y
  m =. !y
  v =. y{.'123456789'
  for_n. i.m do.
    if. y a n A. v do. echo n A. v end.
  end.
)
p 3 NB. 123 321       NB. solution for '123'
p 6 NB. 123654 321654
p 8 NB. 38165472
p 9 NB. 381654729     NB. 12.8s (while), 12.35s (for)
NB. other lengths have no solutions
echo '--'

NB. now, using only length 9

q =: 3 : 0
  for_n. i.!9 do. if. 9 a n A. '123456789' do. n A. '123456789' return. end. end.
)

s =: 6!:1''
r =: q ''
e =: 6!:1''
echo r, ' (',(":e-s),'s)' NB. 3.47

NB. ... and power conjunction ^:

a =: 3 : '*/ y d"(_ 0) >:i.9'  NB. only for n=9, and then fix it to tacit:
a =: [: */ (1+i.9) d"_ 0~ ]
t =: a @ (A.&'123456789')      NB. test in perm.index is ok

s =: 6!:1''               NB. start
n =: (>:^:(-.&t)^:_) 0    NB. calc index of permutation
p =: n A. '123456789'     NB. permutation itself
e =: 6!:1''               NB. end

echo p, ' (',(":e-s),'s)' NB. 111296 -> 381654729 (3.19s [2.23s at work])

NB. finally, the shortest form

d =: 4 : '0=y|".y{.x'
t =: ([: */ (1+i.9) d"_ 0~ ]) @ (A.&'123456789')
echo '123456789' A.~ (>:^:(-.&t)^:_) 0

NB. one-liner is even faster: 2.60s [1.85s at work]
s =: 6!:1''
echo '123456789'A.~(>:^:(-.&(([:*/(1+i.9)(4 :'0=y|".y{.x')"_ 0~])@(A.&'123456789')))^:_)0
e =: 6!:1''
echo '(',(":e-s),'s)' NB. 2.60s ......... but Python is 5+ times faster

exit 0
