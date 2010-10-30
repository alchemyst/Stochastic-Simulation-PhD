.headers 1
.mode column
select days, words, words/days from (select max(julianday(d)) - min(julianday(d)) as days, max(w) - min(w) as words from (select * from maxperday order by d desc limit 2));