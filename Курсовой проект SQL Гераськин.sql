
/*
�������� ������ ������������ ����� ���������� ������ ��������� �� ������� ����������,
���������� � ���� ���������� � �������, ������������� ��������� � ��������� �������������.
*/


DROP DATABASE IF EXISTS kinopoisk_s;

CREATE DATABASE kinopoisk_s;

USE kinopoisk_s;

-- ������� ������������� �����

DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id serial PRIMARY KEY,
	firstname varchar(50) NULL,
	lastname varchar(50) NULL,
	nickname varchar(50) NULL,
	email varchar(50) null
);

-- ������� ������� ������������� �����

DROP TABLE IF EXISTS user_profiles;

CREATE TABLE user_profiles (
	user_id bigint UNSIGNED NOT NULL UNIQUE,
	FOREIGN KEY (user_id) REFERENCES users(id),
	photo_id bigint UNSIGNED NULL,
	registration_data datetime DEFAULT current_timestamp NULL,
	birthday date NULL,
	gender enum('m','f','x') DEFAULT 'x',
	about varchar(250) NULL
);

-- ������� �������

DROP TABLE IF EXISTS kino_units;

CREATE TABLE kino_units (
	id SERIAL PRIMARY KEY,
	name varchar(50) NULL
);

-- ������� "� ������"

DROP TABLE IF EXISTS about_films;

CREATE TABLE about_films (
	film_id bigint UNSIGNED NOT NULL UNIQUE,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	photo_id bigint UNSIGNED NULL,
	original_name varchar(50) NULL,
	made_data YEAR NULL,
	country varchar(100) NULL,
	slogan varchar(150) NULL,
	screenwriters varchar(100) NULL,
	producers varchar(100) NULL,
	operators varchar(100) NULL,
	composers varchar(100) NULL,
	production_designers varchar(100) NULL,
	montage varchar(100) NULL,
	budget bigint UNSIGNED NULL,
	money_country bigint UNSIGNED NULL,
	money_world bigint UNSIGNED NULL,
	premiere_russia date NULL,
	premiere_world date NULL,
	age_restriction int NULL,
	lenght time
);

-- ������� ������ �������

DROP TABLE IF EXISTS unit_rates;

CREATE TABLE unit_rates (
	film_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	user_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	rating TINYINT null	
);

-- ������� �������

DROP TABLE IF EXISTS actors;

CREATE TABLE actors (
	id SERIAL PRIMARY KEY,
	firstname varchar(50) NULL,
	lastname varchar(50) NULL
);

-- ������� ������� �������

DROP TABLE IF EXISTS actor_profiles;

CREATE TABLE actor_profiles (
	actor_id bigint UNSIGNED NOT NULL UNIQUE,
	FOREIGN KEY (actor_id) REFERENCES actors(id),
	photo_id bigint UNSIGNED NULL,
	career varchar(150) NOT NULL,
	height double UNSIGNED NULL,
	birthday date NULL,
	birth_city varchar(50) NULL,
	genres varchar(50) NOT NULL,
	films_count int UNSIGNED NULL,
	gender enum('m','f')
);

-- ������� "� ������� �����"

DROP TABLE IF EXISTS starring;

CREATE TABLE starring (
	film_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	actor_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (actor_id) REFERENCES actors(id)
);

-- ������� ����������

DROP TABLE IF EXISTS directors;

CREATE TABLE directors (
	id SERIAL PRIMARY KEY,
	firstname varchar(50) NULL,
	lastname varchar(50) null
);

-- ������� ������� ����������

DROP TABLE IF EXISTS director_profiles;

CREATE TABLE director_profiles (
	director_id bigint UNSIGNED NOT NULL UNIQUE,
	FOREIGN KEY (director_id) REFERENCES directors(id),
	photo_id bigint UNSIGNED NULL,
	career varchar(150) NOT NULL,
	height double UNSIGNED NULL,
	genres varchar(50) NOT NULL,
	family_partner varchar(50) NULL,
	films_count int UNSIGNED NULL,
	gender enum('m','f')
);

-- ������� ���������� �������

DROP TABLE IF EXISTS director_films;

CREATE TABLE director_films (
	film_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	director_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (director_id) REFERENCES directors(id)
);

-- ������� ������ ������� � ��������

DROP TABLE IF EXISTS genres;

