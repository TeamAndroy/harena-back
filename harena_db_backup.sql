--
-- PostgreSQL database dump
--

\restrict bZ12X4dQo30iLiRlBU2jd4AUZ9KtWN49f5Td27LumbkQZegIkgQG6NkSFZsTJ0f

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS harena_db;
--
-- Name: harena_db; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE harena_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


\unrestrict bZ12X4dQo30iLiRlBU2jd4AUZ9KtWN49f5Td27LumbkQZegIkgQG6NkSFZsTJ0f
\connect harena_db
\restrict bZ12X4dQo30iLiRlBU2jd4AUZ9KtWN49f5Td27LumbkQZegIkgQG6NkSFZsTJ0f

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    archived boolean DEFAULT false NOT NULL
);


--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id integer NOT NULL,
    "entrepriseId" integer DEFAULT 0 NOT NULL,
    name character varying NOT NULL,
    phone character varying,
    email character varying,
    address character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    archived boolean DEFAULT false NOT NULL
);


--
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- Name: entreprise; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entreprise (
    id integer NOT NULL,
    name character varying NOT NULL,
    "managerName" character varying NOT NULL,
    email character varying NOT NULL,
    phone character varying NOT NULL,
    activity character varying NOT NULL,
    "teamSize" character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: entreprise_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.entreprise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entreprise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.entreprise_id_seq OWNED BY public.entreprise.id;


--
-- Name: expense; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.expense (
    id integer NOT NULL,
    "entrepriseId" integer DEFAULT 0 NOT NULL,
    label character varying NOT NULL,
    description character varying,
    amount numeric(15,2) NOT NULL,
    category character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    archived boolean DEFAULT false NOT NULL
);


--
-- Name: expense_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.expense_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: expense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.expense_id_seq OWNED BY public.expense.id;


--
-- Name: payment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    amount numeric(15,2) NOT NULL,
    method character varying DEFAULT 'cash'::character varying NOT NULL,
    reference character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "saleId" integer
);


--
-- Name: payment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    image text,
    "buyPrice" numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    "sellPrice" numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    "entrepriseId" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "categoryId" integer,
    "unitId" integer,
    archived boolean DEFAULT false NOT NULL
);


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: purchase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase (
    id integer NOT NULL,
    "entrepriseId" integer DEFAULT 0 NOT NULL,
    reference character varying NOT NULL,
    supplier character varying,
    "totalAmount" numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    "totalPaid" numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    "paymentStatus" character varying DEFAULT 'pending'::character varying NOT NULL,
    notes character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    archived boolean DEFAULT false NOT NULL
);


--
-- Name: purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.purchase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.purchase_id_seq OWNED BY public.purchase.id;


