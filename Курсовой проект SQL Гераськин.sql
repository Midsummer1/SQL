
/*
Курсовой проект представляет собой упрощенную версию структуры БД сервиса «Кинопоиск»,
содержащую в себе информацию о фильмах, пользователях платформы и различные представления.
*/


DROP DATABASE IF EXISTS kinopoisk_s;

CREATE DATABASE kinopoisk_s;

USE kinopoisk_s;

-- Таблица пользователей сайта

DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id serial PRIMARY KEY,
	firstname varchar(50) NULL,
	lastname varchar(50) NULL,
	nickname varchar(50) NULL,
	email varchar(50) null
);

-- Таблица профиля пользователей сайта

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

-- Таблица фильмов

DROP TABLE IF EXISTS kino_units;

CREATE TABLE kino_units (
	id SERIAL PRIMARY KEY,
	name varchar(50) NULL
);

-- Таблица "О фильме"

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

-- Таблица оценок фильмов

DROP TABLE IF EXISTS unit_rates;

CREATE TABLE unit_rates (
	film_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	user_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	rating TINYINT null	
);

-- Таблица актеров

DROP TABLE IF EXISTS actors;

CREATE TABLE actors (
	id SERIAL PRIMARY KEY,
	firstname varchar(50) NULL,
	lastname varchar(50) NULL
);

-- Таблица профиля актеров

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

-- Таблица "В главных ролях"

DROP TABLE IF EXISTS starring;

CREATE TABLE starring (
	film_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	actor_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (actor_id) REFERENCES actors(id)
);

-- Таблица режиссеров

DROP TABLE IF EXISTS directors;

CREATE TABLE directors (
	id SERIAL PRIMARY KEY,
	firstname varchar(50) NULL,
	lastname varchar(50) null
);

-- Таблица профиля режиссеров

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

-- Таблица режиссеров фильмов

DROP TABLE IF EXISTS director_films;

CREATE TABLE director_films (
	film_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	director_id bigint UNSIGNED NOT NULL,
	FOREIGN KEY (director_id) REFERENCES directors(id)
);

-- Таблица жанров фильмов и сериалов

DROP TABLE IF EXISTS genres;

CREATE TABLE genres (
	film_id bigint UNSIGNED NOT NULL UNIQUE,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	comedy BIT DEFAULT 0 NULL COMMENT 'Комедия',
	cartoon BIT DEFAULT 0 NULL COMMENT 'Мультфильм',
	horror BIT DEFAULT 0 NULL COMMENT 'Ужасы',
	fantastic BIT DEFAULT 0 NULL COMMENT 'Фантастика',
	triller BIT DEFAULT 0 NULL COMMENT 'Триллер',
	action_movie BIT DEFAULT 0 NULL COMMENT 'Боевик',
	melodrama BIT DEFAULT 0 NULL COMMENT 'Мелодрама',
	detective BIT DEFAULT 0 NULL COMMENT 'Детектив',
	adventures BIT DEFAULT 0 NULL COMMENT 'Приключения',
	fantasy BIT DEFAULT 0 NULL COMMENT 'Фэнтези',
	war_film BIT DEFAULT 0 NULL COMMENT 'Военный',
	anime BIT DEFAULT 0 NULL COMMENT 'Аниме',
	history BIT DEFAULT 0 NULL COMMENT 'Исторический',
	family BIT DEFAULT 0 NULL COMMENT 'Семейный',
	drama BIT DEFAULT 0 NULL COMMENT 'Драма',
	documental BIT DEFAULT 0 NULL COMMENT 'Документальный',
	children BIT DEFAULT 0 NULL COMMENT 'Детский',
	criminal BIT DEFAULT 0 NULL COMMENT 'Криминал',
	biography BIT DEFAULT 0 NULL COMMENT 'Биография',
	western BIT DEFAULT 0 NULL COMMENT 'Вестерн',
	noir BIT DEFAULT 0 NULL COMMENT 'Нуар',
	sport BIT DEFAULT 0 NULL COMMENT 'Спортивный',
	short BIT DEFAULT 0 NULL COMMENT 'Короткометражный',
	music BIT DEFAULT 0 NULL COMMENT 'Музыкальный'
);

-- Таблица наград фильмов

DROP TABLE IF EXISTS awards;

