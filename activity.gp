# colours are background, border, axis, then plotting colors
set terminal png enhanced transparent medium size 481,173 xffffff xd0d0d0 xaaaaaa xffff00
#set terminal png  medium size 481,173 x000000 xd0d0d0 xaaaaaa xffff00
set output 'activity.png'
set style data lines
set style line 1 lw 3
set ylabel 'Words'

set grid
set key outside bottom horizontal reverse Left

set xdata time
set format x '%y-%m'
set timefmt '%Y-%m-%d'
set xrange ["2010-01-01":"2010-11-01"]

# fit trendline
f(x) = a*(x-b)
a = 0.0005
b = 2.7e8+8e5

fit f(x) 'activity.dat' using 1:2 via a

plot 'activity.dat' using 1:2 title "detex words", \
     f(x) title sprintf("%.1f words per day", a*24*3600), \
     18234 title "Carl Masters", \
     41734 title "Ruanne Masters"
