NB. AES implementation in J (c) Georgiy Pruss 2014. Based on:
NB. AES implementation in JavaScript (c) Chris Veness 2005-2011
NB. see http://www.movable-type.co.uk/scripts/aes.html
NB. see http://csrc.nist.gov/publications/PubsFIPS.html#197 (fips-197.pdf)

NB. all this will be in aes namespace

Nb =: 4  NB. block size (in words): no of columns in state (fixed at 4 for AES)

xor =: 22 b.
shl =: 33 b.

X =: _2 dfh\] NB. dfh is predefined as 16#.16|'0123456789ABCDEF0123456789abcdef'i.]

NB. sBox is pre-computed multiplicative inverse in GF(2^8) used in subBytes and keyExpansion [§5.1.1]
sBox =:      X'637c777bf26b6fc53001672bfed7ab76ca82c97dfa5947f0add4a2af9ca472c0'
sBox =: sBox,X'b7fd9326363ff7cc34a5e5f171d8311504c723c31896059a071280e2eb27b275'
sBox =: sBox,X'09832c1a1b6e5aa0523bd6b329e32f8453d100ed20fcb15b6acbbe394a4c58cf'
sBox =: sBox,X'd0efaafb434d338545f9027f503c9fa851a3408f929d38f5bcb6da2110fff3d2'
sBox =: sBox,X'cd0c13ec5f974417c4a77e3d645d197360814fdc222a908846eeb814de5e0bdb'
sBox =: sBox,X'e0323a0a4906245cc2d3ac629195e479e7c8376d8dd54ea96c56f4ea657aae08'
sBox =: sBox,X'ba78252e1ca6b4c6e8dd741f4bbd8b8a703eb5664803f60e613557b986c11d9e'
sBox =: sBox,X'e1f8981169d98e949b1e87e9ce5528df8ca1890dbfe6426841992d0fb054bb16'

NB. rCon is Round Constant used for the Key Expansion [1st col is 2^(r-1) in GF(2^8)] [§5.2]
rCon =: |:4 11$0 1 2 4 8 16 32 64 128 27 54,33#0

NB. Perform Key Expansion to generate a Key Schedule for 128/192/256-bit keys [§5.2]
NB. y -- Key as 16/24/32-byte array; returns ((4*Nr+1),Nb)-array as key schedule
keyExpansion =: 3 : 0
  Nr =. 6 + Nk =. <.4%~#y  NB. key length: 4/6/8 words; number of rounds: 10/12/14
  w =. (Nk,4)$y  NB. first part -- the key itself
  for_i. Nk+i.(Nb*(Nr+1))-Nk do.
    temp =. (i-1){w
    if. 0=Nk|i do.
      temp =. ((1|.temp){sBox) xor (<.i%Nk){rCon
    elseif. (Nk>6) *. 4=Nk|i do.
      temp =. temp{sBox  NB. additional SBox[temp] for 256-bit (8-word) keys
    end.
    w =. w, temp xor (i-Nk){w
  end. w
)

mixColumn =: 3 : 0
  z =. (16b11b*127<y)xor 2*y  NB. z = {02}*y
  (1 0 0 0{y)xor(2 2 1 1{y)xor(3 3 3 2{y)xor(0 1 2 0{z)xor(1 2 3 3{z)
)

NB. AES Cipher function: encrypt 'input' state with Rijndael algorithm [§5.1]
NB. x -- Input state: 16-byte (128-bit) array
NB. y -- Key schedule as 2D array (Nb * 4*(Nr+1) items/bytes)
cipher =: 4 : 0
  Nr =. <.<:Nb%~#y  NB. no of rounds: 10/12/14 for 128/192/256-bit keys
  state =. x$~4,Nb  NB. initialise 4xNb byte-array 'state' with input [§3.4]
  i4 =. i.4         NB. ... our state is |:state actually
  for_round. i.Nr-1 do.
    state =. state xor (i4+4*round){y       NB. apply addRoundKey [§5.1.4]
    state =. |: 0 1 2 3|."_1 |: state{sBox  NB. SBox[state] and shiftRows
    state =. mixColumn"_1 state      NB. mixColumns in Nr-1 rounds [§5.1.3]
  end.
  state =. state xor (i4+4*Nr-1){y
  state =. |: 0 1 2 3|."_1 |: state{sBox
  , state xor (i4+4*Nr){y NB. Last addRoundKey and return as 1-d array [§3.4]
)

text =: X'3243f6a8885a308d313198a2e0370734' [ key =: X'2b7e151628aed2a6abf7158809cf4f3c'
assert (X'3925841d02dc09fbdc118597196a0b32') -: text cipher keyExpansion key

NB. ----------------------------------------------------------------------------

key =: X'2b7e151628aed2a6abf7158809cf4f3c'
txt =: X'3243f6a8885a308d313198a2e0370734'
cph =: X'3925841d02dc09fbdc118597196a0b32'
assert cph -: txt cipher keyExpansion key
key =: X'000102030405060708090a0b0c0d0e0f'
txt =: X'00112233445566778899aabbccddeeff'
cph =: X'69C4E0D86A7B0430D8CDB78070B4C55A'
assert cph -: txt cipher keyExpansion key
key =: X'E8E9EAEBEDEEEFF0F2F3F4F5F7F8F9FA'
txt =: X'014BAF2278A69D331D5180103643E99A'
cph =: X'6743C3D1519AB4F2CD9A78AB09A511BD'
assert cph -: txt cipher keyExpansion key
key =: X'11223344556677880000000000000000'
txt =: X'00000000000000001122334455667788'
cph =: X'94FE1F7483D3C77B0F9CB6A112E317C9'
assert cph -: txt cipher keyExpansion key
key =: X'000102030405060708090a0b0c0d0e0f1011121314151617'
txt =: X'00112233445566778899aabbccddeeff'
cph =: X'dda97ca4864cdfe06eaf70a0ec0d7191'
assert cph -: txt cipher keyExpansion key
key =: X'04050607090A0B0C0E0F10111314151618191A1B1D1E1F20'
txt =: X'76777475F1F2F3F4F8F9E6E777707172'
cph =: X'5d1ef20dced6bcbc12131ac7c54788aa'
assert cph -: txt cipher keyExpansion key
key =: X'000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f'
txt =: X'00112233445566778899aabbccddeeff'
cph =: X'8ea2b7ca516745bfeafc49904b496089'
assert cph -: txt cipher keyExpansion key
key =: X'08090A0B0D0E0F10121314151718191A1C1D1E1F21222324262728292B2C2D2E'
txt =: X'069A007FC76A459F98BAF917FEDF9521'
cph =: X'080e9517eb1677719acf728086040ae3'
assert cph -: txt cipher keyExpansion key

NB. Run 'tests 1000' to measure time for 1000 16-byte encryptions
tests =: 3 : 0
  t =. (6!:2) '1 tests ',":y
  echo ' kB/s',~0j1":16e_3*y%t
  NB. i3-3220 3.30GHz -- 61.4 kB/s (was 22.7; 18.8 in 2 procs)
:
  k =. keyExpansion ?16#256
  n =. 0
  for_i. i.y do. n=.n + # k cipher~ ?16#256 end.
  n
)

hex =: 3 : 0
'0123456789ABCDEF'{~16#.^:_1 y
:
'0123456789ABCDEF'{~(x$16)#:y NB. left argument is width
)
HEX =: 13 : ',/"_1(2 hex y)' NB. for better output of matrices