CREATE TABLE awards (
	film_id bigint UNSIGNED NOT NULL UNIQUE,
	FOREIGN KEY (film_id) REFERENCES kino_units(id),
	oscar BIT DEFAULT 0 NOT NULL COMMENT 'Оскар',
	gg BIT DEFAULT 0 NOT NULL COMMENT 'Золотой глобус',
	ba BIT DEFAULT 0 NOT NULL COMMENT 'Британская академия',
	ce BIT DEFAULT 0 NOT NULL COMMENT 'Сезар',
	sag BIT DEFAULT 0 NOT NULL COMMENT 'Премия Гильдии актеров',
	nika BIT DEFAULT 0 NOT NULL COMMENT 'Ника',
	zo BIT DEFAULT 0 NOT NULL COMMENT 'Золотой орел',
	sat BIT DEFAULT 0 NOT NULL COMMENT 'Сатурн',
	goja BIT DEFAULT 0 NOT NULL COMMENT 'Гойа',
	emmy BIT DEFAULT 0 NOT NULL COMMENT 'Эмми',
	afa BIT DEFAULT 0 NOT NULL COMMENT 'Азиатская киноакадемия',
	efa BIT DEFAULT 0 NOT NULL COMMENT 'Европейская киноакадемия',
	mtv BIT DEFAULT 0 NOT NULL COMMENT 'MTV',
	mtv_r BIT DEFAULT 0 NOT NULL COMMENT 'MTV Россия',
	g_ma BIT DEFAULT 0 NOT NULL COMMENT 'Золотая малина',
	zhorzh BIT DEFAULT 0 NOT NULL COMMENT 'Жорж'
);


-- Заполнение таблиц

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
	(1,'Зеленая миля'),
	(2,'Побег из Шоушенка'),
	(3,'Список Шиндлера'),
	(4,'Властелин колец: Возвращение короля'),
	(5,'Форрест Гамп'),
	(6,'Властелин колец: Две крепости'),
	(7,'Властелин колец: Братство Кольца'),
	(8,'1 + 1'),
	(9,'Криминальное Чтиво'),
	(10,'Иван Васильевич меняет профессию');