--
-- Name: purchase_line; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.purchase_line (
    id integer NOT NULL,
    quantity integer NOT NULL,
    "unitPrice" numeric(15,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    "purchaseId" integer,
    "productId" integer
);


--
-- Name: purchase_line_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.purchase_line_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: purchase_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.purchase_line_id_seq OWNED BY public.purchase_line.id;


--
-- Name: sale; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale (
    id integer NOT NULL,
    "entrepriseId" integer DEFAULT 0 NOT NULL,
    reference character varying NOT NULL,
    notes character varying,
    "totalAmount" numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    "totalPaid" numeric(15,2) DEFAULT '0'::numeric NOT NULL,
    "paymentStatus" character varying DEFAULT 'pending'::character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "clientId" integer,
    archived boolean DEFAULT false NOT NULL
);


--
-- Name: sale_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sale_id_seq OWNED BY public.sale.id;


--
-- Name: sale_line; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale_line (
    id integer NOT NULL,
    quantity integer NOT NULL,
    "unitPrice" numeric(15,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    "saleId" integer,
    "productId" integer
);


--
-- Name: sale_line_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sale_line_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sale_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sale_line_id_seq OWNED BY public.sale_line.id;


--
-- Name: unit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unit (
    id integer NOT NULL,
    "entrepriseId" integer DEFAULT 0 NOT NULL,
    name character varying NOT NULL,
    abbreviation character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    archived boolean DEFAULT false NOT NULL
);


--
-- Name: unit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unit_id_seq OWNED BY public.unit.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    role character varying DEFAULT 'admin'::character varying NOT NULL,
    "fullName" character varying,
    "entrepriseId" integer,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: client id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- Name: entreprise id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entreprise ALTER COLUMN id SET DEFAULT nextval('public.entreprise_id_seq'::regclass);


--
-- Name: expense id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expense ALTER COLUMN id SET DEFAULT nextval('public.expense_id_seq'::regclass);


--
-- Name: payment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: purchase id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase ALTER COLUMN id SET DEFAULT nextval('public.purchase_id_seq'::regclass);


--
-- Name: purchase_line id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_line ALTER COLUMN id SET DEFAULT nextval('public.purchase_line_id_seq'::regclass);


--
-- Name: sale id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale ALTER COLUMN id SET DEFAULT nextval('public.sale_id_seq'::regclass);


--
-- Name: sale_line id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_line ALTER COLUMN id SET DEFAULT nextval('public.sale_line_id_seq'::regclass);


--
-- Name: unit id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit ALTER COLUMN id SET DEFAULT nextval('public.unit_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category (id, name, description, "createdAt", archived) FROM stdin;
1	Général	Catégorie générale	2026-04-01 12:44:39.584769	f
2	Chaussures	Chaussures générée automatiquement	2026-04-02 11:40:29.288441	f
3	Électronique	Électronique générée automatiquement	2026-04-02 11:40:29.288441	f
4	Accessoires	Accessoires générée automatiquement	2026-04-02 11:40:29.288441	f
5	Wearables	Wearables générée automatiquement	2026-04-02 11:40:29.288441	f
6	Audio	Audio générée automatiquement	2026-04-02 11:40:29.288441	f
7	Informatique	Informatique générée automatiquement	2026-04-02 11:40:29.288441	f
8	Mode	Mode générée automatiquement	2026-04-02 11:40:29.288441	f
9	Maison	Maison générée automatiquement	2026-04-02 11:40:29.288441	f
10	Électroménager	Électroménager générée automatiquement	2026-04-02 11:40:29.288441	f
11	Sport	Sport générée automatiquement	2026-04-02 11:40:29.288441	f
12	Beauté	Beauté générée automatiquement	2026-04-02 11:40:29.288441	f
13	Hygiène	Hygiène générée automatiquement	2026-04-02 11:40:29.288441	f
14	Alimentaire & Epicerie	Alimentaire & Epicerie générée automatiquement	2026-04-02 13:00:32.201267	f
15	Textile & Mode	Textile & Mode générée automatiquement	2026-04-02 13:00:32.201267	f
16	Bijoux & Accessoires	Bijoux & Accessoires générée automatiquement	2026-04-02 13:00:32.201267	f
17	Café & Thé	Café & Thé générée automatiquement	2026-04-02 13:00:32.201267	f
18	Agriculture & Nature	Agriculture & Nature générée automatiquement	2026-04-02 13:00:32.201267	f
19	Artisanat & Déco	Artisanat & Déco générée automatiquement	2026-04-02 13:00:32.201267	f
20	Musique & Art	Musique & Art générée automatiquement	2026-04-02 13:00:32.201267	f
21	Tourisme & Loisirs	Tourisme & Loisirs générée automatiquement	2026-04-02 13:00:32.201267	f
22	Cosmétique & Bien-être	Cosmétique & Bien-être générée automatiquement	2026-04-02 13:00:32.201267	f
23	Épices & Aromates	Épices & Aromates générée automatiquement	2026-04-02 13:00:32.201267	f
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, "entrepriseId", name, phone, email, address, "createdAt", archived) FROM stdin;
1	1	Mr Moussa	0331454787		Andavamamba	2026-04-02 09:03:07.166658	f
2	1	Sambiavy	0345587412		Toamasina I	2026-04-02 10:52:30.197736	f
\.


--
-- Data for Name: entreprise; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.entreprise (id, name, "managerName", email, phone, activity, "teamSize", "createdAt") FROM stdin;
1	Mara Corporation	Mara Sambelahatse	smara@teste.com	0330438883	Commerciale	6-20	2026-04-01 13:15:41.455001
\.


--
-- Data for Name: expense; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.expense (id, "entrepriseId", label, description, amount, category, "createdAt", archived) FROM stdin;
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment (id, amount, method, reference, "createdAt", "saleId") FROM stdin;
1	7500.00	cash		2026-04-02 09:06:52.926302	1
2	4000000.00	cash		2026-04-02 09:21:49.544472	2
4	1185000.00	transfer		2026-04-02 12:54:17.194895	4
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product (id, name, description, image, "buyPrice", "sellPrice", stock, "entrepriseId", "createdAt", "categoryId", "unitId", archived) FROM stdin;
1	Java	Java product	data:image/jpeg;base64,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	1200.00	1500.00	28	1	2026-04-02 09:04:57.06539	1	4	t
3	Chaussures running Nike style	Chaussures de sport légères adaptées au running quotidien.	https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80	120000.00	180000.00	0	0	2026-04-02 11:40:29.35029	2	\N	f
4	Smartphone Android 128GB	Smartphone performant avec écran HD et grande autonomie.	https://images.unsplash.com/photo-1511707171634-5f897ff02aa9	800000.00	1200000.00	0	0	2026-04-02 11:40:29.381602	3	\N	f
5	Télévision LED 43 pouces	TV écran plat avec résolution Full HD.	https://images.unsplash.com/photo-1593784991095-a205069470b6	1800000.00	2500000.00	0	0	2026-04-02 11:40:29.406376	3	\N	f
6	Sac à dos ordinateur	Sac robuste avec compartiment laptop.	https://images.unsplash.com/photo-1553062407-98eeb64c6a62	50000.00	90000.00	0	0	2026-04-02 11:40:29.436297	4	\N	f
34	Smartphone Android 128GB	Smartphone performant avec écran HD et grande autonomie.	https://images.unsplash.com/photo-1511707171634-5f897ff02aa9	800000.00	1200000.00	0	1	2026-04-02 11:47:57.779177	3	\N	f
7	Montre connectée	Montre intelligente avec suivi de santé.	https://images.unsplash.com/photo-1511732351157-1865efcb7b7b	220000.00	350000.00	0	0	2026-04-02 11:40:29.468233	5	\N	f
8	Casque Bluetooth	Casque sans fil avec réduction de bruit.	https://images.unsplash.com/photo-1518444065439-e933c06ce9cd	70000.00	120000.00	0	0	2026-04-02 11:40:29.515853	6	\N	f
9	Ordinateur portable 15 pouces	Laptop performant pour travail et études.	https://images.unsplash.com/photo-1517336714731-489689fd1ca8	1500000.00	2100000.00	0	0	2026-04-02 11:40:29.553387	7	\N	f
10	Clavier mécanique RGB	Clavier gamer avec rétroéclairage RGB.	https://images.unsplash.com/photo-1518770660439-4636190af475	90000.00	150000.00	0	0	2026-04-02 11:40:29.578148	7	\N	f
11	Souris gaming	Souris ergonomique haute précision.	https://images.unsplash.com/photo-1587829741301-dc798b83add3	40000.00	80000.00	0	0	2026-04-02 11:40:29.602689	7	\N	f
12	Power bank 20000mAh	Batterie externe grande capacité.	https://images.unsplash.com/photo-1585386959984-a4155224a1ad	50000.00	85000.00	0	0	2026-04-02 11:40:29.616822	4	\N	f
13	T-shirt coton	T-shirt confortable en coton.	https://images.unsplash.com/photo-1523381210434-271e8be1f52b	15000.00	30000.00	0	0	2026-04-02 11:40:29.630849	8	\N	f
14	Jean homme	Jean durable coupe moderne.	https://images.unsplash.com/photo-1541099649105-f69ad21f3246	40000.00	80000.00	0	0	2026-04-02 11:40:29.645031	8	\N	f
15	Chaussures casual	Chaussures stylées pour usage quotidien.	https://images.unsplash.com/photo-1528701800489-20be3c1f6b7b	60000.00	110000.00	0	0	2026-04-02 11:40:29.656339	8	\N	f
16	Lunettes de soleil	Protection UV avec design moderne.	https://images.unsplash.com/photo-1511499767150-a48a237f0083	20000.00	45000.00	0	0	2026-04-02 11:40:29.675877	4	\N	f
17	Casquette	Casquette légère et respirante.	https://images.unsplash.com/photo-1521369909029-2afed882baee	10000.00	25000.00	0	0	2026-04-02 11:40:29.690443	8	\N	f
18	Chaise bureau	Chaise ergonomique pour bureau.	https://images.unsplash.com/photo-1586023492125-27b2c045efd7	120000.00	200000.00	0	0	2026-04-02 11:40:29.707112	9	\N	f
19	Table en bois	Table solide en bois naturel.	https://images.unsplash.com/photo-1505693416388-ac5ce068fe85	200000.00	350000.00	0	0	2026-04-02 11:40:29.717915	9	\N	f
20	Lampe LED	Lampe moderne basse consommation.	https://images.unsplash.com/photo-1507473885765-e6ed057f782c	25000.00	60000.00	0	0	2026-04-02 11:40:29.736842	9	\N	f
21	Mixeur électrique	Mixeur puissant pour cuisine.	https://images.unsplash.com/photo-1586201375761-83865001e31c	70000.00	120000.00	0	0	2026-04-02 11:40:29.747252	10	\N	f
22	Bouilloire électrique	Bouilloire rapide et efficace.	https://images.unsplash.com/photo-1606813909353-3b3d3f4b4c1a	30000.00	70000.00	0	0	2026-04-02 11:40:29.763603	10	\N	f
23	Ballon de football	Ballon résistant pour terrain.	https://images.unsplash.com/photo-1517649763962-0c623066013b	20000.00	45000.00	0	0	2026-04-02 11:40:29.773964	11	\N	f
24	Tapis de yoga	Tapis antidérapant fitness.	https://images.unsplash.com/photo-1554306274-f23873d9a26c	30000.00	60000.00	0	0	2026-04-02 11:40:29.79374	11	\N	f
25	Haltères fitness	Poids pour entraînement musculaire.	https://images.unsplash.com/photo-1599058917765-a780eda07a3e	50000.00	90000.00	0	0	2026-04-02 11:40:29.80643	11	\N	f
26	Bouteille isotherme	Garde boissons chaudes/froides.	https://images.unsplash.com/photo-1526401485004-2fa806b6f3b1	15000.00	35000.00	0	0	2026-04-02 11:40:29.82284	11	\N	f
27	Sac de sport	Sac spacieux pour activités sportives.	https://images.unsplash.com/photo-1517836357463-d25dfeac3438	40000.00	80000.00	0	0	2026-04-02 11:40:29.831884	11	\N	f
28	Parfum homme	Parfum longue durée.	https://images.unsplash.com/photo-1541643600914-78b084683601	60000.00	120000.00	0	0	2026-04-02 11:40:29.84958	12	\N	f
29	Crème visage	Crème hydratante peau.	https://images.unsplash.com/photo-1556228578-0d85b1a4d571	20000.00	50000.00	0	0	2026-04-02 11:40:29.861542	12	\N	f
30	Shampooing	Shampooing nourrissant.	https://images.unsplash.com/photo-1585238342028-4b5f7f58f09d	10000.00	25000.00	0	0	2026-04-02 11:40:29.876032	12	\N	f
31	Savon liquide	Savon doux pour la peau.	https://images.unsplash.com/photo-1583947215259-38e31be8751f	8000.00	20000.00	0	0	2026-04-02 11:40:29.88523	12	\N	f
32	Brosse à dents électrique	Brosse rechargeable efficace.	https://images.unsplash.com/photo-1588776814546-1ffcf47267a5	40000.00	90000.00	0	0	2026-04-02 11:40:29.90159	13	\N	f
33	Chaussures running Nike style	Chaussures de sport légères adaptées au running quotidien.	https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80	120000.00	180000.00	0	1	2026-04-02 11:47:57.713668	2	\N	f
35	Télévision LED 43 pouces	TV écran plat avec résolution Full HD.	https://images.unsplash.com/photo-1593784991095-a205069470b6	1800000.00	2500000.00	0	1	2026-04-02 11:47:57.80837	3	\N	f
36	Sac à dos ordinateur	Sac robuste avec compartiment laptop.	https://images.unsplash.com/photo-1553062407-98eeb64c6a62	50000.00	90000.00	0	1	2026-04-02 11:47:57.826126	4	\N	f
37	Montre connectée	Montre intelligente avec suivi de santé.	https://images.unsplash.com/photo-1511732351157-1865efcb7b7b	220000.00	350000.00	0	1	2026-04-02 11:47:57.839787	5	\N	f
39	Ordinateur portable 15 pouces	Laptop performant pour travail et études.	https://images.unsplash.com/photo-1517336714731-489689fd1ca8	1500000.00	2100000.00	0	1	2026-04-02 11:47:57.887542	7	\N	f
40	Clavier mécanique RGB	Clavier gamer avec rétroéclairage RGB.	https://images.unsplash.com/photo-1518770660439-4636190af475	90000.00	150000.00	0	1	2026-04-02 11:47:57.903902	7	\N	f
41	Souris gaming	Souris ergonomique haute précision.	https://images.unsplash.com/photo-1587829741301-dc798b83add3	40000.00	80000.00	0	1	2026-04-02 11:47:57.919223	7	\N	f
42	Power bank 20000mAh	Batterie externe grande capacité.	https://images.unsplash.com/photo-1585386959984-a4155224a1ad	50000.00	85000.00	0	1	2026-04-02 11:47:57.938713	4	\N	f
43	T-shirt coton	T-shirt confortable en coton.	https://images.unsplash.com/photo-1523381210434-271e8be1f52b	15000.00	30000.00	0	1	2026-04-02 11:47:57.95102	8	\N	f
44	Jean homme	Jean durable coupe moderne.	https://images.unsplash.com/photo-1541099649105-f69ad21f3246	40000.00	80000.00	0	1	2026-04-02 11:47:57.967608	8	\N	f
45	Chaussures casual	Chaussures stylées pour usage quotidien.	https://images.unsplash.com/photo-1528701800489-20be3c1f6b7b	60000.00	110000.00	0	1	2026-04-02 11:47:57.980013	8	\N	f
46	Lunettes de soleil	Protection UV avec design moderne.	https://images.unsplash.com/photo-1511499767150-a48a237f0083	20000.00	45000.00	0	1	2026-04-02 11:47:57.997869	4	\N	f
48	Chaise bureau	Chaise ergonomique pour bureau.	https://images.unsplash.com/photo-1586023492125-27b2c045efd7	120000.00	200000.00	0	1	2026-04-02 11:47:58.057795	9	\N	f
49	Table en bois	Table solide en bois naturel.	https://images.unsplash.com/photo-1505693416388-ac5ce068fe85	200000.00	350000.00	0	1	2026-04-02 11:47:58.076613	9	\N	f
50	Lampe LED	Lampe moderne basse consommation.	https://images.unsplash.com/photo-1507473885765-e6ed057f782c	25000.00	60000.00	0	1	2026-04-02 11:47:58.098379	9	\N	f
51	Mixeur électrique	Mixeur puissant pour cuisine.	https://images.unsplash.com/photo-1586201375761-83865001e31c	70000.00	120000.00	0	1	2026-04-02 11:47:58.114702	10	\N	f
52	Bouilloire électrique	Bouilloire rapide et efficace.	https://images.unsplash.com/photo-1606813909353-3b3d3f4b4c1a	30000.00	70000.00	0	1	2026-04-02 11:47:58.151149	10	\N	f
54	Tapis de yoga	Tapis antidérapant fitness.	https://images.unsplash.com/photo-1554306274-f23873d9a26c	30000.00	60000.00	0	1	2026-04-02 11:47:58.36009	11	\N	f
55	Haltères fitness	Poids pour entraînement musculaire.	https://images.unsplash.com/photo-1599058917765-a780eda07a3e	50000.00	90000.00	0	1	2026-04-02 11:47:58.372971	11	\N	f
57	Sac de sport	Sac spacieux pour activités sportives.	https://images.unsplash.com/photo-1517836357463-d25dfeac3438	40000.00	80000.00	0	1	2026-04-02 11:47:58.393105	11	\N	f
58	Parfum homme	Parfum longue durée.	https://images.unsplash.com/photo-1541643600914-78b084683601	60000.00	120000.00	0	1	2026-04-02 11:47:58.400896	12	\N	f
59	Crème visage	Crème hydratante peau.	https://images.unsplash.com/photo-1556228578-0d85b1a4d571	20000.00	50000.00	0	1	2026-04-02 11:47:58.408297	12	\N	f
60	Shampooing	Shampooing nourrissant.	https://images.unsplash.com/photo-1585238342028-4b5f7f58f09d	10000.00	25000.00	0	1	2026-04-02 11:47:58.41606	12	\N	f
61	Savon liquide	Savon doux pour la peau.	https://images.unsplash.com/photo-1583947215259-38e31be8751f	8000.00	20000.00	0	1	2026-04-02 11:47:58.422497	12	\N	f
62	Brosse à dents électrique	Brosse rechargeable efficace.	https://images.unsplash.com/photo-1588776814546-1ffcf47267a5	40000.00	90000.00	0	1	2026-04-02 11:47:58.431304	13	\N	f
53	Ballon de football	Ballon résistant pour terrain.	https://images.unsplash.com/photo-1517649763962-0c623066013b	20000.00	45000.00	1	1	2026-04-02 11:47:58.343218	11	\N	f
56	Bouteille isotherme	Garde boissons chaudes/froides.	https://images.unsplash.com/photo-1526401485004-2fa806b6f3b1	15000.00	35000.00	1	1	2026-04-02 11:47:58.385722	11	\N	f
2	Premium Kitchen Towels (20x 28, 6 Pack) | Large Cotton Dish Towels | Flat & Terry Highly Absorbent Kitchen Linen Set with Hanging Loop | Navy Blue	SOFT & ABSORBENT: Made from 100% ring spun cotton to help keep your home clean and sanitary. Our towels are machine washable and reusable. Effective for soaking up more than paper towels\nENVIRONMENT FRIENDLY: Absorbent hand towels for a healthier, cleaner environment for your home. They maintain their look and feel through multiple wash cycles\n6-PACK: Contains three different textures of towels, including a flat towel and terry towel. Great for drying dishes, cleaning kitchen countertops, wiping up spills, and more\nHANGING LOOP & BONUS TOTE BAG INCLUDED: Bumble Kitchen towels come with an elegant tote bag, making this a great gift for loved ones\nCARE FOR YOUR TOWELS: Machine wash warm and tumble dry low. We recommend to wash before the first use to remove any excess lint leftover from the manufacturing process. Always wash your towels separately to avoid transfer of lint onto your garments.	https://m.media-amazon.com/images/I/61fiaemEz7L._AC_US750_.jpg	155083.63	200000.00	17	1	2026-04-02 09:19:30.005127	1	\N	f
38	Casque Bluetooth	Casque sans fil avec réduction de bruit.	https://images.unsplash.com/photo-1518444065439-e933c06ce9cd	70000.00	120000.00	10	1	2026-04-02 11:47:57.869182	6	\N	f
47	Casquette	Casquette légère et respirante.	https://images.unsplash.com/photo-1521369909029-2afed882baee	10000.00	25000.00	0	1	2026-04-02 11:47:58.021113	8	\N	f
69	Bracelet Corne de Zébu Local	Bracelet sculpté dans de la corne de zébu polie naturellement	https://picsum.photos/seed/necklace-7/400/400	4800.00	11500.00	127	1	2026-04-02 13:00:32.311743	16	19	f
70	Figurine Lémuriens des Hautes Terres	Famille de lémuriens sculptés en bois d'acajou local	https://picsum.photos/seed/basket-231/400/500	6200.00	15100.00	11	1	2026-04-02 13:00:32.320466	19	17	f
63	Confiture de Coco Artisanale Bio	Confiture oncteuse à la noix de coco fraîche et caramel	https://picsum.photos/seed/food-711/500/400	3100.00	7800.00	378	1	2026-04-02 13:00:32.251989	14	18	f
64	Robe Brodée Antananarivo Artisanal	Robe artisanale à broderies florales faites main en coton local	https://picsum.photos/seed/bag-530/400/400	20600.00	48000.00	429	1	2026-04-02 13:00:32.263206	15	19	f
67	Infusion Centella Asiatica Artisanal	Plante médicinale malgache pour la circulation et la mémoire	https://picsum.photos/seed/coffee-424/500/500	3000.00	6900.00	244	1	2026-04-02 13:00:32.294213	17	22	f
66	Chevalière Argent Massif Export	Bague chevalière en argent 925, initiale gravée à la main	https://picsum.photos/seed/ring-949/400/400	17100.00	40900.00	350	1	2026-04-02 13:00:32.286877	16	17	f
71	Café Arabica des Hautes Terres Artisanal	Grains de café arabica cultivés à 1500m d'altitude, notes chocolatées et florales	https://picsum.photos/seed/tea-721/500/500	6700.00	15600.00	326	1	2026-04-02 13:00:32.328453	17	19	f
73	Lamba Mena Traditionnel Artisanal	Tissu de soie traditionnel malgache aux couleurs naturelles vives	https://picsum.photos/seed/textile-11/500/500	27900.00	66900.00	158	1	2026-04-02 13:00:32.347132	15	21	f
74	Sac à Dos Trekking Raphia Premium	Sac robuste en fibres naturelles pour randonnée en forêt	https://picsum.photos/seed/travel-12/500/400	9400.00	22600.00	171	1	2026-04-02 13:00:32.360169	21	19	f
76	Eau Florale de Géranium Premium	Hydrolat pur de géranium rosat, tonifiant et équilibrant	https://picsum.photos/seed/natural-beauty-14/600/500	4200.00	10000.00	69	1	2026-04-02 13:00:32.38105	22	22	f
78	Robe Brodée Antananarivo Bio	Robe artisanale à broderies florales faites main en coton local	https://picsum.photos/seed/textile-16/500/500	15900.00	37200.00	49	1	2026-04-02 13:00:32.406244	15	19	f
80	Compost Naturel de Zébu Artisanal	Fumier de zébu composté, engrais naturel riche en azote	https://picsum.photos/seed/seeds-18/600/400	2900.00	6900.00	237	1	2026-04-02 13:00:32.426916	18	22	f
82	Chocolat Noir 75% Cacao Local	Tablette de chocolat fabriquée avec cacao trinitario malgache	https://picsum.photos/seed/food-20/600/400	3900.00	9300.00	222	1	2026-04-02 13:00:32.44441	14	18	f
84	Bague Corail Rouge Naturel de Madagascar	Bague en argent 925 sertie d'un corail rouge naturel de l'océan Indien	https://picsum.photos/seed/ring-22/400/500	17200.00	40100.00	367	1	2026-04-02 13:00:32.461767	16	19	f
87	Huile de Tamanu Local	Huile cicatrisante extraite des noix de tamanu de la côte Est	https://picsum.photos/seed/organic-26/500/500	9900.00	23900.00	246	1	2026-04-02 13:00:32.489047	22	20	f
90	Savon Charbon Actif Malagasy	Savon détoxifiant au charbon de bois de coco activé	https://picsum.photos/seed/essential-oil-29/600/400	3500.00	8000.00	343	1	2026-04-02 13:00:32.511679	22	19	f
92	Carte Topographique Madagascar Bio	Carte détaillée au 1/500000 de l'ensemble du territoire	https://picsum.photos/seed/hammock-31/400/500	4700.00	11300.00	364	1	2026-04-02 13:00:32.528679	21	20	f
94	Infusion Centella Asiatica des Hautes Terres	Plante médicinale malgache pour la circulation et la mémoire	https://picsum.photos/seed/herbs-34/400/500	2700.00	6400.00	338	1	2026-04-02 13:00:32.541894	17	22	f
95	Confiture de Goyave Artisanal	Confiture maison de goyave rose, peu sucrée et riche en fruits	https://picsum.photos/seed/food-35/600/500	2200.00	5200.00	398	1	2026-04-02 13:00:32.550161	14	19	f
99	Semences Haricot Malagasy de Madagascar	Variété locale non hybridée de haricots rouges traditionnels	https://picsum.photos/seed/plants-39/500/500	1900.00	4800.00	481	1	2026-04-02 13:00:32.580726	18	20	f
100	Collier Perle d'Eau Douce Export	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/ring-40/600/400	17900.00	41700.00	431	1	2026-04-02 13:00:32.59054	16	18	f
103	Lamba Mena Traditionnel Local	Tissu de soie traditionnel malgache aux couleurs naturelles vives	https://picsum.photos/seed/fabric-44/600/500	23200.00	55700.00	237	1	2026-04-02 13:00:32.608789	15	23	f
106	Bracelet Laiton Gravé des Hautes Terres	Bracelet jonc en laiton gravé de proverbes malgaches	https://picsum.photos/seed/necklace-48/600/400	6200.00	14500.00	117	1	2026-04-02 13:00:32.627301	16	20	f
72	Kabosy Mini Export	Petite guitare folk malgache à 4 cordes, bois artisanal local	https://picsum.photos/seed/painting-102/500/400	14500.00	34700.00	58	1	2026-04-02 13:00:32.336883	20	20	f
93	Baume Lèvres Cacao-Vanille de Madagascar	Baume protecteur naturel au beurre de cacao et vanille bourbon	https://picsum.photos/seed/natural-beauty-143/500/500	2600.00	6200.00	130	1	2026-04-02 13:00:32.535881	22	19	f
104	Carte Topographique Madagascar Naturel	Carte détaillée au 1/500000 de l'ensemble du territoire	https://picsum.photos/seed/snorkeling-626/600/500	5700.00	13600.00	454	1	2026-04-02 13:00:32.614054	21	24	f
81	Crème Visage Baobab des Hautes Terres	Crème hydratante à l'huile de baobab, anti-âge et nourrissante	https://picsum.photos/seed/essential-oil-903/600/400	8600.00	20500.00	187	1	2026-04-02 13:00:32.437059	22	16	f
98	Maracas en Calebasse Local	Paire de maracas artisanales en calebasse séchée et graines	https://picsum.photos/seed/art-411/600/400	4000.00	10000.00	111	1	2026-04-02 13:00:32.572967	20	15	f
107	Tableau Peinture Lokanga des Hautes Terres	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/painting-257/600/500	10700.00	24900.00	306	1	2026-04-02 13:00:32.634657	20	21	f
89	Rhum Arrangé Vanille-Épices Naturel	Rhum artisanal infusé vanille, cannelle et clous de girofle	https://picsum.photos/seed/food-313/500/400	12400.00	28900.00	318	1	2026-04-02 13:00:32.504749	14	19	f
85	Compost Naturel de Zébu de Madagascar	Fumier de zébu composté, engrais naturel riche en azote	https://picsum.photos/seed/plants-544/500/400	2800.00	6500.00	51	1	2026-04-02 13:00:32.470436	18	19	f
88	Charbon de Bois Premium Artisanal	Charbon dur longue combustion, issu de forêts gérées durablement	https://picsum.photos/seed/organic-296/600/400	2800.00	6800.00	453	1	2026-04-02 13:00:32.496065	18	15	f
108	Tamarin Concentré	Pâte de tamarin naturelle, acidulée et fruitée	https://picsum.photos/seed/vanilla-980/400/500	1100.00	2700.00	142	1	2026-04-02 13:00:32.640801	23	18	f
96	Lotion Corps Corozo Naturel	Lotion douce au beurre de corozo, hydratation longue durée	https://picsum.photos/seed/natural-beauty-609/500/400	5600.00	13100.00	120	1	2026-04-02 13:00:32.558085	22	18	f
101	Flûte Sodina Naturel	Flûte traversière traditionnelle en bambou, gamme pentatonique	https://picsum.photos/seed/music-instrument-890/500/500	8000.00	19100.00	419	1	2026-04-02 13:00:32.596593	20	17	f
102	Curcuma Bio Local	Racines de curcuma séchées et moulues, riches en curcumine, couleur dorée intense	https://picsum.photos/seed/vanilla-781/400/500	1400.00	3700.00	42	1	2026-04-02 13:00:32.60281	23	17	f
83	Maracas en Calebasse de Madagascar	Paire de maracas artisanales en calebasse séchée et graines	https://picsum.photos/seed/music-instrument-768/600/400	3700.00	9200.00	217	1	2026-04-02 13:00:32.453644	20	18	f
97	Bracelet Laiton Gravé Naturel	Bracelet jonc en laiton gravé de proverbes malgaches	https://picsum.photos/seed/ring-881/600/500	6500.00	15200.00	187	1	2026-04-02 13:00:32.563567	16	17	f
79	Sirop de Cannelle Naturel des Hautes Terres	Sirop artisanal à la cannelle, sans conservateurs ni colorants	https://picsum.photos/seed/food-936/600/500	2600.00	6200.00	249	1	2026-04-02 13:00:32.415386	14	16	f
75	Collier Perle d'Eau Douce de Madagascar	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/ring-969/500/500	15300.00	35800.00	238	1	2026-04-02 13:00:32.371138	16	23	f
105	Charbon de Bois Premium Export	Charbon dur longue combustion, issu de forêts gérées durablement	https://picsum.photos/seed/organic-984/500/400	2400.00	5700.00	41	1	2026-04-02 13:00:32.621306	18	15	f
77	Pareo Batik Nosy Be des Hautes Terres	Pareo technique batik aux motifs marins tropicaux	https://picsum.photos/seed/fabric-988/600/500	6600.00	15100.00	316	1	2026-04-02 13:00:32.394778	15	21	f
110	Pâte de Cacao Pure de Madagascar	Pâte de cacao 100% non sucrée, saveur intense et complexe	https://picsum.photos/seed/honey-52/500/500	5400.00	12500.00	219	1	2026-04-02 13:00:32.654652	14	24	f
111	Confiture de Coco Artisanale des Hautes Terres	Confiture oncteuse à la noix de coco fraîche et caramel	https://picsum.photos/seed/honey-53/500/500	2600.00	6600.00	250	1	2026-04-02 13:00:32.659831	14	20	f
113	Valiha Bambou Artisanale Local	Cithare tubulaire traditionnelle malgache en bambou, 21 cordes	https://picsum.photos/seed/painting-55/600/500	32500.00	78900.00	84	1	2026-04-02 13:00:32.677756	20	22	f
117	Bijou Argent Antaimoro	Bracelet filigrane argent façonné selon techniques ancestrales	https://picsum.photos/seed/wood-carving-59/400/500	10900.00	27200.00	435	1	2026-04-02 13:00:32.713508	19	16	f
118	Sculpture en Bois de Palissandre Artisanal	Statuette sculptée à la main représentant un zébu, bois précieux malgache	https://picsum.photos/seed/handicraft-60/600/400	25000.00	64900.00	468	1	2026-04-02 13:00:32.720509	19	18	f
119	Mélange Romazava Naturel	Mélange traditionnel de feuilles pour le plat national malgache	https://picsum.photos/seed/ginger-61/600/500	2800.00	6700.00	195	1	2026-04-02 13:00:32.726584	23	23	f
122	Bracelet Corne de Zébu Premium	Bracelet sculpté dans de la corne de zébu polie naturellement	https://picsum.photos/seed/ring-64/400/500	5400.00	13000.00	95	1	2026-04-02 13:00:32.765226	16	17	f
127	Valiha Bambou Artisanale Bio	Cithare tubulaire traditionnelle malgache en bambou, 21 cordes	https://picsum.photos/seed/art-70/500/500	31500.00	76600.00	344	1	2026-04-02 13:00:32.805363	20	22	f
130	Semences Haricot Malagasy Export	Variété locale non hybridée de haricots rouges traditionnels	https://picsum.photos/seed/seeds-74/600/500	2300.00	5600.00	139	1	2026-04-02 13:00:32.830792	18	22	f
133	Sac à Dos Trekking Raphia	Sac robuste en fibres naturelles pour randonnée en forêt	https://picsum.photos/seed/snorkeling-78/600/500	9500.00	22800.00	69	1	2026-04-02 13:00:32.872766	21	23	f
134	Feuilles de Moringa Séchées Naturel	Feuilles déshydratées à basse température, valeur nutritive maximale	https://picsum.photos/seed/seeds-79/400/400	3000.00	7000.00	458	1	2026-04-02 13:00:32.878907	18	20	f
135	Kit Snorkeling Corail	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/trekking-80/500/400	14100.00	32800.00	81	1	2026-04-02 13:00:32.887789	21	24	f
137	Savon Charbon Actif Malagasy Export	Savon détoxifiant au charbon de bois de coco activé	https://picsum.photos/seed/natural-beauty-82/400/400	3000.00	6900.00	243	1	2026-04-02 13:00:32.899697	22	24	f
140	Girofle de Maroantsetra des Hautes Terres	Clous de girofle séchés, huile essentielle naturellement riche	https://picsum.photos/seed/vanilla-85/500/500	3100.00	7300.00	39	1	2026-04-02 13:00:32.923875	23	23	f
141	Bracelet Corne de Zébu	Bracelet sculpté dans de la corne de zébu polie naturellement	https://picsum.photos/seed/necklace-87/400/400	5100.00	12200.00	147	1	2026-04-02 13:00:32.929849	16	22	f
142	Panier Tressé en Raphia Naturel	Panier traditionnel fait main par les artisanes des hautes terres	https://picsum.photos/seed/wood-carving-88/600/400	8200.00	20400.00	208	1	2026-04-02 13:00:32.938775	19	16	f
143	Châle en Soie Sauvage de Madagascar	Châle tissé à partir de soie d'araignée dorée de Madagascar	https://picsum.photos/seed/dress-89/600/400	18100.00	43500.00	365	1	2026-04-02 13:00:32.945506	15	23	f
86	Boucles Oreilles Raffia Doré	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/bracelet-400/500/500	4100.00	9600.00	140	1	2026-04-02 13:00:32.480099	16	15	f
136	Djembé Malgache Premium	Tambour djembé sculpté main en bois de manguier et peau de chèvre	https://picsum.photos/seed/art-968/500/400	20400.00	48900.00	273	1	2026-04-02 13:00:32.893974	20	19	f
128	Lotion Corps Corozo Artisanal	Lotion douce au beurre de corozo, hydratation longue durée	https://picsum.photos/seed/essential-oil-537/400/400	6300.00	14600.00	373	1	2026-04-02 13:00:32.811396	22	15	f
125	Chapeau de Paille Malagasy des Hautes Terres	Chapeau tressé à la main en paille de vétiver naturel	https://picsum.photos/seed/basket-923/400/400	5500.00	13300.00	352	1	2026-04-02 13:00:32.790891	19	15	f
129	Cire d'Abeille Pure Premium	Cire naturelle des ruches malgaches, non blanchie, idéale cosmétique	https://picsum.photos/seed/organic-861/400/400	5300.00	12800.00	231	1	2026-04-02 13:00:32.822177	18	24	f
138	Filet de Pêche Artisanal des Hautes Terres	Filet tressé à la main par pêcheurs du littoral Ouest	https://picsum.photos/seed/trekking-366/500/400	7400.00	17500.00	290	1	2026-04-02 13:00:32.908925	21	23	f
116	Poivre Noir Sauvage Export	Poivre sauvage récolté à la main dans les forêts de l'Est, arôme boisé et piquant	https://picsum.photos/seed/cinnamon-414/600/500	3600.00	8200.00	204	1	2026-04-02 13:00:32.706799	23	22	f
139	Sirop de Cannelle Naturel Bio	Sirop artisanal à la cannelle, sans conservateurs ni colorants	https://picsum.photos/seed/chocolate-445/600/400	2600.00	6000.00	26	1	2026-04-02 13:00:32.915262	14	24	f
131	Sérum Hydratant Moringa Premium	Sérum léger à l'huile de moringa, riche en vitamines A et E	https://picsum.photos/seed/skincare-503/400/500	8100.00	19000.00	260	1	2026-04-02 13:00:32.838721	22	20	f
121	Plants Ylang-Ylang Artisanal	Jeunes plants d'ylang-ylang pour cultivation, prêts à repiquer	https://picsum.photos/seed/nature-838/400/500	4700.00	11300.00	361	1	2026-04-02 13:00:32.752902	18	18	f
123	Girofle de Maroantsetra Naturel	Clous de girofle séchés, huile essentielle naturellement riche	https://picsum.photos/seed/cinnamon-839/600/400	3400.00	7900.00	64	1	2026-04-02 13:00:32.774144	23	17	f
115	Café Robusta du Sud Export	Café robusta corsé et intense, idéal pour espresso traditionnel	https://picsum.photos/seed/coffee-750/600/500	3600.00	8100.00	11	1	2026-04-02 13:00:32.700038	17	20	f
126	Tisane Ravintsara de Madagascar	Feuilles de ravintsara séchées, antibactérien naturel, saveur camphrée	https://picsum.photos/seed/herbs-665/600/500	4700.00	10500.00	56	1	2026-04-02 13:00:32.797486	17	22	f
132	Kabosy Mini Naturel	Petite guitare folk malgache à 4 cordes, bois artisanal local	https://picsum.photos/seed/art-682/400/500	15800.00	37900.00	58	1	2026-04-02 13:00:32.845123	20	22	f
112	Café Arabica des Hautes Terres Local	Grains de café arabica cultivés à 1500m d'altitude, notes chocolatées et florales	https://picsum.photos/seed/coffee-686/400/500	6200.00	14600.00	423	1	2026-04-02 13:00:32.667708	17	21	f
114	Sac à Dos Trekking Raphia Bio	Sac robuste en fibres naturelles pour randonnée en forêt	https://picsum.photos/seed/trekking-869/500/500	8800.00	21200.00	351	1	2026-04-02 13:00:32.686244	21	19	f
124	Huile de Ricin Brute Naturel	Huile de ricin pressée à froid, usage cosmétique et industriel	https://picsum.photos/seed/nature-910/400/400	4100.00	9200.00	280	1	2026-04-02 13:00:32.782176	18	19	f
109	Châle en Soie Sauvage Artisanal	Châle tissé à partir de soie d'araignée dorée de Madagascar	https://picsum.photos/seed/dress-952/400/500	19400.00	46700.00	197	1	2026-04-02 13:00:32.645959	15	16	f
144	Collier Perle d'Eau Douce Local	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/ring-90/600/400	17200.00	40100.00	466	1	2026-04-02 13:00:32.953495	16	15	f
150	Hamac Coton Tressé Premium	Hamac artisanal en coton résistant, capacité 120kg	https://picsum.photos/seed/snorkeling-96/500/500	12400.00	28900.00	495	1	2026-04-02 13:00:32.996686	21	21	f
152	Thé Vert de Fianarantsoa Local	Feuilles de thé vert fraîches, légèrement herbacées et délicates	https://picsum.photos/seed/tea-98/500/400	3200.00	7700.00	496	1	2026-04-02 13:00:33.013382	17	18	f
120	Savon Artisanal Ylang-Ylang de Madagascar	Pain de savon froid aux fleurs d'ylang-ylang, peau douce et parfumée	https://picsum.photos/seed/skincare-101/500/500	2600.00	6000.00	446	1	2026-04-02 13:00:32.734535	22	15	f
154	Beurre de Karité Pur Premium	Beurre de karité non raffiné, idéal cuisine et cosmétique	https://picsum.photos/seed/chocolate-103/400/400	6000.00	13800.00	130	1	2026-04-02 13:00:33.061949	14	19	f
156	Béret Laine des Hautes Terres Export	Béret tricoté main en pure laine de mouton des Hautes Terres	https://picsum.photos/seed/bag-105/400/400	6100.00	14300.00	20	1	2026-04-02 13:00:33.077795	15	20	f
157	Sculpture en Bois de Palissandre Premium	Statuette sculptée à la main représentant un zébu, bois précieux malgache	https://picsum.photos/seed/pottery-106/600/500	24300.00	63100.00	144	1	2026-04-02 13:00:33.083745	19	19	f
161	Huile Essentielle Ravintsara de Madagascar	Huile pure de ravintsara distillée, puissant immunostimulant naturel	https://picsum.photos/seed/natural-beauty-110/600/400	11700.00	27300.00	86	1	2026-04-02 13:00:33.114271	22	23	f
164	Panier Tressé en Raphia Bio	Panier traditionnel fait main par les artisanes des hautes terres	https://picsum.photos/seed/basket-113/600/400	7000.00	17400.00	67	1	2026-04-02 13:00:33.145272	19	23	f
165	Carnet Papier Antaimoro Artisanal	Carnet artisanal en papier fait main avec fleurs et feuilles pressées	https://picsum.photos/seed/handicraft-114/400/400	4400.00	11000.00	345	1	2026-04-02 13:00:33.156543	19	19	f
166	Sac à Dos Trekking Raphia Export	Sac robuste en fibres naturelles pour randonnée en forêt	https://picsum.photos/seed/travel-115/400/400	11200.00	26900.00	345	1	2026-04-02 13:00:33.162795	21	21	f
168	Miel de Litchi de Nosy Be Premium	Miel monofloral de litchi, goût floral délicat, récolte artisanale	https://picsum.photos/seed/chocolate-117/400/500	4500.00	10700.00	259	1	2026-04-02 13:00:33.178321	14	15	f
172	Huile de Ricin Brute Export	Huile de ricin pressée à froid, usage cosmétique et industriel	https://picsum.photos/seed/nature-121/600/400	3700.00	8300.00	497	1	2026-04-02 13:00:33.208	18	19	f
174	Kit Snorkeling Corail Bio	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/snorkeling-124/400/400	15900.00	37200.00	346	1	2026-04-02 13:00:33.231536	21	15	f
175	Flûte Sodina Artisanal	Flûte traversière traditionnelle en bambou, gamme pentatonique	https://picsum.photos/seed/painting-125/600/400	9000.00	21300.00	333	1	2026-04-02 13:00:33.240706	20	17	f
146	Panier Tressé en Raphia des Hautes Terres	Panier traditionnel fait main par les artisanes des hautes terres	https://picsum.photos/seed/basket-182/400/400	7200.00	18100.00	122	1	2026-04-02 13:00:32.968243	19	18	f
145	Café Arabica des Hautes Terres Premium	Grains de café arabica cultivés à 1500m d'altitude, notes chocolatées et florales	https://picsum.photos/seed/herbs-710/600/400	5100.00	12000.00	104	1	2026-04-02 13:00:32.960948	17	16	f
162	Pendentif Oeil de Tigre des Hautes Terres	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/jewelry-187/500/500	8100.00	19300.00	428	1	2026-04-02 13:00:33.123608	16	21	f
170	Beurre de Karité Pur Export	Beurre de karité non raffiné, idéal cuisine et cosmétique	https://picsum.photos/seed/food-223/500/500	7300.00	16700.00	208	1	2026-04-02 13:00:33.193807	14	15	f
155	Collier Perles de Mer Artisanal	Collier fait de perles de mer naturelles de Nosy Be	https://picsum.photos/seed/wood-carving-476/400/500	8900.00	22400.00	439	1	2026-04-02 13:00:33.070555	19	19	f
177	Curcuma Bio des Hautes Terres	Racines de curcuma séchées et moulues, riches en curcumine, couleur dorée intense	https://picsum.photos/seed/ginger-906/500/500	1500.00	4000.00	197	1	2026-04-02 13:00:33.258778	23	20	f
158	Sac à Main Raphia Naturel des Hautes Terres	Sac tissé en fibres de raphia, fermoir en bois sculpté	https://picsum.photos/seed/bag-290/500/500	9100.00	21900.00	239	1	2026-04-02 13:00:33.094088	15	15	f
167	Chapeau de Paille Malagasy Bio	Chapeau tressé à la main en paille de vétiver naturel	https://picsum.photos/seed/pottery-340/600/400	5200.00	12500.00	270	1	2026-04-02 13:00:33.171633	19	17	f
148	Huile de Coco Vierge de Madagascar	Huile de noix de coco pressée à froid, certifiée bio	https://picsum.photos/seed/honey-384/600/500	8700.00	20700.00	356	1	2026-04-02 13:00:32.982415	14	23	f
176	Kit Snorkeling Corail des Hautes Terres	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/trekking-994/600/400	12900.00	30100.00	271	1	2026-04-02 13:00:33.248268	21	23	f
163	Carte Topographique Madagascar Premium	Carte détaillée au 1/500000 de l'ensemble du territoire	https://picsum.photos/seed/snorkeling-774/500/400	4600.00	11000.00	255	1	2026-04-02 13:00:33.133106	21	17	f
171	Café Vert Non Torréfié Premium	Café vert pour méthode lente, riche en antioxydants	https://picsum.photos/seed/herbs-997/600/400	9100.00	20500.00	352	1	2026-04-02 13:00:33.199541	17	17	f
159	Sandales Cuir Artisanales de Madagascar	Sandales cuir tannées main, semelles en caoutchouc naturel	https://picsum.photos/seed/bag-569/400/400	11200.00	26200.00	261	1	2026-04-02 13:00:33.099911	15	16	f
160	Savon Charbon Actif Malagasy Bio	Savon détoxifiant au charbon de bois de coco activé	https://picsum.photos/seed/skincare-904/600/400	3400.00	7900.00	368	1	2026-04-02 13:00:33.108764	22	22	f
149	Crème Visage Baobab Bio	Crème hydratante à l'huile de baobab, anti-âge et nourrissante	https://picsum.photos/seed/natural-beauty-815/400/500	7000.00	16500.00	446	1	2026-04-02 13:00:32.990964	22	22	f
169	Collier Perles de Mer des Hautes Terres	Collier fait de perles de mer naturelles de Nosy Be	https://picsum.photos/seed/pottery-831/400/400	8500.00	21300.00	21	1	2026-04-02 13:00:33.184648	19	18	f
151	Filet de Pêche Artisanal Artisanal	Filet tressé à la main par pêcheurs du littoral Ouest	https://picsum.photos/seed/hammock-880/500/500	9100.00	21700.00	131	1	2026-04-02 13:00:33.006767	21	23	f
153	Café Arabica des Hautes Terres des Hautes Terres	Grains de café arabica cultivés à 1500m d'altitude, notes chocolatées et florales	https://picsum.photos/seed/coffee-939/500/400	6700.00	15600.00	23	1	2026-04-02 13:00:33.027265	17	22	f
147	Cire d'Abeille Pure de Madagascar	Cire naturelle des ruches malgaches, non blanchie, idéale cosmétique	https://picsum.photos/seed/organic-985/600/400	5000.00	12000.00	276	1	2026-04-02 13:00:32.976734	18	16	f
179	Figurine Lémuriens de Madagascar	Famille de lémuriens sculptés en bois d'acajou local	https://picsum.photos/seed/wood-carving-129/500/400	6800.00	16400.00	344	1	2026-04-02 13:00:33.28081	19	18	f
184	Panier Tressé en Raphia Artisanal	Panier traditionnel fait main par les artisanes des hautes terres	https://picsum.photos/seed/wood-carving-136/500/500	7200.00	18000.00	166	1	2026-04-02 13:00:33.345124	19	16	f
185	Charbon de Bois Premium	Charbon dur longue combustion, issu de forêts gérées durablement	https://picsum.photos/seed/seeds-137/400/400	2900.00	6800.00	160	1	2026-04-02 13:00:33.351345	18	17	f
193	Foulard Soie Lémuriens de Madagascar	Foulard léger imprimé de motifs représentant les lémuriens	https://picsum.photos/seed/fabric-146/600/400	9400.00	23000.00	109	1	2026-04-02 13:00:33.431104	15	19	f
195	Djembé Malgache Artisanal	Tambour djembé sculpté main en bois de manguier et peau de chèvre	https://picsum.photos/seed/painting-148/400/400	20400.00	48900.00	105	1	2026-04-02 13:00:33.45012	20	17	f
196	Filet de Pêche Artisanal Local	Filet tressé à la main par pêcheurs du littoral Ouest	https://picsum.photos/seed/snorkeling-150/600/500	8700.00	20800.00	309	1	2026-04-02 13:00:33.468199	21	22	f
199	Confiture de Coco Artisanale de Madagascar	Confiture oncteuse à la noix de coco fraîche et caramel	https://picsum.photos/seed/honey-153/400/400	2700.00	6700.00	33	1	2026-04-02 13:00:33.492317	14	22	f
201	Châle en Soie Sauvage des Hautes Terres	Châle tissé à partir de soie d'araignée dorée de Madagascar	https://picsum.photos/seed/bag-155/500/500	21400.00	51400.00	439	1	2026-04-02 13:00:33.507947	15	20	f
202	Café Vert Non Torréfié Naturel	Café vert pour méthode lente, riche en antioxydants	https://picsum.photos/seed/tea-156/400/500	8900.00	19900.00	196	1	2026-04-02 13:00:33.514174	17	19	f
204	Tabouret Bois Sculpté Bio	Tabouret traditionnel en bois de rose avec décors symboliques	https://picsum.photos/seed/basket-158/600/500	27800.00	69500.00	105	1	2026-04-02 13:00:33.529911	19	21	f
205	Bracelet Laiton Gravé Premium	Bracelet jonc en laiton gravé de proverbes malgaches	https://picsum.photos/seed/necklace-160/400/500	5600.00	13000.00	500	1	2026-04-02 13:00:33.548404	16	22	f
206	Robe Brodée Antananarivo	Robe artisanale à broderies florales faites main en coton local	https://picsum.photos/seed/dress-161/500/500	17500.00	40900.00	207	1	2026-04-02 13:00:33.557885	15	24	f
208	Béret Laine des Hautes Terres des Hautes Terres	Béret tricoté main en pure laine de mouton des Hautes Terres	https://picsum.photos/seed/dress-163/600/500	6700.00	15600.00	107	1	2026-04-02 13:00:33.575046	15	19	f
209	Mélange Romazava Artisanal	Mélange traditionnel de feuilles pour le plat national malgache	https://picsum.photos/seed/cinnamon-164/400/400	2500.00	6100.00	403	1	2026-04-02 13:00:33.581918	23	22	f
191	Chevalière Argent Massif Naturel	Bague chevalière en argent 925, initiale gravée à la main	https://picsum.photos/seed/jewelry-946/500/400	22400.00	53900.00	157	1	2026-04-02 13:00:33.414979	16	19	f
180	Sirop de Sucre de Palme	Nectar naturel de palmier raphia, index glycémique bas	https://picsum.photos/seed/chocolate-222/500/500	3600.00	8100.00	64	1	2026-04-02 13:00:33.303205	14	17	f
65	Collier Perle d'Eau Douce	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/necklace-288/600/400	16700.00	38900.00	475	1	2026-04-02 13:00:32.273663	16	16	f
207	Charbon de Bois Premium Naturel	Charbon dur longue combustion, issu de forêts gérées durablement	https://picsum.photos/seed/organic-620/600/500	2100.00	5100.00	51	1	2026-04-02 13:00:33.56519	18	24	f
178	Kit Snorkeling Corail Export	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/travel-891/600/400	17200.00	40100.00	273	1	2026-04-02 13:00:33.268993	21	21	f
200	Baume Lèvres Cacao-Vanille Local	Baume protecteur naturel au beurre de cacao et vanille bourbon	https://picsum.photos/seed/skincare-962/500/500	2300.00	5600.00	308	1	2026-04-02 13:00:33.499046	22	17	f
181	Sirop de Sucre de Palme Local	Nectar naturel de palmier raphia, index glycémique bas	https://picsum.photos/seed/coconut-567/500/500	4000.00	9000.00	239	1	2026-04-02 13:00:33.315768	14	18	f
183	Thé Hibiscus Rouge Local	Fleurs d'hibiscus séchées, infusion rouge rubis acidulée	https://picsum.photos/seed/coffee-680/600/400	2300.00	5700.00	438	1	2026-04-02 13:00:33.334894	17	17	f
192	Confiture de Goyave Local	Confiture maison de goyave rose, peu sucrée et riche en fruits	https://picsum.photos/seed/honey-489/600/400	2800.00	6700.00	418	1	2026-04-02 13:00:33.424319	14	19	f
211	Pâte de Cacao Pure des Hautes Terres	Pâte de cacao 100% non sucrée, saveur intense et complexe	https://picsum.photos/seed/chocolate-562/400/500	6000.00	14000.00	83	1	2026-04-02 13:00:33.610272	14	24	f
188	Vase en Terre Cuite Artisanal	Poterie artisanale décorée de motifs animaliers malgaches	https://picsum.photos/seed/pottery-577/400/400	5800.00	14600.00	213	1	2026-04-02 13:00:33.377514	19	20	f
203	Chocolat Noir 75% Cacao Artisanal	Tablette de chocolat fabriquée avec cacao trinitario malgache	https://picsum.photos/seed/food-746/400/500	3800.00	9000.00	180	1	2026-04-02 13:00:33.523584	14	22	f
182	Carte Topographique Madagascar	Carte détaillée au 1/500000 de l'ensemble du territoire	https://picsum.photos/seed/hammock-655/500/500	5500.00	13200.00	61	1	2026-04-02 13:00:33.326537	21	18	f
189	Cannelle de Madagascar	Bâtons de cannelle de Ceylan cultivés localement, douce et légèrement citronnée	https://picsum.photos/seed/ginger-702/400/400	2200.00	6200.00	453	1	2026-04-02 13:00:33.384568	23	16	f
187	Baume Lèvres Cacao-Vanille Premium	Baume protecteur naturel au beurre de cacao et vanille bourbon	https://picsum.photos/seed/skincare-757/500/400	2700.00	6400.00	369	1	2026-04-02 13:00:33.367457	22	21	f
212	Lamba Mena Traditionnel Export	Tissu de soie traditionnel malgache aux couleurs naturelles vives	https://picsum.photos/seed/dress-771/400/400	24400.00	58500.00	154	1	2026-04-02 13:00:33.616843	15	24	f
210	Mélange Romazava	Mélange traditionnel de feuilles pour le plat national malgache	https://picsum.photos/seed/spices-830/500/400	2700.00	6500.00	185	1	2026-04-02 13:00:33.591504	23	17	f
198	Broderie Lamba Malgache Premium	Tissu traditionnel brodé main aux motifs géométriques colorés	https://picsum.photos/seed/pottery-857/500/400	13200.00	33100.00	20	1	2026-04-02 13:00:33.483552	19	20	f
186	Savon Artisanal Ylang-Ylang Export	Pain de savon froid aux fleurs d'ylang-ylang, peau douce et parfumée	https://picsum.photos/seed/natural-beauty-901/400/400	3100.00	7200.00	424	1	2026-04-02 13:00:33.360869	22	17	f
190	Gingembre Séché Premium	Gingembre de montagne séché, saveur piquante et citronnée	https://picsum.photos/seed/ginger-907/500/500	1500.00	3900.00	399	1	2026-04-02 13:00:33.395275	23	15	f
194	Plants Ylang-Ylang Premium	Jeunes plants d'ylang-ylang pour cultivation, prêts à repiquer	https://picsum.photos/seed/seeds-932/400/400	5500.00	13300.00	308	1	2026-04-02 13:00:33.441515	18	20	f
214	Confiture de Goyave Bio	Confiture maison de goyave rose, peu sucrée et riche en fruits	https://picsum.photos/seed/honey-170/600/500	2300.00	5500.00	211	1	2026-04-02 13:00:33.631174	14	23	f
217	Tapis Raphia Naturel Export	Tapis tissé main en fibres de raphia naturel non teint	https://picsum.photos/seed/handicraft-173/500/500	17600.00	43900.00	121	1	2026-04-02 13:00:33.65564	19	20	f
218	Huile de Ricin Brute Bio	Huile de ricin pressée à froid, usage cosmétique et industriel	https://picsum.photos/seed/nature-174/600/400	4100.00	9300.00	316	1	2026-04-02 13:00:33.662923	18	15	f
219	Pareo Batik Nosy Be Export	Pareo technique batik aux motifs marins tropicaux	https://picsum.photos/seed/fabric-175/500/500	8000.00	18400.00	379	1	2026-04-02 13:00:33.672736	15	23	f
222	Châle en Soie Sauvage Bio	Châle tissé à partir de soie d'araignée dorée de Madagascar	https://picsum.photos/seed/dress-178/400/500	19700.00	47200.00	296	1	2026-04-02 13:00:33.698866	15	17	f
223	Valiha Bambou Artisanale Export	Cithare tubulaire traditionnelle malgache en bambou, 21 cordes	https://picsum.photos/seed/music-instrument-179/600/500	32400.00	78800.00	176	1	2026-04-02 13:00:33.708098	20	21	f
224	Sculpture en Bois de Palissandre Local	Statuette sculptée à la main représentant un zébu, bois précieux malgache	https://picsum.photos/seed/handicraft-181/500/500	25100.00	65300.00	393	1	2026-04-02 13:00:33.725125	19	23	f
225	Affiche Vintage Tananarive Local	Reproduction d'affiche coloniale de Tananarive années 1930	https://picsum.photos/seed/painting-183/500/400	6700.00	15700.00	82	1	2026-04-02 13:00:33.741635	20	15	f
226	Miel de Litchi de Nosy Be Local	Miel monofloral de litchi, goût floral délicat, récolte artisanale	https://picsum.photos/seed/chocolate-185/500/500	4900.00	11700.00	257	1	2026-04-02 13:00:33.759697	14	20	f
227	Café Vert Non Torréfié Local	Café vert pour méthode lente, riche en antioxydants	https://picsum.photos/seed/herbs-186/400/400	7700.00	17300.00	233	1	2026-04-02 13:00:33.764448	17	18	f
235	Tisane Ravintsara Local	Feuilles de ravintsara séchées, antibactérien naturel, saveur camphrée	https://picsum.photos/seed/coffee-719/400/400	4300.00	9500.00	0	1	2026-04-02 13:00:33.850686	17	21	f
234	Chapeau de Paille Malagasy de Madagascar	Chapeau tressé à la main en paille de vétiver naturel	https://picsum.photos/seed/handicraft-200/600/400	4500.00	10800.00	399	1	2026-04-02 13:00:33.846182	19	24	f
241	Cire d'Abeille Pure des Hautes Terres	Cire naturelle des ruches malgaches, non blanchie, idéale cosmétique	https://picsum.photos/seed/plants-207/500/500	5300.00	12700.00	205	1	2026-04-02 13:00:33.886261	18	23	f
245	Parure Turquoise Afrique Artisanal	Ensemble collier-boucles en turquoise africaine naturelle	https://picsum.photos/seed/ring-213/500/400	13000.00	30400.00	345	1	2026-04-02 13:00:33.928499	16	18	f
233	Maracas en Calebasse	Paire de maracas artisanales en calebasse séchée et graines	https://picsum.photos/seed/music-instrument-959/600/400	4400.00	11100.00	427	1	2026-04-02 13:00:33.838939	20	19	f
243	Masque Argile Volcanique de Madagascar	Argile naturelle des hautes terres aux propriétés purifiantes	https://picsum.photos/seed/skincare-408/600/500	5100.00	12200.00	488	1	2026-04-02 13:00:33.910178	22	15	f
239	Boucles Oreilles Raffia Doré Local	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/necklace-321/500/500	4000.00	9400.00	307	1	2026-04-02 13:00:33.876156	16	16	f
238	Charbon de Bois Premium Local	Charbon dur longue combustion, issu de forêts gérées durablement	https://picsum.photos/seed/organic-973/600/400	2400.00	5700.00	486	1	2026-04-02 13:00:33.868374	18	16	f
213	Chocolat Noir 75% Cacao	Tablette de chocolat fabriquée avec cacao trinitario malgache	https://picsum.photos/seed/coconut-885/400/500	3900.00	9200.00	436	1	2026-04-02 13:00:33.624968	14	22	f
242	Maracas en Calebasse Bio	Paire de maracas artisanales en calebasse séchée et graines	https://picsum.photos/seed/art-355/400/500	3700.00	9300.00	118	1	2026-04-02 13:00:33.89482	20	19	f
91	Bague Corail Rouge Naturel Artisanal	Bague en argent 925 sertie d'un corail rouge naturel de l'océan Indien	https://picsum.photos/seed/jewelry-745/400/500	15000.00	35100.00	210	1	2026-04-02 13:00:32.521211	16	16	f
236	Feuilles de Moringa Séchées	Feuilles déshydratées à basse température, valeur nutritive maximale	https://picsum.photos/seed/organic-430/600/400	2800.00	6500.00	199	1	2026-04-02 13:00:33.858619	18	17	f
216	Girofle de Maroantsetra	Clous de girofle séchés, huile essentielle naturellement riche	https://picsum.photos/seed/vanilla-453/400/400	3000.00	7000.00	329	1	2026-04-02 13:00:33.647285	23	20	f
244	Poivre Rose de Bourbon	Baies roses rares, légèrement sucrées et poivrées	https://picsum.photos/seed/ginger-460/600/400	4900.00	11800.00	66	1	2026-04-02 13:00:33.91465	23	16	f
246	Chevalière Argent Massif des Hautes Terres	Bague chevalière en argent 925, initiale gravée à la main	https://picsum.photos/seed/ring-472/600/500	19000.00	45500.00	236	1	2026-04-02 13:00:34.031839	16	20	f
421	Pareo Batik Nosy Be	Pareo technique batik aux motifs marins tropicaux	https://picsum.photos/seed/bag-490/600/500	7900.00	18100.00	16	1	2026-04-02 13:00:37.39173	15	16	f
68	Bambou Séché Décoratif Artisanal	Tiges de bambou de Madagascar, séchées et traitées naturellement	https://picsum.photos/seed/organic-552/600/400	4000.00	9500.00	236	1	2026-04-02 13:00:32.302626	18	15	f
230	Tamarin Concentré des Hautes Terres	Pâte de tamarin naturelle, acidulée et fruitée	https://picsum.photos/seed/spices-555/500/400	1300.00	3300.00	192	1	2026-04-02 13:00:33.801122	23	15	f
232	Kabosy Mini Bio	Petite guitare folk malgache à 4 cordes, bois artisanal local	https://picsum.photos/seed/painting-784/400/400	13100.00	31500.00	153	1	2026-04-02 13:00:33.832096	20	16	f
237	Filet de Pêche Artisanal	Filet tressé à la main par pêcheurs du littoral Ouest	https://picsum.photos/seed/hammock-601/400/500	8200.00	19400.00	81	1	2026-04-02 13:00:33.86325	21	17	f
228	Chapeau de Paille Malagasy Local	Chapeau tressé à la main en paille de vétiver naturel	https://picsum.photos/seed/handicraft-666/600/400	5200.00	12500.00	299	1	2026-04-02 13:00:33.781045	19	16	f
240	Pendentif Oeil de Tigre Artisanal	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/ring-937/600/400	8500.00	20100.00	345	1	2026-04-02 13:00:33.881595	16	16	f
215	Pendentif Oeil de Tigre Naturel	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/jewelry-744/600/500	8600.00	20400.00	250	1	2026-04-02 13:00:33.639778	16	23	f
220	Thé Vert de Fianarantsoa	Feuilles de thé vert fraîches, légèrement herbacées et délicates	https://picsum.photos/seed/coffee-783/500/500	3300.00	8000.00	71	1	2026-04-02 13:00:33.681143	17	23	f
221	Rhum Arrangé Vanille-Épices des Hautes Terres	Rhum artisanal infusé vanille, cannelle et clous de girofle	https://picsum.photos/seed/coconut-850/600/500	12700.00	29700.00	468	1	2026-04-02 13:00:33.689716	14	23	f
249	Carnet Papier Antaimoro de Madagascar	Carnet artisanal en papier fait main avec fleurs et feuilles pressées	https://picsum.photos/seed/basket-219/400/400	3500.00	8700.00	146	1	2026-04-02 13:00:34.128224	19	21	f
250	Valiha Bambou Artisanale	Cithare tubulaire traditionnelle malgache en bambou, 21 cordes	https://picsum.photos/seed/painting-220/400/400	30600.00	74300.00	29	1	2026-04-02 13:00:34.14595	20	16	f
255	Semences Haricot Malagasy Premium	Variété locale non hybridée de haricots rouges traditionnels	https://picsum.photos/seed/nature-230/600/500	2100.00	5300.00	486	1	2026-04-02 13:00:34.259585	18	19	f
256	Sac à Main Raphia Naturel Premium	Sac tissé en fibres de raphia, fermoir en bois sculpté	https://picsum.photos/seed/textile-232/500/400	10000.00	24000.00	98	1	2026-04-02 13:00:34.274175	15	24	f
257	Cardamome Verte des Hautes Terres	Gousses de cardamome fraîches, arôme eucalyptique et citronné	https://picsum.photos/seed/vanilla-233/600/500	4100.00	9800.00	258	1	2026-04-02 13:00:34.280747	23	24	f
262	Robe Brodée Antananarivo Naturel	Robe artisanale à broderies florales faites main en coton local	https://picsum.photos/seed/fabric-239/600/500	17000.00	39700.00	119	1	2026-04-02 13:00:34.358015	15	15	f
267	Pareo Batik Nosy Be Naturel	Pareo technique batik aux motifs marins tropicaux	https://picsum.photos/seed/fabric-244/400/400	7700.00	17600.00	15	1	2026-04-02 13:00:34.443908	15	19	f
231	Bague Corail Rouge Naturel	Bague en argent 925 sertie d'un corail rouge naturel de l'océan Indien	https://picsum.photos/seed/ring-245/600/400	14000.00	32600.00	82	1	2026-04-02 13:00:33.826735	16	15	f
268	Hamac Coton Tressé Export	Hamac artisanal en coton résistant, capacité 120kg	https://picsum.photos/seed/trekking-248/400/500	11000.00	25600.00	192	1	2026-04-02 13:00:34.483507	21	22	f
271	Masque Traditionnel Sakalava Naturel	Masque cérémoniel authentique sculpté dans du bois d'ébène	https://picsum.photos/seed/wood-carving-252/500/500	14000.00	35400.00	100	1	2026-04-02 13:00:34.52809	19	24	f
273	Flûte Sodina Export	Flûte traversière traditionnelle en bambou, gamme pentatonique	https://picsum.photos/seed/painting-255/500/400	7900.00	18700.00	283	1	2026-04-02 13:00:34.553595	20	20	f
274	Café Robusta du Sud Naturel	Café robusta corsé et intense, idéal pour espresso traditionnel	https://picsum.photos/seed/coffee-256/400/500	3700.00	8400.00	73	1	2026-04-02 13:00:34.562904	17	16	f
276	Sirop de Sucre de Palme Bio	Nectar naturel de palmier raphia, index glycémique bas	https://picsum.photos/seed/coconut-260/600/400	3600.00	8100.00	101	1	2026-04-02 13:00:34.585884	14	21	f
254	Feuilles de Moringa Séchées Local	Feuilles déshydratées à basse température, valeur nutritive maximale	https://picsum.photos/seed/organic-261/500/400	2700.00	6300.00	479	1	2026-04-02 13:00:34.245101	18	24	f
277	Thé Vert de Fianarantsoa de Madagascar	Feuilles de thé vert fraîches, légèrement herbacées et délicates	https://picsum.photos/seed/tea-263/400/500	3500.00	8600.00	195	1	2026-04-02 13:00:34.612678	17	21	f
279	Boucles Oreilles Raffia Doré de Madagascar	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/ring-265/600/500	4400.00	10400.00	279	1	2026-04-02 13:00:34.622665	16	22	f
280	Poivre Rose de Bourbon des Hautes Terres	Baies roses rares, légèrement sucrées et poivrées	https://picsum.photos/seed/vanilla-266/600/500	5600.00	13400.00	235	1	2026-04-02 13:00:34.630887	23	20	f
281	Huile de Coco Vierge des Hautes Terres	Huile de noix de coco pressée à froid, certifiée bio	https://picsum.photos/seed/honey-267/400/400	6800.00	16200.00	150	1	2026-04-02 13:00:34.636	14	23	f
253	Café Moka Bourbon des Hautes Terres	Café de qualité supérieure aux arômes fruités et caramel	https://picsum.photos/seed/coffee-293/500/500	8000.00	18200.00	325	1	2026-04-02 13:00:34.23763	17	24	f
258	Vanille de Madagascar Bourbon	Gousses de vanille premium grade A, parfum intense et floral, cultivées dans la région SAVA	https://picsum.photos/seed/ginger-307/500/500	8500.00	19100.00	44	1	2026-04-02 13:00:34.285794	23	18	f
261	Curcuma Bio	Racines de curcuma séchées et moulues, riches en curcumine, couleur dorée intense	https://picsum.photos/seed/pepper-953/600/400	1700.00	4500.00	325	1	2026-04-02 13:00:34.309034	23	18	f
247	Huile de Tamanu Naturel	Huile cicatrisante extraite des noix de tamanu de la côte Est	https://picsum.photos/seed/organic-423/500/400	11100.00	26600.00	447	1	2026-04-02 13:00:34.052081	22	23	f
252	Boucles Oreilles Raffia Doré Naturel	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/necklace-428/400/400	3500.00	8300.00	372	1	2026-04-02 13:00:34.231908	16	21	f
263	Bague Corail Rouge Naturel des Hautes Terres	Bague en argent 925 sertie d'un corail rouge naturel de l'océan Indien	https://picsum.photos/seed/ring-587/400/400	15700.00	36700.00	196	1	2026-04-02 13:00:34.380207	16	20	f
270	Café Robusta du Sud Artisanal	Café robusta corsé et intense, idéal pour espresso traditionnel	https://picsum.photos/seed/coffee-525/600/500	3900.00	8700.00	436	1	2026-04-02 13:00:34.518029	17	17	f
278	Kit Snorkeling Corail Naturel	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/hammock-557/400/500	17100.00	40000.00	464	1	2026-04-02 13:00:34.617534	21	21	f
265	Tamarin Concentré de Madagascar	Pâte de tamarin naturelle, acidulée et fruitée	https://picsum.photos/seed/vanilla-632/500/400	1200.00	3100.00	148	1	2026-04-02 13:00:34.417382	23	23	f
275	Filet de Pêche Artisanal Naturel	Filet tressé à la main par pêcheurs du littoral Ouest	https://picsum.photos/seed/hammock-895/400/400	7100.00	16900.00	493	1	2026-04-02 13:00:34.580231	21	20	f
260	Affiche Vintage Tananarive Export	Reproduction d'affiche coloniale de Tananarive années 1930	https://picsum.photos/seed/music-instrument-934/600/400	5400.00	12600.00	231	1	2026-04-02 13:00:34.298162	20	15	f
259	Café Moka Bourbon Artisanal	Café de qualité supérieure aux arômes fruités et caramel	https://picsum.photos/seed/tea-804/500/400	6200.00	14100.00	258	1	2026-04-02 13:00:34.29313	17	24	f
269	Rhum Arrangé Vanille-Épices Artisanal	Rhum artisanal infusé vanille, cannelle et clous de girofle	https://picsum.photos/seed/coconut-829/500/400	10600.00	24800.00	94	1	2026-04-02 13:00:34.508001	14	17	f
248	Hamac Coton Tressé des Hautes Terres	Hamac artisanal en coton résistant, capacité 120kg	https://picsum.photos/seed/travel-872/500/400	13500.00	31600.00	348	1	2026-04-02 13:00:34.110413	21	15	f
266	Guide Faune Malgache Illustré	Livre illustré de 200 espèces endémiques de Madagascar	https://picsum.photos/seed/snorkeling-983/600/400	7400.00	16700.00	137	1	2026-04-02 13:00:34.43135	21	17	f
272	Baume Lèvres Cacao-Vanille	Baume protecteur naturel au beurre de cacao et vanille bourbon	https://picsum.photos/seed/skincare-902/400/400	2200.00	5200.00	118	1	2026-04-02 13:00:34.540987	22	23	f
251	Thé Vert de Fianarantsoa Bio	Feuilles de thé vert fraîches, légèrement herbacées et délicates	https://picsum.photos/seed/tea-992/500/400	3800.00	9200.00	307	1	2026-04-02 13:00:34.163191	17	20	f
282	Boucles Oreilles Raffia Doré des Hautes Terres	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/bracelet-268/600/500	3900.00	9300.00	129	1	2026-04-02 13:00:34.648941	16	18	f
264	Tisane Ravintsara Export	Feuilles de ravintsara séchées, antibactérien naturel, saveur camphrée	https://picsum.photos/seed/coffee-269/500/400	4500.00	10000.00	343	1	2026-04-02 13:00:34.39918	17	17	f
284	Confiture de Goyave	Confiture maison de goyave rose, peu sucrée et riche en fruits	https://picsum.photos/seed/chocolate-273/500/500	2500.00	6000.00	72	1	2026-04-02 13:00:34.687839	14	17	f
287	Djembé Malgache Local	Tambour djembé sculpté main en bois de manguier et peau de chèvre	https://picsum.photos/seed/music-instrument-276/400/400	21000.00	50400.00	167	1	2026-04-02 13:00:34.705302	20	22	f
290	Kabosy Mini Artisanal	Petite guitare folk malgache à 4 cordes, bois artisanal local	https://picsum.photos/seed/painting-283/600/400	17100.00	41000.00	226	1	2026-04-02 13:00:34.749041	20	19	f
292	Café Moka Bourbon Premium	Café de qualité supérieure aux arômes fruités et caramel	https://picsum.photos/seed/coffee-285/600/500	7600.00	17500.00	352	1	2026-04-02 13:00:34.761855	17	23	f
294	Tamarin Concentré Local	Pâte de tamarin naturelle, acidulée et fruitée	https://picsum.photos/seed/ginger-289/400/400	1300.00	3200.00	164	1	2026-04-02 13:00:34.789278	23	21	f
299	Cannelle de Madagascar Naturel	Bâtons de cannelle de Ceylan cultivés localement, douce et légèrement citronnée	https://picsum.photos/seed/cinnamon-297/500/400	2100.00	5900.00	239	1	2026-04-02 13:00:34.852251	23	24	f
302	Bijou Argent Antaimoro Naturel	Bracelet filigrane argent façonné selon techniques ancestrales	https://picsum.photos/seed/handicraft-300/400/500	9000.00	22500.00	101	1	2026-04-02 13:00:34.881037	19	24	f
303	Gingembre Séché Local	Gingembre de montagne séché, saveur piquante et citronnée	https://picsum.photos/seed/ginger-302/400/400	1600.00	3900.00	407	1	2026-04-02 13:00:34.896534	23	24	f
305	Tableau Peinture Lokanga Premium	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/music-instrument-304/400/500	10600.00	24700.00	442	1	2026-04-02 13:00:34.911729	20	16	f
306	Huile de Tamanu Artisanal	Huile cicatrisante extraite des noix de tamanu de la côte Est	https://picsum.photos/seed/organic-305/500/500	11200.00	26900.00	173	1	2026-04-02 13:00:34.917225	22	22	f
307	Sac à Main Raphia Naturel Local	Sac tissé en fibres de raphia, fermoir en bois sculpté	https://picsum.photos/seed/bag-306/400/400	8600.00	20700.00	312	1	2026-04-02 13:00:34.926697	15	18	f
309	Gingembre Séché de Madagascar	Gingembre de montagne séché, saveur piquante et citronnée	https://picsum.photos/seed/spices-309/400/500	2000.00	5100.00	345	1	2026-04-02 13:00:34.955151	23	16	f
293	Collier Perle d'Eau Douce Bio	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/bracelet-342/500/400	16000.00	37300.00	319	1	2026-04-02 13:00:34.767003	16	19	f
296	Tableau Peinture Lokanga Local	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/music-instrument-454/500/500	10900.00	25500.00	8	1	2026-04-02 13:00:34.809233	20	15	f
301	Collier Perle d'Eau Douce des Hautes Terres	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/jewelry-775/400/400	19800.00	46100.00	173	1	2026-04-02 13:00:34.870454	16	18	f
314	Huile de Coco Vierge	Huile de noix de coco pressée à froid, certifiée bio	https://picsum.photos/seed/coconut-996/500/500	7100.00	16900.00	344	1	2026-04-02 13:00:35.022502	14	17	f
288	Boucles Oreilles Raffia Doré Export	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/ring-437/400/500	4600.00	10800.00	93	1	2026-04-02 13:00:34.712174	16	19	f
286	Carte Topographique Madagascar Export	Carte détaillée au 1/500000 de l'ensemble du territoire	https://picsum.photos/seed/hammock-915/400/500	4500.00	10900.00	14	1	2026-04-02 13:00:34.700527	21	17	f
297	Sac à Main Raphia Naturel	Sac tissé en fibres de raphia, fermoir en bois sculpté	https://picsum.photos/seed/fabric-522/600/500	8900.00	21400.00	120	1	2026-04-02 13:00:34.827329	15	17	f
308	Poivre Rose de Bourbon Export	Baies roses rares, légèrement sucrées et poivrées	https://picsum.photos/seed/cinnamon-958/600/500	5100.00	12300.00	484	1	2026-04-02 13:00:34.94693	23	18	f
289	Parure Turquoise Afrique Premium	Ensemble collier-boucles en turquoise africaine naturelle	https://picsum.photos/seed/bracelet-614/400/500	11500.00	26800.00	377	1	2026-04-02 13:00:34.724298	16	19	f
283	Sacoche Zébu Cuir Local	Sacoche en cuir de zébu tanné naturellement, robuste et unique	https://picsum.photos/seed/fabric-625/600/500	20100.00	47500.00	344	1	2026-04-02 13:00:34.683424	15	24	f
285	Café Moka Bourbon de Madagascar	Café de qualité supérieure aux arômes fruités et caramel	https://picsum.photos/seed/coffee-689/400/500	6300.00	14400.00	220	1	2026-04-02 13:00:34.695203	17	19	f
291	Collier Perles de Mer	Collier fait de perles de mer naturelles de Nosy Be	https://picsum.photos/seed/handicraft-713/400/400	7400.00	18600.00	250	1	2026-04-02 13:00:34.754225	19	17	f
300	Tamarin Concentré Artisanal	Pâte de tamarin naturelle, acidulée et fruitée	https://picsum.photos/seed/ginger-717/500/500	1100.00	2600.00	487	1	2026-04-02 13:00:34.863503	23	24	f
311	Collier Perle d'Eau Douce Artisanal	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/ring-725/400/400	15700.00	36700.00	206	1	2026-04-02 13:00:34.979173	16	16	f
298	Djembé Malgache de Madagascar	Tambour djembé sculpté main en bois de manguier et peau de chèvre	https://picsum.photos/seed/art-756/400/500	17700.00	42600.00	73	1	2026-04-02 13:00:34.833997	20	15	f
304	Pendentif Oeil de Tigre Premium	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/bracelet-787/600/400	7600.00	18000.00	33	1	2026-04-02 13:00:34.901436	16	24	f
310	Sirop de Sucre de Palme Premium	Nectar naturel de palmier raphia, index glycémique bas	https://picsum.photos/seed/honey-843/600/500	3600.00	8100.00	367	1	2026-04-02 13:00:34.971951	14	16	f
313	Chips de Banane Séchée	Chips de banane séchée au soleil, légèrement caramélisées	https://picsum.photos/seed/coconut-848/600/500	1300.00	3400.00	415	1	2026-04-02 13:00:35.004034	14	21	f
316	Affiche Vintage Tananarive de Madagascar	Reproduction d'affiche coloniale de Tananarive années 1930	https://picsum.photos/seed/music-instrument-871/400/400	5800.00	13600.00	159	1	2026-04-02 13:00:35.069907	20	23	f
295	Thé Vert de Fianarantsoa Export	Feuilles de thé vert fraîches, légèrement herbacées et délicates	https://picsum.photos/seed/tea-945/600/500	3100.00	7600.00	207	1	2026-04-02 13:00:34.803015	17	16	f
197	Carte Topographique Madagascar Artisanal	Carte détaillée au 1/500000 de l'ensemble du territoire	https://picsum.photos/seed/trekking-966/400/400	4400.00	10500.00	336	1	2026-04-02 13:00:33.477415	21	18	f
317	Huile Essentielle Ravintsara	Huile pure de ravintsara distillée, puissant immunostimulant naturel	https://picsum.photos/seed/essential-oil-322/400/400	10200.00	23900.00	328	1	2026-04-02 13:00:35.096444	22	23	f
315	Affiche Vintage Tananarive	Reproduction d'affiche coloniale de Tananarive années 1930	https://picsum.photos/seed/painting-335/600/500	6800.00	15900.00	317	1	2026-04-02 13:00:35.048051	20	17	f
324	Sacoche Zébu Cuir Premium	Sacoche en cuir de zébu tanné naturellement, robuste et unique	https://picsum.photos/seed/fabric-336/400/400	21200.00	50100.00	330	1	2026-04-02 13:00:35.417326	15	21	f
325	Bijou Argent Antaimoro des Hautes Terres	Bracelet filigrane argent façonné selon techniques ancestrales	https://picsum.photos/seed/wood-carving-337/400/500	9600.00	24100.00	21	1	2026-04-02 13:00:35.426455	19	20	f
326	Chapeau de Paille Malagasy Artisanal	Chapeau tressé à la main en paille de vétiver naturel	https://picsum.photos/seed/handicraft-338/400/500	4400.00	10500.00	369	1	2026-04-02 13:00:35.436692	19	20	f
327	Eau Florale de Géranium Local	Hydrolat pur de géranium rosat, tonifiant et équilibrant	https://picsum.photos/seed/skincare-341/500/500	3800.00	9000.00	482	1	2026-04-02 13:00:35.476139	22	16	f
329	Gingembre Séché Naturel	Gingembre de montagne séché, saveur piquante et citronnée	https://picsum.photos/seed/vanilla-344/600/400	2000.00	5100.00	135	1	2026-04-02 13:00:35.505701	23	21	f
330	Chocolat Noir 75% Cacao Naturel	Tablette de chocolat fabriquée avec cacao trinitario malgache	https://picsum.photos/seed/honey-345/600/500	3900.00	9200.00	111	1	2026-04-02 13:00:35.514742	14	23	f
333	Broderie Lamba Malgache Artisanal	Tissu traditionnel brodé main aux motifs géométriques colorés	https://picsum.photos/seed/wood-carving-348/600/500	11900.00	29700.00	228	1	2026-04-02 13:00:35.542708	19	17	f
334	Sandales Cuir Artisanales Bio	Sandales cuir tannées main, semelles en caoutchouc naturel	https://picsum.photos/seed/bag-349/400/400	13000.00	30300.00	314	1	2026-04-02 13:00:35.553128	15	17	f
337	Collier Perles de Mer Premium	Collier fait de perles de mer naturelles de Nosy Be	https://picsum.photos/seed/pottery-352/500/500	6800.00	17000.00	9	1	2026-04-02 13:00:35.574857	19	24	f
338	Cannelle de Madagascar Premium	Bâtons de cannelle de Ceylan cultivés localement, douce et légèrement citronnée	https://picsum.photos/seed/spices-353/400/500	2100.00	5700.00	234	1	2026-04-02 13:00:35.583353	23	18	f
339	Hamac Coton Tressé Local	Hamac artisanal en coton résistant, capacité 120kg	https://picsum.photos/seed/travel-357/400/400	12300.00	28700.00	444	1	2026-04-02 13:00:35.860114	21	17	f
335	Café Vert Non Torréfié Export	Café vert pour méthode lente, riche en antioxydants	https://picsum.photos/seed/coffee-358/600/500	8800.00	19800.00	348	1	2026-04-02 13:00:35.558342	17	15	f
343	Feuilles de Moringa Séchées Premium	Feuilles déshydratées à basse température, valeur nutritive maximale	https://picsum.photos/seed/seeds-363/600/400	2900.00	6700.00	64	1	2026-04-02 13:00:35.917423	18	24	f
344	Sculpture en Bois de Palissandre de Madagascar	Statuette sculptée à la main représentant un zébu, bois précieux malgache	https://picsum.photos/seed/wood-carving-365/600/400	22700.00	59100.00	465	1	2026-04-02 13:00:35.937398	19	21	f
345	Sirop de Cannelle Naturel de Madagascar	Sirop artisanal à la cannelle, sans conservateurs ni colorants	https://picsum.photos/seed/chocolate-369/500/400	3100.00	7300.00	9	1	2026-04-02 13:00:35.983578	14	22	f
346	Café Moka Bourbon	Café de qualité supérieure aux arômes fruités et caramel	https://picsum.photos/seed/coffee-370/400/400	6200.00	14200.00	489	1	2026-04-02 13:00:35.993054	17	23	f
347	Masque Traditionnel Sakalava Local	Masque cérémoniel authentique sculpté dans du bois d'ébène	https://picsum.photos/seed/pottery-371/600/400	16600.00	42000.00	153	1	2026-04-02 13:00:36.00196	19	18	f
349	Bambou Séché Décoratif de Madagascar	Tiges de bambou de Madagascar, séchées et traitées naturellement	https://picsum.photos/seed/nature-373/400/400	4600.00	10800.00	303	1	2026-04-02 13:00:36.021723	18	23	f
350	Tisane Ravintsara Premium	Feuilles de ravintsara séchées, antibactérien naturel, saveur camphrée	https://picsum.photos/seed/herbs-375/400/400	4100.00	9000.00	119	1	2026-04-02 13:00:36.045562	17	23	f
348	Chevalière Argent Massif Local	Bague chevalière en argent 925, initiale gravée à la main	https://picsum.photos/seed/jewelry-396/500/500	17200.00	41200.00	337	1	2026-04-02 13:00:36.012448	16	21	f
331	Sacoche Zébu Cuir des Hautes Terres	Sacoche en cuir de zébu tanné naturellement, robuste et unique	https://picsum.photos/seed/textile-874/500/500	24600.00	58100.00	86	1	2026-04-02 13:00:35.524037	15	22	f
323	Sac à Dos Trekking Raphia Artisanal	Sac robuste en fibres naturelles pour randonnée en forêt	https://picsum.photos/seed/snorkeling-828/400/500	8800.00	21200.00	16	1	2026-04-02 13:00:35.392432	21	19	f
322	Sculpture en Bois de Palissandre Naturel	Statuette sculptée à la main représentant un zébu, bois précieux malgache	https://picsum.photos/seed/handicraft-535/600/400	25100.00	65400.00	488	1	2026-04-02 13:00:35.381484	19	16	f
320	Affiche Vintage Tananarive des Hautes Terres	Reproduction d'affiche coloniale de Tananarive années 1930	https://picsum.photos/seed/art-543/400/500	5300.00	12300.00	242	1	2026-04-02 13:00:35.250461	20	19	f
340	Girofle de Maroantsetra Artisanal	Clous de girofle séchés, huile essentielle naturellement riche	https://picsum.photos/seed/pepper-550/600/500	2800.00	6600.00	333	1	2026-04-02 13:00:35.881885	23	18	f
328	Bracelet Laiton Gravé de Madagascar	Bracelet jonc en laiton gravé de proverbes malgaches	https://picsum.photos/seed/jewelry-580/400/400	5600.00	13000.00	414	1	2026-04-02 13:00:35.496587	16	22	f
336	Eau Florale de Géranium Naturel	Hydrolat pur de géranium rosat, tonifiant et équilibrant	https://picsum.photos/seed/essential-oil-663/500/400	3800.00	9100.00	80	1	2026-04-02 13:00:35.569073	22	20	f
319	Pendentif Oeil de Tigre Export	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/jewelry-700/500/500	9100.00	21600.00	452	1	2026-04-02 13:00:35.21711	16	18	f
341	Sirop de Cannelle Naturel Artisanal	Sirop artisanal à la cannelle, sans conservateurs ni colorants	https://picsum.photos/seed/honey-762/500/500	3400.00	8000.00	446	1	2026-04-02 13:00:35.889699	14	20	f
173	Café Robusta du Sud de Madagascar	Café robusta corsé et intense, idéal pour espresso traditionnel	https://picsum.photos/seed/coffee-796/400/400	4100.00	9300.00	393	1	2026-04-02 13:00:33.225199	17	22	f
318	Infusion Centella Asiatica de Madagascar	Plante médicinale malgache pour la circulation et la mémoire	https://picsum.photos/seed/tea-905/600/500	3400.00	7900.00	153	1	2026-04-02 13:00:35.156658	17	17	f
321	Filet de Pêche Artisanal de Madagascar	Filet tressé à la main par pêcheurs du littoral Ouest	https://picsum.photos/seed/hammock-933/500/400	9200.00	21800.00	279	1	2026-04-02 13:00:35.324813	21	19	f
342	Cire d'Abeille Pure Export	Cire naturelle des ruches malgaches, non blanchie, idéale cosmétique	https://picsum.photos/seed/nature-986/400/500	4900.00	11900.00	337	1	2026-04-02 13:00:35.908707	18	24	f
351	Compost Naturel de Zébu Local	Fumier de zébu composté, engrais naturel riche en azote	https://picsum.photos/seed/plants-376/500/400	3200.00	7400.00	157	1	2026-04-02 13:00:36.058332	18	21	f
352	Café Vert Non Torréfié	Café vert pour méthode lente, riche en antioxydants	https://picsum.photos/seed/coffee-377/400/400	8600.00	19500.00	347	1	2026-04-02 13:00:36.067331	17	15	f
354	Robe Brodée Antananarivo des Hautes Terres	Robe artisanale à broderies florales faites main en coton local	https://picsum.photos/seed/fabric-379/600/500	18400.00	43000.00	411	1	2026-04-02 13:00:36.094732	15	17	f
356	Infusion Centella Asiatica Export	Plante médicinale malgache pour la circulation et la mémoire	https://picsum.photos/seed/herbs-383/500/500	3000.00	7000.00	239	1	2026-04-02 13:00:36.129272	17	20	f
358	Panier Tressé en Raphia Premium	Panier traditionnel fait main par les artisanes des hautes terres	https://picsum.photos/seed/basket-387/500/400	7300.00	18200.00	348	1	2026-04-02 13:00:36.193426	19	16	f
360	Guide Faune Malgache Illustré Naturel	Livre illustré de 200 espèces endémiques de Madagascar	https://picsum.photos/seed/trekking-389/600/500	8100.00	18100.00	7	1	2026-04-02 13:00:36.217819	21	19	f
363	Bracelet Laiton Gravé Bio	Bracelet jonc en laiton gravé de proverbes malgaches	https://picsum.photos/seed/necklace-392/500/400	6200.00	14400.00	262	1	2026-04-02 13:00:36.242523	16	17	f
364	Collier Perles de Mer Local	Collier fait de perles de mer naturelles de Nosy Be	https://picsum.photos/seed/basket-393/600/500	8400.00	20900.00	311	1	2026-04-02 13:00:36.252524	19	20	f
357	Béret Laine des Hautes Terres Premium	Béret tricoté main en pure laine de mouton des Hautes Terres	https://picsum.photos/seed/fabric-982/500/400	5900.00	13800.00	426	1	2026-04-02 13:00:36.169015	15	21	f
367	Hamac Coton Tressé Bio	Hamac artisanal en coton résistant, capacité 120kg	https://picsum.photos/seed/travel-398/500/400	13600.00	31700.00	427	1	2026-04-02 13:00:36.304358	21	16	f
369	Pendentif Oeil de Tigre de Madagascar	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/ring-402/600/400	8100.00	19300.00	446	1	2026-04-02 13:00:36.342392	16	21	f
370	Djembé Malgache des Hautes Terres	Tambour djembé sculpté main en bois de manguier et peau de chèvre	https://picsum.photos/seed/art-403/600/500	19200.00	46100.00	150	1	2026-04-02 13:00:36.352173	20	16	f
372	Confiture de Goyave Export	Confiture maison de goyave rose, peu sucrée et riche en fruits	https://picsum.photos/seed/honey-406/600/400	2100.00	5200.00	105	1	2026-04-02 13:00:36.374717	14	18	f
375	Polo Homme en Coton Bio Export	Polo coupe classique taillé dans du coton biologique local	https://picsum.photos/seed/bag-412/400/500	7000.00	16700.00	317	1	2026-04-02 13:00:36.487198	15	18	f
377	Compost Naturel de Zébu Naturel	Fumier de zébu composté, engrais naturel riche en azote	https://picsum.photos/seed/seeds-416/500/400	2600.00	6200.00	26	1	2026-04-02 13:00:36.527487	18	23	f
381	Baume Lèvres Cacao-Vanille Export	Baume protecteur naturel au beurre de cacao et vanille bourbon	https://picsum.photos/seed/organic-425/600/400	2700.00	6400.00	311	1	2026-04-02 13:00:36.71768	22	17	f
355	Beurre de Karité Pur Bio	Beurre de karité non raffiné, idéal cuisine et cosmétique	https://picsum.photos/seed/chocolate-426/400/400	7500.00	17100.00	103	1	2026-04-02 13:00:36.105919	14	24	f
385	Poudre de Moringa Bio Local	Superfood en poudre, 90 nutriments essentiels concentrés	https://picsum.photos/seed/skincare-887/400/500	5600.00	13000.00	254	1	2026-04-02 13:00:36.838914	22	17	f
361	Bracelet Laiton Gravé	Bracelet jonc en laiton gravé de proverbes malgaches	https://picsum.photos/seed/ring-461/600/500	6600.00	15300.00	323	1	2026-04-02 13:00:36.224734	16	23	f
353	Flûte Sodina Premium	Flûte traversière traditionnelle en bambou, gamme pentatonique	https://picsum.photos/seed/painting-777/600/400	8400.00	20000.00	139	1	2026-04-02 13:00:36.076383	20	23	f
362	Poivre Rose de Bourbon Naturel	Baies roses rares, légèrement sucrées et poivrées	https://picsum.photos/seed/pepper-977/600/400	5500.00	13200.00	57	1	2026-04-02 13:00:36.235397	23	22	f
379	Tableau Peinture Lokanga Bio	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/music-instrument-573/600/400	11300.00	26400.00	355	1	2026-04-02 13:00:36.570178	20	22	f
384	Flûte Sodina	Flûte traversière traditionnelle en bambou, gamme pentatonique	https://picsum.photos/seed/art-621/500/400	6900.00	16400.00	104	1	2026-04-02 13:00:36.828353	20	21	f
374	Tableau Peinture Lokanga Export	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/music-instrument-661/400/500	13000.00	30400.00	263	1	2026-04-02 13:00:36.464746	20	18	f
365	Sacoche Zébu Cuir Artisanal	Sacoche en cuir de zébu tanné naturellement, robuste et unique	https://picsum.photos/seed/dress-698/400/500	20900.00	49500.00	324	1	2026-04-02 13:00:36.258778	15	15	f
371	Flûte Sodina Local	Flûte traversière traditionnelle en bambou, gamme pentatonique	https://picsum.photos/seed/art-736/400/500	7700.00	18200.00	295	1	2026-04-02 13:00:36.368689	20	21	f
373	Sac à Dos Trekking Raphia de Madagascar	Sac robuste en fibres naturelles pour randonnée en forêt	https://picsum.photos/seed/trekking-766/500/500	11100.00	26700.00	11	1	2026-04-02 13:00:36.384758	21	21	f
332	Savon Artisanal Ylang-Ylang Naturel	Pain de savon froid aux fleurs d'ylang-ylang, peau douce et parfumée	https://picsum.photos/seed/organic-801/600/400	3000.00	6900.00	90	1	2026-04-02 13:00:35.535519	22	21	f
368	Hamac Coton Tressé de Madagascar	Hamac artisanal en coton résistant, capacité 120kg	https://picsum.photos/seed/travel-942/500/400	12700.00	29600.00	287	1	2026-04-02 13:00:36.314178	21	21	f
383	Huile Essentielle Ravintsara Export	Huile pure de ravintsara distillée, puissant immunostimulant naturel	https://picsum.photos/seed/natural-beauty-846/400/400	13600.00	31700.00	302	1	2026-04-02 13:00:36.790526	22	20	f
359	Vanille de Madagascar Bourbon des Hautes Terres	Gousses de vanille premium grade A, parfum intense et floral, cultivées dans la région SAVA	https://picsum.photos/seed/ginger-886/400/400	7100.00	16000.00	27	1	2026-04-02 13:00:36.204193	23	17	f
366	Tabouret Bois Sculpté Naturel	Tabouret traditionnel en bois de rose avec décors symboliques	https://picsum.photos/seed/basket-943/400/500	28600.00	71500.00	147	1	2026-04-02 13:00:36.269055	19	23	f
382	Gingembre Séché Artisanal	Gingembre de montagne séché, saveur piquante et citronnée	https://picsum.photos/seed/ginger-970/600/400	1600.00	4000.00	423	1	2026-04-02 13:00:36.758589	23	21	f
380	Gingembre Séché Export	Gingembre de montagne séché, saveur piquante et citronnée	https://picsum.photos/seed/pepper-993/600/500	1700.00	4300.00	242	1	2026-04-02 13:00:36.612307	23	20	f
312	Bracelet Corne de Zébu des Hautes Terres	Bracelet sculpté dans de la corne de zébu polie naturellement	https://picsum.photos/seed/ring-998/400/400	5400.00	13000.00	156	1	2026-04-02 13:00:34.996178	16	21	f
378	Sandales Cuir Artisanales Export	Sandales cuir tannées main, semelles en caoutchouc naturel	https://picsum.photos/seed/dress-434/400/400	10300.00	24000.00	398	1	2026-04-02 13:00:36.549595	15	21	f
386	Café Moka Bourbon Export	Café de qualité supérieure aux arômes fruités et caramel	https://picsum.photos/seed/tea-435/400/500	6100.00	13900.00	280	1	2026-04-02 13:00:36.860731	17	24	f
388	Pâte de Cacao Pure Export	Pâte de cacao 100% non sucrée, saveur intense et complexe	https://picsum.photos/seed/honey-438/500/500	5400.00	12600.00	242	1	2026-04-02 13:00:36.890649	14	21	f
393	Maracas en Calebasse Naturel	Paire de maracas artisanales en calebasse séchée et graines	https://picsum.photos/seed/painting-444/500/400	3700.00	9300.00	213	1	2026-04-02 13:00:36.941629	20	15	f
394	Chips de Banane Séchée Bio	Chips de banane séchée au soleil, légèrement caramélisées	https://picsum.photos/seed/honey-446/400/400	1600.00	4200.00	332	1	2026-04-02 13:00:36.962617	14	18	f
395	Poivre Noir Sauvage	Poivre sauvage récolté à la main dans les forêts de l'Est, arôme boisé et piquant	https://picsum.photos/seed/spices-447/500/500	3900.00	8900.00	288	1	2026-04-02 13:00:36.973517	23	20	f
396	Guide Faune Malgache Illustré Premium	Livre illustré de 200 espèces endémiques de Madagascar	https://picsum.photos/seed/snorkeling-449/400/400	7200.00	16100.00	473	1	2026-04-02 13:00:36.994154	21	17	f
397	Chevalière Argent Massif de Madagascar	Bague chevalière en argent 925, initiale gravée à la main	https://picsum.photos/seed/jewelry-450/500/500	20500.00	49200.00	114	1	2026-04-02 13:00:37.00352	16	24	f
398	Parure Turquoise Afrique des Hautes Terres	Ensemble collier-boucles en turquoise africaine naturelle	https://picsum.photos/seed/jewelry-451/400/500	11300.00	26500.00	435	1	2026-04-02 13:00:37.010965	16	16	f
400	Crème Visage Baobab Export	Crème hydratante à l'huile de baobab, anti-âge et nourrissante	https://picsum.photos/seed/essential-oil-455/500/400	8200.00	19400.00	388	1	2026-04-02 13:00:37.044544	22	17	f
402	Beurre de Karité Pur Artisanal	Beurre de karité non raffiné, idéal cuisine et cosmétique	https://picsum.photos/seed/honey-457/500/500	8000.00	18400.00	274	1	2026-04-02 13:00:37.070262	14	15	f
403	Lotion Corps Corozo Bio	Lotion douce au beurre de corozo, hydratation longue durée	https://picsum.photos/seed/essential-oil-458/500/400	5800.00	13400.00	150	1	2026-04-02 13:00:37.076109	22	23	f
404	Sacoche Zébu Cuir Naturel	Sacoche en cuir de zébu tanné naturellement, robuste et unique	https://picsum.photos/seed/fabric-459/600/500	21800.00	51600.00	440	1	2026-04-02 13:00:37.087026	15	21	f
405	Bracelet Corne de Zébu Bio	Bracelet sculpté dans de la corne de zébu polie naturellement	https://picsum.photos/seed/necklace-464/400/400	5000.00	12100.00	451	1	2026-04-02 13:00:37.179419	16	17	f
406	Poudre de Moringa Bio Export	Superfood en poudre, 90 nutriments essentiels concentrés	https://picsum.photos/seed/skincare-465/600/400	5900.00	13800.00	271	1	2026-04-02 13:00:37.192207	22	18	f
407	Café Arabica des Hautes Terres Export	Grains de café arabica cultivés à 1500m d'altitude, notes chocolatées et florales	https://picsum.photos/seed/coffee-466/500/500	6800.00	15800.00	428	1	2026-04-02 13:00:37.205823	17	15	f
412	Rhum Arrangé Vanille-Épices Local	Rhum artisanal infusé vanille, cannelle et clous de girofle	https://picsum.photos/seed/chocolate-475/600/400	12700.00	29700.00	193	1	2026-04-02 13:00:37.27212	14	24	f
413	Vanille de Madagascar Bourbon Artisanal	Gousses de vanille premium grade A, parfum intense et floral, cultivées dans la région SAVA	https://picsum.photos/seed/vanilla-477/600/500	8800.00	19700.00	244	1	2026-04-02 13:00:37.290327	23	16	f
414	Châle en Soie Sauvage	Châle tissé à partir de soie d'araignée dorée de Madagascar	https://picsum.photos/seed/bag-478/400/400	21100.00	50700.00	426	1	2026-04-02 13:00:37.298353	15	23	f
416	Café Robusta du Sud Local	Café robusta corsé et intense, idéal pour espresso traditionnel	https://picsum.photos/seed/coffee-482/400/500	4300.00	9700.00	358	1	2026-04-02 13:00:37.325454	17	16	f
391	Café Moka Bourbon Naturel	Café de qualité supérieure aux arômes fruités et caramel	https://picsum.photos/seed/coffee-683/500/400	7300.00	16600.00	369	1	2026-04-02 13:00:36.925675	17	23	f
418	Savon Artisanal Ylang-Ylang Local	Pain de savon froid aux fleurs d'ylang-ylang, peau douce et parfumée	https://picsum.photos/seed/organic-486/500/500	2600.00	6100.00	57	1	2026-04-02 13:00:37.360102	22	24	f
420	Savon Artisanal Ylang-Ylang Bio	Pain de savon froid aux fleurs d'ylang-ylang, peau douce et parfumée	https://picsum.photos/seed/organic-488/600/400	3300.00	7700.00	44	1	2026-04-02 13:00:37.3747	22	21	f
415	Foulard Soie Lémuriens Bio	Foulard léger imprimé de motifs représentant les lémuriens	https://picsum.photos/seed/bag-636/600/500	10000.00	24600.00	267	1	2026-04-02 13:00:37.320058	15	15	f
409	Kabosy Mini Premium	Petite guitare folk malgache à 4 cordes, bois artisanal local	https://picsum.photos/seed/music-instrument-748/600/500	15000.00	36000.00	278	1	2026-04-02 13:00:37.227537	20	17	f
410	Bracelet Laiton Gravé Artisanal	Bracelet jonc en laiton gravé de proverbes malgaches	https://picsum.photos/seed/bracelet-611/600/400	6100.00	14300.00	315	1	2026-04-02 13:00:37.235988	16	21	f
390	Carnet Papier Antaimoro Local	Carnet artisanal en papier fait main avec fleurs et feuilles pressées	https://picsum.photos/seed/pottery-642/600/400	4000.00	9900.00	323	1	2026-04-02 13:00:36.91894	19	16	f
399	Infusion Centella Asiatica Naturel	Plante médicinale malgache pour la circulation et la mémoire	https://picsum.photos/seed/herbs-868/400/500	3200.00	7500.00	306	1	2026-04-02 13:00:37.020567	17	20	f
389	Poivre Noir Sauvage Premium	Poivre sauvage récolté à la main dans les forêts de l'Est, arôme boisé et piquant	https://picsum.photos/seed/cinnamon-679/600/400	3000.00	6800.00	83	1	2026-04-02 13:00:36.900594	23	18	f
411	Cardamome Verte Bio	Gousses de cardamome fraîches, arôme eucalyptique et citronné	https://picsum.photos/seed/pepper-920/600/400	4000.00	9400.00	120	1	2026-04-02 13:00:37.264541	23	23	f
408	Huile de Tamanu	Huile cicatrisante extraite des noix de tamanu de la côte Est	https://picsum.photos/seed/organic-834/600/400	11000.00	26300.00	409	1	2026-04-02 13:00:37.213453	22	23	f
387	Charbon de Bois Premium de Madagascar	Charbon dur longue combustion, issu de forêts gérées durablement	https://picsum.photos/seed/nature-858/400/500	2600.00	6300.00	73	1	2026-04-02 13:00:36.870886	18	21	f
419	Flûte Sodina des Hautes Terres	Flûte traversière traditionnelle en bambou, gamme pentatonique	https://picsum.photos/seed/painting-941/400/500	6800.00	16200.00	108	1	2026-04-02 13:00:37.369856	20	23	f
417	Tableau Peinture Lokanga Artisanal	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/music-instrument-972/600/400	11100.00	26000.00	401	1	2026-04-02 13:00:37.334606	20	22	f
392	Carte Topographique Madagascar Local	Carte détaillée au 1/500000 de l'ensemble du territoire	https://picsum.photos/seed/travel-991/400/400	4800.00	11600.00	295	1	2026-04-02 13:00:36.933529	21	18	f
422	Bambou Séché Décoratif Premium	Tiges de bambou de Madagascar, séchées et traitées naturellement	https://picsum.photos/seed/nature-492/600/400	3700.00	8800.00	205	1	2026-04-02 13:00:37.405778	18	20	f
423	Chevalière Argent Massif Artisanal	Bague chevalière en argent 925, initiale gravée à la main	https://picsum.photos/seed/ring-493/600/400	20600.00	49400.00	72	1	2026-04-02 13:00:37.426239	16	17	f
424	Sirop de Cannelle Naturel Local	Sirop artisanal à la cannelle, sans conservateurs ni colorants	https://picsum.photos/seed/chocolate-496/600/400	3200.00	7400.00	396	1	2026-04-02 13:00:37.481913	14	19	f
425	Boucles Oreilles Raffia Doré Premium	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/necklace-497/500/500	3900.00	9400.00	25	1	2026-04-02 13:00:37.501797	16	16	f
426	Chips de Banane Séchée de Madagascar	Chips de banane séchée au soleil, légèrement caramélisées	https://picsum.photos/seed/coconut-498/400/400	1300.00	3400.00	101	1	2026-04-02 13:00:37.52233	14	21	f
427	Chocolat Noir 75% Cacao Premium	Tablette de chocolat fabriquée avec cacao trinitario malgache	https://picsum.photos/seed/coconut-500/600/500	4100.00	9700.00	106	1	2026-04-02 13:00:37.575413	14	17	f
428	Confiture de Goyave Premium	Confiture maison de goyave rose, peu sucrée et riche en fruits	https://picsum.photos/seed/chocolate-501/400/500	2400.00	5700.00	341	1	2026-04-02 13:00:37.595872	14	18	f
429	Lamba Mena Traditionnel Bio	Tissu de soie traditionnel malgache aux couleurs naturelles vives	https://picsum.photos/seed/fabric-502/600/400	27000.00	64800.00	478	1	2026-04-02 13:00:37.614202	15	19	f
376	Cire d'Abeille Pure Artisanal	Cire naturelle des ruches malgaches, non blanchie, idéale cosmétique	https://picsum.photos/seed/seeds-504/500/500	4600.00	11000.00	404	1	2026-04-02 13:00:36.493084	18	16	f
401	Collier Perle d'Eau Douce Premium	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/bracelet-507/600/500	19000.00	44300.00	493	1	2026-04-02 13:00:37.055696	16	17	f
430	Sandales Cuir Artisanales	Sandales cuir tannées main, semelles en caoutchouc naturel	https://picsum.photos/seed/fabric-508/400/500	12100.00	28300.00	313	1	2026-04-02 13:00:37.750798	15	22	f
431	Kit Snorkeling Corail de Madagascar	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/snorkeling-509/600/400	14700.00	34400.00	222	1	2026-04-02 13:00:37.759046	21	21	f
435	Semences Haricot Malagasy Local	Variété locale non hybridée de haricots rouges traditionnels	https://picsum.photos/seed/seeds-515/400/400	1900.00	4900.00	126	1	2026-04-02 13:00:37.797341	18	15	f
436	Valiha Bambou Artisanale Artisanal	Cithare tubulaire traditionnelle malgache en bambou, 21 cordes	https://picsum.photos/seed/art-516/600/500	31100.00	75500.00	126	1	2026-04-02 13:00:37.80723	20	23	f
438	Mélange Romazava de Madagascar	Mélange traditionnel de feuilles pour le plat national malgache	https://picsum.photos/seed/spices-520/500/500	2200.00	5200.00	201	1	2026-04-02 13:00:37.833568	23	20	f
439	Miel de Litchi de Nosy Be de Madagascar	Miel monofloral de litchi, goût floral délicat, récolte artisanale	https://picsum.photos/seed/chocolate-521/500/500	5100.00	12200.00	293	1	2026-04-02 13:00:37.85529	14	16	f
440	Parure Turquoise Afrique Export	Ensemble collier-boucles en turquoise africaine naturelle	https://picsum.photos/seed/bracelet-523/500/400	10400.00	24300.00	298	1	2026-04-02 13:00:37.899252	16	20	f
441	Broderie Lamba Malgache Bio	Tissu traditionnel brodé main aux motifs géométriques colorés	https://picsum.photos/seed/wood-carving-529/600/500	12000.00	30100.00	37	1	2026-04-02 13:00:38.042922	19	17	f
443	Cannelle de Madagascar des Hautes Terres	Bâtons de cannelle de Ceylan cultivés localement, douce et légèrement citronnée	https://picsum.photos/seed/spices-533/600/500	1900.00	5300.00	216	1	2026-04-02 13:00:38.118062	23	21	f
444	Valiha Bambou Artisanale Premium	Cithare tubulaire traditionnelle malgache en bambou, 21 cordes	https://picsum.photos/seed/music-instrument-534/400/500	39400.00	95600.00	202	1	2026-04-02 13:00:38.135014	20	20	f
448	Curcuma Bio Export	Racines de curcuma séchées et moulues, riches en curcumine, couleur dorée intense	https://picsum.photos/seed/pepper-540/600/500	1500.00	4000.00	25	1	2026-04-02 13:00:38.236019	23	18	f
449	Guide Faune Malgache Illustré Artisanal	Livre illustré de 200 espèces endémiques de Madagascar	https://picsum.photos/seed/hammock-541/600/500	7000.00	15700.00	405	1	2026-04-02 13:00:38.254294	21	15	f
450	Panier Tressé en Raphia	Panier traditionnel fait main par les artisanes des hautes terres	https://picsum.photos/seed/handicraft-542/400/400	7900.00	19800.00	47	1	2026-04-02 13:00:38.285768	19	24	f
454	Guide Faune Malgache Illustré des Hautes Terres	Livre illustré de 200 espèces endémiques de Madagascar	https://picsum.photos/seed/hammock-553/400/500	7200.00	16100.00	442	1	2026-04-02 13:00:38.45657	21	23	f
433	Cannelle de Madagascar Artisanal	Bâtons de cannelle de Ceylan cultivés localement, douce et légèrement citronnée	https://picsum.photos/seed/ginger-606/600/500	2100.00	5800.00	178	1	2026-04-02 13:00:37.783389	23	23	f
445	Hamac Coton Tressé	Hamac artisanal en coton résistant, capacité 120kg	https://picsum.photos/seed/travel-650/400/500	11000.00	25700.00	369	1	2026-04-02 13:00:38.175462	21	20	f
434	Vase en Terre Cuite Naturel	Poterie artisanale décorée de motifs animaliers malgaches	https://picsum.photos/seed/wood-carving-654/500/400	6800.00	16900.00	384	1	2026-04-02 13:00:37.792532	19	21	f
451	Tamarin Concentré Naturel	Pâte de tamarin naturelle, acidulée et fruitée	https://picsum.photos/seed/vanilla-765/500/500	1300.00	3300.00	298	1	2026-04-02 13:00:38.360905	23	24	f
453	Charbon de Bois Premium des Hautes Terres	Charbon dur longue combustion, issu de forêts gérées durablement	https://picsum.photos/seed/organic-730/600/400	2200.00	5300.00	285	1	2026-04-02 13:00:38.412478	18	20	f
432	Bambou Séché Décoratif des Hautes Terres	Tiges de bambou de Madagascar, séchées et traitées naturellement	https://picsum.photos/seed/seeds-742/400/400	4100.00	9800.00	143	1	2026-04-02 13:00:37.777195	18	23	f
437	Cardamome Verte Local	Gousses de cardamome fraîches, arôme eucalyptique et citronné	https://picsum.photos/seed/ginger-759/400/400	3700.00	8700.00	366	1	2026-04-02 13:00:37.815143	23	18	f
229	Charbon de Bois Premium Premium	Charbon dur longue combustion, issu de forêts gérées durablement	https://picsum.photos/seed/seeds-794/400/400	2200.00	5400.00	322	1	2026-04-02 13:00:33.785794	18	17	f
447	Plants Ylang-Ylang des Hautes Terres	Jeunes plants d'ylang-ylang pour cultivation, prêts à repiquer	https://picsum.photos/seed/plants-798/600/400	5400.00	13000.00	325	1	2026-04-02 13:00:38.222335	18	19	f
452	Boucles Oreilles Raffia Doré Artisanal	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/necklace-800/600/500	4300.00	10300.00	68	1	2026-04-02 13:00:38.378409	16	23	f
446	Flûte Sodina Bio	Flûte traversière traditionnelle en bambou, gamme pentatonique	https://picsum.photos/seed/art-971/400/400	8900.00	21100.00	444	1	2026-04-02 13:00:38.209208	20	21	f
456	Lamba Mena Traditionnel	Tissu de soie traditionnel malgache aux couleurs naturelles vives	https://picsum.photos/seed/bag-560/600/500	26600.00	63800.00	64	1	2026-04-02 13:00:38.541093	15	22	f
457	Bracelet Laiton Gravé Export	Bracelet jonc en laiton gravé de proverbes malgaches	https://picsum.photos/seed/jewelry-561/500/500	6000.00	13900.00	110	1	2026-04-02 13:00:38.548236	16	24	f
458	Huile Massage Jasmin Premium	Huile de massage relaxante aux fleurs de jasmin malgache	https://picsum.photos/seed/organic-564/400/500	6000.00	13600.00	198	1	2026-04-02 13:00:38.588352	22	23	f
459	Poivre Noir Sauvage de Madagascar	Poivre sauvage récolté à la main dans les forêts de l'Est, arôme boisé et piquant	https://picsum.photos/seed/vanilla-565/400/400	3100.00	7200.00	391	1	2026-04-02 13:00:38.615771	23	24	f
460	Tisane Ravintsara Bio	Feuilles de ravintsara séchées, antibactérien naturel, saveur camphrée	https://picsum.photos/seed/herbs-566/500/500	5000.00	11200.00	232	1	2026-04-02 13:00:38.634646	17	22	f
462	Huile de Coco Vierge Artisanal	Huile de noix de coco pressée à froid, certifiée bio	https://picsum.photos/seed/chocolate-572/500/500	7200.00	17000.00	338	1	2026-04-02 13:00:38.727195	14	16	f
463	Sucre de Canne Non Raffiné Local	Sucre brun artisanal de canne à sucre locale, arôme mélasse	https://picsum.photos/seed/food-574/400/500	1500.00	3600.00	291	1	2026-04-02 13:00:38.757036	14	15	f
464	Bambou Séché Décoratif Bio	Tiges de bambou de Madagascar, séchées et traitées naturellement	https://picsum.photos/seed/organic-575/400/400	3900.00	9300.00	112	1	2026-04-02 13:00:38.777774	18	24	f
442	Huile Massage Jasmin	Huile de massage relaxante aux fleurs de jasmin malgache	https://picsum.photos/seed/skincare-576/500/500	7600.00	17500.00	164	1	2026-04-02 13:00:38.071231	22	15	f
465	Beurre de Karité Pur	Beurre de karité non raffiné, idéal cuisine et cosmétique	https://picsum.photos/seed/coconut-578/500/400	6200.00	14300.00	467	1	2026-04-02 13:00:38.879889	14	22	f
466	Eau Florale de Géranium Artisanal	Hydrolat pur de géranium rosat, tonifiant et équilibrant	https://picsum.photos/seed/essential-oil-581/400/400	3600.00	8500.00	310	1	2026-04-02 13:00:38.929936	22	17	f
467	Crème Visage Baobab Naturel	Crème hydratante à l'huile de baobab, anti-âge et nourrissante	https://picsum.photos/seed/skincare-583/500/500	9100.00	21500.00	44	1	2026-04-02 13:00:38.956349	22	15	f
468	Girofle de Maroantsetra Local	Clous de girofle séchés, huile essentielle naturellement riche	https://picsum.photos/seed/cinnamon-584/400/400	2800.00	6500.00	411	1	2026-04-02 13:00:38.982387	23	20	f
471	Parure Turquoise Afrique de Madagascar	Ensemble collier-boucles en turquoise africaine naturelle	https://picsum.photos/seed/bracelet-588/400/500	11900.00	27800.00	224	1	2026-04-02 13:00:39.076489	16	17	f
472	Béret Laine des Hautes Terres de Madagascar	Béret tricoté main en pure laine de mouton des Hautes Terres	https://picsum.photos/seed/bag-589/400/400	6000.00	14100.00	228	1	2026-04-02 13:00:39.103253	15	19	f
473	Châle en Soie Sauvage Export	Châle tissé à partir de soie d'araignée dorée de Madagascar	https://picsum.photos/seed/bag-590/400/400	21200.00	50800.00	383	1	2026-04-02 13:00:39.126063	15	15	f
475	Cannelle de Madagascar Bio	Bâtons de cannelle de Ceylan cultivés localement, douce et légèrement citronnée	https://picsum.photos/seed/pepper-593/500/400	2000.00	5400.00	449	1	2026-04-02 13:00:39.145683	23	15	f
476	Savon Artisanal Ylang-Ylang Artisanal	Pain de savon froid aux fleurs d'ylang-ylang, peau douce et parfumée	https://picsum.photos/seed/essential-oil-594/600/500	2700.00	6200.00	202	1	2026-04-02 13:00:39.170587	22	18	f
477	Djembé Malgache	Tambour djembé sculpté main en bois de manguier et peau de chèvre	https://picsum.photos/seed/painting-596/500/400	18900.00	45400.00	151	1	2026-04-02 13:00:39.182086	20	16	f
481	Lamba Mena Traditionnel Premium	Tissu de soie traditionnel malgache aux couleurs naturelles vives	https://picsum.photos/seed/dress-600/500/500	21500.00	51700.00	347	1	2026-04-02 13:00:39.227121	15	22	f
483	Thé Hibiscus Rouge Bio	Fleurs d'hibiscus séchées, infusion rouge rubis acidulée	https://picsum.photos/seed/coffee-603/500/500	1700.00	4400.00	355	1	2026-04-02 13:00:39.297354	17	21	f
486	Bracelet Corne de Zébu Artisanal	Bracelet sculpté dans de la corne de zébu polie naturellement	https://picsum.photos/seed/jewelry-608/400/500	5000.00	11900.00	493	1	2026-04-02 13:00:39.397393	16	21	f
487	Béret Laine des Hautes Terres	Béret tricoté main en pure laine de mouton des Hautes Terres	https://picsum.photos/seed/textile-610/600/400	6700.00	15500.00	298	1	2026-04-02 13:00:39.433058	15	21	f
488	Tableau Peinture Lokanga Naturel	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/painting-612/500/400	11500.00	26900.00	449	1	2026-04-02 13:00:39.491792	20	17	f
489	Café Vert Non Torréfié Artisanal	Café vert pour méthode lente, riche en antioxydants	https://picsum.photos/seed/coffee-613/500/400	9000.00	20200.00	57	1	2026-04-02 13:00:39.521689	17	19	f
478	Kabosy Mini des Hautes Terres	Petite guitare folk malgache à 4 cordes, bois artisanal local	https://picsum.photos/seed/music-instrument-615/600/400	16200.00	38800.00	263	1	2026-04-02 13:00:39.192955	20	21	f
480	Djembé Malgache Export	Tambour djembé sculpté main en bois de manguier et peau de chèvre	https://picsum.photos/seed/art-644/600/400	20200.00	48500.00	132	1	2026-04-02 13:00:39.210955	20	24	f
470	Confiture de Goyave des Hautes Terres	Confiture maison de goyave rose, peu sucrée et riche en fruits	https://picsum.photos/seed/chocolate-769/600/400	2500.00	6000.00	228	1	2026-04-02 13:00:39.029968	14	23	f
461	Confiture de Goyave de Madagascar	Confiture maison de goyave rose, peu sucrée et riche en fruits	https://picsum.photos/seed/coconut-854/600/400	2500.00	6000.00	286	1	2026-04-02 13:00:38.683696	14	24	f
479	Pareo Batik Nosy Be Premium	Pareo technique batik aux motifs marins tropicaux	https://picsum.photos/seed/bag-864/600/500	6500.00	14800.00	92	1	2026-04-02 13:00:39.201598	15	20	f
474	Chocolat Noir 75% Cacao Export	Tablette de chocolat fabriquée avec cacao trinitario malgache	https://picsum.photos/seed/food-876/600/500	3400.00	8100.00	317	1	2026-04-02 13:00:39.136291	14	18	f
484	Bambou Séché Décoratif Naturel	Tiges de bambou de Madagascar, séchées et traitées naturellement	https://picsum.photos/seed/nature-882/400/500	4300.00	10300.00	246	1	2026-04-02 13:00:39.310388	18	20	f
485	Masque Traditionnel Sakalava Export	Masque cérémoniel authentique sculpté dans du bois d'ébène	https://picsum.photos/seed/basket-919/400/400	13400.00	34000.00	186	1	2026-04-02 13:00:39.321131	19	15	f
469	Compost Naturel de Zébu Export	Fumier de zébu composté, engrais naturel riche en azote	https://picsum.photos/seed/nature-948/600/400	3300.00	7600.00	338	1	2026-04-02 13:00:39.01601	18	19	f
482	Kit Snorkeling Corail Local	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/trekking-965/600/500	17200.00	40200.00	382	1	2026-04-02 13:00:39.284984	21	22	f
490	Sculpture en Bois de Palissandre des Hautes Terres	Statuette sculptée à la main représentant un zébu, bois précieux malgache	https://picsum.photos/seed/wood-carving-616/500/500	23200.00	60400.00	322	1	2026-04-02 13:00:39.578391	19	19	f
491	Foulard Soie Lémuriens Premium	Foulard léger imprimé de motifs représentant les lémuriens	https://picsum.photos/seed/dress-617/500/400	8000.00	19700.00	180	1	2026-04-02 13:00:39.587156	15	17	f
493	Collier Perle d'Eau Douce Naturel	Collier de perles d'eau douce de lac Alaotra, lustre nacré	https://picsum.photos/seed/necklace-624/400/500	18200.00	42400.00	242	1	2026-04-02 13:00:39.661936	16	16	f
495	Collier Perles de Mer Naturel	Collier fait de perles de mer naturelles de Nosy Be	https://picsum.photos/seed/handicraft-628/400/500	9100.00	22700.00	92	1	2026-04-02 13:00:39.6992	19	20	f
496	Boucles Oreilles Raffia Doré Bio	Créoles légères en fils de raphia teint à l'or naturel	https://picsum.photos/seed/ring-629/400/400	4000.00	9600.00	291	1	2026-04-02 13:00:39.703994	16	20	f
498	Filet de Pêche Artisanal Bio	Filet tressé à la main par pêcheurs du littoral Ouest	https://picsum.photos/seed/trekking-633/400/400	7500.00	17800.00	41	1	2026-04-02 13:00:39.836008	21	20	f
499	Savon Charbon Actif Malagasy de Madagascar	Savon détoxifiant au charbon de bois de coco activé	https://picsum.photos/seed/organic-634/400/400	3700.00	8500.00	11	1	2026-04-02 13:00:39.876112	22	18	f
500	Semences Haricot Malagasy Naturel	Variété locale non hybridée de haricots rouges traditionnels	https://picsum.photos/seed/organic-635/500/500	2100.00	5200.00	124	1	2026-04-02 13:00:39.924103	18	18	f
501	Cire d'Abeille Pure Local	Cire naturelle des ruches malgaches, non blanchie, idéale cosmétique	https://picsum.photos/seed/plants-637/600/500	5500.00	13100.00	372	1	2026-04-02 13:00:40.111185	18	15	f
503	Cire d'Abeille Pure	Cire naturelle des ruches malgaches, non blanchie, idéale cosmétique	https://picsum.photos/seed/organic-639/600/400	5200.00	12500.00	35	1	2026-04-02 13:00:40.140764	18	22	f
504	Savon Charbon Actif Malagasy Premium	Savon détoxifiant au charbon de bois de coco activé	https://picsum.photos/seed/skincare-640/600/500	3800.00	8600.00	396	1	2026-04-02 13:00:40.149232	22	24	f
505	Affiche Vintage Tananarive Artisanal	Reproduction d'affiche coloniale de Tananarive années 1930	https://picsum.photos/seed/painting-643/600/500	5300.00	12500.00	450	1	2026-04-02 13:00:40.185058	20	21	f
506	Mélange Romazava des Hautes Terres	Mélange traditionnel de feuilles pour le plat national malgache	https://picsum.photos/seed/pepper-645/600/400	2600.00	6200.00	298	1	2026-04-02 13:00:40.207076	23	23	f
507	Café Arabica des Hautes Terres de Madagascar	Grains de café arabica cultivés à 1500m d'altitude, notes chocolatées et florales	https://picsum.photos/seed/herbs-646/500/500	6100.00	14100.00	145	1	2026-04-02 13:00:40.21563	17	24	f
508	Guide Faune Malgache Illustré Bio	Livre illustré de 200 espèces endémiques de Madagascar	https://picsum.photos/seed/travel-647/600/400	8700.00	19600.00	426	1	2026-04-02 13:00:40.227072	21	16	f
509	Compost Naturel de Zébu des Hautes Terres	Fumier de zébu composté, engrais naturel riche en azote	https://picsum.photos/seed/seeds-648/500/400	2700.00	6300.00	53	1	2026-04-02 13:00:40.235129	18	21	f
510	Plants Ylang-Ylang Naturel	Jeunes plants d'ylang-ylang pour cultivation, prêts à repiquer	https://picsum.photos/seed/organic-649/600/500	4600.00	10900.00	260	1	2026-04-02 13:00:40.246582	18	20	f
513	Chips de Banane Séchée Artisanal	Chips de banane séchée au soleil, légèrement caramélisées	https://picsum.photos/seed/honey-657/500/400	1400.00	3500.00	441	1	2026-04-02 13:00:40.332451	14	16	f
514	Thé Hibiscus Rouge Artisanal	Fleurs d'hibiscus séchées, infusion rouge rubis acidulée	https://picsum.photos/seed/coffee-660/600/500	2000.00	5100.00	298	1	2026-04-02 13:00:40.364325	17	17	f
511	Parure Turquoise Afrique Local	Ensemble collier-boucles en turquoise africaine naturelle	https://picsum.photos/seed/ring-662/500/500	12900.00	30100.00	210	1	2026-04-02 13:00:40.273649	16	24	f
515	Poivre Noir Sauvage des Hautes Terres	Poivre sauvage récolté à la main dans les forêts de l'Est, arôme boisé et piquant	https://picsum.photos/seed/ginger-664/600/400	3100.00	7100.00	497	1	2026-04-02 13:00:40.406258	23	20	f
518	Mélange Romazava Local	Mélange traditionnel de feuilles pour le plat national malgache	https://picsum.photos/seed/vanilla-671/400/500	2400.00	5700.00	134	1	2026-04-02 13:00:40.481906	23	24	f
455	Kabosy Mini de Madagascar	Petite guitare folk malgache à 4 cordes, bois artisanal local	https://picsum.photos/seed/music-instrument-672/600/500	13700.00	32900.00	411	1	2026-04-02 13:00:38.518086	20	20	f
519	Compost Naturel de Zébu	Fumier de zébu composté, engrais naturel riche en azote	https://picsum.photos/seed/nature-674/500/400	3200.00	7500.00	56	1	2026-04-02 13:00:40.505818	18	22	f
520	Semences Haricot Malagasy Bio	Variété locale non hybridée de haricots rouges traditionnels	https://picsum.photos/seed/seeds-675/400/500	1900.00	4900.00	19	1	2026-04-02 13:00:40.514422	18	24	f
521	Figurine Lémuriens Local	Famille de lémuriens sculptés en bois d'acajou local	https://picsum.photos/seed/wood-carving-676/600/400	7700.00	18800.00	498	1	2026-04-02 13:00:40.524036	19	15	f
512	Carte Topographique Madagascar de Madagascar	Carte détaillée au 1/500000 de l'ensemble du territoire	https://picsum.photos/seed/trekking-677/400/500	5400.00	13100.00	449	1	2026-04-02 13:00:40.296343	21	15	f
522	Robe Brodée Antananarivo Local	Robe artisanale à broderies florales faites main en coton local	https://picsum.photos/seed/fabric-678/500/500	20500.00	47800.00	309	1	2026-04-02 13:00:40.540313	15	21	f
524	Masque Traditionnel Sakalava de Madagascar	Masque cérémoniel authentique sculpté dans du bois d'ébène	https://picsum.photos/seed/basket-684/600/400	14800.00	37600.00	382	1	2026-04-02 13:00:40.59113	19	17	f
516	Pendentif Oeil de Tigre Local	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/bracelet-817/500/500	8900.00	21100.00	370	1	2026-04-02 13:00:40.437784	16	21	f
494	Sérum Hydratant Moringa	Sérum léger à l'huile de moringa, riche en vitamines A et E	https://picsum.photos/seed/natural-beauty-990/600/500	9400.00	21900.00	70	1	2026-04-02 13:00:39.684506	22	17	f
492	Sac à Main Raphia Naturel de Madagascar	Sac tissé en fibres de raphia, fermoir en bois sculpté	https://picsum.photos/seed/fabric-897/500/400	9400.00	22600.00	84	1	2026-04-02 13:00:39.650528	15	17	f
523	Tabouret Bois Sculpté des Hautes Terres	Tabouret traditionnel en bois de rose avec décors symboliques	https://picsum.photos/seed/basket-908/600/400	28200.00	70500.00	350	1	2026-04-02 13:00:40.567424	19	16	f
517	Huile de Tamanu Export	Huile cicatrisante extraite des noix de tamanu de la côte Est	https://picsum.photos/seed/organic-925/600/400	11400.00	27300.00	187	1	2026-04-02 13:00:40.44595	22	17	f
502	Maracas en Calebasse des Hautes Terres	Paire de maracas artisanales en calebasse séchée et graines	https://picsum.photos/seed/art-967/500/500	4200.00	10400.00	95	1	2026-04-02 13:00:40.11878	20	19	f
527	Thé Hibiscus Rouge de Madagascar	Fleurs d'hibiscus séchées, infusion rouge rubis acidulée	https://picsum.photos/seed/coffee-690/500/400	2200.00	5600.00	343	1	2026-04-02 13:00:40.658601	17	16	f
528	Pareo Batik Nosy Be Bio	Pareo technique batik aux motifs marins tropicaux	https://picsum.photos/seed/textile-691/400/500	7600.00	17500.00	157	1	2026-04-02 13:00:40.669154	15	24	f
530	Carnet Papier Antaimoro Bio	Carnet artisanal en papier fait main avec fleurs et feuilles pressées	https://picsum.photos/seed/basket-694/400/400	4400.00	11100.00	317	1	2026-04-02 13:00:40.715372	19	17	f
531	Sirop de Cannelle Naturel	Sirop artisanal à la cannelle, sans conservateurs ni colorants	https://picsum.photos/seed/honey-696/400/400	3000.00	6900.00	220	1	2026-04-02 13:00:40.739696	14	15	f
532	Pareo Batik Nosy Be de Madagascar	Pareo technique batik aux motifs marins tropicaux	https://picsum.photos/seed/dress-697/500/500	7400.00	16800.00	226	1	2026-04-02 13:00:40.748862	15	16	f
534	Cannelle de Madagascar Local	Bâtons de cannelle de Ceylan cultivés localement, douce et légèrement citronnée	https://picsum.photos/seed/cinnamon-701/600/500	2000.00	5500.00	286	1	2026-04-02 13:00:40.790404	23	23	f
535	Tisane Ravintsara Artisanal	Feuilles de ravintsara séchées, antibactérien naturel, saveur camphrée	https://picsum.photos/seed/coffee-703/600/500	4800.00	10800.00	10	1	2026-04-02 13:00:40.819957	17	23	f
539	Infusion Centella Asiatica Local	Plante médicinale malgache pour la circulation et la mémoire	https://picsum.photos/seed/herbs-788/600/500	3000.00	7000.00	303	1	2026-04-02 13:00:40.892258	17	17	f
536	Curcuma Bio Premium	Racines de curcuma séchées et moulues, riches en curcumine, couleur dorée intense	https://picsum.photos/seed/spices-705/500/500	1400.00	3800.00	333	1	2026-04-02 13:00:40.85869	23	15	f
537	Carnet Papier Antaimoro	Carnet artisanal en papier fait main avec fleurs et feuilles pressées	https://picsum.photos/seed/wood-carving-707/500/400	4300.00	10700.00	380	1	2026-04-02 13:00:40.87156	19	20	f
538	Kit Snorkeling Corail Premium	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/snorkeling-708/400/400	16100.00	37600.00	83	1	2026-04-02 13:00:40.883319	21	22	f
540	Feuilles de Moringa Séchées Artisanal	Feuilles déshydratées à basse température, valeur nutritive maximale	https://picsum.photos/seed/organic-714/400/400	3000.00	7100.00	184	1	2026-04-02 13:00:41.03327	18	21	f
541	Chocolat Noir 75% Cacao de Madagascar	Tablette de chocolat fabriquée avec cacao trinitario malgache	https://picsum.photos/seed/honey-718/500/400	4500.00	10600.00	297	1	2026-04-02 13:00:41.160423	14	22	f
542	Cire d'Abeille Pure Bio	Cire naturelle des ruches malgaches, non blanchie, idéale cosmétique	https://picsum.photos/seed/plants-720/400/400	5600.00	13400.00	360	1	2026-04-02 13:00:41.192286	18	18	f
549	Bambou Séché Décoratif Local	Tiges de bambou de Madagascar, séchées et traitées naturellement	https://picsum.photos/seed/nature-790/600/500	4200.00	9900.00	322	1	2026-04-02 13:00:41.41664	18	16	f
548	Eau Florale de Géranium Export	Hydrolat pur de géranium rosat, tonifiant et équilibrant	https://picsum.photos/seed/essential-oil-732/400/400	4100.00	9800.00	160	1	2026-04-02 13:00:41.400675	22	17	f
550	Mélange Romazava Bio	Mélange traditionnel de feuilles pour le plat national malgache	https://picsum.photos/seed/cinnamon-734/500/400	2800.00	6700.00	197	1	2026-04-02 13:00:41.431632	23	17	f
551	Plants Ylang-Ylang de Madagascar	Jeunes plants d'ylang-ylang pour cultivation, prêts à repiquer	https://picsum.photos/seed/plants-735/500/500	5000.00	12000.00	34	1	2026-04-02 13:00:41.444322	18	15	f
552	Sérum Hydratant Moringa de Madagascar	Sérum léger à l'huile de moringa, riche en vitamines A et E	https://picsum.photos/seed/organic-737/500/500	8600.00	20100.00	194	1	2026-04-02 13:00:41.46832	22	23	f
553	Sirop de Cannelle Naturel Naturel	Sirop artisanal à la cannelle, sans conservateurs ni colorants	https://picsum.photos/seed/food-738/400/500	2700.00	6200.00	106	1	2026-04-02 13:00:41.493096	14	22	f
554	Sirop de Sucre de Palme des Hautes Terres	Nectar naturel de palmier raphia, index glycémique bas	https://picsum.photos/seed/honey-740/600/400	4400.00	9900.00	332	1	2026-04-02 13:00:41.520009	14	18	f
556	Huile de Coco Vierge Premium	Huile de noix de coco pressée à froid, certifiée bio	https://picsum.photos/seed/chocolate-743/400/400	7800.00	18500.00	292	1	2026-04-02 13:00:41.559003	14	19	f
497	Baume Lèvres Cacao-Vanille Naturel	Baume protecteur naturel au beurre de cacao et vanille bourbon	https://picsum.photos/seed/skincare-747/400/400	2500.00	5900.00	149	1	2026-04-02 13:00:39.725828	22	18	f
557	Carnet Papier Antaimoro Naturel	Carnet artisanal en papier fait main avec fleurs et feuilles pressées	https://picsum.photos/seed/wood-carving-749/600/500	4500.00	11200.00	100	1	2026-04-02 13:00:41.650498	19	15	f
525	Confiture de Coco Artisanale Naturel	Confiture oncteuse à la noix de coco fraîche et caramel	https://picsum.photos/seed/coconut-751/500/400	3200.00	8100.00	29	1	2026-04-02 13:00:40.602674	14	20	f
555	Tableau Peinture Lokanga de Madagascar	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/art-805/500/500	13200.00	30700.00	456	1	2026-04-02 13:00:41.532733	20	24	f
559	Plants Ylang-Ylang Local	Jeunes plants d'ylang-ylang pour cultivation, prêts à repiquer	https://picsum.photos/seed/plants-754/500/500	5100.00	12200.00	390	1	2026-04-02 13:00:41.718821	18	21	f
533	Valiha Bambou Artisanale Naturel	Cithare tubulaire traditionnelle malgache en bambou, 21 cordes	https://picsum.photos/seed/art-786/400/500	36800.00	89400.00	97	1	2026-04-02 13:00:40.766355	20	24	f
544	Polo Homme en Coton Bio Bio	Polo coupe classique taillé dans du coton biologique local	https://picsum.photos/seed/bag-911/400/400	9000.00	21500.00	177	1	2026-04-02 13:00:41.302372	15	21	f
543	Confiture de Coco Artisanale Premium	Confiture oncteuse à la noix de coco fraîche et caramel	https://picsum.photos/seed/honey-851/600/500	3000.00	7400.00	314	1	2026-04-02 13:00:41.240974	14	24	f
547	Café Moka Bourbon Bio	Café de qualité supérieure aux arômes fruités et caramel	https://picsum.photos/seed/herbs-909/500/500	6600.00	15000.00	317	1	2026-04-02 13:00:41.384887	17	18	f
558	Valiha Bambou Artisanale des Hautes Terres	Cithare tubulaire traditionnelle malgache en bambou, 21 cordes	https://picsum.photos/seed/art-917/600/500	37200.00	90300.00	406	1	2026-04-02 13:00:41.697317	20	24	f
529	Poudre de Moringa Bio Naturel	Superfood en poudre, 90 nutriments essentiels concentrés	https://picsum.photos/seed/organic-922/500/400	5500.00	12700.00	338	1	2026-04-02 13:00:40.684475	22	17	f
545	Sac à Main Raphia Naturel Naturel	Sac tissé en fibres de raphia, fermoir en bois sculpté	https://picsum.photos/seed/textile-926/500/400	11100.00	26700.00	272	1	2026-04-02 13:00:41.341124	15	22	f
546	Vase en Terre Cuite Bio	Poterie artisanale décorée de motifs animaliers malgaches	https://picsum.photos/seed/handicraft-960/600/500	5300.00	13300.00	329	1	2026-04-02 13:00:41.352842	19	17	f
560	Sirop de Sucre de Palme Naturel	Nectar naturel de palmier raphia, index glycémique bas	https://picsum.photos/seed/food-755/500/400	4100.00	9200.00	238	1	2026-04-02 13:00:41.728288	14	23	f
561	Sérum Hydratant Moringa Bio	Sérum léger à l'huile de moringa, riche en vitamines A et E	https://picsum.photos/seed/organic-761/600/400	10100.00	23500.00	477	1	2026-04-02 13:00:41.807107	22	15	f
562	Mélange Romazava Premium	Mélange traditionnel de feuilles pour le plat national malgache	https://picsum.photos/seed/cinnamon-763/600/400	2200.00	5400.00	301	1	2026-04-02 13:00:41.835975	23	20	f
563	Parure Turquoise Afrique Naturel	Ensemble collier-boucles en turquoise africaine naturelle	https://picsum.photos/seed/jewelry-767/600/500	12200.00	28400.00	28	1	2026-04-02 13:00:41.89057	16	16	f
564	Huile de Ricin Brute	Huile de ricin pressée à froid, usage cosmétique et industriel	https://picsum.photos/seed/plants-770/500/500	3500.00	7900.00	287	1	2026-04-02 13:00:41.927033	18	17	f
565	Crème Visage Baobab Artisanal	Crème hydratante à l'huile de baobab, anti-âge et nourrissante	https://picsum.photos/seed/organic-772/400/400	7000.00	16600.00	200	1	2026-04-02 13:00:41.947067	22	19	f
526	Foulard Soie Lémuriens Export	Foulard léger imprimé de motifs représentant les lémuriens	https://picsum.photos/seed/bag-776/500/400	10200.00	24900.00	378	1	2026-04-02 13:00:40.637945	15	16	f
567	Sandales Cuir Artisanales Premium	Sandales cuir tannées main, semelles en caoutchouc naturel	https://picsum.photos/seed/dress-779/600/500	12800.00	29800.00	302	1	2026-04-02 13:00:42.020187	15	22	f
568	Tapis Raphia Naturel	Tapis tissé main en fibres de raphia naturel non teint	https://picsum.photos/seed/handicraft-782/500/500	15400.00	38500.00	473	1	2026-04-02 13:00:42.056034	19	15	f
569	Huile de Ricin Brute Premium	Huile de ricin pressée à froid, usage cosmétique et industriel	https://picsum.photos/seed/seeds-785/600/400	4000.00	9100.00	446	1	2026-04-02 13:00:42.096598	18	19	f
571	Châle en Soie Sauvage Local	Châle tissé à partir de soie d'araignée dorée de Madagascar	https://picsum.photos/seed/textile-791/600/400	19700.00	47200.00	202	1	2026-04-02 13:00:42.222002	15	18	f
572	Huile de Ricin Brute des Hautes Terres	Huile de ricin pressée à froid, usage cosmétique et industriel	https://picsum.photos/seed/nature-792/500/400	3500.00	7900.00	436	1	2026-04-02 13:00:42.236388	18	21	f
573	Tapis Raphia Naturel Naturel	Tapis tissé main en fibres de raphia naturel non teint	https://picsum.photos/seed/handicraft-793/400/500	18600.00	46400.00	79	1	2026-04-02 13:00:42.25518	19	15	f
574	Tapis Raphia Naturel Local	Tapis tissé main en fibres de raphia naturel non teint	https://picsum.photos/seed/pottery-795/400/400	15400.00	38500.00	139	1	2026-04-02 13:00:42.282819	19	24	f
576	Maracas en Calebasse Artisanal	Paire de maracas artisanales en calebasse séchée et graines	https://picsum.photos/seed/painting-799/400/500	4300.00	10600.00	390	1	2026-04-02 13:00:42.336149	20	22	f
577	Huile Essentielle Ravintsara Local	Huile pure de ravintsara distillée, puissant immunostimulant naturel	https://picsum.photos/seed/skincare-806/500/400	11600.00	27000.00	376	1	2026-04-02 13:00:42.466147	22	23	f
578	Cardamome Verte	Gousses de cardamome fraîches, arôme eucalyptique et citronné	https://picsum.photos/seed/spices-813/400/500	3500.00	8400.00	35	1	2026-04-02 13:00:42.556332	23	18	f
579	Sacoche Zébu Cuir de Madagascar	Sacoche en cuir de zébu tanné naturellement, robuste et unique	https://picsum.photos/seed/textile-816/500/400	21700.00	51200.00	307	1	2026-04-02 13:00:42.618623	15	21	f
581	Infusion Centella Asiatica	Plante médicinale malgache pour la circulation et la mémoire	https://picsum.photos/seed/coffee-824/600/500	3000.00	6900.00	176	1	2026-04-02 13:00:42.73343	17	20	f
582	Maracas en Calebasse Export	Paire de maracas artisanales en calebasse séchée et graines	https://picsum.photos/seed/music-instrument-825/500/400	3800.00	9400.00	323	1	2026-04-02 13:00:42.743061	20	24	f
583	Pendentif Oeil de Tigre	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/ring-826/500/500	8000.00	18900.00	122	1	2026-04-02 13:00:42.749357	16	19	f
584	Polo Homme en Coton Bio des Hautes Terres	Polo coupe classique taillé dans du coton biologique local	https://picsum.photos/seed/dress-827/500/500	7900.00	18800.00	116	1	2026-04-02 13:00:42.758235	15	23	f
585	Vanille de Madagascar Bourbon Bio	Gousses de vanille premium grade A, parfum intense et floral, cultivées dans la région SAVA	https://picsum.photos/seed/ginger-832/500/400	8200.00	18400.00	2	1	2026-04-02 13:00:42.800268	23	15	f
575	Cardamome Verte Artisanal	Gousses de cardamome fraîches, arôme eucalyptique et citronné	https://picsum.photos/seed/cinnamon-837/400/500	3400.00	8100.00	212	1	2026-04-02 13:00:42.307129	23	23	f
586	Masque Argile Volcanique Export	Argile naturelle des hautes terres aux propriétés purifiantes	https://picsum.photos/seed/essential-oil-840/400/500	5400.00	13100.00	4	1	2026-04-02 13:00:42.886101	22	17	f
587	Chapeau de Paille Malagasy	Chapeau tressé à la main en paille de vétiver naturel	https://picsum.photos/seed/basket-841/400/400	4700.00	11400.00	70	1	2026-04-02 13:00:42.89467	19	17	f
589	Pareo Batik Nosy Be Local	Pareo technique batik aux motifs marins tropicaux	https://picsum.photos/seed/dress-844/500/500	7700.00	17500.00	110	1	2026-04-02 13:00:42.921907	15	17	f
590	Kit Snorkeling Corail Artisanal	Ensemble masque-tuba adapté aux récifs coralliens de Nosy Be	https://picsum.photos/seed/travel-845/600/500	13000.00	30300.00	229	1	2026-04-02 13:00:42.928641	21	17	f
591	Feuilles de Moringa Séchées de Madagascar	Feuilles déshydratées à basse température, valeur nutritive maximale	https://picsum.photos/seed/seeds-847/600/400	2800.00	6500.00	492	1	2026-04-02 13:00:42.946278	18	22	f
592	Beurre de Karité Pur des Hautes Terres	Beurre de karité non raffiné, idéal cuisine et cosmétique	https://picsum.photos/seed/honey-849/500/400	7400.00	17000.00	325	1	2026-04-02 13:00:42.964433	14	18	f
593	Café Arabica des Hautes Terres	Grains de café arabica cultivés à 1500m d'altitude, notes chocolatées et florales	https://picsum.photos/seed/tea-852/600/400	6600.00	15500.00	439	1	2026-04-02 13:00:42.992598	17	19	f
594	Huile de Coco Vierge Local	Huile de noix de coco pressée à froid, certifiée bio	https://picsum.photos/seed/food-855/600/500	7800.00	18500.00	300	1	2026-04-02 13:00:43.023614	14	16	f
580	Guide Faune Malgache Illustré Export	Livre illustré de 200 espèces endémiques de Madagascar	https://picsum.photos/seed/trekking-898/500/400	8100.00	18300.00	231	1	2026-04-02 13:00:42.675772	21	20	f
570	Hamac Coton Tressé Artisanal	Hamac artisanal en coton résistant, capacité 120kg	https://picsum.photos/seed/travel-927/400/500	10800.00	25100.00	155	1	2026-04-02 13:00:42.191951	21	15	f
566	Vanille de Madagascar Bourbon de Madagascar	Gousses de vanille premium grade A, parfum intense et floral, cultivées dans la région SAVA	https://picsum.photos/seed/vanilla-979/400/400	7300.00	16500.00	131	1	2026-04-02 13:00:41.961316	23	23	f
595	Carnet Papier Antaimoro Premium	Carnet artisanal en papier fait main avec fleurs et feuilles pressées	https://picsum.photos/seed/basket-856/400/400	4500.00	11200.00	311	1	2026-04-02 13:00:43.028999	19	16	f
596	Sandales Cuir Artisanales Local	Sandales cuir tannées main, semelles en caoutchouc naturel	https://picsum.photos/seed/dress-859/600/400	12800.00	29900.00	267	1	2026-04-02 13:00:43.053658	15	22	f
597	Thé Vert de Fianarantsoa des Hautes Terres	Feuilles de thé vert fraîches, légèrement herbacées et délicates	https://picsum.photos/seed/herbs-860/600/400	3900.00	9500.00	109	1	2026-04-02 13:00:43.061639	17	20	f
598	Huile de Ricin Brute de Madagascar	Huile de ricin pressée à froid, usage cosmétique et industriel	https://picsum.photos/seed/nature-862/400/500	4000.00	9000.00	120	1	2026-04-02 13:00:43.081131	18	24	f
599	Huile de Tamanu Premium	Huile cicatrisante extraite des noix de tamanu de la côte Est	https://picsum.photos/seed/skincare-863/500/500	9000.00	21600.00	493	1	2026-04-02 13:00:43.090593	22	21	f
600	Tapis Raphia Naturel des Hautes Terres	Tapis tissé main en fibres de raphia naturel non teint	https://picsum.photos/seed/wood-carving-865/400/400	16300.00	40700.00	14	1	2026-04-02 13:00:43.111214	19	19	f
601	Guide Faune Malgache Illustré Local	Livre illustré de 200 espèces endémiques de Madagascar	https://picsum.photos/seed/snorkeling-866/600/500	9000.00	20300.00	146	1	2026-04-02 13:00:43.117136	21	19	f
604	Chevalière Argent Massif	Bague chevalière en argent 925, initiale gravée à la main	https://picsum.photos/seed/necklace-875/500/500	19700.00	47400.00	248	1	2026-04-02 13:00:43.20877	16	16	f
605	Vanille de Madagascar Bourbon Local	Gousses de vanille premium grade A, parfum intense et floral, cultivées dans la région SAVA	https://picsum.photos/seed/spices-877/600/400	8900.00	20000.00	131	1	2026-04-02 13:00:43.227407	23	20	f
606	Pâte de Cacao Pure Naturel	Pâte de cacao 100% non sucrée, saveur intense et complexe	https://picsum.photos/seed/food-879/400/400	5200.00	12200.00	232	1	2026-04-02 13:00:43.247289	14	17	f
607	Broderie Lamba Malgache	Tissu traditionnel brodé main aux motifs géométriques colorés	https://picsum.photos/seed/wood-carving-883/600/400	12600.00	31400.00	127	1	2026-04-02 13:00:43.288562	19	17	f
588	Chocolat Noir 75% Cacao des Hautes Terres	Tablette de chocolat fabriquée avec cacao trinitario malgache	https://picsum.photos/seed/food-884/400/500	4400.00	10500.00	161	1	2026-04-02 13:00:42.902054	14	17	f
608	Café Robusta du Sud Premium	Café robusta corsé et intense, idéal pour espresso traditionnel	https://picsum.photos/seed/herbs-889/600/500	3500.00	7800.00	0	1	2026-04-02 13:00:43.375942	17	23	f
609	Tabouret Bois Sculpté Premium	Tabouret traditionnel en bois de rose avec décors symboliques	https://picsum.photos/seed/pottery-892/600/400	28600.00	71500.00	65	1	2026-04-02 13:00:43.424795	19	23	f
602	Filet de Pêche Artisanal Premium	Filet tressé à la main par pêcheurs du littoral Ouest	https://picsum.photos/seed/hammock-893/400/400	7800.00	18600.00	250	1	2026-04-02 13:00:43.128111	21	18	f
610	Polo Homme en Coton Bio Naturel	Polo coupe classique taillé dans du coton biologique local	https://picsum.photos/seed/fabric-894/600/500	8500.00	20200.00	339	1	2026-04-02 13:00:43.455855	15	20	f
611	Lamba Mena Traditionnel des Hautes Terres	Tissu de soie traditionnel malgache aux couleurs naturelles vives	https://picsum.photos/seed/dress-896/600/500	25300.00	60800.00	89	1	2026-04-02 13:00:43.530044	15	17	f
612	Djembé Malgache Naturel	Tambour djembé sculpté main en bois de manguier et peau de chèvre	https://picsum.photos/seed/music-instrument-900/600/400	18500.00	44400.00	415	1	2026-04-02 13:00:43.630169	20	22	f
613	Sirop de Sucre de Palme Artisanal	Nectar naturel de palmier raphia, index glycémique bas	https://picsum.photos/seed/chocolate-912/600/400	3600.00	8000.00	438	1	2026-04-02 13:00:43.824103	14	19	f
614	Polo Homme en Coton Bio de Madagascar	Polo coupe classique taillé dans du coton biologique local	https://picsum.photos/seed/textile-914/500/500	8600.00	20400.00	273	1	2026-04-02 13:00:43.840477	15	16	f
615	Beurre de Karité Pur Local	Beurre de karité non raffiné, idéal cuisine et cosmétique	https://picsum.photos/seed/chocolate-916/500/500	7200.00	16400.00	333	1	2026-04-02 13:00:43.880286	14	22	f
616	Girofle de Maroantsetra Export	Clous de girofle séchés, huile essentielle naturellement riche	https://picsum.photos/seed/vanilla-918/500/500	3400.00	8000.00	438	1	2026-04-02 13:00:43.907115	23	15	f
617	Foulard Soie Lémuriens Artisanal	Foulard léger imprimé de motifs représentant les lémuriens	https://picsum.photos/seed/dress-924/400/500	8300.00	20200.00	279	1	2026-04-02 13:00:43.970556	15	18	f
618	Lamba Mena Traditionnel Naturel	Tissu de soie traditionnel malgache aux couleurs naturelles vives	https://picsum.photos/seed/bag-928/500/400	22600.00	54300.00	92	1	2026-04-02 13:00:44.113627	15	23	f
619	Feuilles de Moringa Séchées Export	Feuilles déshydratées à basse température, valeur nutritive maximale	https://picsum.photos/seed/organic-929/600/400	3000.00	7100.00	111	1	2026-04-02 13:00:44.128726	18	23	f
620	Girofle de Maroantsetra de Madagascar	Clous de girofle séchés, huile essentielle naturellement riche	https://picsum.photos/seed/spices-930/400/400	3400.00	8000.00	459	1	2026-04-02 13:00:44.137152	23	23	f
621	Tableau Peinture Lokanga	Peinture sur soie représentant un paysage des Hautes Terres	https://picsum.photos/seed/music-instrument-935/400/400	13200.00	30700.00	138	1	2026-04-02 13:00:44.187992	20	21	f
622	Sucre de Canne Non Raffiné Naturel	Sucre brun artisanal de canne à sucre locale, arôme mélasse	https://picsum.photos/seed/chocolate-938/500/400	1500.00	3600.00	204	1	2026-04-02 13:00:44.256672	14	21	f
623	Café Vert Non Torréfié des Hautes Terres	Café vert pour méthode lente, riche en antioxydants	https://picsum.photos/seed/herbs-940/500/500	7400.00	16700.00	422	1	2026-04-02 13:00:44.280763	17	23	f
624	Polo Homme en Coton Bio Local	Polo coupe classique taillé dans du coton biologique local	https://picsum.photos/seed/fabric-944/500/500	9100.00	21500.00	107	1	2026-04-02 13:00:44.317603	15	16	f
625	Affiche Vintage Tananarive Naturel	Reproduction d'affiche coloniale de Tananarive années 1930	https://picsum.photos/seed/music-instrument-947/600/400	5700.00	13400.00	337	1	2026-04-02 13:00:44.344561	20	21	f
603	Sucre de Canne Non Raffiné Export	Sucre brun artisanal de canne à sucre locale, arôme mélasse	https://picsum.photos/seed/honey-950/500/500	1700.00	4000.00	427	1	2026-04-02 13:00:43.159314	14	22	f
626	Collier Perles de Mer Export	Collier fait de perles de mer naturelles de Nosy Be	https://picsum.photos/seed/handicraft-954/400/400	8500.00	21300.00	441	1	2026-04-02 13:00:44.394892	19	23	f
627	Sirop de Cannelle Naturel Premium	Sirop artisanal à la cannelle, sans conservateurs ni colorants	https://picsum.photos/seed/coconut-955/500/400	3400.00	8000.00	362	1	2026-04-02 13:00:44.399618	14	19	f
628	Tabouret Bois Sculpté Artisanal	Tabouret traditionnel en bois de rose avec décors symboliques	https://picsum.photos/seed/pottery-956/600/400	31500.00	78900.00	211	1	2026-04-02 13:00:44.410455	19	17	f
629	Pendentif Oeil de Tigre Bio	Pendentif en oeil de tigre malgache poli, monture argent	https://picsum.photos/seed/ring-957/600/400	7300.00	17200.00	310	1	2026-04-02 13:00:44.415641	16	20	f
630	Thé Hibiscus Rouge des Hautes Terres	Fleurs d'hibiscus séchées, infusion rouge rubis acidulée	https://picsum.photos/seed/coffee-961/600/400	2200.00	5500.00	264	1	2026-04-02 13:00:44.476748	17	17	f
631	Sérum Hydratant Moringa Naturel	Sérum léger à l'huile de moringa, riche en vitamines A et E	https://picsum.photos/seed/skincare-963/400/400	8100.00	18900.00	93	1	2026-04-02 13:00:44.535104	22	21	f
632	Foulard Soie Lémuriens des Hautes Terres	Foulard léger imprimé de motifs représentant les lémuriens	https://picsum.photos/seed/textile-975/600/500	9500.00	23300.00	103	1	2026-04-02 13:00:44.746336	15	19	f
633	Semences Haricot Malagasy Artisanal	Variété locale non hybridée de haricots rouges traditionnels	https://picsum.photos/seed/seeds-978/400/500	1900.00	4800.00	432	1	2026-04-02 13:00:44.768293	18	23	f
634	Broderie Lamba Malgache Local	Tissu traditionnel brodé main aux motifs géométriques colorés	https://picsum.photos/seed/pottery-987/500/500	11000.00	27600.00	273	1	2026-04-02 13:00:44.876703	19	18	f
635	Confiture de Coco Artisanale Artisanal	Confiture oncteuse à la noix de coco fraîche et caramel	https://picsum.photos/seed/honey-989/600/400	3400.00	8600.00	257	1	2026-04-02 13:00:44.905349	14	20	f
636	Savon Artisanal Ylang-Ylang	Pain de savon froid aux fleurs d'ylang-ylang, peau douce et parfumée	https://picsum.photos/seed/skincare-999/400/400	3300.00	7700.00	10	1	2026-04-02 13:00:44.997329	22	21	f
637	Chips de Banane Séchée Local	Chips de banane séchée au soleil, légèrement caramélisées	https://picsum.photos/seed/honey-0/600/500	1300.00	3300.00	216	1	2026-04-02 13:00:45.006045	14	21	f
\.


--
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.purchase (id, "entrepriseId", reference, supplier, "totalAmount", "totalPaid", "paymentStatus", notes, "createdAt", archived) FROM stdin;
2	1	0001/26		45000.00	45000.00	paid		2026-04-02 12:39:24.104663	f
3	1	0002/26		1260000.00	1260000.00	paid		2026-04-02 12:45:06.582059	f
\.


--
-- Data for Name: purchase_line; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.purchase_line (id, quantity, "unitPrice", total, "purchaseId", "productId") FROM stdin;
2	1	20000.00	20000.00	2	53
3	1	10000.00	10000.00	2	47
4	1	15000.00	15000.00	2	56
5	18	70000.00	1260000.00	3	38
\.


--
-- Data for Name: sale; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sale (id, "entrepriseId", reference, notes, "totalAmount", "totalPaid", "paymentStatus", "createdAt", "clientId", archived) FROM stdin;
1	1	0001/26		7500.00	7500.00	paid	2026-04-02 09:06:52.926302	1	f
2	1	0002/26		400000.00	4000000.00	paid	2026-04-02 09:21:49.544472	\N	f
4	1	0003/26		1185000.00	1185000.00	paid	2026-04-02 12:54:17.194895	\N	f
\.


--
-- Data for Name: sale_line; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sale_line (id, quantity, "unitPrice", total, "saleId", "productId") FROM stdin;
1	5	1500.00	7500.00	1	1
2	2	200000.00	400000.00	2	2
5	1	200000.00	200000.00	4	2
6	8	120000.00	960000.00	4	38
7	1	25000.00	25000.00	4	47
\.


--
-- Data for Name: unit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.unit (id, "entrepriseId", name, abbreviation, "createdAt", archived) FROM stdin;
1	0	Pièce	pcs	2026-04-01 12:44:39.593607	f
2	0	Kilogramme	kg	2026-04-01 12:44:39.602403	f
3	0	Litre	L	2026-04-01 12:44:39.607386	f
4	1	Piece	pcs	2026-04-01 13:15:41.532631	f
5	1	Kilogramme	kg	2026-04-01 13:15:41.532631	f
6	1	Litre	L	2026-04-01 13:15:41.532631	f
7	1	Kapoaka	kpk	2026-04-01 13:35:33.823921	f
8	1	Sac	sac	2026-04-02 09:09:26.637492	f
9	1	Tonne 	t	2026-04-02 09:11:13.860906	f
10	1	Gramme 	g	2026-04-02 09:11:22.792916	f
11	1	Mètre 	m	2026-04-02 09:11:33.539453	f
12	1	Centimètre 	cm	2026-04-02 09:11:42.436432	f
13	1	Centilitre 	cl	2026-04-02 09:11:53.103258	f
14	1	Mètre carré	m²	2026-04-02 09:13:08.28554	f
15	1	pièce	pièce	2026-04-02 13:00:32.234365	f
16	1	lot de 5	lot de 5	2026-04-02 13:00:32.234365	f
17	1	kg	kg	2026-04-02 13:00:32.234365	f
18	1	250g	250g	2026-04-02 13:00:32.234365	f
19	1	500g	500g	2026-04-02 13:00:32.234365	f
20	1	litre	litre	2026-04-02 13:00:32.234365	f
21	1	100g	100g	2026-04-02 13:00:32.234365	f
22	1	boîte	boîte	2026-04-02 13:00:32.234365	f
23	1	lot de 3	lot de 3	2026-04-02 13:00:32.234365	f
24	1	500ml	500ml	2026-04-02 13:00:32.234365	f
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (id, username, password, role, "fullName", "entrepriseId", "createdAt") FROM stdin;
1	admin	$2a$10$QfB5XrW.shkkX2Ynu6z7S.vVxZimewK7tPuWWgGuMaXPzqdROw24K	admin	\N	\N	2026-04-01 12:44:39.538553
2	smara	$2a$10$3tMbdzTz9FnaUTjRFzP7j.Cq/NjNf2CoaS8wnIpmpH8rgG74WVYzm	admin	Mara Sambelahatse	1	2026-04-01 13:15:41.552484
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.category_id_seq', 23, true);


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_seq', 2, true);


--
-- Name: entreprise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.entreprise_id_seq', 1, true);


--
-- Name: expense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.expense_id_seq', 1, false);


--
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_id_seq', 4, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_id_seq', 637, true);


--
-- Name: purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.purchase_id_seq', 3, true);


--
-- Name: purchase_line_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.purchase_line_id_seq', 5, true);


--
-- Name: sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sale_id_seq', 4, true);


--
-- Name: sale_line_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sale_line_id_seq', 7, true);


--
-- Name: unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.unit_id_seq', 24, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_id_seq', 2, true);


