--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: marks_after_delete_row_tr(); Type: FUNCTION; Schema: public; Owner: dasha
--

CREATE FUNCTION public.marks_after_delete_row_tr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE videos SET rating = (
      select avg(marks.digit)
      from marks
          where marks.video_id = OLD.video_id)
      WHERE videos.id = OLD.video_id;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.marks_after_delete_row_tr() OWNER TO dasha;

--
-- Name: marks_after_insert_row_tr(); Type: FUNCTION; Schema: public; Owner: dasha
--

CREATE FUNCTION public.marks_after_insert_row_tr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE videos SET rating = (
      select avg(marks.digit)
      from marks
          where marks.video_id = NEW.video_id)
      WHERE videos.id = NEW.video_id;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.marks_after_insert_row_tr() OWNER TO dasha;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO dasha;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    category_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO dasha;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO dasha;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.favorites (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    video_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.favorites OWNER TO dasha;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_id_seq OWNER TO dasha;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: languages; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.languages (
    id bigint NOT NULL,
    language_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.languages OWNER TO dasha;

--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.languages_id_seq OWNER TO dasha;

--
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;


--
-- Name: marks; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.marks (
    id bigint NOT NULL,
    video_id bigint NOT NULL,
    user_id bigint NOT NULL,
    digit integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT digit_check CHECK (((digit >= 1) AND (digit <= 5)))
);


ALTER TABLE public.marks OWNER TO dasha;

--
-- Name: marks_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.marks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.marks_id_seq OWNER TO dasha;

--
-- Name: marks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.marks_id_seq OWNED BY public.marks.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    text text,
    user_id bigint NOT NULL,
    video_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.reviews OWNER TO dasha;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO dasha;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO dasha;

--
-- Name: speakers; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.speakers (
    id bigint NOT NULL,
    speaker_fio character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.speakers OWNER TO dasha;

--
-- Name: speakers_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.speakers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.speakers_id_seq OWNER TO dasha;

--
-- Name: speakers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.speakers_id_seq OWNED BY public.speakers.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    tag_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.tags OWNER TO dasha;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO dasha;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: user_activities; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.user_activities (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    action character varying NOT NULL,
    login_time timestamp(6) without time zone,
    logout_time timestamp(6) without time zone,
    session_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.user_activities OWNER TO dasha;

--
-- Name: user_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.user_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_activities_id_seq OWNER TO dasha;

--
-- Name: user_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.user_activities_id_seq OWNED BY public.user_activities.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    confirmation_token character varying,
    confirmed_at timestamp(6) without time zone,
    confirmation_sent_at timestamp(6) without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp(6) without time zone,
    username character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO dasha;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO dasha;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: video_categories; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.video_categories (
    id bigint NOT NULL,
    video_id bigint NOT NULL,
    category_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.video_categories OWNER TO dasha;

--
-- Name: video_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.video_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_categories_id_seq OWNER TO dasha;

--
-- Name: video_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.video_categories_id_seq OWNED BY public.video_categories.id;


--
-- Name: video_languages; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.video_languages (
    id bigint NOT NULL,
    video_id bigint NOT NULL,
    language_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.video_languages OWNER TO dasha;

--
-- Name: video_languages_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.video_languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_languages_id_seq OWNER TO dasha;

--
-- Name: video_languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.video_languages_id_seq OWNED BY public.video_languages.id;


--
-- Name: video_speakers; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.video_speakers (
    id bigint NOT NULL,
    video_id bigint NOT NULL,
    speaker_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.video_speakers OWNER TO dasha;

--
-- Name: video_speakers_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.video_speakers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_speakers_id_seq OWNER TO dasha;

--
-- Name: video_speakers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.video_speakers_id_seq OWNED BY public.video_speakers.id;


--
-- Name: video_tags; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.video_tags (
    id bigint NOT NULL,
    video_id bigint NOT NULL,
    tag_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.video_tags OWNER TO dasha;

--
-- Name: video_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.video_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_tags_id_seq OWNER TO dasha;

--
-- Name: video_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.video_tags_id_seq OWNED BY public.video_tags.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.videos (
    id bigint NOT NULL,
    video_name character varying NOT NULL,
    video_description text NOT NULL,
    video_url character varying,
    picture_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    key character varying,
    low_res_key character varying,
    rating integer
);


ALTER TABLE public.videos OWNER TO dasha;

--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_id_seq OWNER TO dasha;

--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- Name: watched_videos; Type: TABLE; Schema: public; Owner: dasha
--

CREATE TABLE public.watched_videos (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    video_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.watched_videos OWNER TO dasha;

--
-- Name: watched_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: dasha
--

CREATE SEQUENCE public.watched_videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watched_videos_id_seq OWNER TO dasha;

--
-- Name: watched_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dasha
--

ALTER SEQUENCE public.watched_videos_id_seq OWNED BY public.watched_videos.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: languages id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);


--
-- Name: marks id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.marks ALTER COLUMN id SET DEFAULT nextval('public.marks_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: speakers id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.speakers ALTER COLUMN id SET DEFAULT nextval('public.speakers_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: user_activities id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.user_activities ALTER COLUMN id SET DEFAULT nextval('public.user_activities_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: video_categories id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_categories ALTER COLUMN id SET DEFAULT nextval('public.video_categories_id_seq'::regclass);


--
-- Name: video_languages id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_languages ALTER COLUMN id SET DEFAULT nextval('public.video_languages_id_seq'::regclass);


--
-- Name: video_speakers id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_speakers ALTER COLUMN id SET DEFAULT nextval('public.video_speakers_id_seq'::regclass);


--
-- Name: video_tags id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_tags ALTER COLUMN id SET DEFAULT nextval('public.video_tags_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- Name: watched_videos id; Type: DEFAULT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.watched_videos ALTER COLUMN id SET DEFAULT nextval('public.watched_videos_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-04-23 21:59:22.136547	2024-04-23 21:59:22.136547
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.categories (id, category_name, created_at, updated_at) FROM stdin;
1	продуктовый обзор	2024-04-23 21:59:25.020897	2024-04-23 21:59:25.020897
2	демонстрация продукта	2024-04-23 21:59:25.026542	2024-04-23 21:59:25.026542
3	обучающий материал	2024-04-23 21:59:25.02941	2024-04-23 21:59:25.02941
4	вебинар	2024-04-23 21:59:25.034276	2024-04-23 21:59:25.034276
5	технологические инновации	2024-04-23 21:59:25.037715	2024-04-23 21:59:25.037715
6	тренды	2024-04-23 21:59:25.041252	2024-04-23 21:59:25.041252
7	интервью	2024-04-23 21:59:25.044496	2024-04-23 21:59:25.044496
8	кейс-стадии	2024-04-23 21:59:25.047896	2024-04-23 21:59:25.047896
9	опыт применения	2024-04-23 21:59:25.051398	2024-04-23 21:59:25.051398
10	корпоративная презентация	2024-04-23 21:59:25.055414	2024-04-23 21:59:25.055414
11	мероприятие	2024-04-23 21:59:25.059511	2024-04-23 21:59:25.059511
12	анимация	2024-04-23 21:59:25.063001	2024-04-23 21:59:25.063001
13	инфографика	2024-04-23 21:59:25.066277	2024-04-23 21:59:25.066277
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.favorites (id, user_id, video_id, created_at, updated_at) FROM stdin;
13	1	8	2024-04-23 23:37:25.27848	2024-04-23 23:37:25.27848
14	1	7	2024-04-23 23:42:38.277745	2024-04-23 23:42:38.277745
15	1	6	2024-04-23 23:42:46.418677	2024-04-23 23:42:46.418677
16	2	6	2024-04-23 23:43:20.566169	2024-04-23 23:43:20.566169
17	2	8	2024-04-23 23:43:29.288316	2024-04-23 23:43:29.288316
18	2	7	2024-04-23 23:43:36.703631	2024-04-23 23:43:36.703631
19	3	6	2024-04-23 23:47:46.703028	2024-04-23 23:47:46.703028
20	3	7	2024-04-23 23:47:53.485398	2024-04-23 23:47:53.485398
21	3	8	2024-04-23 23:48:01.143281	2024-04-23 23:48:01.143281
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.languages (id, language_name, created_at, updated_at) FROM stdin;
1	русский	2024-04-23 21:59:24.998125	2024-04-23 21:59:24.998125
2	английский	2024-04-23 21:59:25.004636	2024-04-23 21:59:25.004636
3	немецкий	2024-04-23 21:59:25.009901	2024-04-23 21:59:25.009901
\.


--
-- Data for Name: marks; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.marks (id, video_id, user_id, digit, created_at, updated_at) FROM stdin;
1	6	1	4	2024-04-23 22:36:03.199359	2024-04-23 22:36:03.199359
2	18	1	5	2024-04-23 22:38:14.335855	2024-04-23 22:38:14.335855
3	5	1	5	2024-04-23 22:41:08.798292	2024-04-23 22:41:08.798292
4	23	1	5	2024-04-23 22:43:52.489789	2024-04-23 22:43:52.489789
5	25	1	3	2024-04-23 22:47:22.955925	2024-04-23 22:47:22.955925
6	19	1	4	2024-04-23 22:51:17.646739	2024-04-23 22:51:17.646739
7	13	1	5	2024-04-23 22:53:02.852513	2024-04-23 22:53:02.852513
8	12	1	5	2024-04-23 22:55:13.792163	2024-04-23 22:55:13.792163
9	10	1	3	2024-04-23 22:59:16.35102	2024-04-23 22:59:16.35102
10	4	1	4	2024-04-23 23:00:23.002476	2024-04-23 23:00:23.002476
11	24	1	3	2024-04-23 23:02:53.029751	2024-04-23 23:02:53.029751
12	30	1	5	2024-04-23 23:03:54.077797	2024-04-23 23:03:54.077797
13	11	1	5	2024-04-23 23:05:45.402788	2024-04-23 23:05:45.402788
14	22	1	4	2024-04-23 23:07:52.57106	2024-04-23 23:07:52.57106
15	20	1	2	2024-04-23 23:10:24.631206	2024-04-23 23:10:24.631206
16	16	1	4	2024-04-23 23:11:33.648103	2024-04-23 23:11:33.648103
17	3	1	5	2024-04-23 23:12:50.304316	2024-04-23 23:12:50.304316
18	2	1	4	2024-04-23 23:17:20.815674	2024-04-23 23:17:20.815674
19	15	1	5	2024-04-23 23:18:49.985962	2024-04-23 23:18:49.985962
20	9	1	5	2024-04-23 23:21:25.489635	2024-04-23 23:21:25.489635
21	1	1	4	2024-04-23 23:23:17.940794	2024-04-23 23:23:17.940794
22	27	1	3	2024-04-23 23:29:11.56377	2024-04-23 23:29:11.56377
23	21	1	4	2024-04-23 23:30:24.364826	2024-04-23 23:30:24.364826
24	26	1	4	2024-04-23 23:32:24.684662	2024-04-23 23:32:24.684662
26	17	1	1	2024-04-23 23:34:06.914605	2024-04-23 23:34:06.914605
27	8	1	3	2024-04-23 23:34:45.665645	2024-04-23 23:34:45.665645
28	7	1	5	2024-04-23 23:41:19.305927	2024-04-23 23:41:19.305927
29	7	2	3	2024-04-23 23:44:14.114325	2024-04-23 23:44:14.114325
30	8	2	4	2024-04-23 23:44:28.645307	2024-04-23 23:44:28.645307
31	6	2	2	2024-04-23 23:46:09.008189	2024-04-23 23:46:09.008189
32	8	3	5	2024-04-23 23:48:13.345436	2024-04-23 23:48:13.345436
33	7	3	5	2024-04-23 23:49:51.277939	2024-04-23 23:49:51.277939
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.reviews (id, text, user_id, video_id, created_at, updated_at) FROM stdin;
1	Вот включить бы эти уведомления в симуляторе)	1	6	2024-04-23 22:37:11.576092	2024-04-23 22:37:11.576092
2	Работаю с Димой уже больше двух лет и вместе создаём мобильные приложения. Дима отличный специалист и за этот период всегда совершенствует свои знания. А доклад вообще пушка!	1	18	2024-04-23 22:38:10.082189	2024-04-23 22:38:10.082189
3	На РФ расширятся не думали?)))	1	5	2024-04-23 22:41:33.165626	2024-04-23 22:41:33.165626
5	Будущее наступило 	1	25	2024-04-23 22:48:04.818222	2024-04-23 22:48:04.818222
6	Лизу знаю лично, добрая отзывчивая и целеустремлённая личность, успех Лизы в начале её пути в качестве IT специалиста, а так же её поддержка помогли мне решится и сделать первый шаг в сторону работы мечты,. Пройдя 2 месячный интенсив в StormNet и 3 месяца онлайн практики я устроился в небольшую аутсорс компанию IT услуг в качестве Теститровщика ПО и уже почти год являюсь единственным QA Engineer  на двух крутых проектах. Учится как говорит Лиза и вправду не легко, т.к. объём информации огромен, только бери, но если тема интересна то погружаешься в учебный процесс достаточно быстро. Спасибо тебе Лиза за твой успех, желаю тебе дальнейшего быстрого 	1	4	2024-04-23 23:01:25.130423	2024-04-23 23:01:25.130423
7	What is this? The next US GP or something?	1	30	2024-04-23 23:04:37.94065	2024-04-23 23:04:37.94065
8	Файна! Вы малайцы\nАднак Віталю відовішча на крутую франкфурсткую піўнуху было б не менш даспадобы, мне падаецца ;)	1	22	2024-04-23 23:08:39.417417	2024-04-23 23:08:39.417417
9	Очень крутой формат! было крайне интересно посмотреть на коллег в не столь привычной обстановке ;)	1	3	2024-04-23 23:13:19.124455	2024-04-23 23:13:19.124455
10	Один из лучших видосов по git, что я видел. Я аж прямо захотел работать через terminal после просмотра.	1	15	2024-04-23 23:18:45.593217	2024-04-23 23:18:45.593217
11	 promo sm	1	9	2024-04-23 23:22:19.632348	2024-04-23 23:22:19.632348
13	В чем отличие между алимией 1.4 и второй версией смотрю курс и тут ошибка как пофиксить хз async_session_maker = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)	1	1	2024-04-23 23:24:09.914429	2024-04-23 23:24:09.914429
14	Выглядит очень круто и уютно Было интересно посмотреть. Спасибо за видео	1	21	2024-04-23 23:30:54.034672	2024-04-23 23:30:54.034672
15	42 минуты матчинной воды)	1	17	2024-04-23 23:34:02.006199	2024-04-23 23:34:02.006199
16	На самом деле, всё зависит от компании. Скорее всего, придётся совмещать и эникея и админа. В этом плане, разработчикам повезло больше - всё четко у них.	1	8	2024-04-23 23:36:49.594004	2024-04-23 23:36:49.594004
17	Сразу видно, человек проходил сильную школу на смолячкова! Хорош, видос топ, давай еще!	1	7	2024-04-23 23:41:15.578314	2024-04-23 23:41:15.578314
18	ассная подача, красивый парень, отличное объяснение 	2	7	2024-04-23 23:43:57.079436	2024-04-23 23:43:57.079436
19	в видео видно ламера, не видно даже press any key.	2	8	2024-04-23 23:45:45.585322	2024-04-23 23:45:45.585322
20	Автор по полочкам подал информацию и рассказал что, в какой последовательности и как нужно делать, чтобы собрать iOS проект. Спасибо большое.	2	6	2024-04-23 23:46:56.456902	2024-04-23 23:46:56.456902
22	Спасибо	3	6	2024-04-23 23:49:10.028901	2024-04-23 23:49:10.028901
23	Никому "хидер" слух не режет?  а так все гуд	3	7	2024-04-23 23:49:46.634572	2024-04-23 23:49:46.634572
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.schema_migrations (version) FROM stdin;
20231219135956
20231220143322
20231221141704
20240120120448
20240120120514
20240120123010
20240120194129
20240120194314
20240120194416
20240120205643
20240120205644
20240121010043
20240210111923
20240214063635
20240217120800
20240226081806
20240228071938
20240301071227
20240301100022
20240317200043
20240318220443
\.


--
-- Data for Name: speakers; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.speakers (id, speaker_fio, created_at, updated_at) FROM stdin;
1	Дмитрий Лось	2024-04-23 21:59:25.077724	2024-04-23 21:59:25.077724
2	Нейт Барбеттини	2024-04-23 21:59:25.081024	2024-04-23 21:59:25.081024
3	Павел Мартысюк	2024-04-23 21:59:25.084105	2024-04-23 21:59:25.084105
4	Лиза Васильева 	2024-04-23 21:59:25.087557	2024-04-23 21:59:25.087557
5	Валерий Колесников	2024-04-23 21:59:25.092486	2024-04-23 21:59:25.092486
6	Влад Евневич	2024-04-23 21:59:25.096019	2024-04-23 21:59:25.096019
7	Аристов Игорь	2024-04-23 21:59:25.100857	2024-04-23 21:59:25.100857
8	Вячеслав Морозов	2024-04-23 21:59:25.10612	2024-04-23 21:59:25.10612
9	Илья Ковалев	2024-04-23 21:59:25.109913	2024-04-23 21:59:25.109913
10	Антон Блинков	2024-04-23 21:59:25.113111	2024-04-23 21:59:25.113111
11	Матвей бойков	2024-04-23 21:59:25.11662	2024-04-23 21:59:25.11662
12	Валерия филстович	2024-04-23 21:59:25.119628	2024-04-23 21:59:25.119628
13	Андрей Тсибулко	2024-04-23 21:59:25.12382	2024-04-23 21:59:25.12382
14	Андрей Наличаев	2024-04-23 21:59:25.12746	2024-04-23 21:59:25.12746
15	Chad Justice	2024-04-23 21:59:25.130507	2024-04-23 21:59:25.130507
16	Tim Benedict	2024-04-23 21:59:25.133749	2024-04-23 21:59:25.133749
17	Игорь Гудеев	2024-04-23 21:59:25.136577	2024-04-23 21:59:25.136577
18	Леша Черихович	2024-04-23 21:59:25.139752	2024-04-23 21:59:25.139752
19	Кирилл Ларпенко	2024-04-23 21:59:25.143879	2024-04-23 21:59:25.143879
20	Алексей Чекин	2024-04-23 21:59:25.147544	2024-04-23 21:59:25.147544
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.tags (id, tag_name, created_at, updated_at) FROM stdin;
1	приключения	2024-04-23 21:59:24.942703	2024-04-23 21:59:24.942703
2	тестирование	2024-04-23 21:59:24.946622	2024-04-23 21:59:24.946622
3	backend разработка	2024-04-23 21:59:24.949958	2024-04-23 21:59:24.949958
4	frontend разработка	2024-04-23 21:59:24.954278	2024-04-23 21:59:24.954278
5	сис. администрирование	2024-04-23 21:59:24.960399	2024-04-23 21:59:24.960399
6	дизайн	2024-04-23 21:59:24.965723	2024-04-23 21:59:24.965723
7	не разработчик в it	2024-04-23 21:59:24.971343	2024-04-23 21:59:24.971343
8	спорт	2024-04-23 21:59:24.978945	2024-04-23 21:59:24.978945
9	трансляция	2024-04-23 21:59:24.982939	2024-04-23 21:59:24.982939
\.


--
-- Data for Name: user_activities; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.user_activities (id, user_id, action, login_time, logout_time, session_id, created_at, updated_at) FROM stdin;
1	1	login	2024-04-23 22:00:10.294961	\N	\N	2024-04-23 22:00:10.303227	2024-04-23 22:00:10.303227
2	1	logout	\N	2024-04-23 23:43:00.640169	\N	2024-04-23 23:43:00.642986	2024-04-23 23:43:00.642986
3	2	login	2024-04-23 23:43:16.122953	\N	\N	2024-04-23 23:43:16.124842	2024-04-23 23:43:16.124842
4	2	logout	\N	2024-04-23 23:47:21.410503	\N	2024-04-23 23:47:21.412443	2024-04-23 23:47:21.412443
5	3	login	2024-04-23 23:47:38.148886	\N	\N	2024-04-23 23:47:38.151243	2024-04-23 23:47:38.151243
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, username, created_at, updated_at, role) FROM stdin;
11	user_9@example.com	$2a$12$hiLLqTq/EU.VEC.Dv75kleuiN.rQQ2DNCeHGcLLlHHwCBfz9x0CtW	\N	\N	\N	qQnw4ApK_cnoK24QTAka	2024-04-23 21:59:30.77438	2024-04-23 21:59:24.918737	\N	0	\N	\N	moses	2024-04-23 21:59:24.918695	2024-04-23 21:59:30.774728	0
10	user_8@example.com	$2a$12$0Wb3KFDHT9aGONtPN9hvk.TjhGJT8.UkuaOmDEe7vmTScAjvrFpwC	\N	\N	\N	nGeYD145JwXLfxXwZtkk	2024-04-23 21:59:32.574707	2024-04-23 21:59:24.695671	\N	0	\N	\N	earle.hartmann	2024-04-23 21:59:24.695633	2024-04-23 21:59:32.575058	0
9	user_7@example.com	$2a$12$0O6C8IhDPCOysHyh9lTEp.QS2Bhcl4Vp0CARgUz5dCJrwVO8gs/LG	\N	\N	\N	yxoq4AVnsXjebA76iy5k	2024-04-23 21:59:34.284936	2024-04-23 21:59:24.483768	\N	0	\N	\N	donte	2024-04-23 21:59:24.483729	2024-04-23 21:59:34.285118	0
8	user_6@example.com	$2a$12$teueJ0fL3lPyqvugfFyqL.wsQ6yt9.5XRouKYKQ/YUw5.nILgsEBe	\N	\N	\N	oXztz1Rzzvs15QZffU6b	2024-04-23 21:59:36.123959	2024-04-23 21:59:24.267621	\N	0	\N	\N	kiera.hessel	2024-04-23 21:59:24.267577	2024-04-23 21:59:36.124346	0
7	user_5@example.com	$2a$12$gPd5/PsNbZfczkTZeBDSneqWoljSKNRY/zQa2bpITiYCL0RyQ/.L.	\N	\N	\N	xyRKTZyrLVN-MF5AUwSN	2024-04-23 21:59:38.283724	2024-04-23 21:59:24.04899	\N	0	\N	\N	francisco_collier	2024-04-23 21:59:24.04894	2024-04-23 21:59:38.283884	0
6	user_4@example.com	$2a$12$NINK7G9H2XDOGjZUrjA3GeuV2krYnK6/.SRO2uazzxi1mQ0yK5L6W	\N	\N	\N	6nJMXsxyxfFewGTdjXK-	2024-04-23 21:59:39.818224	2024-04-23 21:59:23.834068	\N	0	\N	\N	eloy	2024-04-23 21:59:23.834029	2024-04-23 21:59:39.818591	0
5	user_3@example.com	$2a$12$UdVVMOM3jEOMNmd3d0XaRecnBTC11HUpfHGrpOVhQuZ.xCzusH4IG	\N	\N	\N	rBKHQC8Pepaf8nK1YKyn	2024-04-23 21:59:41.397719	2024-04-23 21:59:23.617303	\N	0	\N	\N	tracy	2024-04-23 21:59:23.617263	2024-04-23 21:59:41.397893	0
4	user_2@example.com	$2a$12$0i3Sb/JrxY0d38JEcj0D3..d.vRE5zzcYTtFOejaix2oxzIsPtRZu	\N	\N	\N	ZsXJPSWNmCeHkyNcY5Gi	2024-04-23 21:59:43.229428	2024-04-23 21:59:23.400794	\N	0	\N	\N	santos.haag	2024-04-23 21:59:23.400754	2024-04-23 21:59:43.229615	0
3	user_1@example.com	$2a$12$U/4zZXwhXpYi/kjYTvHzB.mrizZHm7PI1Of1L10Z7zcQi8VjHEdD6	\N	\N	\N	BRzx6xauoCM9R16Bpbmt	2024-04-23 21:59:45.125667	2024-04-23 21:59:23.182436	\N	0	\N	\N	ricky	2024-04-23 21:59:23.182397	2024-04-23 21:59:45.126386	0
2	user_0@example.com	$2a$12$yRrdvV5ZRsuy6/RIYkajh.K5pSOOB14oeaQ8L6xHmPtUS7r0bo0cG	\N	\N	\N	-DyRL3HgMy4Tk5b9_sao	2024-04-23 21:59:48.363422	2024-04-23 21:59:22.959568	\N	0	\N	\N	marcy	2024-04-23 21:59:22.959459	2024-04-23 21:59:48.363618	0
1	admin@example.com	$2a$12$OdO8rcborXRzmJXvz5Maquxey5.X4OL.H3PE56vTFrU8U.kVjC01.	\N	\N	\N	AKUFx2FLCWvMzLA8C_hY	2024-04-23 21:59:49.930066	2024-04-23 21:59:22.55278	\N	0	\N	\N	Dasha Admin	2024-04-23 21:59:22.552693	2024-04-23 21:59:49.930237	1
\.


--
-- Data for Name: video_categories; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.video_categories (id, video_id, category_id, created_at, updated_at) FROM stdin;
1	6	3	2024-04-23 22:35:29.758461	2024-04-23 22:35:29.758461
2	18	6	2024-04-23 22:38:52.882741	2024-04-23 22:38:52.882741
3	18	4	2024-04-23 22:39:34.341623	2024-04-23 22:39:34.341623
4	5	7	2024-04-23 22:40:47.464443	2024-04-23 22:40:47.464443
5	5	8	2024-04-23 22:40:58.17149	2024-04-23 22:40:58.17149
6	23	7	2024-04-23 22:43:46.961329	2024-04-23 22:43:46.961329
7	25	1	2024-04-23 22:46:59.572815	2024-04-23 22:46:59.572815
8	25	2	2024-04-23 22:47:04.770512	2024-04-23 22:47:04.770512
9	25	5	2024-04-23 22:47:13.039447	2024-04-23 22:47:13.039447
10	19	2	2024-04-23 22:51:01.160279	2024-04-23 22:51:01.160279
11	13	4	2024-04-23 22:52:39.364816	2024-04-23 22:52:39.364816
12	12	4	2024-04-23 22:54:59.531676	2024-04-23 22:54:59.531676
13	12	8	2024-04-23 22:55:04.556792	2024-04-23 22:55:04.556792
14	12	9	2024-04-23 22:55:09.132474	2024-04-23 22:55:09.132474
15	29	2	2024-04-23 22:56:48.322721	2024-04-23 22:56:48.322721
16	10	2	2024-04-23 22:59:00.734103	2024-04-23 22:59:00.734103
17	4	7	2024-04-23 23:00:01.205215	2024-04-23 23:00:01.205215
18	30	6	2024-04-23 23:03:50.229519	2024-04-23 23:03:50.229519
19	11	4	2024-04-23 23:05:35.265025	2024-04-23 23:05:35.265025
20	11	3	2024-04-23 23:05:39.778721	2024-04-23 23:05:39.778721
21	22	10	2024-04-23 23:07:46.899604	2024-04-23 23:07:46.899604
22	20	10	2024-04-23 23:10:19.655342	2024-04-23 23:10:19.655342
23	16	7	2024-04-23 23:11:20.111275	2024-04-23 23:11:20.111275
24	3	7	2024-04-23 23:12:46.090823	2024-04-23 23:12:46.090823
25	2	9	2024-04-23 23:16:59.332121	2024-04-23 23:16:59.332121
26	2	3	2024-04-23 23:17:14.976212	2024-04-23 23:17:14.976212
27	15	3	2024-04-23 23:19:27.075693	2024-04-23 23:19:27.075693
28	9	13	2024-04-23 23:21:14.375323	2024-04-23 23:21:14.375323
29	9	12	2024-04-23 23:21:19.375419	2024-04-23 23:21:19.375419
30	1	3	2024-04-23 23:23:14.142257	2024-04-23 23:23:14.142257
31	14	11	2024-04-23 23:26:39.171892	2024-04-23 23:26:39.171892
32	28	12	2024-04-23 23:28:17.317627	2024-04-23 23:28:17.317627
33	28	2	2024-04-23 23:28:22.849698	2024-04-23 23:28:22.849698
34	27	12	2024-04-23 23:28:57.320137	2024-04-23 23:28:57.320137
35	27	1	2024-04-23 23:29:03.924012	2024-04-23 23:29:03.924012
36	21	10	2024-04-23 23:30:19.332695	2024-04-23 23:30:19.332695
37	26	6	2024-04-23 23:32:13.083647	2024-04-23 23:32:13.083647
38	26	11	2024-04-23 23:32:20.648297	2024-04-23 23:32:20.648297
39	17	3	2024-04-23 23:33:12.07841	2024-04-23 23:33:12.07841
40	17	4	2024-04-23 23:33:18.766155	2024-04-23 23:33:18.766155
41	8	7	2024-04-23 23:34:39.852336	2024-04-23 23:34:39.852336
42	7	3	2024-04-23 23:42:14.279458	2024-04-23 23:42:14.279458
\.


--
-- Data for Name: video_languages; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.video_languages (id, video_id, language_id, created_at, updated_at) FROM stdin;
1	6	1	2024-04-23 22:33:15.191313	2024-04-23 22:33:15.191313
2	18	1	2024-04-23 22:38:19.373809	2024-04-23 22:38:19.373809
3	5	1	2024-04-23 22:40:15.943418	2024-04-23 22:40:15.943418
4	23	1	2024-04-23 22:43:31.765936	2024-04-23 22:43:31.765936
5	25	1	2024-04-23 22:44:38.557217	2024-04-23 22:44:38.557217
6	19	1	2024-04-23 22:50:30.377029	2024-04-23 22:50:30.377029
7	13	2	2024-04-23 22:52:07.859866	2024-04-23 22:52:07.859866
8	12	2	2024-04-23 22:54:28.773938	2024-04-23 22:54:28.773938
9	29	2	2024-04-23 22:56:00.674525	2024-04-23 22:56:00.674525
10	10	2	2024-04-23 22:58:22.713888	2024-04-23 22:58:22.713888
11	4	1	2024-04-23 22:59:41.654059	2024-04-23 22:59:41.654059
12	24	1	2024-04-23 23:02:03.922029	2024-04-23 23:02:03.922029
13	30	2	2024-04-23 23:03:13.029849	2024-04-23 23:03:13.029849
14	11	2	2024-04-23 23:05:04.267462	2024-04-23 23:05:04.267462
15	22	1	2024-04-23 23:07:08.001883	2024-04-23 23:07:08.001883
16	16	1	2024-04-23 23:10:46.726319	2024-04-23 23:10:46.726319
17	3	1	2024-04-23 23:12:14.338599	2024-04-23 23:12:14.338599
18	2	1	2024-04-23 23:15:17.23394	2024-04-23 23:15:17.23394
19	15	1	2024-04-23 23:18:55.312603	2024-04-23 23:18:55.312603
20	9	2	2024-04-23 23:20:34.178593	2024-04-23 23:20:34.178593
21	1	1	2024-04-23 23:22:58.773136	2024-04-23 23:22:58.773136
22	14	1	2024-04-23 23:26:16.372796	2024-04-23 23:26:16.372796
23	28	2	2024-04-23 23:27:56.057422	2024-04-23 23:27:56.057422
24	21	1	2024-04-23 23:30:04.863127	2024-04-23 23:30:04.863127
25	26	1	2024-04-23 23:32:01.182938	2024-04-23 23:32:01.182938
26	17	1	2024-04-23 23:32:51.372178	2024-04-23 23:32:51.372178
27	8	1	2024-04-23 23:34:24.572043	2024-04-23 23:34:24.572043
28	7	1	2024-04-23 23:41:23.559211	2024-04-23 23:41:23.559211
\.


--
-- Data for Name: video_speakers; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.video_speakers (id, video_id, speaker_id, created_at, updated_at) FROM stdin;
1	6	6	2024-04-23 22:33:56.44057	2024-04-23 22:33:56.44057
2	18	1	2024-04-23 22:38:44.932824	2024-04-23 22:38:44.932824
3	5	3	2024-04-23 22:40:35.290357	2024-04-23 22:40:35.290357
4	25	9	2024-04-23 22:46:52.068481	2024-04-23 22:46:52.068481
5	13	15	2024-04-23 22:52:22.881565	2024-04-23 22:52:22.881565
6	13	16	2024-04-23 22:52:46.760946	2024-04-23 22:52:46.760946
7	13	14	2024-04-23 22:52:57.622081	2024-04-23 22:52:57.622081
8	12	14	2024-04-23 22:54:44.6876	2024-04-23 22:54:44.6876
9	4	4	2024-04-23 23:00:17.056425	2024-04-23 23:00:17.056425
10	30	18	2024-04-23 23:03:32.229505	2024-04-23 23:03:32.229505
11	11	13	2024-04-23 23:05:30.657961	2024-04-23 23:05:30.657961
12	22	3	2024-04-23 23:07:23.279737	2024-04-23 23:07:23.279737
13	16	19	2024-04-23 23:11:06.272177	2024-04-23 23:11:06.272177
14	16	18	2024-04-23 23:11:27.543064	2024-04-23 23:11:27.543064
15	3	3	2024-04-23 23:12:25.765919	2024-04-23 23:12:25.765919
16	3	5	2024-04-23 23:12:36.643607	2024-04-23 23:12:36.643607
17	2	8	2024-04-23 23:16:03.191009	2024-04-23 23:16:03.191009
18	15	17	2024-04-23 23:19:18.744619	2024-04-23 23:19:18.744619
19	1	3	2024-04-23 23:23:09.675637	2024-04-23 23:23:09.675637
20	17	10	2024-04-23 23:33:04.095722	2024-04-23 23:33:04.095722
21	8	11	2024-04-23 23:34:34.801016	2024-04-23 23:34:34.801016
22	7	17	2024-04-23 23:42:09.392319	2024-04-23 23:42:09.392319
\.


--
-- Data for Name: video_tags; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.video_tags (id, video_id, tag_id, created_at, updated_at) FROM stdin;
1	18	6	2024-04-23 22:38:34.283283	2024-04-23 22:38:34.283283
2	5	7	2024-04-23 22:40:22.303164	2024-04-23 22:40:22.303164
3	13	3	2024-04-23 22:52:16.199594	2024-04-23 22:52:16.199594
4	12	3	2024-04-23 22:54:36.883341	2024-04-23 22:54:36.883341
5	4	7	2024-04-23 22:59:46.686777	2024-04-23 22:59:46.686777
6	4	2	2024-04-23 23:00:04.930576	2024-04-23 23:00:04.930576
7	24	8	2024-04-23 23:02:09.382965	2024-04-23 23:02:09.382965
8	30	8	2024-04-23 23:03:19.536773	2024-04-23 23:03:19.536773
9	16	8	2024-04-23 23:10:50.818332	2024-04-23 23:10:50.818332
10	3	8	2024-04-23 23:12:21.590534	2024-04-23 23:12:21.590534
11	2	3	2024-04-23 23:15:38.389547	2024-04-23 23:15:38.389547
12	9	3	2024-04-23 23:20:43.168588	2024-04-23 23:20:43.168588
13	1	3	2024-04-23 23:23:03.358815	2024-04-23 23:23:03.358815
14	14	8	2024-04-23 23:26:24.251367	2024-04-23 23:26:24.251367
15	14	1	2024-04-23 23:26:28.574414	2024-04-23 23:26:28.574414
16	27	6	2024-04-23 23:28:47.870705	2024-04-23 23:28:47.870705
17	26	3	2024-04-23 23:32:08.731868	2024-04-23 23:32:08.731868
18	17	6	2024-04-23 23:32:54.75279	2024-04-23 23:32:54.75279
19	8	7	2024-04-23 23:34:28.678808	2024-04-23 23:34:28.678808
20	7	3	2024-04-23 23:41:32.897509	2024-04-23 23:41:32.897509
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.videos (id, video_name, video_description, video_url, picture_url, created_at, updated_at, key, low_res_key, rating) FROM stdin;
4	QA-инженер – о задачах, проектах, и том, как получить работу мечты [НЕРАЗРАБОТЧИК В IT]	QA-инженер: кто такой, как им стать и почему в IT без него было бы очень грустно\r\nНовая рубрика: говорим о профессиях, которые позволят тебе работать в IT-сфере, не будучи разработчиком. Начинаем с Quality Assurance или, если проще, с тестирования.\r\nНа первый взгляд это проще, чем непосредственно разработка ПО, но и тут есть свои нюансы и сложности. Как раз о них (и не только) пойдет речь в этом видео. \r\n\r\nQA-инженер Лиза Васильева рассказывает:\r\n· в чем состоит работа отдела тестирования\r\n· чем отличается Manual QA от AQA\r\n· какие не самые приятные личные качества могут оказаться суперполезными в работе QA\r\n· что освоить и какие скиллы подтянуть, чтобы войти в профессию (от навыков коммуникации до знания http, json и xml протоколов, например)\r\n	QA-инженер___о_задачах__проектах__и_том__как_получить_работу_мечты__НЕРАЗРАБОТЧИ__1_.mp4	Screenshot_from_2024-02-05_10-55-22.png	2024-04-23 22:05:48.043204	2024-04-23 22:05:48.043204	\N	\N	4
3	INNOSPORT #1 __ Земля, вода, огонь и воздух	Друзья, всем привет! \r\n\r\nНам очень хочется, чтобы серия видео про спорт стала нашей постоянной рубрикой. Мы сделали первое видео и показали, как будет выглядеть формат. \r\nЕсли у тебя есть идеи, интересные мысли или ты недавно сделал что-то крутое: покажи всем остальным. Давай вместе выберем локацию, напишем сценарий и сделаем классный контент!\r\n	INNOSPORT__1____Земля__вода__огонь_и_воздух.mp4	Screenshot_from_2024-02-05_10-57-09.png	2024-04-23 22:04:40.95173	2024-04-23 22:04:40.95173	\N	\N	5
2	HintedSpinner - библиотека, дающая возможность добавлять Hint в Android	Кто работает с Android, тот знает: есть проблемка. И не одна, но мы сейчас именно про Spinner с хинтом. Большинство разработчиков "спотыкались" на этом уже давно, а нативного решения от команды Android SDK все не было.\r\n\r\n"Никуда не годится", решили мы - и вуаля! Встречай лёгкую, простую, кастомизируемую библиотеку с крутым экзамплом. Больше ничего не скажем: скачивай, пробуй, изучай возможности. Будет круто, если оставишь фидбэк в комментариях! 🔥\r\n	HintedSpinner_-_библиотека__дающая_возможность_добавлять_Hint_в_Android.mp4	Screenshot_from_2024-02-05_10-56-08.png	2024-04-23 22:03:48.963548	2024-04-23 22:03:48.963548	\N	\N	4
1	FastAPI с нуля за 10 минут! Взаимодействие с SQLAlchemy, Pydantic, Alembic	FastAPI — штука хоть и не новая, но все же достаточно молодая. Живой интерес к ней начал расти буквально в последние пару лет. Если заглянуть на Github, то увидим, что количество звезд у этого backend-фреймворка составляет примерно половину (и даже больше) от количества звезд у Flask и Django (а это, на минуточку, гиганты рынка, без их упоминания не обходится ни один туториал и ни одна вакансия в Data Science).\r\n\r\nНесмотря на это, широкого обсуждения FastAPI в сети либо на профильных конференциях не наблюдается, равно как и частого использования в IT-продуктах. Соответственно, не так уж много разработчиков понимают, что это и зачем оно им надо.\r\n \r\nМы решили восполнить этот пробел! В новом видео Python-разработчик Innowise Павел Мартысюк: \r\n- рассказывает в общих чертах про фреймворк\r\n- выделяет плюсы и минусы,  показывает возможности\r\n- подробно останавливается на взаимодействии с библиотеками SQLAlchemy, Pydantic, Alembic\r\n	FastAPI_с_нуля_за_10_минут__Взаимодействие_с_SQLAlchemy__Pydantic__Alembic.mp4	Screenshot_from_2024-02-05_10-59-52.png	2024-04-23 22:01:13.647183	2024-04-23 22:01:13.647183	\N	\N	4
10	Transforming Retail_ How Innowise is Revolutionizing eCommerce #retail #ecommerc	🛒💡 Ready to transform your online store? Discover how Innowise's eCommerce software development services can take your business to the next level! Our team of experts specializes in creating custom, innovative solutions that drive growth and enhance customer experience. Whether you're a startup or an established retail player, we have the IT expertise to elevate your eCommerce game. Dive into our latest video to see how we're revolutionizing the digital retail landscape.\r\n	Transforming_Retail__How_Innowise_is_Revolutionizing_eCommerce__retail__ecommerc.mp4	Screenshot_from_2024-04-23_23-55-45.png	2024-04-23 22:10:32.609664	2024-04-23 22:10:32.609664	\N	\N	3
11	Innowise's eCommerce Webinar for FMCG Manufacturers	📈🛒 Are you ready to transform your FMCG business with eCommerce? Join Innowise's exclusive webinar and learn from eCommerce experts how to boost your profits using analytics. Discover strategies that will take your sales to the next level, understand your customers better, and make smarter business decisions. Don't miss this opportunity to revolutionize your FMCG brand.\r\n\r\nInnowise presents a must-attend eCommerce webinar designed specifically for FMCG manufacturers aiming to elevate their market presence and profitability. Learn from eCommerce experts how to effectively use analytics to uncover hidden opportunities, streamline your operations, and create compelling customer experiences that drive sales. This comprehensive guide will cover everything from the basics of setting up an eCommerce platform to advanced techniques in analytics that can help you predict trends, manage inventory more efficiently, and boost your bottom line.\r\n	Innowise_s_eCommerce_Webinar_for_FMCG_Manufacturers__webinar__ecommerce.mp4	Screenshot_from_2024-04-23_23-57-45.png	2024-04-23 22:11:09.981808	2024-04-23 22:11:09.981808	\N	\N	5
9	From Concept to Launch_ Innowise Software Development Process	Ever wondered how a simple idea becomes a tech reality? Dive into the world of @innowiseglobal, where we turn concepts into cutting-edge software. Our latest video takes you through each step of the software development process, from the initial idea to product launch and beyond. Discover the passion, precision, and innovation behind every project. Ready to see how your rough idea can become the next big thing?💡\r\n	From_Concept_to_Launch__Innowise_Software_Development_Process__innowiseglobal.mp4	Screenshot_from_2024-04-23_23-54-00.png	2024-04-23 22:09:37.07693	2024-04-23 22:09:37.07693	\N	\N	5
7	Секреты OAuth 2.0 и OIDC_ Применение в приложениях	В этом видео мы глубоко погружаемся в мир авторизации и аутентификации, рассматривая ключевые аспекты OAUTH 2.0 и OIDC (OpenID Connect). Если вы занимаетесь разработкой приложений или интересуетесь безопасностью в IT, это видео для вас.\r\n\r\nО чем мы узнаем в этом видео:\r\n\r\nОсновы OAUTH 2.0 и OIDC: Мы рассмотрим базовые принципы и функциональность каждого протокола, а также поговорим о том, как они взаимодействуют между собой.\r\n\r\nOIDC vs OAUTH 2.0: Мы проанализируем ключевые различия между OpenID Connect и протоколом авторизации OAUTH 2.0. Это позволит вам лучше понять, когда и как использовать каждый из них.\r\n\r\nПрименение в приложениях: Мы рассмотрим примеры реального применения OAUTH 2.0 и OIDC в приложениях, сфокусировавшись на использовании в рамках языка программирования Java.\r\n\r\nБезопасность: Обсудим вопросы безопасности, связанные с авторизацией и аутентификацией, и как OAUTH 2.0 и OIDC помогают защищать ваши приложения.\r\n	Секреты_OAuth_2.0_и_OIDC__Применение_в_приложениях.mp4	Screenshot_from_2024-02-05_10-54-41.png	2024-04-23 22:08:17.960989	2024-04-23 22:08:17.960989	\N	\N	4
8	Системный администратор [НЕРАЗРАБОТЧИК В IT]	Все хоть раз в жизни сталкивались с сисадминами, все знают хотя бы пару шуток и уж точно гору стереотипов о них, но понимаете ли вы, в чем состоит его работа? В новом видео Матфей Байков, system administrator варшавского офиса Innowise, рассказывает:\r\n- чем он занимается каждый день и какие проблемы приходится решать\r\n- какие навыки нужны для такой работы и где их получить\r\n- какие карьерные перспективы у системного администратора, если однажды ему надоест отвечать на глупые вопросы юзеров :)\r\n	Системный_администратор__НЕРАЗРАБОТЧИК_В_IT_.mp4	Screenshot_from_2024-02-05_10-55-11.png	2024-04-23 22:08:58.696901	2024-04-23 22:08:58.696901	\N	\N	4
14	Day of the Programmer '22	Мы, конечно, любим все праздники в году, но День программиста — особый повод. Мы и отметили его по-особому! Каждый офис придумал что-то свое, в итоге были:\r\n\r\n🔥 спортивные соревнования\r\n🔥 бильярд, настольный теннис, волейбол\r\n🔥 квест по мотивам «Форд Баярд»\r\n🔥 караоке\r\n🔥 бармен-шоу\r\n🔥 танцы\r\n\r\nДумаете, это все? Конечно, нет: было много веселья, вкуснейшие угощения, хоровое пение под хиты, смешные кадры, брызги шампанского... Кто-то еще сомневается, что Innowise умеет отдыхать? 😎\r\n	Day_of_the_Programmer__22.mp4	Screenshot_from_2024-04-24_00-13-32.png	2024-04-23 22:13:07.954505	2024-04-23 22:13:07.954505	\N	\N	\N
19	VOKA.IO - AR Medical Solution	Как инновационные разработки белорусских программистов и врачей могут преобразовать медицину? Команда Innowise Group посетила Витебский Государственный Университет, чтобы наглядно продемонстрировать это студентам и преподавателям.\r\n\r\nМы представили MR ассистента хирурга VOKA.IO – медицинскую систему, которая с помощью технологий Mixed Reality позволяет визуализировать 3D модели поврежденных костей, органов и тканей внутри пациента. Решение помогает врачам эффективнее планировать операции и делать точную разметку хирургических доступов. VOKA.IO получил признание среди медицинского сообщества в разных странах, стал одним из победителей World Summit Award 2019 и получил серебро на 19-м конгрессе EFORT. С использованием нашего решения уже были успешно прооперированы более 60 пациентов, а в настоящий момент разрабатываются новые способы проведения хирургических операций.\r\n\r\nРуководители проекта показали работу VOKA.IO на примере манекена, рассказали о возможностях решения для лечения пациентов, а также обсудили, как еще разработчики могут изменить мир к лучшему.\r\n	VOKA.IO_-_AR_Medical_Solution.mp4	Screenshot_from_2024-04-24_00-32-08.png	2024-04-23 22:18:31.656558	2024-04-23 22:18:31.656558	\N	\N	4
13	VITREUS AMA_ Unveiling Innowise's Next-Gen Blockchain Solution #webinar #blockch	🚀 Ready to dive into the future of blockchain? Join our VITREUS AMA session and tech webinar hosted by #VITREUS! 🌐💡 Discover how our cutting-edge blockchain solution is poised to revolutionize the industry.\r\nGet your questions ready and interact live with our blockchain experts. Don't miss out on this opportunity to learn about the next big thing in blockchain technology.\r\n	VITREUS_AMA__Unveiling_Innowise_s_Next-Gen_Blockchain_Solution__webinar__blockch.mp4	Screenshot_from_2024-04-24_00-10-58.png	2024-04-23 22:12:45.747704	2024-04-23 22:12:45.747704	\N	\N	5
16	INNOSPORT #2 __ Тактика, напор и ощущение полёта	Друзья,\r\n\r\nВторой выпуск INNOSPORT про достижения, проактивность и любовь к спорту наших коллег.\r\nЮра расскажет, почему он выбирает хоккей, Леша о своём гимнастическом прошлом и ощущении тела относительно земли, а Кирилл объяснит, почему бокс называют "шахматами движений".\r\nСмотри быстрее и делись впечатлениями в комментариях.\r\n	INNOSPORT__2____Тактика__напор_и_ощущение_полёта.mp4	Screenshot_from_2024-04-24_00-21-02.png	2024-04-23 22:15:05.462488	2024-04-23 22:15:05.462488	\N	\N	4
15	Git. Путешествие туда и обратно	Тут представлен доклад по Git, количество адекватных коммитов увеличено вдвое.\r\n\r\nВ этом  ролике мы рассмотрим:\r\n- Как появился Git в современном понимании\r\n- Что происходит внутри черного ящика\r\n- Почему уметь пользоваться Git - классно\r\n- Как конфигурировать Git\r\n- Как работают основные команды Git\r\n- Как работать с удаленным репозиторием\r\n- И многое другое\r\n	Git._Путешествие_туда_и_обратно.mp4	Screenshot_from_2024-04-24_00-17-03.png	2024-04-23 22:13:36.101122	2024-04-23 22:13:36.101122	\N	\N	5
24	International Yoga Day 2021 __ Innowise	Асана, мудра, намасте… Если вы знакомы с этими словами, то вы точно занимаетесь или интересуетесь йогой 🧘‍♀️ И даже если вы не в теме, но очень хотите заниматься, то стоит начать сейчас!\r\n\r\n21 июня во всем мире отмечают международный день йоги.\r\nДату праздника выбрали не случайно. В ночь с 21 на 22 июня празднуется летнее солнцестояние, самый длинный день в году.\r\n\r\nМы решили отметить праздник и провести занятие йогой совместно с коллегами, чтобы расслабиться перед новой рабочей неделей и зарядиться позитивной летней энергией.\r\n	International_Yoga_Day_2021____Innowise__1_.mp4	Screenshot_from_2024-04-24_00-42-43.png	2024-04-23 22:21:59.356536	2024-04-23 22:21:59.356536	\N	\N	3
22	Innowise. Frankfurt am Main	Innowise открыл офис во Франкфурте.  Это важный шаг для компании как минимум по трем причинам:\r\n\r\n- Франкфурт - финансовая столица Германии и всей Европы. Fintech - одно из крупнейших направлений в Innowise, у нас много клиентов в DACH, так что здесь нам самое место\r\n- еще год назад мы открывали в соседних странах, сегодня мы\r\nзабрались гораздо дальше:  у Innowise 7 офисов за пределами Беларуси, и это только начало\r\n- первыми новый офис опробуют специалисты Sale-отдела, но в недалеком будущем сюда смогут переезжать и разработчики\r\n\r\nМы добавили еще один флажок на воображаемую карту офисов - и намерены всерьез обосноваться в этой точке. Точно знаем: все достижимо, если упорно работать!\r\n	Innowise._Frankfurt_am_Main.mp4	Screenshot_from_2024-04-24_00-37-04.png	2024-04-23 22:19:56.200316	2024-04-23 22:19:56.200316	\N	\N	4
20	Innowise. Dusseldorf	Дюссельдорф – новая рабочая локация на карте компании. Мы продолжаем уверенно укреплять свои позиции на рынке DACH, поэтому открываем в Германии третий офис (в дополнение к Мюнхену и Франкфурту). Уверены, что здесь нас ждет много успешно реализованных проектов и продуктивных встреч с заказчиками.\r\n\r\nПоздравляем Innowise с еще одним крутым этапом и ждем всех в гости!\r\n	Innowise._Dusseldorf.mp4	Screenshot_from_2024-04-24_00-33-54.png	2024-04-23 22:18:58.748421	2024-04-23 22:18:58.748421	\N	\N	2
21	Экскурсия по Варшавскому офису Innowise	Мы — IT-компания Innowise, и это наш офис в Варшаве. Мы по-настоящему гордимся им, потому что:\r\n- он находится в самом сердце города, в The Warsaw Hub, рядом с Google и другими известными компаниями\r\n- нам удалось создать комфортное и уютное пространство для продуктивной работы и приятного отдыха большой команды\r\n- из окна открываются шикарные виды на центр столицы:)\r\n\r\nЖдем всех в нашем офисе: клиентов, партнеров и, конечно, новых сотрудников. Увидимся в Innowise!\r\n	Экскурсия_по_Варшавскому_офису_Innowise.mp4	Screenshot_from_2024-04-24_00-34-34.png	2024-04-23 22:19:27.963717	2024-04-23 22:19:27.963717	\N	\N	4
28	Breaking Boundaries with Innowise_ The New Era of AR & VR Innovations	🚀🌐 Dive into the future with #Innowise ! We're at the forefront of transforming imagination into reality through cutting-edge AR & VR development. Experience how our end-to-end software solutions are setting new standards in immersive technology. Ready to explore the next dimension of digital innovation?\r\nLet’s redefine what's possible together!\r\n	Breaking_Boundaries_with_Innowise__The_New_Era_of_AR___VR_Innovations.mp4	Screenshot_from_2024-04-24_00-54-14.png	2024-04-23 22:24:53.993782	2024-04-23 22:24:53.993782	\N	\N	\N
29	Transforming Training_ Innowise's Journey in Advanced AR_VR Development	🚀🌐 Dive into the future with #Innowise ! We're at the forefront of transforming imagination into reality through cutting-edge AR & VR development. Experience how our end-to-end software solutions are setting new standards in immersive technology. Ready to explore the next dimension of digital innovation?\r\nLet’s redefine what's possible together!\r\n	Transforming_Training__Innowise_s_Journey_in_Advanced_AR_VR_Development.mp4	Screenshot_from_2024-04-24_00-54-45.png	2024-04-23 22:27:57.338157	2024-04-23 22:27:57.338157	\N	\N	\N
18	Работают ли тренды мобильного дизайна 2021 __ Тренды UI_UX дизайна	Lead UI/UX Designer Дмитрий рассказывает о трендах мобильного дизайна, сформулированных в 2019-ом и их актуальности в 2021-ом. Минимализм (Zero UI), bottom navigation, digital detox — мы поговорим обо всех "трендсеттерах" мобильной разработки и дизайна интерфейсов.\r\n\r\nСпикер — Дмитрий Лось. «Феномен Баадера — Майнхоф, или зачем нам это всё».\r\nLead UI/UX Designer в Innowise Group, Lead Designer в компаниях CCT и ArtofWeb. Опыт в дизайне более 10 лет.\r\n\r\nДизайн суббота — проект, созданный для обмена опытом и неформального общения между дизайнерами цифровых продуктов. Мы приглашаем интересных специалистов из сферы дизайна в качестве спикеров и модераторов встреч.\r\n	Работают_ли_тренды_мобильного_дизайна_2021____Тренды_UI_UX_дизайна.mp4	Screenshot_from_2024-04-24_00-29-32.png	2024-04-23 22:18:06.921582	2024-04-23 22:18:06.921582	\N	\N	5
27	3D Virtual Tour_ Marc Chagall Art Centre #3dart	🎨✨ Step into the future of art and architecture with our latest 3D modeling masterpiece! We've brought the Marc Chagall Art Centre to life in a way you've never seen before. From a detailed 3D city map to the intricate designs of the art centre itself, experience the blend of culture and technology. Don't miss this virtual tour! 🌐💻\r\n	3D_Virtual_Tour__Marc_Chagall_Art_Centre__3dart.mp4	Screenshot_from_2024-04-24_00-50-53.png	2024-04-23 22:24:21.09038	2024-04-23 22:24:21.09038	\N	\N	3
26	Что такое Code of conduct Как не стоит вести себя с коллегами	Как не стоит вести себя с коллегами? Что такое Code of conduct ? И что делать, если вы нарушили его?  🤔\r\n\r\nОтветами поделился спикер Вячеслав Морозов на образовательном митапе в Гомеле, который прошел на прошлых выходных.\r\n\r\nМы разобрались в вопросах теории и практики, обсудили, почему так важно соблюдать кодекс поведения и провели интерактивную игру. Участники выбирали “опасные” темы для делового общения с коллегами и заказчиками.\r\n\r\nПонравилась тема встречи? Мы готовим еще больше активностей!\r\nПодписывайся на наши социальные сети, следи за анонсами и посещай ивенты 🔥.\r\n	Что_такое_Code_of_conduct_Как_не_стоит_вести_себя_с_коллегами__1_.mp4	Screenshot_from_2024-04-24_00-48-24.png	2024-04-23 22:23:46.250259	2024-04-23 22:23:46.250259	\N	\N	4
6	Разработка уведомлений в iOS __ iOS Notifications Tutorial	При разработке приложений нередко возникает необходимость предусмотреть отправку уведомлений - например, чтобы сообщить пользователю о новом концерте, о добавлении его в друзья, повышении курса валют и других событиях. \r\n\r\nВлад Евневич, Middle iOS-разработчик в Innowise, детально расскажет о Local Notifications, Push Notifications, а также о механизме Rich Notifications в iOS. \r\n\r\nКод демо-приложения доступен для изучения: \r\nhttps://gitlab.com/innowise-group-mee...\r\n	Разработка_уведомлений_в_iOS____iOS_Notifications_Tutorial.mp4	Screenshot_from_2024-02-05_10-56-16.png	2024-04-23 22:07:41.523566	2024-04-23 22:07:41.523566	\N	\N	3
5	Копирайтеры. ИИ нас заменит! [НЕРАЗРАБОТЧИК В IT]	Встречайте Лену и Пашу — двух талантливых копирайтеров, работающих в нашей компании. Они решили поделиться своим опытом и рассказать о том, в чем состоит их работа, какие задачи они решают ежедневно и какие трудности они преодолевают.\r\n\r\nВ этом видео Лена и Паша проливают свет на мир копирайтинга в айти-сфере. Они рассказывают о том, какими навыками нужно обладать для успешной работы в этой области, и даже дают советы, где можно приобрести необходимые знания и умения.\r\n\r\nНо это не все! В ролике Лена и Паша также обсуждают какие возможности и вызовы ждут специалистов в этой области, рассказывают какой карьерный путь они прошли за свою жизнь, а также делятся тем, как они учатся сейчас.\r\n\r\nНе упустите шанс заглянуть внутрь работы копирайтеров в IT-компании и получить уникальный взгляд на эту увлекательную профессию. Подписывайтесь на наш канал, чтобы не пропустить новые выпуски!\r\n	Копирайтеры._ИИ_нас_заменит___НЕРАЗРАБОТЧИК_В_IT_.mp4	Screenshot_from_2024-02-05_11-06-23.png	2024-04-23 22:06:25.202197	2024-04-23 22:06:25.202197	\N	\N	5
23	Дети отвечают на вопросы про работу в IT __ Innowise	Знают ли дети, где и кем работают их родители? А что делают на работе?\r\n\r\nМы решили проверить это и провели небольшой опрос среди детей наших сотрудников. Вот такие вопросы мы им задали:\r\n\r\nКем работает мама/папа в компании? Чем занимается?\r\nКто такие программисты и что они делают?\r\nХотел(а) бы ты стать программистом, когда вырастешь?\r\nА хотел(а) бы работать в Innowise Group, как мама/папа?\r\n\r\nОтветы были абсолютно разные. Но ребята точно знали: родители очень любят свою работу и, приходя домой, рассказывают много интересных историй. А еще многие хотели бы пойти по стопам мамы или папы – тоже стать программистами :)\r\n	Дети_отвечают_на_вопросы_про_работу_в_IT____Innowise__1_.mp4	Screenshot_from_2024-04-24_00-40-54.png	2024-04-23 22:21:25.648533	2024-04-23 22:21:25.648533	\N	\N	5
25	Видим пациента насквозь с помощью очков смешанной реальности Microsoft HoloLens	Давно хотел(а) понять, как связаны смешанная реальность и медицина? Еще не удавалось примерить MS HoloLens, а очень хочется увидеть VOKA.IO изнутри?\r\n\r\nСейчас мы раскроем все секреты!\r\n\r\nVOKA. IO – это ассистент хирурга, который помогает в диагностике заболеваний внутренних органов, тканей, костей, а также планировании и проведении операций.\r\n\r\nЭто первый в мире инструмент на основе смешанной реальности для Microsoft HoloLens, которым уже пользуются для диагностики и лечения пациентов в нескольких научно-практических центрах Беларуси.\r\n\r\nКак это работает?\r\n\r\nСначала проводят КТ или МРТ пациента. Затем полученные данные преобразуют в трехмерную модель, которую загружают в медицинскую систему VOKA.IO. Дальше врач надевает очки Microsoft HoloLens, и 3D-модель отображается в дополненной реальности. Так технология помогает видеть реального человека и виртуальную модель одновременно – кость, орган или мышцу.\r\n	Видим_пациента_насквозь_с_помощью_очков_смешанной_реальности_Microsoft_HoloLens.mp4	Screenshot_from_2024-04-24_00-46-58.png	2024-04-23 22:22:25.217786	2024-04-23 22:22:25.217786	\N	\N	3
12	Unlocking the Future_ Tokenization Webinar with Innowise's Blockchain Expert	🚀🔐 Ready to unlock the potential of blockchain? Join Innowise's exclusive webinar on Tokenization and learn from leading blockchain experts! Dive into how tokenization is revolutionizing industries, from finance to real estate, and discover strategies to leverage this technology for your advantage. Whether you're an investor, entrepreneur, or tech enthusiast, this is your gateway to mastering blockchain.\r\n\r\nWhy you should watch the webinar:\r\n\r\n✅ Unleash transformation\r\nEmbark on a journey to explore the transformative power of tokenization and witness its game-changing influence on the current market landscape.\r\n\r\n✅ Dive into the core\r\nDelve deep into the fundamental principles underpinning tokenization and explore its diverse applications that extend far beyond conventional boundaries.\r\n\r\n✅ Real-world insights\r\nGain valuable knowledge from real-world use cases that vividly demonstrate how tokenization is reshaping the financial sector, offering you a glimpse into the limitless possibilities it holds.\r\n	Unlocking_the_Future__Tokenization_Webinar_with_Innowise_s_Blockchain_Expert.mp4	Screenshot_from_2024-04-24_00-01-59.png	2024-04-23 22:12:15.707285	2024-04-23 22:12:15.707285	\N	\N	5
30	Innowise x Formula1_ Let's Race Into the Future and Innovation	Welcome to the race of a lifetime! 🏎️💨\r\n\r\nJust like every race, each day presents new obstacles and opportunities for growth and success. Every turn, both on the track and in the business realm, presents a fresh set of challenges.\r\n\r\nAt Innowise Group, we strive to operate like a well-oiled, high-performance machine, finely tuned and ready to conquer the track. However, we understand that true victory is not achieved through solo efforts. It takes an exceptional team to make things happen. Through the determination, resilience, and unwavering dedication of our talented Innowisers like our CTO Dmitry Nazarevich and over 1500 other amazing software engineers, we confidently navigate every turn and overcome every hurdle that comes our way.\r\n\r\nFor us, completing each lap represents more than just reaching the finish line. It symbolizes a successfully delivered project that creates value for our customers. Every lap we complete brings us closer to our vision of innovation in action, mutual success, and business growth.\r\n\r\nAs we race forward, we continue to gain expertise and cultivate a collective knowledge that propels us to new heights. We are not merely a company; we are a community of forward-thinkers and trailblazers, constantly seeking new opportunities and embracing the cutting-edge technologies that drive progress.\r\n\r\nTogether, let's continue racing towards a future filled with triumphs, sustainable change, and unforgettable achievements. Join us on this incredible journey as we leave our mark on the track and in the business world.\r\n	Innowise_x_Formula1__Let_s_Race_Into_the_Future_and_Innovation.mp4	Screenshot_from_2024-04-24_00-56-34.png	2024-04-23 22:28:57.431675	2024-04-23 22:28:57.431675	\N	\N	5
17	Теперь ты SENIOR дизайнер __ Путь от дилетанта до профессионала	CEO Blink Agency Антон Блинков рассказывает о том, что отличает Trainee от Junior, Junior от Middle и том, как достигнуть заветного "Senior". Какие конкретно черты отличают начинающего дизайнера от познавшего дзен профессионала? Отвечаем на волнующие вопросы в новом выпуске "Дизайн субботы"\r\n\r\nСпикер — Антон Блинков Lead Designer и основатель студии Blink Agency с опытом более 8 лет. Работал над приложениями для Loona, Astrology and Palmistry Coach, Gem4me и многими другими.\r\n\r\nДизайн суббота — проект, созданный для обмена опытом и неформального общения между дизайнерами цифровых продуктов. Мы приглашаем интересных специалистов из сферы дизайна в качестве спикеров и модераторов встреч.\r\n	Теперь_ты_SENIOR_дизайнер____Путь_от_дилетанта_до_профессионала.mp4	Screenshot_from_2024-04-24_00-27-50.png	2024-04-23 22:15:47.932336	2024-04-23 22:16:33.352767	\N	\N	1
\.


