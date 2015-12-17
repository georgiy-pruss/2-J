NB. convert/misc/md5
NB. RSA Data Security, Inc. MD5 Message-Digest Algorithm
NB. version: 1.0.2
NB.
NB. See RFC 1321 for license details
NB. J implementation -- (C) 2003 Oleg Kobchenko;
NB.
NB. 09/04/2003 Oleg Kobchenko
NB. 03/31/2007 Oleg Kobchenko j601, JAL
NB. 12/17/2015 G.Pruss j803

NB. require 'convert'
coclass 'pcrypt'

NB. lt= (*. -.)~   gt= *. -.   ge= +. -.   xor= ~:
'`lt gt ge xor and or sh'=: (20 b.)`(18 b.)`(27 b.)`(22 b.)`(17 b.)`(23 b.)`(33 b.)
rot=: 4294967295 and sh or ] sh~ 32 -~ [ NB. (y << x) | (y >>> (32 - x))
add=: ((16bffffffff&and)@+)"0
hexlist=: tolower@:,@:hfd@:,@:(|."1)@(256 256 256 256&#:)

cmn=: 4 : 0
  'x s t'=. x [ 'q a b'=. y
  b add s rot (a add q) add (x add t)
)

ff=: cmn (((1&{ and 2&{) or 1&{ lt 3&{) , 2&{.)
gg=: cmn (((1&{ and 3&{) or 2&{ gt 3&{) , 2&{.)
hh=: cmn (((1&{ xor 2&{)xor 3&{       ) , 2&{.)
ii=: cmn (( 2&{ xor 1&{  ge 3&{       ) , 2&{.)
op=: ff`gg`hh`ii

I=: ".;._2(0 : 0)
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
1 6 11 0 5 10 15 4 9 14 3 8 13 2 7 12
5 8 11 14 1 4 7 10 13 0 3 6 9 12 15 2
0 7 14 5 12 3 10 1 8 15 6 13 4 11 2 9
)
S=: 4 4$7 12 17 22 5 9 14 20 4 11 16 23 6 10 15 21

NB. T=: |:".;._2(0 : 0)
NB. 16bd76aa478 16bf61e2562 16bfffa3942 16bf4292244
NB. 16be8c7b756 16bc040b340 16b8771f681 16b432aff97
NB. 16b242070db 16b265e5a51 16b6d9d6122 16bab9423a7
NB. 16bc1bdceee 16be9b6c7aa 16bfde5380c 16bfc93a039
NB. 16bf57c0faf 16bd62f105d 16ba4beea44 16b655b59c3
NB. 16b4787c62a 16b02441453 16b4bdecfa9 16b8f0ccc92
NB. 16ba8304613 16bd8a1e681 16bf6bb4b60 16bffeff47d
NB. 16bfd469501 16be7d3fbc8 16bbebfbc70 16b85845dd1
NB. 16b698098d8 16b21e1cde6 16b289b7ec6 16b6fa87e4f
NB. 16b8b44f7af 16bc33707d6 16beaa127fa 16bfe2ce6e0
NB. 16bffff5bb1 16bf4d50d87 16bd4ef3085 16ba3014314
NB. 16b895cd7be 16b455a14ed 16b04881d05 16b4e0811a1
NB. 16b6b901122 16ba9e3e905 16bd9d4d039 16bf7537e82
NB. 16bfd987193 16bfcefa3f8 16be6db99e5 16bbd3af235
NB. 16ba679438e 16b676f02d9 16b1fa27cf8 16b2ad7d2bb
NB. 16b49b40821 16b8d2a4c8a 16bc4ac5665 16beb86d391
NB. )
T=: 4 16$<.16b100000000*|1 o.>:i.64

norm=: 3 : 0
n=. 16 * 1 + _6 sh 8 + #y
b=. n#0  [  y=. a.i.y
for_i. i. #y do.
  b=. ((j { b) or (8*4|i) sh i{y) (j=. _2 sh i) } b
end.
b=. ((j { b) or (8*4|i) sh 128) (j=._2 sh i=.#y) } b
_16]\ (8 * #y) (n-2) } b
)

NB.*md5 v MD5 Message-Digest Algorithm
NB.  diagest=. md5 message
md5=: 3 : 0
X=. norm y
q=. r=. 16b67452301 16befcdab89 16b98badcfe 16b10325476
for_x. X do.
  for_j. i.4 do.
    l=. ((j{I){x) ,. (16$j{S) ,. j{T
    for_i. i.16 do.
      r=. _1|.((i{l) (op@.j) r),}.r
    end.
  end.
  q=. r=. r add q
end.
hexlist r
)

md5_z_=: md5_pcrypt_

NB. standart tests
assert 'd41d8cd98f00b204e9800998ecf8427e' -: md5 ''
assert '7215ee9c7d9dc229d2921a40e899ec5f' -: md5 ' '
assert '0cc175b9c0f1b6a831c399e269772661' -: md5 'a'
assert '900150983cd24fb0d6963f7d28e17f72' -: md5 'abc'
assert 'f96b697d7cb7938d525a2f31aaf161d0' -: md5 'message digest'
assert 'c3fcd3d76192e4007dfb496cca67e13b' -: md5 a=.'abcdefghijklmnopqrstuvwxyz'
assert 'd174ab98d277d9f5a5611c2c9f419d9f' -: md5 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',a,'0123456789'
assert '57edf4a22be3c955ac49da2e2107b67a' -: md5 80$'1234567890'

echo md5 fread <'md5.ijs'
exit 0