--
-- Name: sale_line PK_2e11b0e71b42991c92b5e1e15b0; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_line
    ADD CONSTRAINT "PK_2e11b0e71b42991c92b5e1e15b0" PRIMARY KEY (id);


--
-- Name: unit PK_4252c4be609041e559f0c80f58a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT "PK_4252c4be609041e559f0c80f58a" PRIMARY KEY (id);


--
-- Name: entreprise PK_63c75d0f90c68bc24a89e812692; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entreprise
    ADD CONSTRAINT "PK_63c75d0f90c68bc24a89e812692" PRIMARY KEY (id);


--
-- Name: purchase PK_86cc2ebeb9e17fc9c0774b05f69; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT "PK_86cc2ebeb9e17fc9c0774b05f69" PRIMARY KEY (id);


--
-- Name: purchase_line PK_965aadeec5e87dcdbda24186c05; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_line
    ADD CONSTRAINT "PK_965aadeec5e87dcdbda24186c05" PRIMARY KEY (id);


--
-- Name: client PK_96da49381769303a6515a8785c7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT "PK_96da49381769303a6515a8785c7" PRIMARY KEY (id);


--
-- Name: category PK_9c4e4a89e3674fc9f382d733f03; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT "PK_9c4e4a89e3674fc9f382d733f03" PRIMARY KEY (id);


