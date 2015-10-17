use 'tjd moonphase moonsun'

z =. 3
d =. dnf_now ''
j =. z jd4dnf d
echo 'Date/time  ',z s4jd j
echo ''
echo 'Julian day number ', 0j4 ": j
echo 'Unix time         ', 0j1 ": ut4jd j
p =. phase j
echo 'Moon phase        ', 0j10": 1{p
echo 'Moon age          ', ((10>2{p){0j9 0j10)":2{p
echo 'Illuminated       ', (0j8": 100*0{p),'%'
echo 'Distance          ', 0j5 ": 3{p
echo 'Angular diameter  ', 0j10": 4{p
echo 'Sun distance      ', 0j2 ": 5{p
echo 'Sun ang. diameter ', 0j10": 6{p
echo ''
t =. 5&}."1 s4dnf"0 z&dnf4jd"0 phase_hunt j
echo 'Last New Moon   ', 0{t
echo 'First Quater    ', 1{t
echo 'Full Moon       ', 2{t
echo 'Third Quater    ', 3{t
echo 'Next New Moon   ', 4{t

exit 0