--
-- Data for Name: watched_videos; Type: TABLE DATA; Schema: public; Owner: dasha
--

COPY public.watched_videos (id, user_id, video_id, created_at, updated_at) FROM stdin;
1	1	18	2024-04-23 22:39:45.567253	2024-04-23 22:39:45.567253
2	1	5	2024-04-23 22:41:02.022352	2024-04-23 22:41:02.022352
3	1	25	2024-04-23 22:47:17.79483	2024-04-23 22:47:17.79483
4	1	13	2024-04-23 22:54:03.915873	2024-04-23 22:54:03.915873
5	1	2	2024-04-23 23:18:09.647234	2024-04-23 23:18:09.647234
6	1	15	2024-04-23 23:18:51.78562	2024-04-23 23:18:51.78562
7	1	17	2024-04-23 23:32:44.949861	2024-04-23 23:32:44.949861
8	1	8	2024-04-23 23:36:53.147946	2024-04-23 23:36:53.147946
9	1	7	2024-04-23 23:42:25.485906	2024-04-23 23:42:25.485906
10	2	7	2024-04-23 23:44:19.050441	2024-04-23 23:44:19.050441
11	2	8	2024-04-23 23:45:51.37838	2024-04-23 23:45:51.37838
12	2	6	2024-04-23 23:46:13.575084	2024-04-23 23:46:13.575084
13	3	8	2024-04-23 23:48:19.880372	2024-04-23 23:48:19.880372
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.categories_id_seq', 13, true);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.favorites_id_seq', 21, true);


