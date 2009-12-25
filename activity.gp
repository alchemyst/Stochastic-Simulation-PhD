# colours are background, border, axis, then plotting colors
set terminal png transparent medium size 481,173 xffffff xd0d0d0 xaaaaaa xffff00
#set terminal png  medium size 481,173 x000000 xd0d0d0 xaaaaaa xffff00
set output 'activity.png'
set style data lines
set style line 1 lw 3
set ylabel 'Words'
set xdata time
set format x '%m/%d'
set grid
set timefmt '%Y-%m-%d'

# fit trendline
f(x) = a*(x-b)
a = 0.0005
b = 2.7e8+8e5

fit f(x) 'activity.dat' using 1:2 via a

plot 'activity.dat' using 1:2 notitle, f(x) title sprintf("%.1f words per day", a*24*3600)

