﻿-- 02-a-0100
Направете копие на файла /etc/passwd във вашата home директория под името my_passwd.
	cp /etc/passwd ~/my_passwd

-- 02-a-0500
Направете директория practice-test в home директорията ви. Вътре направете директория test1. Можете ли да направите тези две неща наведнъж? Разгледайте нужната man страница. След това създайте празен файл вътре, който да се казва test.txt, преместете го в practice-test чрез релативни пътища.
	mkdir -p ~/practice-test/test1
	touch ~/practice-test/test1 test.txt
	cd ~/practice-test/test1
	mv test.txt ..

-- 02-a-0600
Копирайте файловете f1, f2, f3 от директорията /tmp/os2018/practice/01/ в директория dir1, намираща се във вашата home директория. Ако нямате такава, създайте я.
	mkdir ~/dir1
	cp f1 f2 f3 ~/dir1

-- 02-a-0601
Нека файлът f2 бъде преместен в директория dir2, намираща се във вашата home директория и бъде преименуван на numbers.
	mkdir ~/dir2
	mv ~/dir1/f2 ~/dir2/numbers

-- 02-a-1200
Отпечатайте имената на всички директории в директорията /home.
	find /home -type d

-- 02-a-2100
Създайте symlink на файла /etc/passwd в home директорията ви (да се казва например passwd_symlink).
	ln -s /etc/passwd ~/passwd_symlink

-- 02-a-4000
Създайте файл permissions.txt в home директорията си. За него дайте единствено - read права на потребителя създал файла, write and exec на групата, read and exec на всички останали. Направете го и с битове, и чрез "буквички".
	touch ~/permissions.txt
	chmod u=r,g=wx,o=rx ~/permissions.txt	|| chmod 0435 ~/permissions.txt

-- 02-a-4100
За да намерите какво сте правили днес: намерете всички файлове в home директорията ви, които са променени от вас в последния 1 час.
	find ~/ -mmin -60 		//или там все едно кое е amin, cmin

-- 02-a-5000
Копирайте secret.txt от /tmp/os2018/02/ в home директорията си. Прочетете го с командата cat.
	(сигурно проблемът е, че файла няма read права, и затова трябва със sudo да ги добавим, ако можем)
	sudo chmod u+r /tmp/os2018/02/secret.txt
	//asks for your password
	cp /tmp/os2018/02/secret.txt ~
	cat secret.txt

-- 02-a-5400
Изведете всички обикновени ("regular") файлове, които /etc и нейните преки поддиректории съдържат
	find /etc -maxdepth 2 -type f

-- 02-a-5401
Създайте файл, който да съдържа само първите 5 реда от изхода на 02-a-5400
	find /etc -maxdepth 2 -type f | head -n 5 > ~/output5401.txt

-- 02-a-5402
Изведете всички обикновени ("regular") файлове, които само преките поддиректории на /etc съдържат
	find /etc -mindepth 2 -maxdepth 2 -type f

-- 02-a-5403
Изведете всички преки поддиректории на /etc
	find /etc -mindepth 1 -maxdepth 1 -type d

-- 02-a-5500
Създайте файл, който да съдържа само последните 10 реда от изхода на 02-a-5403
	find /etc -mindepth 1 -maxdepth 1 -type d | tail -n 10 > ~/output5500.txt

-- 02-a-5501
Изведете обикновените файлове по-големи от 42 байта в home директорията ви
	find ~ -type f -size +42c

-- 02-a-5503
Изведете всички обикновени файлове в директорията SI които са от групата students
	find /SI -type f -group students

-- 02-a-5504
Изведете всички обикновени файлове в директорията SI които са от групата students, които имат write права за достъп за група или за останалите(o=w) // ако в свободното си време искате да пишете по файлове на други хора
	find /home/SI -group 504 \( -perm -g=w \) -or \( -perm -o=w \)		//няма такава група students, затова напр 504 е групата на студенти от СИ
	//
	find /home/SI -group 504 -perm /g=w,o=w

-- 02-a-5505
Изведете всички файлове, които са по-нови от създадения файл в 02-a-5401
	find . -type f -newer ~/output5401.txt		|| ili e  -anewer, -cnewer
	
-- 02-a-5506
Изтрийте файловете по-нови от създаденият в 02-a-5401 файл
	find . -type f -newer ~/output5401.txt -delete

-- 02-a-6000
Намерете файловете в /bin, които могат да се четат, пишат и изпълняват от всички.
	find /bin -perm a=rwx		|| find /bin -perm 777

-- 02-a-8000
Копирайте всички файлове от /bin, които могат да се четат, пишат и изпълняват от всички, в bin2 директория в home директорията ви. Направете такава, ако нямате.
	mkdir ~/bin2
	find /bin -perm a=rwx -exec cp '{}' ~/bin2 \;

-- 02-a-9000
от предната задача: когато вече сте получили home/../../bin2 с команди, архивирайте всички команди вътре, които започват с b в архив, който се казва b_start.tar. (командата, която архивира е tar -c -f <файл1> <файл2>...)
Можете ли да направите архив на всеки?

	find ~/bin2 -name 'b*' -exec tar -c -f b_start.tar '{}' \;		//архив, който съдържа всички, които започват с b

	find ~/bin2 -name 'b*' -exec tar -c -f '{}.tar' '{}' \;			//прави отделен архив на всеки, който започва с b

-- 02-a-9500
Използвайки едно извикване на командата find, отпечатайте броя на редовете във всеки обикновен файл в /home директорията.
	find /home -type f -exec wc -l '{}' \;
	
-- 02-b-4000
Копирайте най-големия файл от тези, намиращи се в /tmp/os2018/02/bytes/, в home директорията си.
	find ./some_dir -type f - exec du -a '{}' \; | sort -n -r | head -n 1 | cut -f 2 | xargs -I'{}' cp '{}' ~


