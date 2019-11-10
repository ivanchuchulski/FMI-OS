﻿-- SI-2017-z1
Задача 1:
Напишете серия от команди, извеждащи на екрана само броя на всички обекти във файловата
система, чиито собственик е текущият потребител.

Забележка: Във файловата система със сигурност съществуват директории, до които нямате достъп.

	find / -user $(whoami) 2>/dev/null | wc -l

Примерен изход:
260415

-- SI-2017-z2
Задача 2:
Намерете имената на топ 5 файлове в текущата директория с най-много hardlinks.
Примерен изход:
a1.txt
a2.txt
a3.txt
b1.txt
b2.txt

	find . -maxdepth 1 -type f -printf "%n %f\n" | sort -r -n -t ' ' -k 1 | cut -d ' ' -f 2 | head -n 5

-- SI-2017-z3
Задача 3:
Напишете серия от команди, които от файла /etc/passwd да взимат първите имена на студентите от
специалност СИ, чиито фамилии завършват на "а". Изведете колко пъти се среща най-често срещаното
име и кое е то.
Примерно съдържание на файла:
s61934:x:1177:504:Mariq Cholakova:/home/SI/s61934:/bin/bash
s61916:x:1178:504:Simeon Aleksandrov:/home/SI/s61916:/bin/bash
s61884:x:1179:504:Ruslan Kapelev:/home/SI/s61884:/bin/bash
s61895:x:1180:504:Zorka Shindova:/home/SI/s61895:/bin/bash
s61899:x:1182:504:Zorka Ivanova:/home/SI/s61899:/bin/bash
s81374:x:1117:503:Ivan Kamburov, KN, 2kurs, 7gr:/home/KN/s81374:/bin/bash
s81382:x:1118:503:Teodora Cirkova, KN, 2kurs, 7gr:/home/KN/s81382:/bin/bash
Примерен изход:
2 Zorka

	fgrep 'SI' /etc/passwd | cut -d ':' -f 5 | cut -d ',' -f 1 | egrep '*a$' | cut -d ' ' -f 1 | sort -k 1 | uniq -c | sort -r -n -k 1 | head -n 1


-- SI-2018-z1
Задача 1:
Променете правата на всички директории, намиращи се някъде /във/ вашата home директория,
така че да станат такива, каквито биха се получили, ако ги бяхте създали с маска 0022.
	правата ще са
	  0777
	~ 0022
	  0755
	find ~/ -type d -exec chmod 0755 '{}' \;

-- SI-2018-z2
Задача 2:
Напишете серия от команди, извеждащи на екрана /само/ inode-а на най-скоро променения (по съдържание)
файл, намиращ се в home директорията на потребител pesho (или нейните под-директории), който има
повече от едно име.
	find ~pesho -type f -links +1 -printf "%T@ %i\n" 2>/dev/null | sort -r -n -t ' ' -k 1 | head -n 1 | cut -d ' ' -f 2

-- SI-2018-z3
Задача 3:
При подреждане в нарастващ ред на потребителските идентификатори (UID) на акаунтите,
дефинирани в системата, 201-ят акаунт е от групата, запазена за акаунти от специалност СИ.

Изведете списък с имената (име и фамилия) и home директориите на всички акаунти
от специалност СИ, подреден по ф.н.
За справка:
s61988:x:1219:504:Stoian Genchev,SI,2,5:/home/SI/s61988:/bin/bash
s81430:x:1234:503:Iordan Petkov, KN, k2, g7:/home/KN/s81430:/bin/bash
s61807:x:1248:504:Elica Venchova:/home/SI/s61807:/bin/bash
s62009:x:1254:504:Denitsa Dobreva, 2, 6:/home/SI/s62009:/bin/bash
s61756:x:1258:504:Katrin Kartuleva, SI, 4, 1:/home/SI/s61756:/bin/bash
s855287:x:1195:504:Vaska Kichukova,SI,2,5:/home/SI/s855287:/bin/bash

Примерен изход:
Katrin Kartuleva:/home/SI/s61756
Elica Venchova:/home/SI/s61807
Stoian Genchev:/home/SI/s61988
Denitsa Dobreva:/home/SI/s62009
Vaska Kichukova:/home/SI/s855287

	cat /etc/passwd | sort -n -t ':' -k 3 | tail -n +201 | sort -n -t ':' -k 1 | fgrep 'SI' | awk -F[:,] '{print $5 ":" $(NF-1);}'
	//ако е без условието за 201-я пак работи?
	cat /etc/passwd | sort -n -t ':' -k 1 | fgrep 'SI' | awk -F[:,] '{print $5 ":" $(NF-1);}'

