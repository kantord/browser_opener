places.txt: luakit_places.txt firefox_places.txt chrome_places.txt
	cat chrome_places.txt luakit_places.txt firefox_places.txt > places.txt

~/.config/chromium/Default/History:
	chromium

chrome_places.txt: ~/.config/chromium/Default/History
	cp ~/.config/chromium/Default/History /tmp/chrome_history
	sqlite3 /tmp/chrome_history "select 'chrome',title,url from (select * from (select title,url from urls order by visit_count desc limit 100) union select * from (select title,url from urls order by last_visit_time desc)) where title != \"\"" > chrome_places.txt
	rm /tmp/chrome_history

~/.mozilla/firefox/*.default/places.sqlite:
	firefox

firefox_places.txt: ~/.mozilla/firefox/*.default/places.sqlite
	sqlite3 ~/.mozilla/firefox/*.default/places.sqlite "select 'firefox',title,url from (select * from (select title,url from moz_places order by visit_count desc limit 100) union select * from (select title,url from moz_places order by last_visit_date desc))" > firefox_places.txt

~/.local/share/luakit/history.db:
	luakit

luakit_places.txt: ~/.local/share/luakit/history.db
	sqlite3 ~/.local/share/luakit/history.db "select 'luakit',title,uri from (select * from (select title,uri from history order by visits desc limit 100) union select * from (select title,uri from history order by last_visit desc limit 100)) group by uri" > luakit_places.txt
