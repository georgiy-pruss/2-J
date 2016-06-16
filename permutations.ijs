NB. based on https://docs.python.org/3/library/itertools.html#itertools.permutations

permutations =: 3 : 0
  (#y) permutations y
:
  pool =. y
  n =. #y
  r =. x
  assert. r<:n
  indices =. i. n
  cycles =. n - i. r

  echo (r{.indices){pool

  while. 1 do.
    for_i. i. -r do. ii=.i
      cycles =. (c =. <: i{cycles) i}cycles
      brk=.0
      if. c=0 do.
        indices =. (i{.indices),1|.i}.indices
        cycles =. (n-i) i}cycles
      else.
        j =. - i{cycles
        indices =. ((i,j){indices) (j,i)}indices
        echo (r{.indices){pool
        brk=.1
        break.
      end.
    end.
    if. brk=0 do. return. end.
  end.
)

permutations 'abcd'
2 permutations 'abcd'

echo '--'
echo (i.!4) A. 'abcd' NB. it's better to use the built-in

NB. with permutations without echo:
NB.   6!:2 'permutations 1 2 3 4 5 6 7 8 9'
NB. 4.84
NB.   pp=: 3 : 'for_i. i. !y do. z=.i A. 1 2 3 4 5 6 7 8 9 end.'
NB.   6!:2 'pp 9'
NB. 0.595