--
-- Name: languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.languages_id_seq', 3, true);


--
-- Name: marks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.marks_id_seq', 33, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.reviews_id_seq', 23, true);


--
-- Name: speakers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.speakers_id_seq', 20, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.tags_id_seq', 9, true);


--
-- Name: user_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.user_activities_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.users_id_seq', 11, true);


--
-- Name: video_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.video_categories_id_seq', 42, true);


--
-- Name: video_languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.video_languages_id_seq', 28, true);


--
-- Name: video_speakers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.video_speakers_id_seq', 22, true);


--
-- Name: video_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.video_tags_id_seq', 20, true);


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.videos_id_seq', 30, true);


--
-- Name: watched_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dasha
--

SELECT pg_catalog.setval('public.watched_videos_id_seq', 13, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: marks marks_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.marks
    ADD CONSTRAINT marks_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: speakers speakers_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.speakers
    ADD CONSTRAINT speakers_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: user_activities user_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.user_activities
    ADD CONSTRAINT user_activities_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: video_categories video_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_categories
    ADD CONSTRAINT video_categories_pkey PRIMARY KEY (id);


--
-- Name: video_languages video_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_languages
    ADD CONSTRAINT video_languages_pkey PRIMARY KEY (id);


--
-- Name: video_speakers video_speakers_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_speakers
    ADD CONSTRAINT video_speakers_pkey PRIMARY KEY (id);


--
-- Name: video_tags video_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_tags
    ADD CONSTRAINT video_tags_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: watched_videos watched_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.watched_videos
    ADD CONSTRAINT watched_videos_pkey PRIMARY KEY (id);


--
-- Name: index_favorites_on_user_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_favorites_on_user_id ON public.favorites USING btree (user_id);


--
-- Name: index_favorites_on_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_favorites_on_video_id ON public.favorites USING btree (video_id);


--
-- Name: index_marks_on_user_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_marks_on_user_id ON public.marks USING btree (user_id);


--
-- Name: index_marks_on_user_id_and_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE UNIQUE INDEX index_marks_on_user_id_and_video_id ON public.marks USING btree (user_id, video_id);


--
-- Name: index_marks_on_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_marks_on_video_id ON public.marks USING btree (video_id);


--
-- Name: index_reviews_on_user_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_reviews_on_user_id ON public.reviews USING btree (user_id);


--
-- Name: index_reviews_on_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_reviews_on_video_id ON public.reviews USING btree (video_id);


--
-- Name: index_user_activities_on_user_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_user_activities_on_user_id ON public.user_activities USING btree (user_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: dasha
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: dasha
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: dasha
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_video_categories_on_category_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_video_categories_on_category_id ON public.video_categories USING btree (category_id);


--
-- Name: index_video_categories_on_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_video_categories_on_video_id ON public.video_categories USING btree (video_id);


--
-- Name: index_video_languages_on_language_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_video_languages_on_language_id ON public.video_languages USING btree (language_id);


--
-- Name: index_video_languages_on_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_video_languages_on_video_id ON public.video_languages USING btree (video_id);


--
-- Name: index_video_speakers_on_speaker_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_video_speakers_on_speaker_id ON public.video_speakers USING btree (speaker_id);


--
-- Name: index_video_speakers_on_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_video_speakers_on_video_id ON public.video_speakers USING btree (video_id);


--
-- Name: index_video_tags_on_tag_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_video_tags_on_tag_id ON public.video_tags USING btree (tag_id);


--
-- Name: index_video_tags_on_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_video_tags_on_video_id ON public.video_tags USING btree (video_id);


--
-- Name: index_watched_videos_on_user_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_watched_videos_on_user_id ON public.watched_videos USING btree (user_id);


--
-- Name: index_watched_videos_on_video_id; Type: INDEX; Schema: public; Owner: dasha
--

CREATE INDEX index_watched_videos_on_video_id ON public.watched_videos USING btree (video_id);


--
-- Name: marks marks_after_delete_row_tr; Type: TRIGGER; Schema: public; Owner: dasha
--

CREATE TRIGGER marks_after_delete_row_tr AFTER DELETE ON public.marks FOR EACH ROW EXECUTE FUNCTION public.marks_after_delete_row_tr();


--
-- Name: marks marks_after_insert_row_tr; Type: TRIGGER; Schema: public; Owner: dasha
--

CREATE TRIGGER marks_after_insert_row_tr AFTER INSERT ON public.marks FOR EACH ROW EXECUTE FUNCTION public.marks_after_insert_row_tr();


--
-- Name: video_languages fk_rails_160d6c0e07; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_languages
    ADD CONSTRAINT fk_rails_160d6c0e07 FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: user_activities fk_rails_56e545161c; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.user_activities
    ADD CONSTRAINT fk_rails_56e545161c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: video_speakers fk_rails_5ae4fef373; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_speakers
    ADD CONSTRAINT fk_rails_5ae4fef373 FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: video_categories fk_rails_6c7e71cde7; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_categories
    ADD CONSTRAINT fk_rails_6c7e71cde7 FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: marks fk_rails_6f82d45597; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.marks
    ADD CONSTRAINT fk_rails_6f82d45597 FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: reviews fk_rails_74a66bd6c5; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_74a66bd6c5 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: video_speakers fk_rails_80ba6464b1; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_speakers
    ADD CONSTRAINT fk_rails_80ba6464b1 FOREIGN KEY (speaker_id) REFERENCES public.speakers(id);


--
-- Name: watched_videos fk_rails_815a68421f; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.watched_videos
    ADD CONSTRAINT fk_rails_815a68421f FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: marks fk_rails_8a89591deb; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.marks
    ADD CONSTRAINT fk_rails_8a89591deb FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: reviews fk_rails_9d113a2f76; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_9d113a2f76 FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: video_languages fk_rails_adb392f21d; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_languages
    ADD CONSTRAINT fk_rails_adb392f21d FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: video_tags fk_rails_af94da446b; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_tags
    ADD CONSTRAINT fk_rails_af94da446b FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- Name: video_categories fk_rails_afa6fb1e5b; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_categories
    ADD CONSTRAINT fk_rails_afa6fb1e5b FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: favorites fk_rails_b24a5713a2; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_b24a5713a2 FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- Name: favorites fk_rails_d15744e438; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_d15744e438 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: watched_videos fk_rails_fb3f6236fd; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.watched_videos
    ADD CONSTRAINT fk_rails_fb3f6236fd FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: video_tags fk_rails_fcdb957abf; Type: FK CONSTRAINT; Schema: public; Owner: dasha
--

ALTER TABLE ONLY public.video_tags
    ADD CONSTRAINT fk_rails_fcdb957abf FOREIGN KEY (video_id) REFERENCES public.videos(id);


--
-- PostgreSQL database dump complete
--