--
-- Name: product PK_bebc9158e480b949565b4dc7a82; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PK_bebc9158e480b949565b4dc7a82" PRIMARY KEY (id);


--
-- Name: user PK_cace4a159ff9f2512dd42373760; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);


--
-- Name: sale PK_d03891c457cbcd22974732b5de2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT "PK_d03891c457cbcd22974732b5de2" PRIMARY KEY (id);


--
-- Name: expense PK_edd925b450e13ea36197c9590fc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expense
    ADD CONSTRAINT "PK_edd925b450e13ea36197c9590fc" PRIMARY KEY (id);


--
-- Name: payment PK_fcaec7df5adf9cac408c686b2ab; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT "PK_fcaec7df5adf9cac408c686b2ab" PRIMARY KEY (id);


--
-- Name: user UQ_78a916df40e02a9deb1c4b75edb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_78a916df40e02a9deb1c4b75edb" UNIQUE (username);


--
-- Name: sale FK_1f170accf5236a71106a84ed97b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT "FK_1f170accf5236a71106a84ed97b" FOREIGN KEY ("clientId") REFERENCES public.client(id);


--
-- Name: payment FK_20e00028ffa954ae1ca85a8fad7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT "FK_20e00028ffa954ae1ca85a8fad7" FOREIGN KEY ("saleId") REFERENCES public.sale(id) ON DELETE CASCADE;


