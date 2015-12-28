NB. based on https://docs.python.org/3/library/itertools.html

ncx=: 4 : 0 NB. next combination index; x - n; y - prev indices
  if. 0=$$y do. i.y return. end.
  for_i. i.-r=.#y do.
    if. (i+x-r)~:i{y do.
      y=.(>:i{y)i}y NB. y[i]+=1; for j in range(i+1, r): y[j]=y[j-1]+1
      for_j. (>:i)+i.r->:i do. y=.(>:(<:j){y)j}y end. y return.
    end.
  end.
  0$0
)

NB. Example:

p=: 'ABCDEF'
n=: #p
r=: 4

(3 : 'whilst. 0<#y do. echo (y=.n ncx y){p end.') r

( ([ [ echo@({&p)) @ (n&ncx) )^:(0<#)^:_ r