CREATE TABLE genres (
	film_id bigint UNSIGNED NOT NULL UNIQUE,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	comedy BIT DEFAULT 0 NULL COMMENT '�������',
	cartoon BIT DEFAULT 0 NULL COMMENT '����������',
	horror BIT DEFAULT 0 NULL COMMENT '�����',
	fantastic BIT DEFAULT 0 NULL COMMENT '����������',
	triller BIT DEFAULT 0 NULL COMMENT '�������',
	action_movie BIT DEFAULT 0 NULL COMMENT '������',
	melodrama BIT DEFAULT 0 NULL COMMENT '���������',
	detective BIT DEFAULT 0 NULL COMMENT '��������',
	adventures BIT DEFAULT 0 NULL COMMENT '�����������',
	fantasy BIT DEFAULT 0 NULL COMMENT '�������',
	war_film BIT DEFAULT 0 NULL COMMENT '�������',
	anime BIT DEFAULT 0 NULL COMMENT '�����',
	history BIT DEFAULT 0 NULL COMMENT '������������',
	family BIT DEFAULT 0 NULL COMMENT '��������',
	drama BIT DEFAULT 0 NULL COMMENT '�����',
	documental BIT DEFAULT 0 NULL COMMENT '��������������',
	children BIT DEFAULT 0 NULL COMMENT '�������',
	criminal BIT DEFAULT 0 NULL COMMENT '��������',
	biography BIT DEFAULT 0 NULL COMMENT '���������',
	western BIT DEFAULT 0 NULL COMMENT '�������',
	noir BIT DEFAULT 0 NULL COMMENT '����',
	sport BIT DEFAULT 0 NULL COMMENT '����������',
	short BIT DEFAULT 0 NULL COMMENT '����������������',
	music BIT DEFAULT 0 NULL COMMENT '�����������'
);

-- ������� ������ �������

DROP TABLE IF EXISTS awards;

CREATE TABLE awards (
	film_id bigint UNSIGNED NOT NULL UNIQUE,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	oscar BIT DEFAULT 0 NOT NULL COMMENT '�����',
	gg BIT DEFAULT 0 NOT NULL COMMENT '������� ������',
	ba BIT DEFAULT 0 NOT NULL COMMENT '���������� ��������',
	ce BIT DEFAULT 0 NOT NULL COMMENT '�����',
	sag BIT DEFAULT 0 NOT NULL COMMENT '������ ������� �������',
	nika BIT DEFAULT 0 NOT NULL COMMENT '����',
	zo BIT DEFAULT 0 NOT NULL COMMENT '������� ����',
	sat BIT DEFAULT 0 NOT NULL COMMENT '������',
	goja BIT DEFAULT 0 NOT NULL COMMENT '����',
	emmy BIT DEFAULT 0 NOT NULL COMMENT '����',
	afa BIT DEFAULT 0 NOT NULL COMMENT '��������� ������������',
	efa BIT DEFAULT 0 NOT NULL COMMENT '����������� ������������',
	mtv BIT DEFAULT 0 NOT NULL COMMENT 'MTV',
	mtv_r BIT DEFAULT 0 NOT NULL COMMENT 'MTV ������',
	g_ma BIT DEFAULT 0 NOT NULL COMMENT '������� ������',
	zhorzh BIT DEFAULT 0 NOT NULL COMMENT '����'
);


-- ���������� ������

INSERT INTO users VALUES
	(1, 'Kendra', 'Lewis', 'Lewis23', 'Kendra_Lewis1604@elnee.tech'),
	(2, 'Caitlyn', 'Grant',	'Grant', 'Caitlyn_Grant8558@naiker.biz'),
	(3, 'Leanne', 'Murray',	'Murray', 'Leanne_Murray97@corti.com'),
	(4, 'Gloria', 'Ellis', 'Ellis',	'Gloria_Ellis3428@bauros.biz'),
	(5, 'Bernadette', 'Hale', 'Hale', 'Bernadette_Hale5011@famism.biz'),
	(6, 'Fred',	'Whatson', 'Whatson', 'Fred_Whatson9610@brety.org'),
	(7, 'Beatrice', 'Hunter', 'Hunter',	'Beatrice_Hunter9389@tonsy.org'),
	(8, 'Mayleen', 'Pope', 'Pope', 'Mayleen_Pope5486@joiniaa.com'),
	(9, 'Julian', 'Logan', 'Logan',	'Julian_Logan7280@deons.tech'),
	(10, 'Luke', 'Anderson', 'Anderson', 'Luke_Anderson7005@eirey.tech');