--
-- Name: product FK_2ee96d5eff55f14a6e37470b782; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_2ee96d5eff55f14a6e37470b782" FOREIGN KEY ("unitId") REFERENCES public.unit(id);


--
-- Name: user FK_4cb65c3c68624638b5cf05a8cbe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "FK_4cb65c3c68624638b5cf05a8cbe" FOREIGN KEY ("entrepriseId") REFERENCES public.entreprise(id) ON DELETE SET NULL;


--
-- Name: purchase_line FK_5e5b05ec9f4051800c8bd4fa5b6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_line
    ADD CONSTRAINT "FK_5e5b05ec9f4051800c8bd4fa5b6" FOREIGN KEY ("purchaseId") REFERENCES public.purchase(id) ON DELETE CASCADE;


--
-- Name: sale_line FK_bf2544590612ca0dfa773f265e0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_line
    ADD CONSTRAINT "FK_bf2544590612ca0dfa773f265e0" FOREIGN KEY ("productId") REFERENCES public.product(id);


--
-- Name: sale_line FK_c83932381deae8c3e841655dcae; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_line
    ADD CONSTRAINT "FK_c83932381deae8c3e841655dcae" FOREIGN KEY ("saleId") REFERENCES public.sale(id) ON DELETE CASCADE;


--
-- Name: purchase_line FK_ec3f3194c3766205a1ab8f2c3d4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.purchase_line
    ADD CONSTRAINT "FK_ec3f3194c3766205a1ab8f2c3d4" FOREIGN KEY ("productId") REFERENCES public.product(id);


--
-- Name: product FK_ff0c0301a95e517153df97f6812; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_ff0c0301a95e517153df97f6812" FOREIGN KEY ("categoryId") REFERENCES public.category(id);


--
-- PostgreSQL database dump complete
--

\unrestrict bZ12X4dQo30iLiRlBU2jd4AUZ9KtWN49f5Td27LumbkQZegIkgQG6NkSFZsTJ0f

