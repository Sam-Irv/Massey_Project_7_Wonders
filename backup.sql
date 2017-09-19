--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE alembic_version OWNER TO admin;

--
-- Name: card; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE card (
    id integer NOT NULL,
    name character varying(50),
    "noPlayers" integer,
    age integer,
    colour character varying(10),
    "costMoney" integer,
    "costWood" integer,
    "costBrick" integer,
    "costOre" integer,
    "costStone" integer,
    "costGlass" integer,
    "costPaper" integer,
    "costCloth" integer,
    prerequisite1 character varying(50),
    prerequisite2 character varying(50),
    "giveWood" integer,
    "giveBrick" integer,
    "giveOre" integer,
    "giveStone" integer,
    "giveGlass" integer,
    "givePaper" integer,
    "giveCloth" integer,
    "resourceAlternating" boolean,
    "givePoints" integer,
    "giveMilitary" integer,
    "giveMoney" integer,
    "giveResearch" character varying(10)
);


ALTER TABLE card OWNER TO admin;

--
-- Name: card_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE card_id_seq OWNER TO admin;

--
-- Name: card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE card_id_seq OWNED BY card.id;


--
-- Name: cardhist; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE cardhist (
    id integer NOT NULL,
    "playerId" integer,
    "cardId" integer,
    discarded boolean,
    for_wonder boolean
);


ALTER TABLE cardhist OWNER TO admin;

--
-- Name: cardhist_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE cardhist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cardhist_id_seq OWNER TO admin;

--
-- Name: cardhist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE cardhist_id_seq OWNED BY cardhist.id;


--
-- Name: game; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE game (
    id integer NOT NULL,
    age integer,
    round integer,
    started boolean,
    complete boolean
);


ALTER TABLE game OWNER TO admin;

--
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE game_id_seq OWNER TO admin;

--
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE game_id_seq OWNED BY game.id;


--
-- Name: player; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE player (
    id integer NOT NULL,
    "gameId" integer,
    "userId" integer,
    ready boolean,
    left_id integer,
    right_id integer,
    wonder character varying(50),
    wonder_level integer,
    max_wonder integer,
    wood integer,
    brick integer,
    ore integer,
    stone integer,
    glass integer,
    paper integer,
    cloth integer,
    points integer,
    military integer,
    money integer,
    cog integer,
    tablet integer,
    compass integer,
    wildcard integer,
    extra_wood integer,
    extra_brick integer,
    extra_ore integer,
    extra_stone integer,
    extra_glass integer,
    extra_paper integer,
    extra_cloth integer,
    military_loss integer
);


ALTER TABLE player OWNER TO admin;

--
-- Name: player_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE player_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE player_id_seq OWNER TO admin;

--
-- Name: player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE player_id_seq OWNED BY player.id;


--
-- Name: round; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE round (
    id integer NOT NULL,
    age integer,
    round integer,
    "playerId" integer,
    "cardId" integer
);


ALTER TABLE round OWNER TO admin;

--
-- Name: round_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE round_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE round_id_seq OWNER TO admin;

--
-- Name: round_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE round_id_seq OWNED BY round.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE "user" (
    id integer NOT NULL,
    email character varying(255),
    password character varying(255)
);


ALTER TABLE "user" OWNER TO admin;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO admin;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: wonder; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE wonder (
    id integer NOT NULL,
    name character varying(50),
    slots integer,
    card_0 character varying(30),
    card_1 character varying(30),
    card_2 character varying(30),
    card_3 character varying(30),
    card_4 character varying(30)
);


ALTER TABLE wonder OWNER TO admin;

--
-- Name: wonder_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE wonder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wonder_id_seq OWNER TO admin;

--
-- Name: wonder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE wonder_id_seq OWNED BY wonder.id;


--
-- Name: card id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY card ALTER COLUMN id SET DEFAULT nextval('card_id_seq'::regclass);


--
-- Name: cardhist id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cardhist ALTER COLUMN id SET DEFAULT nextval('cardhist_id_seq'::regclass);


--
-- Name: game id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY game ALTER COLUMN id SET DEFAULT nextval('game_id_seq'::regclass);


--
-- Name: player id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY player ALTER COLUMN id SET DEFAULT nextval('player_id_seq'::regclass);