INSERT INTO user_profiles VALUES
	(1, 1, DEFAULT,	'1960-8-20',	'f', 'Mauris id fringilla tortor. Sed tristique scelerisque est sit amet porttitor. Nunc.'),
	(2,	2, DEFAULT, '1964-8-20', 'f', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '),
	(3,	3, DEFAULT,	'1990-3-5', 'm', 'Ut at gravida risus. Nunc ut est suscipit, varius ipsum at'),
	(4,	4, DEFAULT,	'1960-7-30', 'f', 'Phasellus vehicula lacinia laoreet. Nunc velit lorem, ultrices eu est ac,'),
	(5,	5, DEFAULT,	'1978-12-6', 'm', 'Pellentesque finibus nec elit in varius'),
	(6,	6, DEFAULT,	'1945-5-3', 'f', 'Praesent vel consequat lacus, non fermentum lorem.'),
	(7,	7, DEFAULT,	'2000-5-6', 'f', ' Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. '),
	(8,	8, DEFAULT,	'1997-8-14', 'f', 'Etiam faucibus orci et dui pulvinar pretium. Praesent volutpat erat nisl,'),
	(9,	9, DEFAULT,	'1989-12-29', DEFAULT, 'Proin sagittis nec sem id vulputate.'),
	(10, 10, DEFAULT, '1995-8-22', 'm', 'Mauris et dolor dolor. Ut mattis bibendum nisl, sit amet sodales ligula.');

INSERT INTO kino_units VALUES
	(1,'������� ����'),
	(2,'����� �� ��������'),
	(3,'������ ��������'),
	(4,'��������� �����: ����������� ������'),
	(5,'������� ����'),
	(6,'��������� �����: ��� ��������'),
	(7,'��������� �����: �������� ������'),
	(8,'1 + 1'),
	(9,'������������ �����'),
	(10,'���� ���������� ������ ���������');

INSERT INTO about_films VALUES
	(1, 1, 'The Green Mile', '1999','���', '���� ������� �� ����� � ������. ���� �� ���������� � ����� �� ����', '����� ��������, ������ ����',
	'����� ��������, ����� ������', '����� ����������', '����� ������', '������ ����, ������ ����', '������ �������-����', 60000000, 136801374,
	150000000, '2000-04-16', '1999-12-06', 16, '03:09:00'),
	(2, 2, 'The Shawshank Redemption', '1994', '���', '������ - ��� �������. ������� - ��� �������', 'Chadwick Lee', 'Chadwick Lee', 'Chadwick Lee',
	'Chadwick Lee',	'Chadwick Lee', 'Chadwick Lee',	25000000, 28341469,	77218, '2019-09-10', '1994-04-05', 16, '02:22:00'),
	(3, 3, 'Schindlers List', 1993,	'���', '����� ������ - ������',	'Boris Willson', 'Boris Willson', 'Boris Willson', 'Boris Willson', 'Boris Willson', 'Boris Willson',
	35000000, 154000000, 4500000, '1994-03-02', '1999-05-01', 16, '01:56:00'),
	(4, 4, 'The Lord of the Rings: The Return of the King', 2003, '����� ��������',	'�There can be no triumph without loss. No victory without suffering. No freedom without sacrifice�',
	'Boris Huggins', 'Boris Huggins', 'Gind Errinf', 'Boris Huggins', 'Boris Huggins', 'Boris Huggins',	200000000, 54000000, 400000, '2003-11-02', '2003-12-01', 16, '02:34:00'),
	(5, 5, 'Forrest Gump', '1994', '���', '���� ��� ������� �� ����� �������, ����� ���� ��� �� ������� ��� ������� �������� �����',
	'Shay Grady', 'Shay Grady', 'Shay Grady', 'Shay Grady', 'Shay Grady', 'Shay Grady', 1000000, 23000000, 32000000, '1995-04-11', '1994-09-10', 16, '01:30:20'),
	(6, 6, 'The Lord of the Rings: The Two Towers',	'2002', '����� ��������',	'������������ �������������', 'Melania Funnell', 'Melania Funnell', 'Melania Funnell', 'Melania Funnell', 'Melania Funnell', 'Melania Funnell',
	45000000, 100000000, 1200000, '2002-11-01', '2002-12-03', 16, '2:30:45'),
	(7, 7, 'The Lord of the Rings: The Fellowship of the Ring', '2001', '����� ��������',	'�Power can be held in the smallest of things...�',	'Ramon Reyes', 'Ramon Reyes', 'Ramon Reyes', 'Ramon Reyes', 'Ramon Reyes', 'Ramon Reyes',
	98000345, 235000000, 6500000, '2001-11-17', '2001-12-03', 16, '2:32:45'),
	(8, 8, 'Intouchables', '2011', '�������', '�Sometimes you have to reach into someone elses world to find out whats missing in your own�', 'Vicky Stone', 'Vicky Stone', 'Vicky Stone', 'Vicky Stone', 'Vicky Stone', 'Vicky Stone',
	6000000, 27000000, 1200000, '2011-11-09', '2011-12-04', 16, '1:32:40'),
	(9, 9, 'Pulp Fiction', '1994', '���', '�Just because you are a character doesnt mean you have character�', 'Mackenzie Greenwood',	'Mackenzie Greenwood',	'Mackenzie Greenwood',	'Mackenzie Greenwood',	'Mackenzie Greenwood',	'Mackenzie Greenwood',
	8000000, 107928000, 200000,	'2011-11-09', '2011-12-04', 16, '1:32:40'),
	(10, 10, '���� ���������� ������ ���������', '1973', '����', '-', '������� ������', '������� �������', '��������� �������', '����� �������', '������� ������', '������� ���������',
	NULL, NULL, NULL, '1973-03-17', NULL, 16, '01:28:00');

INSERT INTO unit_rates VALUES
	(1, 2, 9),
	(1, 7, 7),
	(2, 4, 6),
	(2, 1, 10),
	(3, 5, 6),
	(3, 8, 9),
	(1, 8, 7),
	(5, 2, 6),
	(6, 10, 9),
	(10, 7, 7);
	
INSERT INTO actors VALUES
	(1, '���', '�����'),
	(2, '���', '�������'),
	(3, '������', '������'),
	(4, '����', '�����'),
	(5, '�������', '���'),
	(6, '���', '��������'),
	(7, '�������', '�����'),
	(8, '����', '��������'),
	(9, '������', '�. �������'),
	(10, '���������', '����������');
	
INSERT INTO actor_profiles VALUES
	(1, 11, '�����, ��������, ��������, ���������', 1.83, '1956-07-09', '�������, ���', '�������, �����, ��������������', 399, 'm'),
	(2, 12, '�����, ��������, ��������, ���������', 1.96, '1958-10-16', '����-������, ���', '�����, �������, ���������', 213, 'm'),
	(3, 13, '�����, ��������, ��������', 1.88, '1937-06-01', '������, ���', '�����, �������, ��������', 358, 'm'),
	(4, 14, '�����, ��������', 1.92, '1952-07-07', '��������, �������� ��������', '�����, �������, ������', 303, 'm'),
	(5, 15, '�����, ��������, ��������', 1.65, '1981-01-28', '�����-������, ���', '�������, �����, �����������', 271, 'm'),
	(6, 16, '�����, ��������, ���������', 1.83, '1939-05-25', '������, ������', '�������, �����, ���������������', 295, 'm'),
	(7, 17, '�����, ��������', 1.74, '1955-09-21', '�����, �������', '�������, �����, ���������', 131, 'm'),
	(8, 18, '�����, ��������, ���������', 1.88, '1954-02-18', '���-������, ���', '�������, �����, ��������', 295, 'm'),
	(9, 19, '�����, ��������', 1.88, '1948-12-21', '���������, ���', '�����, ������, �������', 427, 'm'),
	(10, 20, '�����, ����� �������', 1.69, '1937-05-30', '����������, ����', '�������, �����, ���������', 310, 'm');

INSERT INTO starring VALUES
	(1, 1),
	(2, 2),
	(2, 3),
	(3, 4),
	(4, 5),
	(4, 6),
	(5, 1),
	(6, 5),
	(6, 6),
	(7, 5),
	(7, 6),
	(8, 7),
	(9, 8),
	(9, 9),
	(10, 10);

INSERT INTO directors VALUES
	(1, '�����', '��������'),
	(2, '������', '��������'),
	(3, '�����', '�������'),
	(4, '������', '�������'),
	(5, '������', '�����'),
	(6, '�������', '���������'),
	(7, '������', '������');

INSERT INTO director_profiles VALUES
	(1, 21, '���������, �����, ��������, ��������', 1.83, '�����, �������, �����', '����� ������', 60, 'm'),
	(2, 22, '��������, ��������, �����, ���������, ��������, ��������, ����������', 1.72, '�����������, �����, �������', '��� ������', 482, 'm'),
	(3, 23, '��������, ��������, �����, ���������, ��������, ��������, ��������', 1.65, '���������������, ��������������, �������', '���� �������', 164, 'm'),
	(4, 24, '��������, ��������, ���������, �����', 1.83, '�������, �����, �������', '����� �������', 130, 'm'),
	(5, 25, '���������, ��������, ��������, �����', DEFAULT, '�������, �����, ���������������', DEFAULT, 33, 'm'),
	(6, 26, '�����, ���������, ��������, ��������, ��������, ��������', 1.85, '�����, �������, ��������', '�������� ���', 234, 'm'),
	(7, 27, '��������, ���������, �����', 1.83, '�������, ��������, �����������', '���� ����������', 32, 'm');
	
INSERT INTO director_films VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 3),
	(5, 4),
	(6, 3),
	(7, 3),
	(8, 5),
	(9, 6),
	(10, 7);