INSERT INTO about_films VALUES
	(1, 1, 'The Green Mile', '1999','США', '«Пол Эджкомб не верил в чудеса. Пока не столкнулся с одним из них»', 'Фрэнк Дарабонт, Стивен Кинг',
	'Фрэнк Дарабонт, Дэвид Валдес', 'Дэвид Тэттерсолл', 'Томас Ньюман', 'Теренс Марш, Уильям Крус', 'Ричард Фрэнсис-Брюс', 60000000, 136801374,
	150000000, '2000-04-16', '1999-12-06', 16, '03:09:00'),
	(2, 2, 'The Shawshank Redemption', '1994', 'США', '«Страх - это кандалы. Надежда - это свобода»', 'Chadwick Lee', 'Chadwick Lee', 'Chadwick Lee',
	'Chadwick Lee',	'Chadwick Lee', 'Chadwick Lee',	25000000, 28341469,	77218, '2019-09-10', '1994-04-05', 16, '02:22:00'),
	(3, 3, 'Schindlers List', 1993,	'США', '«Этот список - жизнь»',	'Boris Willson', 'Boris Willson', 'Boris Willson', 'Boris Willson', 'Boris Willson', 'Boris Willson',
	35000000, 154000000, 4500000, '1994-03-02', '1999-05-01', 16, '01:56:00'),
	(4, 4, 'The Lord of the Rings: The Return of the King', 2003, 'Новая Зеландия',	'«There can be no triumph without loss. No victory without suffering. No freedom without sacrifice»',
	'Boris Huggins', 'Boris Huggins', 'Gind Errinf', 'Boris Huggins', 'Boris Huggins', 'Boris Huggins',	200000000, 54000000, 400000, '2003-11-02', '2003-12-01', 16, '02:34:00'),
	(5, 5, 'Forrest Gump', '1994', 'США', '«Мир уже никогда не будет прежним, после того как вы увидите его глазами Форреста Гампа»',
	'Shay Grady', 'Shay Grady', 'Shay Grady', 'Shay Grady', 'Shay Grady', 'Shay Grady', 1000000, 23000000, 32000000, '1995-04-11', '1994-09-10', 16, '01:30:20'),
	(6, 6, 'The Lord of the Rings: The Two Towers',	'2002', 'Новая Зеландия',	'«Приключение продолжается»', 'Melania Funnell', 'Melania Funnell', 'Melania Funnell', 'Melania Funnell', 'Melania Funnell', 'Melania Funnell',
	45000000, 100000000, 1200000, '2002-11-01', '2002-12-03', 16, '2:30:45'),
	(7, 7, 'The Lord of the Rings: The Fellowship of the Ring', '2001', 'Новая Зеландия',	'«Power can be held in the smallest of things...»',	'Ramon Reyes', 'Ramon Reyes', 'Ramon Reyes', 'Ramon Reyes', 'Ramon Reyes', 'Ramon Reyes',
	98000345, 235000000, 6500000, '2001-11-17', '2001-12-03', 16, '2:32:45'),
	(8, 8, 'Intouchables', '2011', 'Франция', '«Sometimes you have to reach into someone elses world to find out whats missing in your own»', 'Vicky Stone', 'Vicky Stone', 'Vicky Stone', 'Vicky Stone', 'Vicky Stone', 'Vicky Stone',
	6000000, 27000000, 1200000, '2011-11-09', '2011-12-04', 16, '1:32:40'),
	(9, 9, 'Pulp Fiction', '1994', 'США', '«Just because you are a character doesnt mean you have character»', 'Mackenzie Greenwood',	'Mackenzie Greenwood',	'Mackenzie Greenwood',	'Mackenzie Greenwood',	'Mackenzie Greenwood',	'Mackenzie Greenwood',
	8000000, 107928000, 200000,	'2011-11-09', '2011-12-04', 16, '1:32:40'),
	(10, 10, 'Иван Васильевич меняет профессию', '1973', 'СССР', '-', 'Владлен Бахнов', 'Виталий Абрамов', 'Александр Зацепин', 'Раиса Петрова', 'Клавдия Алеева', 'Евгений Куманьков',
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
	(1, 'Том', 'Хэнкс'),
	(2, 'Тим', 'Роббинс'),
	(3, 'Морган', 'Фриман'),
	(4, 'Лиам', 'Нисон'),
	(5, 'Элайджа', 'Вуд'),
	(6, 'Иэн', 'Маккелен'),
	(7, 'Франсуа', 'Клюзе'),
	(8, 'Джон', 'Траволта'),
	(9, 'Самюэл', 'Л. Джексон'),
	(10, 'Александр', 'Демьяненко');
	
INSERT INTO actor_profiles VALUES
	(1, 11, 'Актер, Продюсер, Режиссер, Сценарист', 1.83, '1956-07-09', 'Конкорд, США', 'Комедия, драма, документальный', 399, 'm'),
	(2, 12, 'Актер, Продюсер, Режиссер, Сценарист', 1.96, '1958-10-16', 'Уэст-Ковина, США', 'Драма, комедия, мелодрама', 213, 'm'),
	(3, 13, 'Актер, Продюсер, Режиссер', 1.88, '1937-06-01', 'Мемфис, США', 'Драма, триллер, криминал', 358, 'm'),
	(4, 14, 'Актер, Продюсер', 1.92, '1952-07-07', 'Беллимен, Северная Ирландия', 'Драма, триллер, боевик', 303, 'm'),
	(5, 15, 'Актер, Продюсер, Режиссер', 1.65, '1981-01-28', 'Сидар-Рапидс, США', 'Комедия, драма, приключения', 271, 'm'),
	(6, 16, 'Актер, Продюсер, Сценарист', 1.83, '1939-05-25', 'Бернли, Англия', 'Комедия, драма, короткометражка', 295, 'm'),
	(7, 17, 'Актер, Режиссер', 1.74, '1955-09-21', 'Париж, Франция', 'Комедия, драма, мелодрама', 131, 'm'),
	(8, 18, 'Актер, Продюсер, Сценарист', 1.88, '1954-02-18', 'Нью-Джерси, США', 'Триллер, драма, криминал', 295, 'm'),
	(9, 19, 'Актер, Продюсер', 1.88, '1948-12-21', 'Вашингтон, США', 'Драма, боевик, триллер', 427, 'm'),
	(10, 20, 'Актер, актер дубляжа', 1.69, '1937-05-30', 'Свердловск, СССР', 'Комедия, драма, мелодрама', 310, 'm');

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
	(1, 'Фрэнк', 'Дарабонт'),
	(2, 'Стивен', 'Спилберг'),
	(3, 'Питер', 'Джексон'),
	(4, 'Роберт', 'Земекис'),
	(5, 'Оливье', 'Накаш'),
	(6, 'Квентин', 'Тарантино'),
	(7, 'Леонид', 'Гайдай');

INSERT INTO director_profiles VALUES
	(1, 21, 'Сценарист, Актер, Режиссер, Продюсер', 1.83, 'Драма, триллер, ужасы', 'Керин Вагнер', 60, 'm'),
	(2, 22, 'Продюсер, Режиссер, Актер, Сценарист, Монтажер, Оператор, Композитор', 1.72, 'Приключения, драма, комедия', 'Эми Ирвинг', 482, 'm'),
	(3, 23, 'Продюсер, Режиссер, Актер, Сценарист, Оператор, Художник, Монтажер', 1.65, 'Короткометражка, документальный, фэнтези', 'Кэти Джексон', 164, 'm'),
	(4, 24, 'Продюсер, Режиссер, Сценарист, Актер', 1.83, 'Комедия, драма, триллер', 'Лесли Земекис', 130, 'm'),
	(5, 25, 'Сценарист, Режиссер, Продюсер, Актер', DEFAULT, 'Комедия, драма, короткометражка', DEFAULT, 33, 'm'),
	(6, 26, 'Актер, Сценарист, Режиссер, Продюсер, Оператор, Монтажер', 1.85, 'Драма, комедия, криминал', 'Даниэлла Пик', 234, 'm'),
	(7, 27, 'Режиссер, Сценарист, Актер', 1.83, 'Комедия, криминал, приключения', 'Нина Гребешкова', 32, 'm');
	
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


-- Представления

-- Топ 5 фильмов по бюджету

DROP VIEW IF EXISTS top5_films_bidget;

CREATE VIEW top5_films_bidget AS
	SELECT ku.name, af.budget
	FROM kino_units AS ku
	JOIN about_films AS af
	WHERE ku.id = af.film_id
	ORDER BY af.budget DESC
	LIMIT 5;

SELECT * FROM top5_films_bidget;

-- Вся информация о фильме

DROP VIEW IF EXISTS film_info;

CREATE VIEW film_info AS
	SELECT ku.name, af.*
	FROM kino_units AS ku
	RIGHT JOIN about_films AS af
	ON ku.id = af.film_id;

SELECT * FROM film_info;

-- Режиссеры и их фильмы

DROP VIEW IF EXISTS directors_and_films;

CREATE VIEW directors_and_films AS
	SELECT d.firstname, d.lastname, ku.name
	FROM directors AS d
	JOIN director_films AS df
	JOIN kino_units AS ku
	ON ku.id = df.film_id AND d.id = df.director_id AND d.id = df.director_id;

SELECT * FROM directors_and_films;

-- Фильмы с Оскаром или Золотым глобусом

DROP VIEW IF EXISTS films_with_awards;

CREATE VIEW films_with_awards AS
	SELECT ku.name, aw.oscar, aw.gg
	FROM kino_units AS ku
	JOIN awards AS aw
	WHERE ku.id = aw.film_id AND (oscar = 1 OR gg = 1);

SELECT * FROM films_with_awards;


-- Хранимые процедуры


-- Актеры, сыгравшие в определенном фильме

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


-- Количество оценок фильмов, которые поставили пользователи 30 лет и младше

DROP PROCEDURE IF EXISTS users_30;

CREATE PROCEDURE users_30()
BEGIN
	SELECT user_id, count(*) AS amount
	FROM unit_rates
	WHERE user_id IN (SELECT user_id FROM user_profiles WHERE timestampdiff(YEAR, birthday, now()) <= 30) GROUP BY user_id;
END;

CALL users_30();


-- Фильмы, в которых сыграл определенный актер

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

-- Список пользователей, которые ставили оценки хотя бы один раз

DROP PROCEDURE IF EXISTS nickname_rates_once;

CREATE PROCEDURE nickname_rates_once()
BEGIN
	SELECT DISTINCT nickname
	FROM users AS u
	JOIN unit_rates AS ur 
	ON u.id = ur.user_id;
END;

CALL nickname_rates_once();



-- Хранимые функции


-- Средняя оценка для фильма, исходя из оценок пользователей


DROP FUNCTION IF EXISTS art;

CREATE FUNCTION art(n int) RETURNS decimal(7,4) DETERMINISTIC
BEGIN
	DECLARE z decimal(7,4);
	SELECT avg(rating) FROM unit_rates WHERE film_id = n INTO z;
	RETURN z;
END;

SELECT art (3);


-- Триггеры

-- Триггер на дату рождения пользователя

DROP TRIGGER IF EXISTS date_b;

CREATE TRIGGER date_b BEFORE UPDATE ON user_profiles FOR EACH ROW
BEGIN
	IF NEW.birthday >= CURRENT_DATE()
	THEN SIGNAL SQLSTATE '45000' SET message_text = 'Ошибка. Неверная дата';
	END IF;
END;

