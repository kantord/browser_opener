places.txt: luakit_places.txt firefox_places.txt
	cat luakit_places.txt firefox_places.txt > places.txt

firefox_places.txt: ~/.mozilla/firefox/w70pzgxt.default/places.sqlite
	sqlite3 ~/.mozilla/firefox/w70pzgxt.default/places.sqlite "select 'firefox',title,url from (select * from (select title,url from moz_places order by visit_count desc limit 100) union select * from (select title,url from moz_places order by last_visit_date desc))" > firefox_places.txt

luakit_places.txt: ~/.local/share/luakit/history.db
	sqlite3 ~/.local/share/luakit/history.db "select 'luakit',title,uri from (select * from (select title,uri from history order by visits desc limit 100) union select * from (select title,uri from history order by last_visit desc limit 100)) group by uri" > luakit_places.txt