INSERT INTO genres VALUES
	(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0),
	(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0),
	(4, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(6, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(7, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	(8, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0),
	(9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0),
	(10, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

INSERT INTO awards VALUES
(1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0),
(5, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0),
(7, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0),
(8, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1),
(9, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0),
(10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);


-- �������������

-- ��� 5 ������� �� �������

DROP VIEW IF EXISTS top5_films_bidget;

CREATE VIEW top5_films_bidget AS
	SELECT ku.name, af.budget
	FROM kino_units AS ku
	JOIN about_films AS af
	WHERE ku.id = af.film_id
	ORDER BY af.budget DESC
	LIMIT 5;

SELECT * FROM top5_films_bidget;

-- ��� ���������� � ������

DROP VIEW IF EXISTS film_info;

CREATE VIEW film_info AS
	SELECT ku.name, af.*
	FROM kino_units AS ku
	RIGHT JOIN about_films AS af
	ON ku.id = af.film_id;

SELECT * FROM film_info;

-- ��������� � �� ������

DROP VIEW IF EXISTS directors_and_films;

CREATE VIEW directors_and_films AS
	SELECT d.firstname, d.lastname, ku.name
	FROM directors AS d
	JOIN director_films AS df
	JOIN kino_units AS ku
	ON ku.id = df.film_id AND d.id = df.director_id AND d.id = df.director_id;

SELECT * FROM directors_and_films;

-- ������ � ������� ��� ������� ��������

DROP VIEW IF EXISTS films_with_awards;

CREATE VIEW films_with_awards AS
	SELECT ku.name, aw.oscar, aw.gg
	FROM kino_units AS ku
	JOIN awards AS aw
	WHERE ku.id = aw.film_id AND (oscar = 1 OR gg = 1);

SELECT * FROM films_with_awards;


-- �������� ���������


-- ������, ��������� � ������������ ������

DROP PROCEDURE IF EXISTS film_actors;

CREATE PROCEDURE film_actors(film_id bigint unsigned)
BEGIN
	SELECT ac.firstname, ac.lastname
	FROM actors AS ac
	JOIN starring AS st
	JOIN kino_units AS ku
	ON ku.id = st.film_id AND ac.id = st.actor_id AND ku.id = film_id;
END;


CALL film_actors(2);


-- ���������� ������ �������, ������� ��������� ������������ 30 ��� � ������

DROP PROCEDURE IF EXISTS users_30;

CREATE PROCEDURE users_30()
BEGIN
	SELECT user_id, count(*) AS amount
	FROM unit_rates
	WHERE user_id IN (SELECT user_id FROM user_profiles WHERE timestampdiff(YEAR, birthday, now()) <= 30) GROUP BY user_id;
END;

CALL users_30();


-- ������, � ������� ������ ������������ �����

DROP PROCEDURE IF EXISTS actor_career;

CREATE PROCEDURE actor_career(actor_id bigint UNSIGNED)
BEGIN
	SELECT ku.name
	FROM kino_units AS ku
	JOIN starring AS st
	JOIN actors AS ac
	ON ku.id = st.film_id AND ac.id = st.actor_id AND ac.id = actor_id;
END;


CALL actor_career(5);

-- ������ �������������, ������� ������� ������ ���� �� ���� ���

DROP PROCEDURE IF EXISTS nickname_rates_once;

CREATE PROCEDURE nickname_rates_once()
BEGIN
	SELECT DISTINCT nickname
	FROM users AS u
	JOIN unit_rates AS ur 
	ON u.id = ur.user_id;
END;

CALL nickname_rates_once();



-- �������� �������


-- ������� ������ ��� ������, ������ �� ������ �������������


DROP FUNCTION IF EXISTS art;

CREATE FUNCTION art(n int) RETURNS decimal(7,4) DETERMINISTIC
BEGIN
	DECLARE z decimal(7,4);
	SELECT avg(rating) FROM unit_rates WHERE film_id = n INTO z;
	RETURN z;
END;

SELECT art (3);


-- ��������

-- ������� �� ���� �������� ������������

DROP TRIGGER IF EXISTS date_b;

CREATE TRIGGER date_b BEFORE UPDATE ON user_profiles FOR EACH ROW
BEGIN
	IF NEW.birthday >= CURRENT_DATE()
	THEN SIGNAL SQLSTATE '45000' SET message_text = '������. �������� ����';
	END IF;
END;