--
-- Name: round id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY round ALTER COLUMN id SET DEFAULT nextval('round_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: wonder id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY wonder ALTER COLUMN id SET DEFAULT nextval('wonder_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY alembic_version (version_num) FROM stdin;
d2db659c43b6
\.


--
-- Data for Name: card; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY card (id, name, "noPlayers", age, colour, "costMoney", "costWood", "costBrick", "costOre", "costStone", "costGlass", "costPaper", "costCloth", prerequisite1, prerequisite2, "giveWood", "giveBrick", "giveOre", "giveStone", "giveGlass", "givePaper", "giveCloth", "resourceAlternating", "givePoints", "giveMilitary", "giveMoney", "giveResearch") FROM stdin;
1	giza_0	0	0	wonder	0	0	0	0	0	0	0	0			0	0	0	1	0	0	0	f	0	0	0	
2	giza_1	0	0	wonder	0	2	0	0	0	0	0	0			0	0	0	0	0	0	0	f	3	0	0	
3	giza_2	0	0	wonder	0	0	0	0	3	0	0	0			0	0	0	0	0	0	0	f	5	0	0	
4	giza_3	0	0	wonder	0	0	3	0	0	0	0	0			0	0	0	0	0	0	0	f	5	0	0	
5	giza_4	0	0	wonder	0	0	0	0	4	0	1	0			0	0	0	0	0	0	0	f	7	0	0	
6	alex_0	0	0	wonder	0	0	0	0	0	0	0	0			0	0	0	0	1	0	0	f	0	0	0	
7	alex_1	0	0	wonder	0	0	2	0	0	0	0	0			1	1	1	1	0	0	0	t	0	0	0	
8	alex_2	0	0	wonder	0	2	0	0	0	0	0	0			0	0	0	0	1	1	1	t	0	0	0	
9	alex_3	0	0	wonder	0	0	0	0	3	0	0	0			0	0	0	0	0	0	0	f	7	0	0	
10	zeus_0	0	0	wonder	0	0	0	0	0	0	0	0			1	0	0	0	0	0	0	f	0	0	0	
11	zeus_1	0	0	wonder	0	2	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
12	zeus_2	0	0	wonder	0	0	0	0	2	0	0	0			0	0	0	0	0	0	0	f	5	0	0	
13	zeus_3	0	0	wonder	0	0	0	2	0	0	0	1			0	0	0	0	0	0	0	f	0	0	0	
14	ephesus_0	0	0	wonder	0	0	0	0	0	0	0	0			0	0	0	0	0	1	0	f	0	0	0	
15	ephesus_1	0	0	wonder	0	0	0	0	2	0	0	0			0	0	0	0	0	0	0	f	2	0	4	
16	ephesus_2	0	0	wonder	0	2	0	0	0	0	0	0			0	0	0	0	0	0	0	f	3	0	4	
17	ephesus_3	0	0	wonder	0	0	0	0	0	1	1	1			0	0	0	0	0	0	0	f	5	0	4	
18	hali_0	0	0	wonder	0	0	0	0	0	0	0	0			0	0	0	0	0	0	1	f	0	0	0	
19	hali_1	0	0	wonder	0	0	0	2	0	0	0	0			0	0	0	0	0	0	0	f	2	0	0	
20	hali_2	0	0	wonder	0	0	3	0	0	0	0	0			0	0	0	0	0	0	0	f	1	0	0	
21	hali_3	0	0	wonder	0	0	0	0	0	1	1	1			0	0	0	0	0	0	0	f	0	0	0	
22	rhodes_0	0	0	wonder	0	0	0	0	0	0	0	0			0	0	1	0	0	0	0	f	0	0	0	
23	rhodes_1	0	0	wonder	0	0	0	0	3	0	0	0			0	0	0	0	0	0	0	f	3	1	3	
24	rhodes_2	0	0	wonder	0	0	0	4	0	0	0	0			0	0	0	0	0	0	0	f	4	1	4	
25	babylon_0	0	0	wonder	0	0	0	0	0	0	0	0			0	1	0	0	0	0	0	f	0	0	0	
26	babylon_1	0	0	wonder	0	0	1	0	0	0	0	1			0	0	0	0	0	0	0	f	3	0	0	
27	babylon_2	0	0	wonder	0	2	0	0	0	1	0	0			0	0	0	0	0	0	0	f	0	0	0	
28	babylon_3	0	0	wonder	0	0	3	0	0	0	1	0			0	0	0	0	0	0	0	f	0	0	0	
29	Lumber Yard	3	1	brown	0	0	0	0	0	0	0	0			1	0	0	0	0	0	0	f	0	0	0	
30	Ore Vein	3	1	brown	0	0	0	0	0	0	0	0			0	0	1	0	0	0	0	f	0	0	0	
31	Clay Pool	3	1	brown	0	0	0	0	0	0	0	0			0	1	0	0	0	0	0	f	0	0	0	
32	Stone Pit	3	1	brown	0	0	0	0	0	0	0	0			0	0	0	1	0	0	0	f	0	0	0	
33	Timber Yard	3	1	brown	0	0	0	0	0	0	0	0			1	0	0	1	0	0	0	t	0	0	0	
34	Clay Pit	3	1	brown	0	0	0	0	0	0	0	0			0	1	1	0	0	0	0	t	0	0	0	
35	Loom	3	1	grey	0	0	0	0	0	0	0	0			0	0	0	0	0	0	1	f	0	0	0	
36	Glassworks	3	1	grey	0	0	0	0	0	0	0	0			0	0	0	0	1	0	0	f	0	0	0	
37	Press	3	1	grey	0	0	0	0	0	0	0	0			0	0	0	0	0	1	0	f	0	0	0	
38	East Trading Post	3	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
39	West Trading Post	3	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
40	Marketplace	3	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
41	Altar	3	1	blue	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	2	0	0	
42	Theatre	3	1	blue	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	2	0	0	
43	Baths	3	1	blue	0	0	0	0	1	0	0	0			0	0	0	0	0	0	0	f	3	0	0	
44	Stockade	3	1	red	0	1	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	1	0	
45	Barracks	3	1	red	0	0	0	1	0	0	0	0			0	0	0	0	0	0	0	f	0	1	0	
46	Guard Tower	3	1	red	0	0	1	0	0	0	0	0			0	0	0	0	0	0	0	f	0	1	0	
47	Apothecary	3	1	green	0	0	0	0	0	0	0	1			0	0	0	0	0	0	0	f	0	0	0	compass
48	Workshop	3	1	green	0	0	0	0	0	1	0	0			0	0	0	0	0	0	0	f	0	0	0	cog
49	Scriptorium	3	1	green	0	0	0	0	0	0	1	0			0	0	0	0	0	0	0	f	0	0	0	tablet
50	Lumber Yard	4	1	brown	0	0	0	0	0	0	0	0			1	0	0	0	0	0	0	f	0	0	0	
51	Ore Vein	4	1	brown	0	0	0	0	0	0	0	0			0	0	1	0	0	0	0	f	0	0	0	
52	Excavation	4	1	brown	0	0	0	0	0	0	0	0			0	1	0	1	0	0	0	t	0	0	0	
53	Pawnshop	4	1	blue	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	3	0	0	
54	Tavern	4	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	5	
55	Guard Tower	4	1	red	0	0	1	0	0	0	0	0			0	0	0	0	0	0	0	f	0	1	0	
56	Scriptorium	4	1	green	0	0	0	0	0	0	1	0			0	0	0	0	0	0	0	f	0	0	0	tablet
57	Stone Pit	5	1	brown	0	0	0	0	0	0	0	0			0	0	0	1	0	0	0	f	0	0	0	
58	Clay Pool	5	1	brown	0	0	0	0	0	0	0	0			0	1	0	0	0	0	0	f	0	0	0	
59	Forest Cave	5	1	brown	0	0	0	0	0	0	0	0			1	0	1	0	0	0	0	t	0	0	0	
60	Altar	5	1	blue	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	2	0	0	
61	Tavern	5	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	5	
62	Barracks	5	1	red	0	0	0	1	0	0	0	0			0	0	0	0	0	0	0	f	0	1	0	
63	Apothecary	5	1	green	0	0	0	0	0	0	0	1			0	0	0	0	0	0	0	f	0	0	0	compass
64	Tree Farm	6	1	brown	0	0	0	0	0	0	0	0			1	1	0	0	0	0	0	t	0	0	0	
65	Mine	6	1	brown	0	0	0	0	0	0	0	0			0	0	1	1	0	0	0	t	0	0	0	
66	Loom	6	1	grey	0	0	0	0	0	0	0	0			0	0	0	0	0	0	1	f	0	0	0	
67	Glassworks	6	1	grey	0	0	0	0	0	0	0	0			0	0	0	0	1	0	0	f	0	0	0	
68	Press	6	1	grey	0	0	0	0	0	0	0	0			0	0	0	0	0	1	0	f	0	0	0	
69	Theatre	6	1	blue	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	2	0	0	
70	Marketplace	6	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
71	Pawnshop	7	1	blue	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	3	0	0	
72	Baths	7	1	blue	0	0	0	0	1	0	0	0			0	0	0	0	0	0	0	f	3	0	0	
73	Tavern	7	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	5	
74	East Trading Post	7	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
75	West Trading Post	7	1	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
76	Stockade	7	1	red	0	1	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	1	0	
77	Workshop	7	1	green	0	0	0	0	0	1	0	0			0	0	0	0	0	0	0	f	0	0	0	cog
78	Sawmill	3	2	brown	0	0	0	0	0	0	0	0			2	0	0	0	0	0	0	f	0	0	0	
79	Foundry	3	2	brown	0	0	0	0	0	0	0	0			0	0	2	0	0	0	0	f	0	0	0	
80	Brick Yard	3	2	brown	0	0	0	0	0	0	0	0			0	2	0	0	0	0	0	f	0	0	0	
81	Quarry	3	2	brown	0	0	0	0	0	0	0	0			0	0	0	2	0	0	0	f	0	0	0	
82	Loom	3	2	grey	0	0	0	0	0	0	0	0			0	0	0	0	0	0	1	f	0	0	0	
83	Glassworks	3	2	grey	0	0	0	0	0	0	0	0			0	0	0	0	1	0	0	f	0	0	0	
84	Press	3	2	grey	0	0	0	0	0	0	0	0			0	0	0	0	0	1	0	f	0	0	0	
85	Caravansery	3	2	yellow	0	2	0	0	0	0	0	0	Marketplace		1	1	1	1	0	0	0	t	0	0	0	
86	Forum	3	2	yellow	0	0	2	0	0	0	0	0	East Trading Post	West Trading Post	0	0	0	0	1	1	1	t	0	0	0	
87	Vineyard	3	2	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
88	Temple	3	2	blue	0	1	1	0	0	1	0	0	Altar		0	0	0	0	0	0	0	f	3	0	0	
89	Courthouse	3	2	blue	0	0	2	0	0	0	0	1	Scriptorium		0	0	0	0	0	0	0	f	4	0	0	
90	Statue	3	2	blue	0	1	0	2	0	0	0	0	Theatre		0	0	0	0	0	0	0	f	4	0	0	
91	Aqueduct	3	2	blue	0	0	0	0	3	0	0	0	Baths		0	0	0	0	0	0	0	f	5	0	0	
92	Stables	3	2	red	0	1	1	1	0	0	0	0	Apothecary		0	0	0	0	0	0	0	f	0	2	0	
93	Archery Range	3	2	red	0	2	0	1	0	0	0	0	Workshop		0	0	0	0	0	0	0	f	0	2	0	
94	Walls	3	2	red	0	0	0	0	3	0	0	0			0	0	0	0	0	0	0	f	0	2	0	
95	Library	3	2	green	0	0	0	0	2	0	0	1	Scriptorium		0	0	0	0	0	0	0	f	0	0	0	tablet
96	Laboratory	3	2	green	0	0	2	0	0	0	1	0	Workshop		0	0	0	0	0	0	0	f	0	0	0	cog
97	Dispensary	3	2	green	0	0	0	2	0	1	0	0	Apothecary		0	0	0	0	0	0	0	f	0	0	0	compass
98	School	3	2	green	0	1	0	0	0	0	1	0			0	0	0	0	0	0	0	f	0	0	0	tablet
99	Sawmill	4	2	brown	0	0	0	0	0	0	0	0			2	0	0	0	0	0	0	f	0	0	0	
100	Foundry	4	2	brown	0	0	0	0	0	0	0	0			0	0	2	0	0	0	0	f	0	0	0	
101	Brick Yard	4	2	brown	0	0	0	0	0	0	0	0			0	2	0	0	0	0	0	f	0	0	0	
102	Quarry	4	2	brown	0	0	0	0	0	0	0	0			0	0	0	2	0	0	0	f	0	0	0	
103	Bazaar	4	2	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
104	Training Ground	4	2	red	0	1	0	2	0	0	0	0			0	0	0	0	0	0	0	f	0	2	0	
105	Dispensary	4	2	green	0	0	0	2	0	1	0	0	Apothecary		0	0	0	0	0	0	0	f	0	0	0	compass
106	Loom	5	2	grey	0	0	0	0	0	0	0	0			0	0	0	0	0	0	1	f	0	0	0	
107	Glassworks	5	2	grey	0	0	0	0	0	0	0	0			0	0	0	0	1	0	0	f	0	0	0	
108	Press	5	2	grey	0	0	0	0	0	0	0	0			0	0	0	0	0	1	0	f	0	0	0	
109	Courthouse	5	2	blue	0	0	2	0	0	0	0	1	Scriptorium		0	0	0	0	0	0	0	f	4	0	0	
110	Caravansery	5	2	yellow	0	2	0	0	0	0	0	0	Marketplace		1	1	1	1	0	0	0	t	0	0	0	
111	Stables	5	2	red	0	1	1	1	0	0	0	0	Apothecary		0	0	0	0	0	0	0	f	0	2	0	
112	Laboratory	5	2	green	0	0	2	0	0	0	1	0	Workshop		0	0	0	0	0	0	0	f	0	0	0	cog
113	Temple	6	2	blue	0	1	1	0	0	1	0	0	Altar		0	0	0	0	0	0	0	f	3	0	0	
114	Forum	6	2	yellow	0	0	2	0	0	0	0	0	East Trading Post	West Trading Post	0	0	0	0	1	1	1	t	0	0	0	
115	Caravansery	6	2	yellow	0	2	0	0	0	0	0	0	Marketplace		1	1	1	1	0	0	0	t	0	0	0	
116	Vineyard	6	2	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
117	Training Ground	6	2	red	0	1	0	2	0	0	0	0			0	0	0	0	0	0	0	f	0	2	0	
118	Archery Range	6	2	red	0	2	0	1	0	0	0	0	Workshop		0	0	0	0	0	0	0	f	0	2	0	
119	Library	6	2	green	0	0	0	0	2	0	0	1	Scriptorium		0	0	0	0	0	0	0	f	0	0	0	tablet
120	Aqueduct	7	2	blue	0	0	0	0	3	0	0	0	Baths		0	0	0	0	0	0	0	f	5	0	0	
121	Statue	7	2	blue	0	1	0	2	0	0	0	0	Theatre		0	0	0	0	0	0	0	f	4	0	0	
122	Forum	7	2	yellow	0	0	2	0	0	0	0	0	East Trading Post	West Trading Post	0	0	0	0	1	1	1	t	0	0	0	
123	Bazaar	7	2	yellow	0	0	0	0	0	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
124	Walls	7	2	red	0	0	0	0	3	0	0	0			0	0	0	0	0	0	0	f	0	2	0	
125	Training Ground	7	2	red	0	1	0	2	0	0	0	0			0	0	0	0	0	0	0	f	0	2	0	
126	School	7	2	green	0	1	0	0	0	0	1	0			0	0	0	0	0	0	0	f	0	0	0	tablet
127	Gardens	3	3	blue	0	1	2	0	0	0	0	0	Statue		0	0	0	0	0	0	0	f	5	0	0	
128	Senate	3	3	blue	0	2	0	1	1	0	0	0	Library		0	0	0	0	0	0	0	f	6	0	0	
129	Town Hall	3	3	blue	0	0	0	1	2	1	0	0			0	0	0	0	0	0	0	f	6	0	0	
130	Pantheon	3	3	blue	0	0	2	1	0	1	1	1	Temple		0	0	0	0	0	0	0	f	7	0	0	
131	Palace	3	3	blue	0	1	1	1	1	1	1	1			0	0	0	0	0	0	0	f	8	0	0	
132	University	3	3	green	0	2	0	0	0	0	1	1	Library		0	0	0	0	0	0	0	f	0	0	0	tablet
133	Observatory	3	3	green	0	0	0	2	0	1	0	1	Laboratory		0	0	0	0	0	0	0	f	0	0	0	cog
134	Study	3	3	green	0	1	0	0	0	0	1	1	School		0	0	0	0	0	0	0	f	0	0	0	cog
135	Lodge	3	3	green	0	0	2	0	0	0	1	1	Dispensary		0	0	0	0	0	0	0	f	0	0	0	compass
136	Academy	3	3	green	0	0	0	0	3	1	0	0	School		0	0	0	0	0	0	0	f	0	0	0	compass
137	Siege Workshop	3	3	red	0	1	3	0	0	0	0	0	Laboratory		0	0	0	0	0	0	0	f	0	3	0	
138	Fortification	3	3	red	0	0	0	3	1	0	0	0	Walls		0	0	0	0	0	0	0	f	0	3	0	
139	Arsenal	3	3	red	0	2	0	1	0	0	0	1			0	0	0	0	0	0	0	f	0	3	0	
140	Arena	3	3	yellow	0	0	0	1	2	0	0	0	Dispensary		0	0	0	0	0	0	0	f	0	0	0	
141	Lighthouse	3	3	yellow	0	0	0	0	1	1	0	0	Caravansery		0	0	0	0	0	0	0	f	0	0	0	
142	Haven	3	3	yellow	0	1	0	1	0	0	0	1	Forum		0	0	0	0	0	0	0	f	0	0	0	
143	Gardens	4	3	blue	0	1	2	0	0	0	0	0	Statue		0	0	0	0	0	0	0	f	5	0	0	
144	Haven	4	3	yellow	0	1	0	1	0	0	0	1	Forum		0	0	0	0	0	0	0	f	0	0	0	
145	Chamber Of Commerce	4	3	yellow	0	0	2	0	0	0	1	0			0	0	0	0	0	0	0	f	0	0	0	
146	Circus	4	3	red	0	0	0	1	3	0	0	0	Training Ground		0	0	0	0	0	0	0	f	0	3	0	
147	Arsenal	4	3	red	0	2	0	1	0	0	0	1			0	0	0	0	0	0	0	f	0	3	0	
148	University	4	3	green	0	2	0	0	0	0	1	1	Library		0	0	0	0	0	0	0	f	0	0	0	tablet
149	Town Hall	5	3	blue	0	0	0	1	2	1	0	0			0	0	0	0	0	0	0	f	6	0	0	
150	Senate	5	3	blue	0	2	0	1	1	0	0	0	Library		0	0	0	0	0	0	0	f	6	0	0	
151	Arena	5	3	yellow	0	0	0	1	2	0	0	0	Dispensary		0	0	0	0	0	0	0	f	0	0	0	
152	Circus	5	3	red	0	0	0	1	3	0	0	0	Training Ground		0	0	0	0	0	0	0	f	0	3	0	
153	Siege Workshop	5	3	red	0	1	3	0	0	0	0	0	Laboratory		0	0	0	0	0	0	0	f	0	3	0	
154	Study	5	3	green	0	1	0	0	0	0	1	1	School		0	0	0	0	0	0	0	f	0	0	0	cog
155	Pantheon	6	3	blue	0	0	2	1	0	1	1	1	Temple		0	0	0	0	0	0	0	f	7	0	0	
156	Town Hall	6	3	blue	0	0	0	1	2	1	0	0			0	0	0	0	0	0	0	f	6	0	0	
157	Lighthouse	6	3	yellow	0	0	0	0	1	1	0	0	Caravansery		0	0	0	0	0	0	0	f	0	0	0	
158	Chamber Of Commerce	6	3	yellow	0	0	2	0	0	0	1	0			0	0	0	0	0	0	0	f	0	0	0	
159	Circus	6	3	red	0	0	0	1	3	0	0	0	Training Ground		0	0	0	0	0	0	0	f	0	3	0	
160	Lodge	6	3	green	0	0	2	0	0	0	1	1	Dispensary		0	0	0	0	0	0	0	f	0	0	0	compass
161	Palace	7	3	blue	0	1	1	1	1	1	1	1			0	0	0	0	0	0	0	f	8	0	0	
162	Arena	7	3	yellow	0	0	0	1	2	0	0	0	Dispensary		0	0	0	0	0	0	0	f	0	0	0	
163	Fortification	7	3	red	0	0	0	3	1	0	0	0	Walls		0	0	0	0	0	0	0	f	0	3	0	
164	Arsenal	7	3	red	0	2	0	1	0	0	0	1			0	0	0	0	0	0	0	f	0	3	0	
165	Observatory	7	3	green	0	0	0	2	0	1	0	1	Laboratory		0	0	0	0	0	0	0	f	0	0	0	cog
166	Academy	7	3	green	0	0	0	0	3	1	0	0	School		0	0	0	0	0	0	0	f	0	0	0	compass
167	Workers Guild	0	3	purple	0	1	1	2	1	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
168	Craftsmens Guild	0	3	purple	0	0	0	2	2	0	0	0			0	0	0	0	0	0	0	f	0	0	0	
169	Shipowners Guild	0	3	purple	0	3	0	0	0	1	1	0			0	0	0	0	0	0	0	f	0	0	0	
170	Traders Guild	0	3	purple	0	0	0	0	0	1	1	1			0	0	0	0	0	0	0	f	0	0	0	
171	Magistrates Guild	0	3	purple	0	3	0	0	1	0	0	1			0	0	0	0	0	0	0	f	0	0	0	
172	Builders Guild	0	3	purple	0	0	2	0	2	1	0	0			0	0	0	0	0	0	0	f	0	0	0	
173	Philosophers Guild	0	3	purple	0	0	3	0	0	0	1	1			0	0	0	0	0	0	0	f	0	0	0	
174	Scientists Guild	0	3	purple	0	2	0	2	0	0	1	0			0	0	0	0	0	0	0	f	0	0	0	
175	Spies Guild	0	3	purple	0	0	3	0	0	1	0	0			0	0	0	0	0	0	0	f	0	0	0	
176	Strategists Guild	0	3	purple	0	0	0	2	1	0	0	1			0	0	0	0	0	0	0	f	0	0	0	
\.


--
-- Name: card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('card_id_seq', 176, true);


--
-- Data for Name: cardhist; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY cardhist (id, "playerId", "cardId", discarded, for_wonder) FROM stdin;
1	1	25	f	t
2	2	6	f	t
3	3	18	f	t
4	4	1	f	t
5	5	25	f	t
6	6	22	f	t
7	6	33	f	f
8	4	29	t	f
9	9	10	f	t
10	8	14	f	t
11	7	25	f	t
12	7	29	f	f
13	9	32	f	f
14	12	1	f	t
15	11	10	f	t
16	10	14	f	t
17	10	35	f	f
18	12	29	f	f
19	14	14	f	t
20	13	22	f	t
21	15	6	f	t
22	15	32	f	f
23	14	34	f	f
24	13	29	f	f
25	15	33	f	f
26	14	35	f	f
27	13	30	f	f
28	15	38	f	f
29	14	37	f	f
30	13	31	f	f
31	13	36	f	f
32	14	39	f	f
33	15	41	f	f
34	15	45	f	f
35	14	42	f	f
36	13	40	f	f
37	15	48	f	f
38	14	44	f	f
39	13	43	t	f
40	14	82	f	f
41	13	81	f	f
42	15	78	t	f
43	13	85	t	f
44	14	84	t	f
45	15	79	f	f
46	13	96	f	f
47	14	97	f	f
48	15	80	f	f
49	13	87	f	f
50	14	88	f	f
51	15	83	f	f
52	13	92	f	f
53	14	89	t	f
54	15	86	t	f
55	13	93	f	f
56	14	91	f	f
57	15	90	t	f
58	15	130	f	f
59	14	127	f	f
60	13	132	f	f
61	15	131	f	f
62	14	129	f	f
63	13	133	f	f
64	15	137	t	f
65	14	135	t	f
66	13	136	t	f
67	15	142	f	f
68	14	141	f	f
69	13	172	f	f
70	15	167	t	f
71	14	174	t	f
72	13	176	t	f
73	15	171	f	f
74	14	138	f	f
75	13	140	f	f
\.


--
-- Name: cardhist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('cardhist_id_seq', 75, true);


--
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY game (id, age, round, started, complete) FROM stdin;
1	1	1	t	t
2	1	1	t	t
3	1	1	t	t
4	1	1	t	t
5	3	6	t	f
\.


--
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('game_id_seq', 5, true);


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY player (id, "gameId", "userId", ready, left_id, right_id, wonder, wonder_level, max_wonder, wood, brick, ore, stone, glass, paper, cloth, points, military, money, cog, tablet, compass, wildcard, extra_wood, extra_brick, extra_ore, extra_stone, extra_glass, extra_paper, extra_cloth, military_loss) FROM stdin;
7	3	3	t	8	9	The Hanging Gardens of Babylon	0	3	1	1	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0
9	3	2	t	7	8	The Statue of Zeus in Olympia	0	3	1	0	0	1	0	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0
1	1	1	t	3	2	The Hanging Gardens of Babylon	0	3	0	1	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	\N
15	5	3	t	13	14	The Lighthouse of Alexandria	0	3	0	2	2	1	2	0	0	18	1	18	1	0	0	0	1	0	0	1	0	0	0	1
2	1	3	t	1	3	The Lighthouse of Alexandria	0	3	0	0	0	0	1	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	\N
3	1	2	t	2	1	The Mausoleum of Halicarnassus	0	3	0	0	0	0	0	0	1	0	0	3	0	0	0	0	0	0	0	0	0	0	0	\N
13	5	2	t	14	15	The Colossus of Rhodes	0	2	1	1	2	2	1	0	0	9	4	15	2	1	0	0	0	0	0	0	0	0	0	2
14	5	6	t	15	13	The Temple of Artemis in Ephesus	0	3	0	0	0	0	0	2	2	22	4	15	0	0	1	0	0	1	1	0	0	0	0	1
11	4	6	t	12	10	The Statue of Zeus in Olympia	0	3	1	0	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0
5	2	5	t	4	6	The Hanging Gardens of Babylon	0	3	0	1	0	0	0	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	\N
10	4	3	t	11	12	The Temple of Artemis in Ephesus	0	3	0	0	0	0	0	1	1	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0
12	4	2	t	10	11	The Pyramids of Giza	0	4	1	0	0	1	0	0	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0
6	2	6	t	5	4	The Colossus of Rhodes	0	2	0	0	1	0	0	0	0	0	0	3	0	0	0	0	1	0	0	1	0	0	0	\N
4	2	4	t	6	5	The Pyramids of Giza	0	4	0	0	0	1	0	0	0	0	0	6	0	0	0	0	0	0	0	0	0	0	0	\N
8	3	6	t	9	7	The Temple of Artemis in Ephesus	0	3	0	0	0	0	0	1	0	0	0	3	0	0	0	0	0	0	0	0	0	0	0	0
\.


--
-- Name: player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('player_id_seq', 15, true);


--
-- Data for Name: round; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY round (id, age, round, "playerId", "cardId") FROM stdin;
1	1	1	1	34
2	1	1	1	36
3	1	1	1	33
4	1	1	1	45
5	1	1	1	32
6	1	1	1	40
7	1	1	1	44
8	1	1	2	29
9	1	1	2	48
10	1	1	2	47
11	1	1	2	46
12	1	1	2	39
13	1	1	2	31
14	1	1	2	37
15	1	1	3	38
16	1	1	3	49
17	1	1	3	42
18	1	1	3	43
19	1	1	3	35
20	1	1	3	41
21	1	1	3	30
22	1	1	4	29
23	1	1	4	40
24	1	1	4	49
25	1	1	4	48
26	1	1	4	34
27	1	1	4	31
28	1	1	4	39
29	1	1	5	41
30	1	1	5	30
31	1	1	5	44
32	1	1	5	43
33	1	1	5	37
34	1	1	5	36
35	1	1	5	32
36	1	1	6	38
37	1	1	6	47
38	1	1	6	46
39	1	1	6	35
40	1	1	6	45
41	1	1	6	33
42	1	1	6	42
43	1	2	5	38
44	1	2	5	47
45	1	2	5	46
46	1	2	5	35
47	1	2	5	45
48	1	2	5	42
49	1	2	6	40
50	1	2	6	49
51	1	2	6	48
52	1	2	6	34
53	1	2	6	31
54	1	2	6	39
55	1	1	9	32
56	1	1	9	35
57	1	1	9	37
58	1	1	9	48
59	1	1	9	39
60	1	1	9	47
61	1	1	9	44
62	1	1	8	45
63	1	1	8	43
64	1	1	8	42
65	1	1	8	36
66	1	1	8	46
67	1	1	8	33
68	1	1	8	31
69	1	1	7	29
70	1	1	7	38
71	1	1	7	34
72	1	1	7	41
73	1	1	7	49
74	1	1	7	40
75	1	1	7	30
76	1	2	8	38
77	1	2	8	34
78	1	2	8	41
79	1	2	8	49
80	1	2	8	40
81	1	2	8	30
82	1	2	7	35
83	1	2	7	37
84	1	2	7	48
85	1	2	7	39
86	1	2	7	47
87	1	2	7	44
88	1	1	12	33
89	1	1	12	46
90	1	1	12	44
91	1	1	12	34
92	1	1	12	29
93	1	1	12	48
94	1	1	12	43
95	1	1	11	40
96	1	1	11	41
97	1	1	11	31
98	1	1	11	39
99	1	1	11	30
100	1	1	11	38
101	1	1	11	32
102	1	1	10	47
103	1	1	10	42
104	1	1	10	36
105	1	1	10	37
106	1	1	10	49
107	1	1	10	45
108	1	1	10	35
109	1	2	11	47
110	1	2	11	42
111	1	2	11	36
112	1	2	11	37
113	1	2	11	49
114	1	2	11	45
115	1	2	10	33
116	1	2	10	46
117	1	2	10	44
118	1	2	10	34
119	1	2	10	48
120	1	2	10	43
121	1	1	14	42
122	1	1	14	44
123	1	1	14	39
124	1	1	14	34
125	1	1	14	35
126	1	1	14	37
127	1	1	14	47
128	1	1	13	43
129	1	1	13	36
130	1	1	13	40
131	1	1	13	46
132	1	1	13	31
133	1	1	13	29
134	1	1	13	30
135	1	1	15	48
136	1	1	15	41
137	1	1	15	49
138	1	1	15	38
139	1	1	15	45
140	1	1	15	32
141	1	1	15	33
142	1	2	15	48
143	1	2	15	41
144	1	2	15	49
145	1	2	15	38
146	1	2	15	45
147	1	2	15	33
148	1	2	14	42
149	1	2	14	44
150	1	2	14	39
151	1	2	14	35
152	1	2	14	37
153	1	2	14	47
154	1	2	13	43
155	1	2	13	36
156	1	2	13	40
157	1	2	13	46
158	1	2	13	31
159	1	2	13	30
160	1	3	15	48
161	1	3	15	41
162	1	3	15	49
163	1	3	15	38
164	1	3	15	45
165	1	3	14	42
166	1	3	14	44
167	1	3	14	39
168	1	3	14	37
169	1	3	14	47
170	1	3	13	43
171	1	3	13	36
172	1	3	13	40
173	1	3	13	46
174	1	3	13	31
175	1	4	15	48
176	1	4	15	41
177	1	4	15	49
178	1	4	15	45
179	1	4	14	42
180	1	4	14	44
181	1	4	14	39
182	1	4	14	47
183	1	4	13	43
184	1	4	13	36
185	1	4	13	40
186	1	4	13	46
187	1	5	13	43
188	1	5	13	40
189	1	5	13	46
190	1	5	14	42
191	1	5	14	44
192	1	5	14	47
193	1	5	15	48
194	1	5	15	49
195	1	5	15	45
196	1	6	15	48
197	1	6	15	49
198	1	6	14	44
199	1	6	14	47
200	1	6	13	43
201	1	6	13	46
202	1	7	15	49
203	1	7	14	47
204	1	7	13	46
205	2	1	15	79
206	2	1	15	83
207	2	1	15	86
208	2	1	15	94
209	2	1	15	90
210	2	1	15	78
211	2	1	15	80
212	2	1	14	91
213	2	1	14	84
214	2	1	14	89
215	2	1	14	88
216	2	1	14	97
217	2	1	14	82
218	2	1	14	98
219	2	1	13	85
220	2	1	13	92
221	2	1	13	81
222	2	1	13	87
223	2	1	13	93
224	2	1	13	96
225	2	1	13	95
226	2	2	14	91
227	2	2	14	84
228	2	2	14	89
229	2	2	14	88
230	2	2	14	97
231	2	2	14	98
232	2	2	13	85
233	2	2	13	92
234	2	2	13	87
235	2	2	13	93
236	2	2	13	96
237	2	2	13	95
238	2	2	15	79
239	2	2	15	83
240	2	2	15	86
241	2	2	15	94
242	2	2	15	90
243	2	2	15	80
244	2	3	13	92
245	2	3	13	87
246	2	3	13	93
247	2	3	13	96
248	2	3	13	95
249	2	3	14	91
250	2	3	14	89
251	2	3	14	88
252	2	3	14	97
253	2	3	14	98
254	2	3	15	83
255	2	3	15	86
256	2	3	15	94
257	2	3	15	90
258	2	3	15	80
259	2	4	13	92
260	2	4	13	87
261	2	4	13	93
262	2	4	13	95
263	2	4	14	91
264	2	4	14	89
265	2	4	14	88
266	2	4	14	98
267	2	4	15	83
268	2	4	15	86
269	2	4	15	94
270	2	4	15	90
271	2	5	13	92
272	2	5	13	93
273	2	5	13	95
274	2	5	14	91
275	2	5	14	89
276	2	5	14	98
277	2	5	15	86
278	2	5	15	94
279	2	5	15	90
280	2	6	13	93
281	2	6	13	95
282	2	6	14	91
283	2	6	14	98
284	2	6	15	94
285	2	6	15	90
286	2	7	13	95
287	2	7	14	98
288	2	7	15	94
289	3	1	13	132
290	3	1	13	176
291	3	1	13	136
292	3	1	13	133
293	3	1	13	140
294	3	1	13	172
295	3	1	13	170
296	3	1	14	174
297	3	1	14	141
298	3	1	14	138
299	3	1	14	129
300	3	1	14	127
301	3	1	14	135
302	3	1	14	139
303	3	1	15	171
304	3	1	15	137
305	3	1	15	131
306	3	1	15	142
307	3	1	15	167
308	3	1	15	173
309	3	1	15	130
310	3	2	15	171
311	3	2	15	137
312	3	2	15	131
313	3	2	15	142
314	3	2	15	167
315	3	2	15	173
316	3	2	14	174
317	3	2	14	141
318	3	2	14	138
319	3	2	14	129
320	3	2	14	135
321	3	2	14	139
322	3	2	13	176
323	3	2	13	136
324	3	2	13	133
325	3	2	13	140
326	3	2	13	172
327	3	2	13	170
328	3	3	15	171
329	3	3	15	137
330	3	3	15	142
331	3	3	15	167
332	3	3	15	173
333	3	3	14	174
334	3	3	14	141
335	3	3	14	138
336	3	3	14	135
337	3	3	14	139
338	3	3	13	176
339	3	3	13	136
340	3	3	13	140
341	3	3	13	172
342	3	3	13	170
343	3	4	15	171
344	3	4	15	142
345	3	4	15	167
346	3	4	15	173
347	3	4	14	174
348	3	4	14	141
349	3	4	14	138
350	3	4	14	139
351	3	4	13	176
352	3	4	13	140
353	3	4	13	172
354	3	4	13	170
355	3	5	15	171
356	3	5	15	167
357	3	5	15	173
358	3	5	14	174
359	3	5	14	138
360	3	5	14	139
361	3	5	13	176
362	3	5	13	140
363	3	5	13	170
364	3	6	15	171
365	3	6	15	173
366	3	6	14	138
367	3	6	14	139
368	3	6	13	140
369	3	6	13	170
370	3	7	15	173
371	3	7	14	139
372	3	7	13	170
\.


--
-- Name: round_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('round_id_seq', 372, true);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY "user" (id, email, password) FROM stdin;
1	1@1.com	$2b$12$/8jIN/XkSg5BZ/GExNAt.euwxpz3mXjhpMlbMdyIyXj1inkmQAlVS
2	2@2.com	$2b$12$72fDpsEVZG/lAwL7a5zst.bus5q8ua2zSKWVJuLcPEgXipL7nWOCe
3	mitchell.m.donaldson@gmail.com	$2b$12$56CjqQq2uUIUrOfqIPYy9uL1eBtFXEXEmCvEnWDHJERCmbKKXKuea
4	6@6.cpm	$2b$12$kifHRDSwN9vnHSrMRRP/6uo2mKcoGXWJGjCGGUqAGd3ky48Whig5u
5	7@7.com	$2b$12$p0yGGScVuvZwb.Fy2k6otO3zmHRqQHtMaUyf5qBlLfJjNhzoduTJK
6	8@8.com	$2b$12$j5tlp2DW87G.Fj4haqUQ1uR.XTqtYPfE6Z/Uj7q.noSUNdAeU.o0S
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('user_id_seq', 6, true);


--
-- Data for Name: wonder; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY wonder (id, name, slots, card_0, card_1, card_2, card_3, card_4) FROM stdin;
1	The Pyramids of Giza	4	giza_0	giza_1	giza_2	giza_3	giza_4
2	The Lighthouse of Alexandria	3	alex_0	alex_1	alex_2	alex_3	
3	The Statue of Zeus in Olympia	3	zeus_0	zeus_1	zeus_2	zeus_3	
4	The Temple of Artemis in Ephesus	3	ephesus_0	ephesus_1	ephesus_2	ephesus_3	
5	The Mausoleum of Halicarnassus	3	hali_0	hali_1	hali_2	hali_3	
6	The Colossus of Rhodes	2	rhodes_0	rhodes_1	rhodes_2		
7	The Hanging Gardens of Babylon	3	babylon_0	babylon_1	babylon_2	babylon_3	
\.


--
-- Name: wonder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('wonder_id_seq', 7, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: card card_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY card
    ADD CONSTRAINT card_pkey PRIMARY KEY (id);


--
-- Name: cardhist cardhist_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cardhist
    ADD CONSTRAINT cardhist_pkey PRIMARY KEY (id);


--
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_pkey PRIMARY KEY (id);


--
-- Name: round round_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY round
    ADD CONSTRAINT round_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: wonder wonder_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY wonder
    ADD CONSTRAINT wonder_pkey PRIMARY KEY (id);


--
-- Name: cardhist cardhist_cardId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cardhist
    ADD CONSTRAINT "cardhist_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES card(id);


--
-- Name: cardhist cardhist_playerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY cardhist
    ADD CONSTRAINT "cardhist_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES player(id);


--
-- Name: player player_gameId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY player
    ADD CONSTRAINT "player_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES game(id);


--
-- Name: player player_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY player
    ADD CONSTRAINT "player_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"(id);


--
-- Name: round round_cardId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY round
    ADD CONSTRAINT "round_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES card(id);


--
-- Name: round round_playerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY round
    ADD CONSTRAINT "round_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES player(id);


--
-- PostgreSQL database dump complete
--

