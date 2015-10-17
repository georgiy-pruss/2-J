NB. moonsun.ijs 1.0 (C) 2015 Georgiy Pruss, based on:
NB. http://diggr-roguelike.googlecode.com/git/moon.py
NB. moon.py, based on code by John Walker (http://www.fourmilab.ch/)
NB. ported to Python by Kevin Turner <acapnotic@twistedmatrix.com>
NB. on June 6, 2001 (JDN 2452066.52491), under a full moon.

use 'tjd.ijs'

NB. AstronomicalConstants
NB. Angles here are in degrees
epoch =: 2444238.5 NB. 1980 January 0.0 in JDN
ecliptic_longitude_epoch =: 278.833540 NB. Ecliptic longitude of the Sun at epoch 1980.0
ecliptic_longitude_perigee =: 282.596403 NB. Ecliptic longitude of the Sun at perigee
eccentricity =: 0.016718 NB. Eccentricity of Earth's orbit
eccentricity2 =: %:(1+eccentricity)%(1-eccentricity) NB. ~1.01686
sun_smaxis =: 1.49585e8 NB. Semi-major axis of Earth's orbit, in kilometers
sun_angular_size_smaxis =: 0.533128 NB. Sun's angular size, in degrees, at semi-major axis distance
NB. Elements of the Moon's orbit, epoch 1980.0
moon_mean_longitude_epoch =: 64.975464 NB. Moon's mean longitude at the epoch
moon_mean_perigee_epoch =: 349.383063 NB. Mean longitude of the perigee at the epoch
node_mean_longitude_epoch =: 151.950429 NB. Mean longitude of the node at the epoch
moon_inclination =: 5.145396 NB. Inclination of the Moon's orbit
moon_eccentricity =: 0.054900 NB. Eccentricity of the Moon's orbit
moon_angular_size =: 0.5181 NB. Moon's angular size at distance a from Earth
moon_smaxis =: 384401.0 NB. Semi-mojor axis of the Moon's orbit, in kilometers
moon_parallax =: 0.9507 NB. Parallax at a distance a from Earth
synodic_month =: 29.53058868 NB. Synodic month (new Moon to new Moon), in days
lunations_base =: 2423436.0 NB. Base date for E. W. Brown's numbered series of lunations (1923.1.16)

rfd =: 180 %~ o.    NB. Radians from degrees
dfr =: (180%o.1)&*  NB. Degrees from radians
sind =: 1 o. rfd
cosd =: 2 o. rfd

NB. Solve the equation of Kepler
kepler =: 4 : 0 NB. x=m y=ecc epsilon=1e_6
  e =. m =. rfd x
  while. 1 do.
    delta =. (e - y * 1 o. e) - m
    e =. e - delta % (1.0 - y * 2 o. e)
    if. 1e_6 >: |delta do. e return. end.
  end.
)

NB. Calculate phase of moon as a fraction (and other Moon and Sun data).
NB. The argument is the time for which the phase is requested, Julian Day Number.
NB. Returns a list containing the terminator phase angle as a percentage of
NB. a full circle (i.e., 0 to 1), the illuminated fraction of the Moon's disc,
NB. the Moon's age in days and fraction, the distance of the Moon from the
NB. centre of the Earth, and the angular diameter subtended by the Moon as
NB. seen by an observer at the centre of the Earth
phase =: 3 : 0 NB. phase_date
  NB. Calculation of the Sun's position
  day =. y - epoch NB. date within the epoch
  N =. 360|(360%365.2422) * day NB. Mean anomaly of the Sun
  NB. Convert from perigee coordinates to epoch 1980
  M =. 360|N + ecliptic_longitude_epoch - ecliptic_longitude_perigee
  NB. Solve Kepler's equation
  Ec =. M kepler eccentricity
  Ec =. eccentricity2 * 3 o. -:Ec
  NB. True anomaly
  Ec =. 2*dfr _3 o. Ec
  NB. Suns's geometric ecliptic longuitude
  lambda_sun =. 360|Ec + ecliptic_longitude_perigee
  NB. Orbital distance factor
  F =. (1 + eccentricity * cosd Ec) % (1 - *:eccentricity)
  NB. Distance to Sun in km
  sun_dist =. sun_smaxis % F
  sun_angular_diameter =. F * sun_angular_size_smaxis

  NB. Calculation of the Moon's position
  NB. Moon's mean longitude
  moon_longitude =. 360|(13.1763966 * day) + moon_mean_longitude_epoch
  NB. Moon's mean anomaly
  MM =. 360|moon_longitude - (0.1114041 * day) + moon_mean_perigee_epoch
  NB. Moon's ascending node mean longitude
  NB. MN =. fixangle(c.node_mean_longitude_epoch - 0.0529539 * day)
  evection =. 1.2739 * sind (2*(moon_longitude - lambda_sun)) - MM
  annual_eq =. 0.1858 * sinM =. sind M NB. Annual equation
  A3 =. 0.37 * sinM NB. Correction term
  MmP =. MM + evection - annual_eq + A3
  mEc =. 6.2886 * sind MmP NB. Correction for the equation of the centre
  A4 =. 0.214 * sind 2*MmP NB. Another correction term
  lP =. moon_longitude + evection + mEc - annual_eq - A4 NB. Corrected longitude
  variation =. 0.6583 * sind 2*(lP - lambda_sun)
  lPP =. lP + variation NB. True longitude

  NB. Calculation of the Moon's inclination
  NB. -- unused for phase calculation.
  NB. NP =. MN - 0.16 * sin(torad(M)) NB. Corrected longitude of the node
  NB. y =. sin(torad(lPP - NP)) * cos(torad(c.moon_inclination)) NB. Y inclination coordinate
  NB. x =. cos(torad(lPP - NP)) NB. X inclination coordinate
  NB. lambda_moon =. todeg(atan2(y,x)) + NP NB. Ecliptic longitude (unused?)
  NB. Ecliptic latitude (unused?)
  NB. BetaM =. todeg(asin(sin(torad(lPP - NP)) * sin(torad(c.moon_inclination))))

  NB. Calculation of the phase of the Moon
  moon_age =. lPP - lambda_sun NB. Age of the Moon, in degrees
  moon_phase =. (1 - cosd moon_age) % 2.0 NB. Phase of the Moon
  NB. Calculate distance of Moon from the centre of the Earth
  moon_dist =. (moon_smaxis*(1-*:moon_eccentricity))%(1+moon_eccentricity*cosd MmP+mEc)
  NB. Calculate Moon's angular diameter
  moon_diam_frac =. moon_dist % moon_smaxis
  moon_angular_diameter =. moon_angular_size % moon_diam_frac
  NB. Calculate Moon's parallax (unused?)
  NB. moon_parallax =. moon_parallax % moon_diam_frac

  r =. moon_phase, m, synodic_month*m=.(360|moon_age)%360
  r, moon_dist, moon_angular_diameter, sun_dist, sun_angular_diameter
)

3 : 0 ARGV_j_
  if. 2>#y do. return. end.
  if. 0='moonsun.ijs'-:_11{.>1{y do. return. end.
  if. 2<#y do.
    if. 9=#y do.
      a =. (".@:>)"0 [2}.y NB. conv to int args 2 3 4  5 6 7  8
      j =. (z=.{:a) jd4dnf dnf4ymdhms }:a
    else.
      echo 'optional args: yyyy mm dd HH MM SS TZ'
      exit 1
    end.
  else.
    j =. (z=.3) jd4dnf dnf_now'' NB. tz=3 for Kiev, EEST and 2 for EET
  end.
  p =. phase j
  echo 'date/time  ',z s4jd j
  echo 'julian day number ', 0j4 ": j
  echo 'unix time         ', 0j1 ": unix4jd j
  echo 'moon phase        ', 0j10": 1{p
  echo 'moon age          ', ((10>2{p){0j9 0j10)":2{p
  echo 'illuminated       ', 0j10": 0{p
  echo 'distance          ', 0j5 ": 3{p
  echo 'angular diameter  ', 0j10": 4{p
  echo 'sun distance      ', 0j2 ": 5{p
  echo 'sun ang. diameter ', 0j10": 6{p
  exit 0
)

