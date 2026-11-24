--
-- PostgreSQL database dump
--

\restrict HJc7clF5XSARR7wVKFGrNDBffFk9Ij7TpZUmexZuSkS4cFFYabt5ERQBTcrY5hB

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-24 21:36:11

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
-- TOC entry 223 (class 1259 OID 17438)
-- Name: dim_education; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_education (
    education_key integer NOT NULL,
    education_level character varying(50) NOT NULL,
    education_group character varying(50) NOT NULL
);


ALTER TABLE public.dim_education OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17437)
-- Name: dim_education_education_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_education_education_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_education_education_key_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 222
-- Name: dim_education_education_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_education_education_key_seq OWNED BY public.dim_education.education_key;


--
-- TOC entry 227 (class 1259 OID 17462)
-- Name: dim_employment_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_employment_status (
    employment_status_key integer NOT NULL,
    employment_status_name character varying(100) NOT NULL
);


ALTER TABLE public.dim_employment_status OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17461)
-- Name: dim_employment_status_employment_status_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_employment_status_employment_status_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_employment_status_employment_status_key_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 226
-- Name: dim_employment_status_employment_status_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_employment_status_employment_status_key_seq OWNED BY public.dim_employment_status.employment_status_key;


--
-- TOC entry 225 (class 1259 OID 17450)
-- Name: dim_position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_position (
    position_key integer NOT NULL,
    position_type character varying(50) NOT NULL,
    position_name character varying(100) NOT NULL
);


ALTER TABLE public.dim_position OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17449)
-- Name: dim_position_position_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_position_position_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_position_position_key_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 224
-- Name: dim_position_position_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_position_position_key_seq OWNED BY public.dim_position.position_key;


--
-- TOC entry 220 (class 1259 OID 17415)
-- Name: dim_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_staff (
    staff_key integer NOT NULL,
    staff_id character varying(20),
    staff_name character varying(200) NOT NULL,
    nip character varying(30),
    staff_type character varying(20) NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE public.dim_staff OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17414)
-- Name: dim_staff_staff_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_staff_staff_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_staff_staff_key_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 219
-- Name: dim_staff_staff_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_staff_staff_key_seq OWNED BY public.dim_staff.staff_key;


--
-- TOC entry 221 (class 1259 OID 17427)
-- Name: dim_time; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_time (
    time_key integer NOT NULL,
    year integer NOT NULL,
    quarter integer NOT NULL,
    semester character varying(20) NOT NULL,
    period_label character varying(30) NOT NULL
);


ALTER TABLE public.dim_time OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17473)
-- Name: dim_unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_unit (
    unit_key integer NOT NULL,
    unit_name character varying(150) NOT NULL,
    unit_category character varying(50) NOT NULL
);


ALTER TABLE public.dim_unit OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17472)
-- Name: dim_unit_unit_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_unit_unit_key_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_unit_unit_key_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 228
-- Name: dim_unit_unit_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_unit_unit_key_seq OWNED BY public.dim_unit.unit_key;


--
-- TOC entry 231 (class 1259 OID 17485)
-- Name: fact_staff_performance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_staff_performance (
    fact_id integer NOT NULL,
    staff_key integer NOT NULL,
    time_key integer NOT NULL,
    education_key integer NOT NULL,
    position_key integer NOT NULL,
    employment_status_key integer NOT NULL,
    unit_key integer NOT NULL,
    staff_count integer DEFAULT 1 NOT NULL,
    dosen_count integer DEFAULT 0 NOT NULL,
    tpa_count integer DEFAULT 0 NOT NULL,
    publication_count integer DEFAULT 0 NOT NULL,
    avg_edom_score numeric(5,2),
    research_project_count integer DEFAULT 0 NOT NULL,
    abdimas_count integer DEFAULT 0 NOT NULL,
    abdimas_participation_flag integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.fact_staff_performance OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17484)
-- Name: fact_staff_performance_fact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_staff_performance_fact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fact_staff_performance_fact_id_seq OWNER TO postgres;

--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 230
-- Name: fact_staff_performance_fact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_staff_performance_fact_id_seq OWNED BY public.fact_staff_performance.fact_id;


--
-- TOC entry 4887 (class 2604 OID 17441)
-- Name: dim_education education_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_education ALTER COLUMN education_key SET DEFAULT nextval('public.dim_education_education_key_seq'::regclass);


--
-- TOC entry 4889 (class 2604 OID 17465)
-- Name: dim_employment_status employment_status_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_employment_status ALTER COLUMN employment_status_key SET DEFAULT nextval('public.dim_employment_status_employment_status_key_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 17453)
-- Name: dim_position position_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_position ALTER COLUMN position_key SET DEFAULT nextval('public.dim_position_position_key_seq'::regclass);


--
-- TOC entry 4885 (class 2604 OID 17418)
-- Name: dim_staff staff_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_staff ALTER COLUMN staff_key SET DEFAULT nextval('public.dim_staff_staff_key_seq'::regclass);


--
-- TOC entry 4890 (class 2604 OID 17476)
-- Name: dim_unit unit_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_unit ALTER COLUMN unit_key SET DEFAULT nextval('public.dim_unit_unit_key_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 17488)
-- Name: fact_staff_performance fact_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance ALTER COLUMN fact_id SET DEFAULT nextval('public.fact_staff_performance_fact_id_seq'::regclass);


--
-- TOC entry 5082 (class 0 OID 17438)
-- Dependencies: 223
-- Data for Name: dim_education; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_education (education_key, education_level, education_group) FROM stdin;
1	Diploma	Non-Sarjana
2	S1/D4	Sarjana
3	S2	Pascasarjana
4	S3	Pascasarjana
5	SMA/SMK	Non-Sarjana
6	Unknown	Unknown
\.


--
-- TOC entry 5086 (class 0 OID 17462)
-- Dependencies: 227
-- Data for Name: dim_employment_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_employment_status (employment_status_key, employment_status_name) FROM stdin;
1	Pegawai Tetap
2	Perbantuan Kopertis
3	Perbantuan Telkom
4	Profesional Full Time
5	Profesional Part Time
6	Tenaga Layanan Harian / Magang
7	Unknown
\.


--
-- TOC entry 5084 (class 0 OID 17450)
-- Dependencies: 225
-- Data for Name: dim_position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_position (position_key, position_type, position_name) FROM stdin;
1	Akademik	Asisten Ahli
2	Akademik	Guru Besar
3	Akademik	Lektor
4	Akademik	Lektor Kepala
5	Akademik	NJAD
6	Akademik	Non Jabatan Fungsion
7	TPA	Madya 1
8	TPA	Madya 2
9	TPA	Madya 3
10	TPA	Muda 1
11	TPA	Muda 2
12	TPA	Tenaga Layanan Harian
13	TPA	Utama 3
14	Unknown	Unknown
\.


--
-- TOC entry 5079 (class 0 OID 17415)
-- Dependencies: 220
-- Data for Name: dim_staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_staff (staff_key, staff_id, staff_name, nip, staff_type, is_active) FROM stdin;
1	ADE	Ade Romadhony	06840042	DOSEN	t
2	ZHH	Aaz Muhammad Hafidz Azis	23990046	DOSEN	t
3	ALH	Abdullah Hanifan	24900005	DOSEN	t
4	ABK	Abdullah Iskandar	24960014	DOSEN	t
5	ACK	Achmad Lukman	26780001	DOSEN	t
6	FMH	Aditya Firman Ihsan	21950003	DOSEN	t
7	ADW	Adiwijaya	00740046	DOSEN	t
8	ATW	Agung Toto Wibowo	06810035	DOSEN	t
9	AJG	Aji Gautama Putrada	15850084	DOSEN	t
10	ANM	Andi Maulana Yusuf	25980006	DOSEN	t
11	ADF	Anditya Arifianto	14890028	DOSEN	f
12	ADR	Andrian Rakhmatsyah	02760051	DOSEN	f
13	APK	Angelina Prima Kurniati	06830027	DOSEN	t
14	NIQ	Aniq Atiqi Rohmawati	15880028	DOSEN	f
15	NDN	Anisa Herdiani	15850002	DOSEN	f
16	TSA	Annisa Aditsania	15900046	DOSEN	f
17	NMR	Anung Asmoro	21730002	DOSEN	t
18	FVE	Arfive Gandhi	22910008	DOSEN	t
19	ABW	Ari Moesriami Barmawi	08600006	DOSEN	t
20	RIE	Arie Ardiyanti Suryani	02770027	DOSEN	t
21	HPY	Ario Harry Prayogo	19920026	DOSEN	t
22	TYH	Aristyo Hadikusuma	20930051	DOSEN	t
23	NLF	Arnida Lailatul Latifah	21870008	DOSEN	t
24	SCD	Ati Suci Dian Martha	23830004	DOSEN	t
25	UIW	Aulia Arif Wardana	20920037	DOSEN	f
26	AZN	Azka Khoirunnisa	22970005	DOSEN	t
27	BBD	Bambang Ari Wahyudi	14860086	DOSEN	f
28	BMG	Bambang Subeno	23820006	DOSEN	t
29	ERF	Bayu Erfianto	05730058	DOSEN	t
30	BDP	Bedy Purnama	10790050	DOSEN	t
31	UAI	Bunyamin	25720006	DOSEN	f
32	DGS	Dadang Setiawan	16730068	DOSEN	t
33	DNH	Dade Nurjanah	97730005	DOSEN	t
34	DAS	Dana Sulistyo Kusumo	02780011	DOSEN	t
35	DJN	Danang Junaedi	14780062	DOSEN	f
36	DTO	Danang Triantoro Murdiansyah	14870045	DOSEN	t
37	DWM	Dawam Dwi Jatmiko Suwawi	14890033	DOSEN	t
38	DDR	Dede Rohidin	91670044	DOSEN	t
39	DLW	Dede Tarwidi	14840039	DOSEN	t
40	DNS	Deni Saepudin	99750013	DOSEN	t
41	DAY	Didit Adytia	16830005	DOSEN	t
42	DOK	Dita Oktaria	25920027	DOSEN	f
43	DYA	Diyas Puspandari	99730029	DOSEN	t
44	DWS	Dodi Wisaksono Sudiharto	06760030	DOSEN	f
45	DQU	Dody Qori Utama	14870074	DOSEN	t
46	DRI	Donni Richasdy	15900040	DOSEN	f
47	EKD	Eko Darwiyanto	13680041	DOSEN	t
48	EAR	Ema Rachmawati	10800050	DOSEN	t
49	END	Endro Ariyanto	04660014	DOSEN	t
50	EMJ	Erwid Musthofa Jadied	15810055	DOSEN	t
51	ERW	Erwin Budi Setiawan	00760045	DOSEN	t
52	FLF	Fadil Al Afgani	24990017	DOSEN	t
53	FAR	Farah Afianti	23860001	DOSEN	t
54	FSY	Farisya Setiadi	24830001	DOSEN	t
55	FFS	Fauzan Firdaus	25980003	DOSEN	t
56	FAZ	Fazmah Arif Yulianto	99750034	DOSEN	t
57	FBW	Febri Dawani	25850012	DOSEN	t
58	FSV	Febryanti Sthevanie	14880014	DOSEN	t
59	FDF	Feddy Dea Reskyadita	15860071	DOSEN	t
60	VIR	Fhira Nhita	13860015	DOSEN	t
61	FTY	Fitriyani	10830001	DOSEN	t
62	FLO	Florita Diana Sari	02750011	DOSEN	t
63	GKL	Gamma Kosala	26920005	DOSEN	t
64	GAW	Gede Agung Ary Wisudiawan	14870024	DOSEN	t
65	GIA	Gia Septiana Wulandari	19870017	DOSEN	t
66	HUI	Hani Nurrahmi	20920043	DOSEN	f
67	HMT	Hasmawati	15900049	DOSEN	f
68	HHN	Hilal Hudan Nuha	13860093	DOSEN	t
69	HFL	Hilda Fahlena	23920001	DOSEN	t
70	IGR	I Gede Manggala Putra	24950017	DOSEN	t
71	IYK	I Wayan Palton Anuwiksa	23950001	DOSEN	t
72	IBR	Ibnu Asror	06840031	DOSEN	f
73	IDV	Ikke Dian Oktaviani	22950006	DOSEN	t
74	IMD	Imelda Atastina	07770053	DOSEN	t
75	IDL	Indra Lukmana Sardi	18890120	DOSEN	f
76	IND	Indwiarti	98690022	DOSEN	t
77	IPL	Irma Palupi	14880065	DOSEN	t
78	IKN	Isman Kurniawan	15870066	DOSEN	t
79	IZA	Izzatul Ummah	13840021	DOSEN	t
80	JTI	Jati Hiliamsyah Husen	20920040	DOSEN	t
81	JMT	Jimmy Tirtawangsa	10630002	DOSEN	t
82	JDN	Jondri	95700035	DOSEN	t
83	KMM	Kemas Muslim Lhaksmana	13820075	DOSEN	t
84	KMS	Kemas Rahmat Saleh Wiharja	06830034	DOSEN	t
85	KNR	Kurniawan Nur Ramadhani	14880009	DOSEN	t
86	KSA	Kusuma Adi Achmad	22770001	DOSEN	t
87	AYU	Kusuma Ayu Laksitowening	05840010	DOSEN	t
88	LZD	Lazuardy Syahrul Dafriansa	24970011	DOSEN	t
89	LDS	Lidya Ningsih	23950047	DOSEN	t
90	DWF	Mahendra Dwifebri Purbolaksono	22940018	DOSEN	f
91	MDS	Mahmud Dwi Sulistiyo	13880017	DOSEN	t
92	MHD	Mahmud Imrona	93670017	DOSEN	t
93	MMA	Maman Abdurohman	99750010	DOSEN	t
94	MIU	Miftahul Adnan Rasyid	25950001	DOSEN	t
95	MKS	Mira Kania Sabariah	14770011	DOSEN	t
96	MAB	Moch Arif Bijaksana	21650006	DOSEN	t
97	MTD	Monterico Adrian	25870010	DOSEN	t
98	UIR	Muhamad Irsan	26800002	DOSEN	t
99	MKY	Muhammad Al Makky	20850008	DOSEN	f
100	MAN	Muhammad Arief Nugroho	15850039	DOSEN	f
101	MZI	Muhammad Arzaki	15870058	DOSEN	f
102	FFT	Muhammad Faris Fathoni	26910004	DOSEN	t
103	NKN	Niken Dwi Wahyu Cahyani	00750052	DOSEN	t
104	NGS	Novian Anggis Suwastika	13850083	DOSEN	t
105	NKS	Nungki Selviandro	14880076	DOSEN	t
106	NGN	Nur Ghaniaviyanto Ramadhan	26960011	DOSEN	t
107	JYN	Nurjayanti	19920020	DOSEN	t
108	NIK	Nurul Ikhsan	14870044	DOSEN	t
109	PMN	Parman Sukarno	17770073	DOSEN	t
110	PEY	Prasti Eko Yunanto	19890017	DOSEN	f
111	PHG	Prati Hutari Gani	20900028	DOSEN	f
112	PHN	Putu Harry Gunawan	16860043	DOSEN	t
113	RYJ	Rahmat Yasirandi	20910007	DOSEN	t
114	RFU	Rian Febrian Umbara	08820009	DOSEN	t
115	FKI	Rifki Wijaya	26840004	DOSEN	t
116	RMB	Rimba Whidiana Ciptasari	04740062	DOSEN	t
117	GMO	Rio Guntur Utomo	22900021	DOSEN	t
118	NTT	Rio Nurtantyana	23930002	DOSEN	t
119	RSM	Rita Rismala	14860098	DOSEN	t
120	PHV	Rizka Reza Pahlevi	22950030	DOSEN	f
121	RSC	Rosa Reska Riskiana	20930035	DOSEN	t
122	RLG	Ryan Lingga Wicaksono	15930004	DOSEN	t
123	SFY	Said Al Faraby	15890019	DOSEN	t
124	SBG	Satria Akbar Mugitama	26910007	DOSEN	t
125	SMD	Satria Mandala	16730040	DOSEN	t
126	SLL	Selly Meliana	23780002	DOSEN	f
127	SRN	Setyorini	01760040	DOSEN	t
128	UFI	Shaufiah	06820004	DOSEN	f
129	SYP	Shinta Yulia Puspitasari	18880124	DOSEN	t
130	SPO	Sidik Prabowo	15870072	DOSEN	t
131	SKH	Siti Amatullah Karimah	17900086	DOSEN	f
132	SSD	Siti Sa Adah	13860014	DOSEN	f
133	SSI	Sri Suryani Prasetiyowati	99750003	DOSEN	t
134	SWD	Sri Widowati	93670013	DOSEN	t
135	UTY	Sutiyo	26810002	DOSEN	t
136	SUO	Suyanto	99740057	DOSEN	t
137	COK	Tjokorda Agung Budi Wirayuda	06830020	DOSEN	t
138	UNW	Untari Novia Wisesty	13870083	DOSEN	t
139	UII	Utami Kusuma Dewi	19950016	DOSEN	t
140	VRA	Vera Suryani	03790039	DOSEN	t
141	VRE	Veronikha Effendy	14790043	DOSEN	f
142	VLY	Villy Satria Praditha	19920025	DOSEN	t
143	WRH	Warih Maharani	01780020	DOSEN	t
144	WDU	Widi Astuti	19910018	DOSEN	f
145	WKF	Wikky Fawwaz Al Maki	22820013	DOSEN	t
146	YFA	Yanuar Firdaus Arie Wibowo	05790003	DOSEN	t
147	YGO	Yogi Anggun Saloko Yudo	21840005	DOSEN	t
148	YDN	Yudhistira Nugraha	19810005	DOSEN	t
149	YPR	Yudi Priyadi	20710004	DOSEN	t
150	YLS	Yuliant Sibaroni	00750036	DOSEN	t
151	ZKA	Z K Abdurahman Baizal	99750047	DOSEN	t
152	THF	Thofik Nugroho	25840001	DOSEN	t
153	AQI	Ayu Qatrunnada Istiqfarri	25009004	DOSEN	t
154	GMF	Gian Maxmillian Firdaus	25020004	DOSEN	t
155	SAR	Sabrina Adinda Sari	25010014	DOSEN	t
156	FZD	Fauzan Ramadhan	25940006	DOSEN	t
157	HEL	Hassan Rizky Putra Sailellah	25010013	DOSEN	t
158	HYA	Hilya Tsaniya Ismet	25990030	DOSEN	t
159	FLN	Faidhil Nugrah Ramadhan Ahmad	22950023	DOSEN	t
160	DYW	Dytha Ananda Widhiarso	25010044	DOSEN	t
161	BVM	Bintang Vieshe Mone	25010043	DOSEN	t
162	PAA	Pratama Azmi Atmajaya	25990033	DOSEN	t
163	KIF	Khalis Sofi	25970022	DOSEN	t
164	BWW	Bagas Wibowo	25990041	DOSEN	t
165	WLR	Wilda Royhan	26970029	DOSEN	t
166	SST	Suma Danu Ristianto	26970030	DOSEN	t
167	PPV	Prazna Paramitha Avi	26010023	DOSEN	t
168	GHK	Ghina Khoerunnisa	26000044	DOSEN	t
169	WHS	Wahyu Suryaningrat	26970031	DOSEN	t
170	IWH	Irfan Walhidayah	26990044	DOSEN	t
171	RZY	Agus Fachrur Rozy	26920014	DOSEN	t
172	NFD	Anisa Nurfirda Ramdhani	26950019	DOSEN	t
173	YEN	Yeyen Hamidah	26890009	DOSEN	t
174	ANK	Andi Shafira Dyah Kurniasari	26000043	DOSEN	t
175	BTN	Ahmad Bintang Arif	26020013	DOSEN	t
176	SZA	Sza Sza Amulya Larasati	26020012	DOSEN	t
177	GFR	Fifinella Rahma	26990043	DOSEN	t
178	KAH	Karisa Ardelia Hanifah	26990048	DOSEN	t
179	OCH	Moch Nurul Indra Al Fauzan	26980040	DOSEN	t
180	DFB	Daffa Maulana Hibban	26000061	DOSEN	t
181	MYT	Meydie Tri Malindo	\N	DOSEN	t
182	LVM	Elva Amalia	26010033	DOSEN	t
183	NOH	Nando Alhasanain	26000060	DOSEN	t
184	WIN	Wahidin	\N	DOSEN	t
185	\N	Yusril Izza	\N	DOSEN	f
186	EDF	Edward Ferdian	24840004	DOSEN	t
187	SMS	Isa Mulia Insan	24970006	DOSEN	t
188	TDR	Ramanti Dharayani	20920047	DOSEN	t
189	\N	Ajid Awaludin	1820060	TPA	t
190	\N	Ami Rahmi Fatimah	22940012	TPA	t
191	\N	Annisa Rahmah Muflihah	26990002	TPA	t
192	\N	Asep Fitrijatna	3710050	TPA	t
193	\N	Fairuz Zahrah An Nibras	23950042	TPA	t
194	\N	Fawqa Nurra R	26980007	TPA	t
195	\N	Hasmita	23970036	TPA	t
196	\N	I Putu Sudiksa	97730020	TPA	t
197	\N	Iwan Kurniawan	93700014	TPA	t
198	\N	Ken Diva Gusti A	26970006	TPA	t
199	\N	M Ferby Aridlo	22900018	TPA	t
200	\N	Mutiara Rizka Nasution	22970015	TPA	t
201	\N	Nani	97720020	TPA	t
202	\N	Oku Dewi Noviantika Putri	26890002	TPA	t
203	\N	Rana Qonita Rofila	26970014	TPA	t
204	\N	Renaning Karutami Susilo	22990009	TPA	t
205	\N	Ri Handayani	15860063	TPA	t
206	\N	Sandi Muhamad Nasir	770008	TPA	t
207	\N	Sari Rahmawati	11830049	TPA	t
208	\N	Tri Usadi Prasetyo	1750018	TPA	t
209	\N	M Khoeri Habibulloh Al Faqih	62497035	TPA	t
210	\N	Siti Nur Latifah	62497037	TPA	t
211	\N	Gina Dofira	62499036	TPA	t
212	\N	Sari Widyastuti	22930028	TPA	t
213	\N	Najmi Nuzuliya Rahmani	26990017	TPA	t
214	\N	Farisi Rahman	82496056	TPA	t
215	\N	Fernanda Aditya Nugraha	822980138	TPA	t
216	\N	Benedicta Isadora R Sihombing	82400116	TPA	t
217	\N	Adam Rafif Faqih	826020028	TPA	t
218	\N	Ismi Wardanita	826020038	TPA	t
219	\N	Muhamad Harsya S	826030158	TPA	t
220	\N	Mutiara Nur Ikhsani	826040608	TPA	t
221	\N	Ni Luh Ayu Paramita P	82602099	TPA	t
222	\N	Rihan Hidayat	\N	TPA	t
223	\N	Regy Renanda Rahman	\N	TPA	t
224	\N	Rahma Sakti Rahardian	\N	TPA	t
225	\N	Muhammad Haydar Maulana	\N	TPA	t
226	\N	Iqro Banyuanto	\N	TPA	t
227	\N	Alif Taufiqurrahman	\N	TPA	t
228	VVI	Alva Nurvina Sularso	17820086	DOSEN	t
229	DEC	Demi Adidrana	24880005	DOSEN	t
230	ENY	Deny Haryadi	23910013	DOSEN	t
231	WRA	Dwina Satrinia	20890029	DOSEN	t
232	OGO	Hertanto Suryoprayogo	20890028	DOSEN	t
233	HII	Hesmi Aria Yanti	22880015	DOSEN	t
234	IAU	Indra Aulia	23900008	DOSEN	t
235	NII	Nurul Ilmi	20930061	DOSEN	t
236	RNZ	Rana Zaini Fathiyana	23950035	DOSEN	t
237	UIN	Saparudin	20690005	DOSEN	t
238	STZ	Siti Zahrotul Fajriyah	20910047	DOSEN	t
239	SYJ	Syifa Nurgaida Yutia	23930018	DOSEN	t
240	ZKP	Zuki Pristiantoro Putro	23950017	DOSEN	t
241	WMN	Widang Muttaqin	25980002	DOSEN	t
242	HDW	Haddad Alwi Yafie	25980007	DOSEN	t
243	CYT	Achmad Udin Zailani	25830001	DOSEN	t
244	EYR	Desi Nurnaningsih	25850002	DOSEN	t
245	RRD	Risnandar	\N	DOSEN	t
246	REF	Arief Ramadhan	\N	DOSEN	t
247	AQO	Andri Qiantori	\N	DOSEN	t
248	NDP	Dian Andriana	\N	DOSEN	t
249	MWA	Marastika Wicaksono Aji Bawono	\N	DOSEN	t
250	SLK	Samuel Andi Kristyan	\N	DOSEN	t
251	\N	Hanif Khairuddin	\N	DOSEN	t
252	ACY	Staff-ACY	\N	DOSEN	t
\.


--
-- TOC entry 5080 (class 0 OID 17427)
-- Dependencies: 221
-- Data for Name: dim_time; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_time (time_key, year, quarter, semester, period_label) FROM stdin;
20253	2025	3	Ganjil	2025-Q3
20254	2025	4	Ganjil	2025-Q4
20261	2026	1	Genap	2026-Q1
20262	2026	2	Genap	2026-Q2
\.


--
-- TOC entry 5088 (class 0 OID 17473)
-- Dependencies: 229
-- Data for Name: dim_unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_unit (unit_key, unit_name, unit_category) FROM stdin;
1	KK CITI	Kelompok Keahlian
2	S1 Informatika	Program Studi
3	S1 Informatika Kampus Jakarta	Program Studi
4	S1 PJJ Informatika	Program Studi
5	S1 Rekayasa Perangkat Lunak	Program Studi
6	S1 Sains Data	Program Studi
7	S1 Teknologi Informasi	Program Studi
8	S1 Teknologi Informasi Kampus Jakarta	Program Studi
9	S2 Ilmu Forensik	Program Studi
10	S2 Informatika	Program Studi
11	S3 Informatika	Program Studi
12	Sekretariat FIF	Unit Pendukung
13	Unknown	Unknown
14	Urusan Kemahasiswaan FIF	Unit Pendukung
15	Urusan Laboratorium FIF	Unit Pendukung
16	Urusan Layanan Akademik FIF	Unit Pendukung
17	Urusan Sumber Daya FIF	Unit Pendukung
\.


--
-- TOC entry 5090 (class 0 OID 17485)
-- Dependencies: 231
-- Data for Name: fact_staff_performance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_staff_performance (fact_id, staff_key, time_key, education_key, position_key, employment_status_key, unit_key, staff_count, dosen_count, tpa_count, publication_count, avg_edom_score, research_project_count, abdimas_count, abdimas_participation_flag) FROM stdin;
1	1	20253	4	4	1	10	1	1	0	3	87.16	5	0	0
2	1	20254	4	4	1	10	1	1	0	5	87.16	5	0	0
3	1	20261	4	4	1	10	1	1	0	0	87.16	1	0	0
4	1	20262	4	4	1	10	1	1	0	2	87.16	2	0	0
5	2	20253	3	1	4	5	1	1	0	0	85.39	2	5	1
6	2	20254	3	1	4	5	1	1	0	0	85.39	2	5	1
7	2	20261	3	1	4	5	1	1	0	1	85.39	3	3	1
8	2	20262	3	1	4	5	1	1	0	0	85.39	3	3	1
9	3	20253	3	5	4	4	1	1	0	1	89.23	1	4	1
10	3	20254	3	5	4	4	1	1	0	1	89.23	1	4	1
11	3	20261	3	5	4	4	1	1	0	0	89.23	1	2	1
12	3	20262	3	5	4	4	1	1	0	0	89.23	2	2	1
13	4	20253	3	5	4	2	1	1	0	0	\N	0	0	0
14	4	20254	3	5	4	2	1	1	0	0	\N	0	0	0
15	4	20261	3	5	4	2	1	1	0	0	\N	0	0	0
16	4	20262	3	5	4	2	1	1	0	1	\N	0	0	0
17	5	20253	4	3	1	7	1	1	0	1	82.42	1	3	1
18	5	20254	4	3	1	7	1	1	0	0	82.42	1	3	1
19	5	20261	4	3	1	7	1	1	0	0	82.42	1	0	0
20	5	20262	4	3	1	7	1	1	0	2	82.42	1	0	0
21	6	20253	4	3	1	2	1	1	0	3	90.37	5	0	0
22	6	20254	4	3	1	2	1	1	0	9	90.37	5	0	0
23	6	20261	4	3	1	2	1	1	0	0	90.37	2	0	0
24	6	20262	4	3	1	2	1	1	0	5	90.37	4	0	0
25	7	20253	4	2	1	11	1	1	0	7	87.94	12	2	1
26	7	20254	4	2	1	11	1	1	0	7	87.94	15	3	1
27	7	20261	4	2	1	11	1	1	0	0	87.94	10	2	1
28	7	20262	4	2	1	11	1	1	0	6	87.94	14	2	1
29	8	20253	4	3	1	10	1	1	0	3	91.82	4	1	1
30	8	20254	4	3	1	10	1	1	0	6	91.82	4	1	1
31	8	20261	4	3	1	10	1	1	0	0	91.82	3	1	1
32	8	20262	4	3	1	10	1	1	0	5	91.82	3	2	1
33	9	20253	4	3	1	7	1	1	0	12	\N	3	4	1
34	9	20254	4	3	1	7	1	1	0	15	\N	6	4	1
35	9	20261	4	3	1	7	1	1	0	3	\N	4	3	1
36	9	20262	4	3	1	7	1	1	0	15	\N	4	3	1
37	10	20253	3	5	4	2	1	1	0	0	\N	2	4	1
38	10	20254	3	5	4	2	1	1	0	0	\N	1	4	1
39	10	20261	3	5	4	2	1	1	0	0	\N	3	3	1
40	10	20262	3	5	4	2	1	1	0	0	\N	3	3	1
41	11	20253	3	1	1	2	1	1	0	0	\N	0	0	0
42	11	20254	3	1	1	2	1	1	0	0	\N	0	0	0
43	11	20261	3	1	1	2	1	1	0	0	\N	0	0	0
44	11	20262	3	1	1	2	1	1	0	0	\N	0	0	0
45	12	20253	3	3	1	2	1	1	0	1	\N	0	0	0
46	12	20254	3	3	1	2	1	1	0	0	\N	0	0	0
47	12	20261	3	3	1	2	1	1	0	0	\N	0	0	0
48	12	20262	3	3	1	2	1	1	0	0	\N	0	0	0
49	13	20253	4	4	1	2	1	1	0	1	86.29	1	2	1
50	13	20254	4	4	1	2	1	1	0	3	86.29	2	2	1
51	13	20261	4	4	1	2	1	1	0	0	86.29	1	0	0
52	13	20262	4	4	1	2	1	1	0	0	86.29	3	0	0
53	14	20253	3	3	1	2	1	1	0	0	\N	0	0	0
54	14	20254	3	3	1	2	1	1	0	1	\N	0	0	0
55	14	20261	3	3	1	2	1	1	0	0	\N	0	0	0
56	14	20262	3	3	1	2	1	1	0	0	\N	0	0	0
57	15	20253	3	1	1	4	1	1	0	0	\N	0	0	0
58	15	20254	3	1	1	4	1	1	0	0	\N	0	0	0
59	15	20261	3	1	1	4	1	1	0	0	\N	0	0	0
60	15	20262	3	1	1	4	1	1	0	0	\N	0	0	0
61	16	20253	3	1	1	2	1	1	0	0	\N	0	0	0
62	16	20254	3	1	1	2	1	1	0	0	\N	0	0	0
63	16	20261	3	1	1	2	1	1	0	0	\N	0	0	0
64	16	20262	3	1	1	2	1	1	0	0	\N	0	0	0
65	17	20253	4	5	5	7	1	1	0	0	71.85	0	0	0
66	17	20254	4	5	5	7	1	1	0	0	71.85	0	0	0
67	17	20261	4	5	5	7	1	1	0	0	71.85	0	0	0
68	17	20262	4	5	5	7	1	1	0	0	71.85	0	0	0
69	18	20253	4	3	1	5	1	1	0	2	86.34	3	2	1
70	18	20254	4	3	1	5	1	1	0	3	86.34	3	2	1
71	18	20261	4	3	1	5	1	1	0	1	86.34	2	2	1
72	18	20262	4	3	1	5	1	1	0	4	86.34	2	2	1
73	19	20253	4	2	2	9	1	1	0	0	88.24	1	4	1
74	19	20254	4	2	2	9	1	1	0	0	88.24	1	4	1
75	19	20261	4	2	2	9	1	1	0	0	88.24	1	2	1
76	19	20262	4	2	2	9	1	1	0	0	88.24	1	2	1
77	20	20253	4	3	1	10	1	1	0	1	86.28	1	2	1
78	20	20254	4	3	1	10	1	1	0	0	86.28	1	2	1
79	20	20261	4	3	1	10	1	1	0	0	86.28	2	2	1
80	20	20262	4	3	1	10	1	1	0	0	86.28	2	2	1
81	21	20253	3	1	1	5	1	1	0	2	86.89	3	3	1
82	21	20254	3	1	1	5	1	1	0	0	86.89	3	3	1
83	21	20261	3	1	1	5	1	1	0	1	86.89	2	1	1
84	21	20262	3	1	1	5	1	1	0	1	86.89	2	1	1
85	22	20253	3	1	5	7	1	1	0	0	84.41	0	0	0
86	22	20254	3	1	5	7	1	1	0	0	84.41	0	0	0
87	22	20261	3	1	5	7	1	1	0	0	84.41	0	0	0
88	22	20262	3	1	5	7	1	1	0	0	84.41	0	0	0
89	23	20253	4	5	5	2	1	1	0	1	88.05	1	0	0
90	23	20254	4	5	5	2	1	1	0	0	88.05	1	0	0
91	23	20261	4	5	5	2	1	1	0	0	88.05	0	0	0
92	23	20262	4	5	5	2	1	1	0	0	88.05	0	0	0
93	24	20253	4	3	1	5	1	1	0	2	81.72	3	2	1
94	24	20254	4	3	1	5	1	1	0	2	81.72	3	2	1
95	24	20261	4	3	1	5	1	1	0	1	81.72	2	1	1
96	24	20262	4	3	1	5	1	1	0	0	81.72	2	1	1
97	25	20253	3	1	1	7	1	1	0	0	\N	0	2	1
98	25	20254	3	1	1	7	1	1	0	8	\N	0	2	1
99	25	20261	3	1	1	7	1	1	0	1	\N	0	0	0
100	25	20262	3	1	1	7	1	1	0	0	\N	0	0	0
101	26	20253	3	1	4	6	1	1	0	2	81.01	1	0	0
102	26	20254	3	1	4	6	1	1	0	1	81.01	1	0	0
103	26	20261	3	1	4	6	1	1	0	0	81.01	1	2	1
104	26	20262	3	1	4	6	1	1	0	4	81.01	1	2	1
105	27	20253	3	3	1	2	1	1	0	1	83.21	0	0	0
106	27	20254	3	3	1	2	1	1	0	0	83.21	0	0	0
107	27	20261	3	3	1	2	1	1	0	0	83.21	0	0	0
108	27	20262	3	3	1	2	1	1	0	0	83.21	0	0	0
109	28	20253	3	1	4	2	1	1	0	1	89.33	0	0	0
110	28	20254	3	1	4	2	1	1	0	0	89.33	0	0	0
111	28	20261	3	1	4	2	1	1	0	0	89.33	0	0	0
112	28	20262	3	1	4	2	1	1	0	1	89.33	0	0	0
113	29	20253	4	4	1	11	1	1	0	3	83.50	8	3	1
114	29	20254	4	4	1	11	1	1	0	8	83.50	9	4	1
115	29	20261	4	4	1	11	1	1	0	1	83.50	4	2	1
116	29	20262	4	4	1	11	1	1	0	0	83.50	8	2	1
117	30	20253	4	3	1	2	1	1	0	1	83.60	3	2	1
118	30	20254	4	3	1	2	1	1	0	9	83.60	6	2	1
119	30	20261	4	3	1	2	1	1	0	1	83.60	2	1	1
120	30	20262	4	3	1	2	1	1	0	5	83.60	3	1	1
121	31	20253	3	1	1	2	1	1	0	0	84.83	0	2	1
122	31	20254	3	1	1	2	1	1	0	2	84.83	0	2	1
123	31	20261	3	1	1	2	1	1	0	1	84.83	0	0	0
124	31	20262	3	1	1	2	1	1	0	1	84.83	0	0	0
125	32	20253	4	3	3	2	1	1	0	0	89.44	1	1	1
126	32	20254	4	3	3	2	1	1	0	1	89.44	1	1	1
127	32	20261	4	3	3	2	1	1	0	0	89.44	0	1	1
128	32	20262	4	3	3	2	1	1	0	0	89.44	0	1	1
129	33	20253	4	4	1	10	1	1	0	0	81.88	5	1	1
130	33	20254	4	4	1	10	1	1	0	3	81.88	5	1	1
131	33	20261	4	4	1	10	1	1	0	1	81.88	3	0	0
132	33	20262	4	4	1	10	1	1	0	2	81.88	5	2	1
133	34	20253	4	4	1	5	1	1	0	0	83.78	1	3	1
134	34	20254	4	4	1	5	1	1	0	0	83.78	0	3	1
135	34	20261	4	4	1	5	1	1	0	0	83.78	2	1	1
136	34	20262	4	4	1	5	1	1	0	0	83.78	2	1	1
137	35	20253	3	3	1	5	1	1	0	0	\N	0	0	0
138	35	20254	3	3	1	5	1	1	0	0	\N	0	0	0
139	35	20261	3	3	1	5	1	1	0	0	\N	0	0	0
140	35	20262	3	3	1	5	1	1	0	0	\N	0	0	0
141	36	20253	3	1	1	2	1	1	0	1	81.66	1	0	0
142	36	20254	3	1	1	2	1	1	0	4	81.66	2	0	0
143	36	20261	3	1	1	2	1	1	0	0	81.66	2	0	0
144	36	20262	3	1	1	2	1	1	0	0	81.66	2	0	0
145	37	20253	3	3	1	2	1	1	0	0	84.17	0	0	0
146	37	20254	3	3	1	2	1	1	0	1	84.17	0	0	0
147	37	20261	3	3	1	2	1	1	0	0	84.17	0	0	0
148	37	20262	3	3	1	2	1	1	0	0	84.17	0	0	0
149	38	20253	4	3	1	2	1	1	0	0	83.20	0	1	1
150	38	20254	4	3	1	2	1	1	0	1	83.20	0	1	1
151	38	20261	4	3	1	2	1	1	0	0	83.20	0	0	0
152	38	20262	4	3	1	2	1	1	0	1	83.20	0	0	0
153	39	20253	4	3	1	2	1	1	0	1	\N	0	2	1
154	39	20254	4	3	1	2	1	1	0	1	\N	1	2	1
155	39	20261	4	3	1	2	1	1	0	0	\N	2	1	1
156	39	20262	4	3	1	2	1	1	0	1	\N	4	1	1
157	40	20253	4	3	1	2	1	1	0	4	83.10	7	4	1
158	40	20254	4	3	1	2	1	1	0	1	83.10	8	4	1
159	40	20261	4	3	1	2	1	1	0	1	83.10	5	1	1
160	40	20262	4	3	1	2	1	1	0	3	83.10	6	1	1
161	41	20253	4	4	1	2	1	1	0	1	92.19	6	4	1
162	41	20254	4	4	1	2	1	1	0	6	92.19	7	4	1
163	41	20261	4	4	1	2	1	1	0	0	92.19	4	1	1
164	41	20262	4	4	1	2	1	1	0	1	92.19	8	1	1
165	42	20253	3	1	1	7	1	1	0	2	80.49	2	3	1
166	42	20254	3	1	1	7	1	1	0	0	80.49	2	3	1
167	42	20261	3	1	1	7	1	1	0	0	80.49	0	0	0
168	42	20262	3	1	1	7	1	1	0	0	80.49	0	0	0
169	43	20253	4	3	1	2	1	1	0	0	89.94	2	3	1
170	43	20254	4	3	1	2	1	1	0	0	89.94	2	3	1
171	43	20261	4	3	1	2	1	1	0	1	89.94	0	2	1
172	43	20262	4	3	1	2	1	1	0	0	89.94	0	2	1
173	44	20253	3	3	1	2	1	1	0	0	\N	0	0	0
174	44	20254	3	3	1	2	1	1	0	0	\N	0	0	0
175	44	20261	3	3	1	2	1	1	0	0	\N	0	0	0
176	44	20262	3	3	1	2	1	1	0	0	\N	0	0	0
177	45	20253	4	5	1	2	1	1	0	0	92.11	1	0	0
178	45	20254	4	5	1	2	1	1	0	0	92.11	1	0	0
179	45	20261	4	5	1	2	1	1	0	0	92.11	1	0	0
180	45	20262	4	5	1	2	1	1	0	0	92.11	1	0	0
181	46	20253	3	1	1	2	1	1	0	1	82.35	4	2	1
182	46	20254	3	1	1	2	1	1	0	1	82.35	5	2	1
183	46	20261	3	1	1	2	1	1	0	0	82.35	1	1	1
184	46	20262	3	1	1	2	1	1	0	2	82.35	1	1	1
185	47	20253	3	3	1	2	1	1	0	2	85.59	1	2	1
186	47	20254	3	3	1	2	1	1	0	4	85.59	1	2	1
187	47	20261	3	3	1	2	1	1	0	0	85.59	1	1	1
188	47	20262	3	3	1	2	1	1	0	2	85.59	1	1	1
189	48	20253	4	4	1	2	1	1	0	5	88.88	3	2	1
190	48	20254	4	4	1	2	1	1	0	0	88.88	3	2	1
191	48	20261	4	4	1	2	1	1	0	0	88.88	1	0	0
192	48	20262	4	4	1	2	1	1	0	6	88.88	3	1	1
193	49	20253	3	1	1	7	1	1	0	3	87.12	1	3	1
194	49	20254	3	1	1	7	1	1	0	0	87.12	1	3	1
195	49	20261	3	1	1	7	1	1	0	0	87.12	1	2	1
196	49	20262	3	1	1	7	1	1	0	2	87.12	2	2	1
197	50	20253	3	1	1	2	1	1	0	2	84.64	3	3	1
198	50	20254	3	1	1	2	1	1	0	0	84.64	3	3	1
199	50	20261	3	1	1	2	1	1	0	1	84.64	1	1	1
200	50	20262	3	1	1	2	1	1	0	0	84.64	1	1	1
201	51	20253	4	4	1	2	1	1	0	12	85.75	0	1	1
202	51	20254	4	4	1	2	1	1	0	17	85.75	0	1	1
203	51	20261	4	4	1	2	1	1	0	0	85.75	1	1	1
204	51	20262	4	4	1	2	1	1	0	0	85.75	4	1	1
205	52	20253	3	1	4	5	1	1	0	3	\N	3	4	1
206	52	20254	3	1	4	5	1	1	0	2	\N	3	4	1
207	52	20261	3	1	4	5	1	1	0	1	\N	1	2	1
208	52	20262	3	1	4	5	1	1	0	0	\N	1	2	1
209	53	20253	4	3	1	9	1	1	0	4	86.88	2	4	1
210	53	20254	4	3	1	9	1	1	0	1	86.88	2	4	1
211	53	20261	4	3	1	9	1	1	0	0	86.88	1	3	1
212	53	20262	4	3	1	9	1	1	0	2	86.88	1	3	1
213	54	20253	4	1	4	7	1	1	0	2	82.58	3	3	1
214	54	20254	4	1	4	7	1	1	0	1	82.58	3	3	1
215	54	20261	4	1	4	7	1	1	0	0	82.58	2	3	1
216	54	20262	4	1	4	7	1	1	0	0	82.58	3	3	1
217	55	20253	3	5	4	5	1	1	0	3	\N	2	3	1
218	55	20254	3	5	4	5	1	1	0	0	\N	5	3	1
219	55	20261	3	5	4	5	1	1	0	0	\N	5	2	1
220	55	20262	3	5	4	5	1	1	0	1	\N	5	2	1
221	56	20253	4	3	1	2	1	1	0	0	89.40	2	3	1
222	56	20254	4	3	1	2	1	1	0	3	89.40	2	3	1
223	56	20261	4	3	1	2	1	1	0	0	89.40	0	1	1
224	56	20262	4	3	1	2	1	1	0	2	89.40	0	3	1
225	57	20253	3	1	1	2	1	1	0	1	84.86	4	5	1
226	57	20254	3	1	1	2	1	1	0	0	84.86	4	5	1
227	57	20261	3	1	1	2	1	1	0	0	84.86	0	0	0
228	57	20262	3	1	1	2	1	1	0	1	84.86	0	0	0
229	58	20253	3	4	1	2	1	1	0	6	85.81	5	2	1
230	58	20254	3	4	1	2	1	1	0	2	85.81	5	3	1
231	58	20261	3	4	1	2	1	1	0	1	85.81	0	0	0
232	58	20262	3	4	1	2	1	1	0	2	85.81	0	0	0
233	59	20253	3	1	1	5	1	1	0	1	83.90	3	3	1
234	59	20254	3	1	1	5	1	1	0	3	83.90	3	3	1
235	59	20261	3	1	1	5	1	1	0	0	83.90	1	2	1
236	59	20262	3	1	1	5	1	1	0	1	83.90	1	2	1
237	60	20253	4	3	1	6	1	1	0	0	\N	0	1	1
238	60	20254	4	3	1	6	1	1	0	0	\N	0	1	1
239	60	20261	4	3	1	6	1	1	0	0	\N	1	1	1
240	60	20262	4	3	1	6	1	1	0	1	\N	1	1	1
241	61	20253	4	3	1	4	1	1	0	4	82.26	2	2	1
242	61	20254	4	3	1	4	1	1	0	12	82.26	3	2	1
243	61	20261	4	3	1	4	1	1	0	0	82.26	3	2	1
244	61	20262	4	3	1	4	1	1	0	5	82.26	3	2	1
245	62	20253	4	1	1	2	1	1	0	0	\N	0	1	1
246	62	20254	4	1	1	2	1	1	0	0	\N	1	1	1
247	62	20261	4	1	1	2	1	1	0	0	\N	1	1	1
248	62	20262	4	1	1	2	1	1	0	0	\N	1	1	1
249	63	20253	4	3	1	2	1	1	0	4	84.36	4	3	1
250	63	20254	4	3	1	2	1	1	0	2	84.36	4	3	1
251	63	20261	4	3	1	2	1	1	0	0	84.36	1	1	1
252	63	20262	4	3	1	2	1	1	0	1	84.36	3	1	1
253	64	20253	3	3	1	2	1	1	0	0	74.13	3	2	1
254	64	20254	3	3	1	2	1	1	0	2	74.13	3	2	1
255	64	20261	3	3	1	2	1	1	0	1	74.13	2	2	1
256	64	20262	3	3	1	2	1	1	0	0	74.13	3	2	1
257	65	20253	4	1	1	2	1	1	0	1	85.88	3	4	1
258	65	20254	4	1	1	2	1	1	0	2	85.88	3	4	1
259	65	20261	4	1	1	2	1	1	0	0	85.88	2	1	1
260	65	20262	4	1	1	2	1	1	0	1	85.88	2	1	1
261	66	20253	3	1	1	2	1	1	0	2	84.12	2	2	1
262	66	20254	3	1	1	2	1	1	0	2	84.12	2	2	1
263	66	20261	3	1	1	2	1	1	0	0	84.12	0	1	1
264	66	20262	3	1	1	2	1	1	0	1	84.12	0	1	1
265	67	20253	3	3	1	2	1	1	0	0	86.82	2	2	1
266	67	20254	3	3	1	2	1	1	0	4	86.82	2	2	1
267	67	20261	3	3	1	2	1	1	0	1	86.82	2	1	1
268	67	20262	3	3	1	2	1	1	0	2	86.82	2	1	1
269	68	20253	4	4	1	11	1	1	0	9	91.92	4	3	1
270	68	20254	4	4	1	11	1	1	0	8	91.92	6	4	1
271	68	20261	4	4	1	11	1	1	0	3	91.92	3	3	1
272	68	20262	4	4	1	11	1	1	0	3	91.92	6	3	1
273	69	20253	4	3	4	2	1	1	0	1	84.33	2	2	1
274	69	20254	4	3	4	2	1	1	0	2	84.33	2	2	1
275	69	20261	4	3	4	2	1	1	0	0	84.33	1	0	0
276	69	20262	4	3	4	2	1	1	0	1	84.33	2	0	0
277	70	20253	3	5	4	5	1	1	0	1	84.60	2	2	1
278	70	20254	3	5	4	5	1	1	0	1	84.60	2	2	1
279	70	20261	3	5	4	5	1	1	0	0	84.60	2	1	1
280	70	20262	3	5	4	5	1	1	0	1	84.60	2	1	1
281	71	20253	4	5	4	6	1	1	0	0	88.09	2	5	1
282	71	20254	4	5	4	6	1	1	0	8	88.09	3	5	1
283	71	20261	4	5	4	6	1	1	0	1	88.09	4	2	1
284	71	20262	4	5	4	6	1	1	0	3	88.09	4	2	1
285	72	20253	3	3	1	4	1	1	0	1	\N	0	0	0
286	72	20254	3	3	1	4	1	1	0	1	\N	0	0	0
287	72	20261	3	3	1	4	1	1	0	0	\N	0	0	0
288	72	20262	3	3	1	4	1	1	0	0	\N	0	0	0
289	73	20253	3	1	4	7	1	1	0	5	87.58	3	3	1
290	73	20254	3	1	4	7	1	1	0	2	87.58	3	3	1
291	73	20261	3	1	4	7	1	1	0	1	87.58	1	2	1
292	73	20262	3	1	4	7	1	1	0	3	87.58	1	2	1
293	74	20253	4	3	1	6	1	1	0	0	80.46	2	2	1
294	74	20254	4	3	1	6	1	1	0	0	80.46	2	2	1
295	74	20261	4	3	1	6	1	1	0	0	80.46	1	0	0
296	74	20262	4	3	1	6	1	1	0	0	80.46	1	2	1
297	75	20253	3	3	1	4	1	1	0	2	78.68	2	3	1
298	75	20254	3	3	1	4	1	1	0	3	78.68	2	3	1
299	75	20261	3	3	1	4	1	1	0	0	78.68	1	1	1
300	75	20262	3	3	1	4	1	1	0	0	78.68	1	1	1
301	76	20253	3	3	1	2	1	1	0	0	82.27	2	4	1
302	76	20254	3	3	1	2	1	1	0	11	82.27	2	4	1
303	76	20261	3	3	1	2	1	1	0	1	82.27	0	2	1
304	76	20262	3	3	1	2	1	1	0	1	82.27	0	2	1
305	77	20253	4	3	1	2	1	1	0	1	81.16	1	1	1
306	77	20254	4	3	1	2	1	1	0	1	81.16	1	1	1
307	77	20261	4	3	1	2	1	1	0	0	81.16	2	0	0
308	77	20262	4	3	1	2	1	1	0	0	81.16	2	0	0
309	78	20253	4	4	1	2	1	1	0	11	78.44	5	2	1
310	78	20254	4	4	1	2	1	1	0	13	78.44	6	2	1
311	78	20261	4	4	1	2	1	1	0	0	78.44	4	1	1
312	78	20262	4	4	1	2	1	1	0	13	78.44	5	1	1
313	79	20253	3	1	1	4	1	1	0	2	83.48	2	2	1
314	79	20254	3	1	1	4	1	1	0	1	83.48	2	2	1
315	79	20261	3	1	1	4	1	1	0	0	83.48	0	1	1
316	79	20262	3	1	1	4	1	1	0	1	83.48	1	1	1
317	80	20253	4	1	1	5	1	1	0	4	\N	1	2	1
318	80	20254	4	1	1	5	1	1	0	4	\N	1	2	1
319	80	20261	4	1	1	5	1	1	0	0	\N	2	0	0
320	80	20262	4	1	1	5	1	1	0	1	\N	2	0	0
321	81	20253	4	5	5	10	1	1	0	0	89.05	0	0	0
322	81	20254	4	5	5	10	1	1	0	0	89.05	0	0	0
323	81	20261	4	5	5	10	1	1	0	0	89.05	0	0	0
324	81	20262	4	5	5	10	1	1	0	0	89.05	0	0	0
325	82	20253	3	4	1	6	1	1	0	0	81.64	2	5	1
326	82	20254	3	4	1	6	1	1	0	4	81.64	2	5	1
327	82	20261	3	4	1	6	1	1	0	0	81.64	1	1	1
328	82	20262	3	4	1	6	1	1	0	0	81.64	1	1	1
329	83	20253	4	4	1	2	1	1	0	3	82.60	2	3	1
330	83	20254	4	4	1	2	1	1	0	8	82.60	3	4	1
331	83	20261	4	4	1	2	1	1	0	2	82.60	2	0	0
332	83	20262	4	4	1	2	1	1	0	9	82.60	3	1	1
333	84	20253	4	4	1	6	1	1	0	2	81.52	6	0	0
334	84	20254	4	4	1	6	1	1	0	0	81.52	8	0	0
335	84	20261	4	4	1	6	1	1	0	1	81.52	3	1	1
336	84	20262	4	4	1	6	1	1	0	2	81.52	3	1	1
337	85	20253	4	3	1	2	1	1	0	5	\N	0	4	1
338	85	20254	4	3	1	2	1	1	0	5	\N	0	4	1
339	85	20261	4	3	1	2	1	1	0	0	\N	1	1	1
340	85	20262	4	3	1	2	1	1	0	3	\N	1	2	1
341	86	20253	4	3	5	7	1	1	0	0	83.40	0	3	1
342	86	20254	4	3	5	7	1	1	0	0	83.40	0	3	1
343	86	20261	4	3	5	7	1	1	0	0	83.40	0	1	1
344	86	20262	4	3	5	7	1	1	0	0	83.40	0	1	1
345	87	20253	4	3	1	2	1	1	0	0	81.01	2	2	1
346	87	20254	4	3	1	2	1	1	0	1	81.01	2	2	1
347	87	20261	4	3	1	2	1	1	0	0	81.01	2	1	1
348	87	20262	4	3	1	2	1	1	0	1	81.01	3	2	1
349	88	20253	3	5	4	4	1	1	0	0	\N	0	3	1
350	88	20254	3	5	4	4	1	1	0	0	\N	0	3	1
351	88	20261	3	5	4	4	1	1	0	0	\N	0	1	1
352	88	20262	3	5	4	4	1	1	0	0	\N	0	1	1
353	89	20253	3	1	4	2	1	1	0	2	83.49	1	5	1
354	89	20254	3	1	4	2	1	1	0	1	83.49	3	5	1
355	89	20261	3	1	4	2	1	1	0	0	83.49	4	3	1
356	89	20262	3	1	4	2	1	1	0	0	83.49	4	3	1
357	90	20253	3	3	1	5	1	1	0	4	90.98	5	2	1
358	90	20254	3	3	1	5	1	1	0	1	90.98	7	2	1
359	90	20261	3	3	1	5	1	1	0	0	90.98	3	0	0
360	90	20262	3	3	1	5	1	1	0	0	90.98	3	0	0
361	91	20253	4	4	1	2	1	1	0	3	86.90	4	4	1
362	91	20254	4	4	1	2	1	1	0	12	86.90	8	4	1
363	91	20261	4	4	1	2	1	1	0	0	86.90	6	1	1
364	91	20262	4	4	1	2	1	1	0	5	86.90	9	2	1
365	92	20253	4	3	1	2	1	1	0	1	\N	1	2	1
366	92	20254	4	3	1	2	1	1	0	1	\N	1	2	1
367	92	20261	4	3	1	2	1	1	0	1	\N	1	1	1
368	92	20262	4	3	1	2	1	1	0	0	\N	1	1	1
369	93	20253	4	2	1	11	1	1	0	1	85.41	3	2	1
370	93	20254	4	2	1	11	1	1	0	3	85.41	5	2	1
371	93	20261	4	2	1	11	1	1	0	1	85.41	3	1	1
372	93	20262	4	2	1	11	1	1	0	0	85.41	4	1	1
373	94	20253	3	5	4	5	1	1	0	0	\N	0	2	1
374	94	20254	3	5	4	5	1	1	0	0	\N	0	2	1
375	94	20261	3	5	4	5	1	1	0	0	\N	2	1	1
376	94	20262	3	5	4	5	1	1	0	2	\N	2	1	1
377	95	20253	4	3	1	5	1	1	0	5	88.49	5	4	1
378	95	20254	4	3	1	5	1	1	0	2	88.49	5	4	1
379	95	20261	4	3	1	5	1	1	0	0	88.49	5	2	1
380	95	20262	4	3	1	5	1	1	0	0	88.49	5	2	1
381	96	20253	4	1	3	6	1	1	0	0	84.43	2	1	1
382	96	20254	4	1	3	6	1	1	0	2	84.43	2	1	1
383	96	20261	4	1	3	6	1	1	0	0	84.43	1	0	0
384	96	20262	4	1	3	6	1	1	0	1	84.43	1	0	0
385	97	20253	3	1	1	7	1	1	0	0	87.00	1	1	1
386	97	20254	3	1	1	7	1	1	0	0	87.00	2	1	1
387	97	20261	3	1	1	7	1	1	0	0	87.00	1	0	0
388	97	20262	3	1	1	7	1	1	0	0	87.00	2	0	0
389	98	20253	4	3	1	7	1	1	0	8	84.25	1	5	1
390	98	20254	4	3	1	7	1	1	0	0	84.25	2	5	1
391	98	20261	4	3	1	7	1	1	0	0	84.25	3	3	1
392	98	20262	4	3	1	7	1	1	0	1	84.25	4	3	1
393	99	20253	3	1	1	2	1	1	0	4	91.63	4	4	1
394	99	20254	3	1	1	2	1	1	0	1	91.63	4	5	1
395	99	20261	3	1	1	2	1	1	0	0	91.63	0	1	1
396	99	20262	3	1	1	2	1	1	0	0	91.63	0	1	1
397	100	20253	3	1	1	2	1	1	0	0	\N	0	1	1
398	100	20254	3	1	1	2	1	1	0	0	\N	0	1	1
399	100	20261	3	1	1	2	1	1	0	0	\N	0	0	0
400	100	20262	3	1	1	2	1	1	0	0	\N	0	0	0
401	101	20253	3	3	1	4	1	1	0	0	72.31	0	0	0
402	101	20254	3	3	1	4	1	1	0	0	72.31	0	0	0
403	101	20261	3	3	1	4	1	1	0	0	72.31	0	0	0
404	101	20262	3	3	1	4	1	1	0	0	72.31	0	0	0
405	102	20253	4	3	1	7	1	1	0	1	85.82	1	5	1
406	102	20254	4	3	1	7	1	1	0	0	85.82	2	5	1
407	102	20261	4	3	1	7	1	1	0	0	85.82	2	2	1
408	102	20262	4	3	1	7	1	1	0	0	85.82	3	2	1
409	103	20253	4	3	1	9	1	1	0	1	87.58	3	2	1
410	103	20254	4	3	1	9	1	1	0	6	87.58	3	2	1
411	103	20261	4	3	1	9	1	1	0	2	87.58	0	3	1
412	103	20262	4	3	1	9	1	1	0	1	87.58	1	3	1
413	104	20253	4	3	1	7	1	1	0	1	\N	0	4	1
414	104	20254	4	3	1	7	1	1	0	7	\N	0	4	1
415	104	20261	4	3	1	7	1	1	0	0	\N	2	1	1
416	104	20262	4	3	1	7	1	1	0	0	\N	6	1	1
417	105	20253	4	3	1	5	1	1	0	6	84.25	3	2	1
418	105	20254	4	3	1	5	1	1	0	1	84.25	7	3	1
419	105	20261	4	3	1	5	1	1	0	2	84.25	7	2	1
420	105	20262	4	3	1	5	1	1	0	1	84.25	7	2	1
421	106	20253	4	3	1	6	1	1	0	3	\N	1	2	1
422	106	20254	4	3	1	6	1	1	0	3	\N	2	4	1
423	106	20261	4	3	1	6	1	1	0	1	\N	3	2	1
424	106	20262	4	3	1	6	1	1	0	4	\N	4	2	1
425	107	20253	3	1	1	5	1	1	0	0	86.46	1	2	1
426	107	20254	3	1	1	5	1	1	0	0	86.46	3	2	1
427	107	20261	3	1	1	5	1	1	0	0	86.46	3	2	1
428	107	20262	3	1	1	5	1	1	0	1	86.46	3	2	1
429	108	20253	4	3	1	2	1	1	0	1	84.10	0	0	0
430	108	20254	4	3	1	2	1	1	0	0	84.10	0	0	0
431	108	20261	4	3	1	2	1	1	0	0	84.10	0	1	1
432	108	20262	4	3	1	2	1	1	0	0	84.10	0	1	1
433	109	20253	4	3	1	10	1	1	0	2	86.49	3	3	1
434	109	20254	4	3	1	10	1	1	0	8	86.49	5	3	1
435	109	20261	4	3	1	10	1	1	0	1	86.49	2	1	1
436	109	20262	4	3	1	10	1	1	0	1	86.49	4	1	1
437	110	20253	3	1	1	2	1	1	0	0	87.71	3	3	1
438	110	20254	3	1	1	2	1	1	0	1	87.71	4	3	1
439	110	20261	3	1	1	2	1	1	0	0	87.71	2	1	1
440	110	20262	3	1	1	2	1	1	0	1	87.71	2	1	1
441	111	20253	3	1	1	2	1	1	0	4	79.34	3	2	1
442	111	20254	3	1	1	2	1	1	0	3	79.34	3	2	1
443	111	20261	3	1	1	2	1	1	0	0	79.34	1	1	1
444	111	20262	3	1	1	2	1	1	0	1	79.34	2	1	1
445	112	20253	4	4	1	2	1	1	0	6	92.03	6	5	1
446	112	20254	4	4	1	2	1	1	0	36	92.03	7	5	1
447	112	20261	4	4	1	2	1	1	0	3	92.03	4	2	1
448	112	20262	4	4	1	2	1	1	0	12	92.03	6	3	1
449	113	20253	4	3	1	7	1	1	0	4	\N	1	3	1
450	113	20254	4	3	1	7	1	1	0	3	\N	3	3	1
451	113	20261	4	3	1	7	1	1	0	0	\N	4	2	1
452	113	20262	4	3	1	7	1	1	0	1	\N	4	2	1
453	114	20253	4	1	1	2	1	1	0	0	\N	1	2	1
454	114	20254	4	1	1	2	1	1	0	2	\N	1	2	1
455	114	20261	4	1	1	2	1	1	0	1	\N	1	1	1
456	114	20262	4	1	1	2	1	1	0	0	\N	1	1	1
457	115	20253	4	3	1	2	1	1	0	4	85.59	4	2	1
458	115	20254	4	3	1	2	1	1	0	1	85.59	4	2	1
459	115	20261	4	3	1	2	1	1	0	1	85.59	2	0	0
460	115	20262	4	3	1	2	1	1	0	2	85.59	2	1	1
461	116	20253	4	3	1	9	1	1	0	4	88.84	1	4	1
462	116	20254	4	3	1	9	1	1	0	0	88.84	1	4	1
463	116	20261	4	3	1	9	1	1	0	0	88.84	0	3	1
464	116	20262	4	3	1	9	1	1	0	1	88.84	0	3	1
465	117	20253	4	4	1	7	1	1	0	4	86.61	5	3	1
466	117	20254	4	4	1	7	1	1	0	7	86.61	5	3	1
467	117	20261	4	4	1	7	1	1	0	0	86.61	3	1	1
468	117	20262	4	4	1	7	1	1	0	5	86.61	5	1	1
469	118	20253	4	3	5	2	1	1	0	2	88.18	2	2	1
470	118	20254	4	3	5	2	1	1	0	3	88.18	2	2	1
471	118	20261	4	3	5	2	1	1	0	0	88.18	2	1	1
472	118	20262	4	3	5	2	1	1	0	7	88.18	2	1	1
473	119	20253	4	3	1	2	1	1	0	2	\N	4	2	1
474	119	20254	4	3	1	2	1	1	0	3	\N	4	2	1
475	119	20261	4	3	1	2	1	1	0	1	\N	1	1	1
476	119	20262	4	3	1	2	1	1	0	6	\N	2	1	1
477	120	20253	3	1	1	2	1	1	0	0	\N	0	0	0
478	120	20254	3	1	1	2	1	1	0	0	\N	0	0	0
479	120	20261	3	1	1	2	1	1	0	0	\N	0	0	0
480	120	20262	3	1	1	2	1	1	0	1	\N	0	0	0
481	121	20253	3	3	1	2	1	1	0	0	89.03	1	2	1
482	121	20254	3	3	1	2	1	1	0	4	89.03	1	2	1
483	121	20261	3	3	1	2	1	1	0	0	89.03	0	0	0
484	121	20262	3	3	1	2	1	1	0	0	89.03	0	0	0
485	122	20253	3	1	1	7	1	1	0	7	89.52	2	4	1
486	122	20254	3	1	1	7	1	1	0	3	89.52	2	4	1
487	122	20261	3	1	1	7	1	1	0	0	89.52	1	3	1
488	122	20262	3	1	1	7	1	1	0	3	89.52	1	3	1
489	123	20253	4	3	1	2	1	1	0	0	\N	1	0	0
490	123	20254	4	3	1	2	1	1	0	0	\N	1	1	1
491	123	20261	4	3	1	2	1	1	0	0	\N	1	0	0
492	123	20262	4	3	1	2	1	1	0	0	\N	2	1	1
493	124	20253	3	1	1	7	1	1	0	3	84.36	2	4	1
494	124	20254	3	1	1	7	1	1	0	0	84.36	2	4	1
495	124	20261	3	1	1	7	1	1	0	0	84.36	0	2	1
496	124	20262	3	1	1	7	1	1	0	0	84.36	0	2	1
497	125	20253	4	4	1	2	1	1	0	0	85.48	3	3	1
498	125	20254	4	4	1	2	1	1	0	11	85.48	3	3	1
499	125	20261	4	4	1	2	1	1	0	0	85.48	1	2	1
500	125	20262	4	4	1	2	1	1	0	0	85.48	2	2	1
501	126	20253	3	3	1	2	1	1	0	1	89.26	5	3	1
502	126	20254	3	3	1	2	1	1	0	2	89.26	5	3	1
503	126	20261	3	3	1	2	1	1	0	0	89.26	0	0	0
504	126	20262	3	3	1	2	1	1	0	0	89.26	0	0	0
505	127	20253	4	3	1	10	1	1	0	2	84.16	0	4	1
506	127	20254	4	3	1	10	1	1	0	4	84.16	1	4	1
507	127	20261	4	3	1	10	1	1	0	0	84.16	1	2	1
508	127	20262	4	3	1	10	1	1	0	0	84.16	1	2	1
509	128	20253	3	3	1	2	1	1	0	3	82.85	1	3	1
510	128	20254	3	3	1	2	1	1	0	0	82.85	1	3	1
511	128	20261	3	3	1	2	1	1	0	0	82.85	0	2	1
512	128	20262	3	3	1	2	1	1	0	0	82.85	0	2	1
513	129	20253	3	1	1	2	1	1	0	2	88.81	0	2	1
514	129	20254	3	1	1	2	1	1	0	1	88.81	1	2	1
515	129	20261	3	1	1	2	1	1	0	0	88.81	1	1	1
516	129	20262	3	1	1	2	1	1	0	1	88.81	2	1	1
517	130	20253	3	3	1	7	1	1	0	2	\N	1	0	0
518	130	20254	3	3	1	7	1	1	0	0	\N	1	0	0
519	130	20261	3	3	1	7	1	1	0	1	\N	0	0	0
520	130	20262	3	3	1	7	1	1	0	3	\N	0	0	0
521	131	20253	3	3	1	2	1	1	0	0	84.47	0	0	0
522	131	20254	3	3	1	2	1	1	0	0	84.47	0	0	0
523	131	20261	3	3	1	2	1	1	0	0	84.47	0	0	0
524	131	20262	3	3	1	2	1	1	0	1	84.47	0	0	0
525	132	20253	3	3	1	2	1	1	0	0	\N	0	0	0
526	132	20254	3	3	1	2	1	1	0	0	\N	0	0	0
527	132	20261	3	3	1	2	1	1	0	0	\N	0	0	0
528	132	20262	3	3	1	2	1	1	0	0	\N	0	0	0
529	133	20253	3	4	1	2	1	1	0	0	87.76	2	2	1
530	133	20254	3	4	1	2	1	1	0	0	87.76	0	2	1
531	133	20261	3	4	1	2	1	1	0	0	87.76	1	1	1
532	133	20262	3	4	1	2	1	1	0	0	87.76	1	1	1
533	134	20253	3	1	1	2	1	1	0	3	85.94	1	2	1
534	134	20254	3	1	1	2	1	1	0	2	85.94	1	2	1
535	134	20261	3	1	1	2	1	1	0	0	85.94	2	2	1
536	134	20262	3	1	1	2	1	1	0	0	85.94	2	2	1
537	135	20253	4	1	1	7	1	1	0	1	80.82	1	2	1
538	135	20254	4	1	1	7	1	1	0	0	80.82	1	2	1
539	135	20261	4	1	1	7	1	1	0	0	80.82	0	2	1
540	135	20262	4	1	1	7	1	1	0	2	80.82	0	2	1
541	136	20253	4	2	1	11	1	1	0	0	93.23	6	3	1
542	136	20254	4	2	1	11	1	1	0	2	93.23	6	3	1
543	136	20261	4	2	1	11	1	1	0	0	93.23	6	0	0
544	136	20262	4	2	1	11	1	1	0	1	93.23	9	0	0
545	137	20253	4	3	1	2	1	1	0	1	83.46	3	5	1
546	137	20254	4	3	1	2	1	1	0	2	83.46	5	5	1
547	137	20261	4	3	1	2	1	1	0	1	83.46	2	1	1
548	137	20262	4	3	1	2	1	1	0	1	83.46	3	3	1
549	138	20253	4	4	1	2	1	1	0	2	89.33	5	4	1
550	138	20254	4	4	1	2	1	1	0	3	89.33	5	3	1
551	138	20261	4	4	1	2	1	1	0	1	89.33	3	2	1
552	138	20262	4	4	1	2	1	1	0	7	89.33	6	2	1
553	139	20253	3	1	1	5	1	1	0	1	87.99	2	2	1
554	139	20254	3	1	1	5	1	1	0	0	87.99	2	2	1
555	139	20261	3	1	1	5	1	1	0	0	87.99	2	1	1
556	139	20262	3	1	1	5	1	1	0	0	87.99	2	1	1
557	140	20253	4	4	1	9	1	1	0	0	88.34	3	3	1
558	140	20254	4	4	1	9	1	1	0	3	88.34	3	3	1
559	140	20261	4	4	1	9	1	1	0	1	88.34	1	1	1
560	140	20262	4	4	1	9	1	1	0	1	88.34	3	1	1
561	141	20253	3	1	1	5	1	1	0	0	\N	0	0	0
562	141	20254	3	1	1	5	1	1	0	0	\N	0	0	0
563	141	20261	3	1	1	5	1	1	0	0	\N	0	0	0
564	141	20262	3	1	1	5	1	1	0	0	\N	0	0	0
565	142	20253	3	1	1	5	1	1	0	1	91.91	4	3	1
566	142	20254	3	1	1	5	1	1	0	2	91.91	4	3	1
567	142	20261	3	1	1	5	1	1	0	1	91.91	2	1	1
568	142	20262	3	1	1	5	1	1	0	2	91.91	2	1	1
569	143	20253	4	4	1	6	1	1	0	2	85.85	4	3	1
570	143	20254	4	4	1	6	1	1	0	1	85.85	4	3	1
571	143	20261	4	4	1	6	1	1	0	0	85.85	3	1	1
572	143	20262	4	4	1	6	1	1	0	3	85.85	4	1	1
573	144	20253	3	1	1	2	1	1	0	0	81.99	0	0	0
574	144	20254	3	1	1	2	1	1	0	2	81.99	0	0	0
575	144	20261	3	1	1	2	1	1	0	0	81.99	0	0	0
576	144	20262	3	1	1	2	1	1	0	4	81.99	0	0	0
577	145	20253	4	3	1	2	1	1	0	3	79.06	0	0	0
578	145	20254	4	3	1	2	1	1	0	2	79.06	0	0	0
579	145	20261	4	3	1	2	1	1	0	0	79.06	0	0	0
580	145	20262	4	3	1	2	1	1	0	0	79.06	0	1	1
581	146	20253	3	3	1	2	1	1	0	0	91.94	1	0	0
582	146	20254	3	3	1	2	1	1	0	1	91.94	1	0	0
583	146	20261	3	3	1	2	1	1	0	0	91.94	1	1	1
584	146	20262	3	3	1	2	1	1	0	0	91.94	2	1	1
585	147	20253	4	5	5	7	1	1	0	0	86.82	0	1	1
586	147	20254	4	5	5	7	1	1	0	0	86.82	0	1	1
587	147	20261	4	5	5	7	1	1	0	0	86.82	0	2	1
588	147	20262	4	5	5	7	1	1	0	0	86.82	0	2	1
589	148	20253	4	3	5	2	1	1	0	0	75.00	0	0	0
590	148	20254	4	3	5	2	1	1	0	5	75.00	0	0	0
591	148	20261	4	3	5	2	1	1	0	0	75.00	0	1	1
592	148	20262	4	3	5	2	1	1	0	0	75.00	0	1	1
593	149	20253	3	3	1	5	1	1	0	1	84.62	1	2	1
594	149	20254	3	3	1	5	1	1	0	0	84.62	1	2	1
595	149	20261	3	3	1	5	1	1	0	0	84.62	1	1	1
596	149	20262	3	3	1	5	1	1	0	2	84.62	1	1	1
597	150	20253	4	4	1	5	1	1	0	7	77.78	3	2	1
598	150	20254	4	4	1	5	1	1	0	3	77.78	3	2	1
599	150	20261	4	4	1	5	1	1	0	1	77.78	1	1	1
600	150	20262	4	4	1	5	1	1	0	4	77.78	1	1	1
601	151	20253	4	2	1	2	1	1	0	5	85.76	5	5	1
602	151	20254	4	2	1	2	1	1	0	16	85.76	6	5	1
603	151	20261	4	2	1	2	1	1	0	0	85.76	4	2	1
604	151	20262	4	2	1	2	1	1	0	5	85.76	7	4	1
605	152	20253	3	5	4	7	1	1	0	0	\N	0	1	1
606	152	20254	3	5	4	7	1	1	0	0	\N	0	1	1
607	152	20261	3	5	4	7	1	1	0	0	\N	0	3	1
608	152	20262	3	5	4	7	1	1	0	0	\N	0	3	1
609	153	20253	3	5	4	2	1	1	0	0	\N	0	2	1
610	153	20254	3	5	4	2	1	1	0	4	\N	0	2	1
611	153	20261	3	5	4	2	1	1	0	0	\N	2	2	1
612	153	20262	3	5	4	2	1	1	0	3	\N	2	2	1
613	154	20253	3	5	4	2	1	1	0	0	\N	1	3	1
614	154	20254	3	5	4	2	1	1	0	0	\N	1	3	1
615	154	20261	3	5	4	2	1	1	0	0	\N	1	2	1
616	154	20262	3	5	4	2	1	1	0	0	\N	1	2	1
617	155	20253	3	5	4	2	1	1	0	0	\N	1	1	1
618	155	20254	3	5	4	2	1	1	0	2	\N	3	1	1
619	155	20261	3	5	4	2	1	1	0	0	\N	6	1	1
620	155	20262	3	5	4	2	1	1	0	2	\N	7	1	1
621	156	20253	3	5	4	5	1	1	0	0	\N	1	2	1
622	156	20254	3	5	4	5	1	1	0	0	\N	1	2	1
623	156	20261	3	5	4	5	1	1	0	0	\N	2	2	1
624	156	20262	3	5	4	5	1	1	0	1	\N	2	2	1
625	157	20253	3	5	4	7	1	1	0	5	\N	1	3	1
626	157	20254	3	5	4	7	1	1	0	4	\N	2	3	1
627	157	20261	3	5	4	7	1	1	0	2	\N	4	4	1
628	157	20262	3	5	4	7	1	1	0	4	\N	5	4	1
629	158	20253	4	5	4	2	1	1	0	0	\N	0	0	0
630	158	20254	4	5	4	2	1	1	0	0	\N	0	0	0
631	158	20261	4	5	4	2	1	1	0	0	\N	2	1	1
632	158	20262	4	5	4	2	1	1	0	2	\N	2	1	1
633	159	20253	3	5	1	5	1	1	0	0	\N	0	0	0
634	159	20254	3	5	1	5	1	1	0	0	\N	0	1	1
635	159	20261	3	5	1	5	1	1	0	0	\N	2	2	1
636	159	20262	3	5	1	5	1	1	0	1	\N	2	2	1
637	160	20253	3	5	4	7	1	1	0	0	\N	0	0	0
638	160	20254	3	5	4	7	1	1	0	0	\N	0	0	0
639	160	20261	3	5	4	7	1	1	0	0	\N	2	0	0
640	160	20262	3	5	4	7	1	1	0	0	\N	2	2	1
641	161	20253	3	5	4	2	1	1	0	0	\N	0	0	0
642	161	20254	3	5	4	2	1	1	0	0	\N	0	0	0
643	161	20261	3	5	4	2	1	1	0	0	\N	2	1	1
644	161	20262	3	5	4	2	1	1	0	1	\N	2	3	1
645	162	20253	3	5	4	2	1	1	0	0	\N	0	0	0
646	162	20254	3	5	4	2	1	1	0	0	\N	0	0	0
647	162	20261	3	5	4	2	1	1	0	0	\N	1	0	0
648	162	20262	3	5	4	2	1	1	0	0	\N	1	1	1
649	163	20253	3	5	4	7	1	1	0	0	\N	0	0	0
650	163	20254	3	5	4	7	1	1	0	0	\N	0	0	0
651	163	20261	3	5	4	7	1	1	0	0	\N	3	2	1
652	163	20262	3	5	4	7	1	1	0	0	\N	3	2	1
653	164	20253	3	5	4	7	1	1	0	0	\N	0	0	0
654	164	20254	3	5	4	7	1	1	0	0	\N	0	0	0
655	164	20261	3	5	4	7	1	1	0	0	\N	2	1	1
656	164	20262	3	5	4	7	1	1	0	1	\N	2	1	1
657	165	20253	3	5	4	2	1	1	0	0	\N	0	0	0
658	165	20254	3	5	4	2	1	1	0	0	\N	0	0	0
659	165	20261	3	5	4	2	1	1	0	0	\N	0	0	0
660	165	20262	3	5	4	2	1	1	0	0	\N	0	1	1
661	166	20253	3	5	4	7	1	1	0	0	\N	0	0	0
662	166	20254	3	5	4	7	1	1	0	0	\N	0	0	0
663	166	20261	3	5	4	7	1	1	0	2	\N	0	2	1
664	166	20262	3	5	4	7	1	1	0	0	\N	1	2	1
665	167	20253	3	5	4	2	1	1	0	0	\N	0	0	0
666	167	20254	3	5	4	2	1	1	0	0	\N	0	0	0
667	167	20261	3	5	4	2	1	1	0	1	\N	1	1	1
668	167	20262	3	5	4	2	1	1	0	0	\N	1	2	1
669	168	20253	3	5	4	6	1	1	0	0	\N	0	0	0
670	168	20254	3	5	4	6	1	1	0	0	\N	0	0	0
671	168	20261	3	5	4	6	1	1	0	0	\N	0	0	0
672	168	20262	3	5	4	6	1	1	0	0	\N	0	1	1
673	169	20253	3	5	4	6	1	1	0	0	\N	0	0	0
674	169	20254	3	5	4	6	1	1	0	0	\N	0	0	0
675	169	20261	3	5	4	6	1	1	0	1	\N	0	1	1
676	169	20262	3	5	4	6	1	1	0	0	\N	0	1	1
677	170	20253	3	5	4	7	1	1	0	0	\N	0	0	0
678	170	20254	3	5	4	7	1	1	0	0	\N	0	0	0
679	170	20261	3	5	4	7	1	1	0	1	\N	0	0	0
680	170	20262	3	5	4	7	1	1	0	4	\N	0	1	1
681	171	20253	3	5	4	6	1	1	0	0	\N	0	0	0
682	171	20254	3	5	4	6	1	1	0	0	\N	0	0	0
683	171	20261	3	5	4	6	1	1	0	1	\N	0	0	0
684	171	20262	3	5	4	6	1	1	0	1	\N	0	1	1
685	172	20253	3	5	4	6	1	1	0	0	\N	0	0	0
686	172	20254	3	5	4	6	1	1	0	0	\N	0	0	0
687	172	20261	3	5	4	6	1	1	0	0	\N	0	0	0
688	172	20262	3	5	4	6	1	1	0	0	\N	0	0	0
689	173	20253	3	5	4	6	1	1	0	0	95.53	0	0	0
690	173	20254	3	5	4	6	1	1	0	0	95.53	0	0	0
691	173	20261	3	5	4	6	1	1	0	0	95.53	0	1	1
692	173	20262	3	5	4	6	1	1	0	0	95.53	1	1	1
693	174	20253	3	5	4	7	1	1	0	0	\N	0	0	0
694	174	20254	3	5	4	7	1	1	0	0	\N	0	0	0
695	174	20261	3	5	4	7	1	1	0	0	\N	0	1	1
696	174	20262	3	5	4	7	1	1	0	0	\N	1	1	1
697	175	20253	3	5	4	4	1	1	0	0	\N	0	0	0
698	175	20254	3	5	4	4	1	1	0	0	\N	0	0	0
699	175	20261	3	5	4	4	1	1	0	1	\N	0	0	0
700	175	20262	3	5	4	4	1	1	0	0	\N	0	1	1
701	176	20253	3	5	4	4	1	1	0	0	\N	0	0	0
702	176	20254	3	5	4	4	1	1	0	0	\N	0	0	0
703	176	20261	3	5	4	4	1	1	0	0	\N	0	0	0
704	176	20262	3	5	4	4	1	1	0	0	\N	0	1	1
705	177	20253	3	5	4	4	1	1	0	0	\N	0	1	1
706	177	20254	3	5	4	4	1	1	0	0	\N	0	1	1
707	177	20261	3	5	4	4	1	1	0	0	\N	0	4	1
708	177	20262	3	5	4	4	1	1	0	0	\N	0	4	1
709	178	20253	3	5	4	7	1	1	0	0	\N	0	0	0
710	178	20254	3	5	4	7	1	1	0	0	\N	0	0	0
711	178	20261	3	5	4	7	1	1	0	0	\N	0	0	0
712	178	20262	3	5	4	7	1	1	0	0	\N	0	0	0
713	179	20253	3	5	4	5	1	1	0	0	\N	0	0	0
714	179	20254	3	5	4	5	1	1	0	0	\N	0	0	0
715	179	20261	3	5	4	5	1	1	0	0	\N	0	0	0
716	179	20262	3	5	4	5	1	1	0	0	\N	0	0	0
717	180	20253	3	5	4	7	1	1	0	0	\N	0	0	0
718	180	20254	3	5	4	7	1	1	0	0	\N	0	0	0
719	180	20261	3	5	4	7	1	1	0	0	\N	0	0	0
720	180	20262	3	5	4	7	1	1	0	0	\N	0	0	0
721	181	20253	3	5	4	7	1	1	0	0	\N	0	0	0
722	181	20254	3	5	4	7	1	1	0	0	\N	0	0	0
723	181	20261	3	5	4	7	1	1	0	0	\N	0	0	0
724	181	20262	3	5	4	7	1	1	0	0	\N	0	0	0
725	182	20253	3	5	4	4	1	1	0	0	\N	0	0	0
726	182	20254	3	5	4	4	1	1	0	0	\N	0	0	0
727	182	20261	3	5	4	4	1	1	0	0	\N	0	0	0
728	182	20262	3	5	4	4	1	1	0	0	\N	0	0	0
729	183	20253	3	5	4	7	1	1	0	0	\N	0	0	0
730	183	20254	3	5	4	7	1	1	0	0	\N	0	0	0
731	183	20261	3	5	4	7	1	1	0	0	\N	0	0	0
732	183	20262	3	5	4	7	1	1	0	0	\N	0	0	0
733	184	20253	3	5	4	7	1	1	0	0	\N	0	0	0
734	184	20254	3	5	4	7	1	1	0	0	\N	0	0	0
735	184	20261	3	5	4	7	1	1	0	0	\N	0	0	0
736	184	20262	3	5	4	7	1	1	0	0	\N	0	0	0
737	185	20253	3	5	4	2	1	1	0	0	\N	0	0	0
738	185	20254	3	5	4	2	1	1	0	0	\N	0	0	0
739	185	20261	3	5	4	2	1	1	0	0	\N	0	0	0
740	185	20262	3	5	4	2	1	1	0	0	\N	0	0	0
741	186	20253	4	5	4	2	1	1	0	2	86.34	4	2	1
742	186	20254	4	5	4	2	1	1	0	4	86.34	4	2	1
743	186	20261	4	5	4	2	1	1	0	0	86.34	1	2	1
744	186	20262	4	5	4	2	1	1	0	5	86.34	2	2	1
745	187	20253	3	5	4	5	1	1	0	4	\N	3	3	1
746	187	20254	3	5	4	5	1	1	0	6	\N	3	3	1
747	187	20261	3	5	4	5	1	1	0	0	\N	0	2	1
748	187	20262	3	5	4	5	1	1	0	2	\N	1	2	1
749	188	20253	6	14	7	7	1	1	0	0	68.05	0	0	0
750	188	20254	6	14	7	7	1	1	0	0	68.05	0	0	0
751	188	20261	6	14	7	7	1	1	0	0	68.05	0	0	0
752	188	20262	6	14	7	7	1	1	0	2	68.05	0	0	0
753	189	20253	5	7	1	12	1	0	1	0	\N	0	0	0
754	189	20254	5	7	1	12	1	0	1	0	\N	0	0	0
755	189	20261	5	7	1	12	1	0	1	0	\N	0	0	0
756	189	20262	5	7	1	12	1	0	1	0	\N	0	0	0
757	190	20253	2	7	1	14	1	0	1	0	\N	0	0	0
758	190	20254	2	7	1	14	1	0	1	0	\N	0	0	0
759	190	20261	2	7	1	14	1	0	1	0	\N	0	0	0
760	190	20262	2	7	1	14	1	0	1	0	\N	0	0	0
761	191	20253	2	7	1	5	1	0	1	0	\N	0	0	0
762	191	20254	2	7	1	5	1	0	1	0	\N	0	0	0
763	191	20261	2	7	1	5	1	0	1	0	\N	0	0	0
764	191	20262	2	7	1	5	1	0	1	0	\N	0	0	0
765	192	20253	5	10	1	16	1	0	1	0	\N	0	0	0
766	192	20254	5	10	1	16	1	0	1	0	\N	0	0	0
767	192	20261	5	10	1	16	1	0	1	0	\N	0	0	0
768	192	20262	5	10	1	16	1	0	1	0	\N	0	0	0
769	193	20253	1	11	1	17	1	0	1	0	\N	0	0	0
770	193	20254	1	11	1	17	1	0	1	0	\N	0	0	0
771	193	20261	1	11	1	17	1	0	1	0	\N	0	0	0
772	193	20262	1	11	1	17	1	0	1	0	\N	0	0	0
773	194	20253	2	7	1	6	1	0	1	0	\N	0	0	0
774	194	20254	2	7	1	6	1	0	1	0	\N	0	0	0
775	194	20261	2	7	1	6	1	0	1	0	\N	0	0	0
776	194	20262	2	7	1	6	1	0	1	0	\N	0	0	0
777	195	20253	2	7	1	2	1	0	1	0	\N	0	0	0
778	195	20254	2	7	1	2	1	0	1	0	\N	0	0	0
779	195	20261	2	7	1	2	1	0	1	0	\N	0	1	1
780	195	20262	2	7	1	2	1	0	1	0	\N	0	1	1
781	196	20253	2	8	1	16	1	0	1	0	\N	0	0	0
782	196	20254	2	8	1	16	1	0	1	0	\N	0	0	0
783	196	20261	2	8	1	16	1	0	1	0	\N	0	0	0
784	196	20262	2	8	1	16	1	0	1	0	\N	0	0	0
785	197	20253	5	10	1	16	1	0	1	0	\N	0	0	0
786	197	20254	5	10	1	16	1	0	1	0	\N	0	0	0
787	197	20261	5	10	1	16	1	0	1	0	\N	0	0	0
788	197	20262	5	10	1	16	1	0	1	0	\N	0	0	0
789	198	20253	1	10	1	12	1	0	1	0	\N	0	0	0
790	198	20254	1	10	1	12	1	0	1	0	\N	0	0	0
791	198	20261	1	10	1	12	1	0	1	0	\N	0	0	0
792	198	20262	1	10	1	12	1	0	1	0	\N	0	0	0
793	199	20253	2	8	1	12	1	0	1	0	\N	0	0	0
794	199	20254	2	8	1	12	1	0	1	0	\N	0	0	0
795	199	20261	2	8	1	12	1	0	1	0	\N	0	0	0
796	199	20262	2	8	1	12	1	0	1	0	\N	0	0	0
797	200	20253	2	8	1	16	1	0	1	0	\N	0	0	0
798	200	20254	2	8	1	16	1	0	1	0	\N	0	0	0
799	200	20261	2	8	1	16	1	0	1	0	\N	0	0	0
800	200	20262	2	8	1	16	1	0	1	0	\N	0	0	0
801	201	20253	5	11	1	12	1	0	1	0	\N	0	0	0
802	201	20254	5	11	1	12	1	0	1	0	\N	0	0	0
803	201	20261	5	11	1	12	1	0	1	0	\N	0	0	0
804	201	20262	5	11	1	12	1	0	1	0	\N	0	0	0
805	202	20253	2	10	1	15	1	0	1	0	\N	0	0	0
806	202	20254	2	10	1	15	1	0	1	0	\N	0	0	0
807	202	20261	2	10	1	15	1	0	1	0	\N	0	0	0
808	202	20262	2	10	1	15	1	0	1	0	\N	0	0	0
809	203	20253	2	7	1	10	1	0	1	0	\N	0	0	0
810	203	20254	2	7	1	10	1	0	1	0	\N	0	0	0
811	203	20261	2	7	1	10	1	0	1	0	\N	0	0	0
812	203	20262	2	7	1	10	1	0	1	0	\N	0	0	0
813	204	20253	2	8	1	7	1	0	1	0	\N	0	0	0
814	204	20254	2	8	1	7	1	0	1	0	\N	0	0	0
815	204	20261	2	8	1	7	1	0	1	0	\N	0	0	0
816	204	20262	2	8	1	7	1	0	1	0	\N	0	0	0
817	205	20253	3	9	1	10	1	0	1	0	\N	0	0	0
818	205	20254	3	9	1	10	1	0	1	0	\N	0	0	0
819	205	20261	3	9	1	10	1	0	1	0	\N	0	0	0
820	205	20262	3	9	1	10	1	0	1	0	\N	0	0	0
821	206	20253	5	11	1	17	1	0	1	0	\N	0	0	0
822	206	20254	5	11	1	17	1	0	1	0	\N	0	0	0
823	206	20261	5	11	1	17	1	0	1	0	\N	0	0	0
824	206	20262	5	11	1	17	1	0	1	0	\N	0	0	0
825	207	20253	3	13	1	17	1	0	1	0	\N	0	1	1
826	207	20254	3	13	1	17	1	0	1	0	\N	0	1	1
827	207	20261	3	13	1	17	1	0	1	0	\N	0	1	1
828	207	20262	3	13	1	17	1	0	1	0	\N	0	1	1
829	208	20253	5	10	1	16	1	0	1	0	\N	0	0	0
830	208	20254	5	10	1	16	1	0	1	0	\N	0	0	0
831	208	20261	5	10	1	16	1	0	1	0	\N	0	0	0
832	208	20262	5	10	1	16	1	0	1	0	\N	0	0	0
833	209	20253	2	7	4	11	1	0	1	0	\N	0	0	0
834	209	20254	2	7	4	11	1	0	1	0	\N	0	0	0
835	209	20261	2	7	4	11	1	0	1	0	\N	0	1	1
836	209	20262	2	7	4	11	1	0	1	0	\N	0	1	1
837	210	20253	2	7	4	16	1	0	1	0	\N	0	0	0
838	210	20254	2	7	4	16	1	0	1	0	\N	0	0	0
839	210	20261	2	7	4	16	1	0	1	0	\N	0	0	0
840	210	20262	2	7	4	16	1	0	1	0	\N	0	0	0
841	211	20253	2	7	4	4	1	0	1	0	\N	0	0	0
842	211	20254	2	7	4	4	1	0	1	0	\N	0	0	0
843	211	20261	2	7	4	4	1	0	1	0	\N	0	0	0
844	211	20262	2	7	4	4	1	0	1	0	\N	0	0	0
845	212	20253	1	10	1	17	1	0	1	0	\N	0	0	0
846	212	20254	1	10	1	17	1	0	1	0	\N	0	0	0
847	212	20261	1	10	1	17	1	0	1	0	\N	0	0	0
848	212	20262	1	10	1	17	1	0	1	0	\N	0	0	0
849	213	20253	2	7	1	9	1	0	1	0	\N	0	0	0
850	213	20254	2	7	1	9	1	0	1	0	\N	0	0	0
851	213	20261	2	7	1	9	1	0	1	0	\N	0	0	0
852	213	20262	2	7	1	9	1	0	1	0	\N	0	0	0
853	214	20253	2	12	6	2	1	0	1	0	\N	0	0	0
854	214	20254	2	12	6	2	1	0	1	0	\N	0	0	0
855	214	20261	2	12	6	2	1	0	1	0	\N	0	0	0
856	214	20262	2	12	6	2	1	0	1	0	\N	0	0	0
857	215	20253	2	12	6	1	1	0	1	0	\N	0	0	0
858	215	20254	2	12	6	1	1	0	1	0	\N	0	0	0
859	215	20261	2	12	6	1	1	0	1	0	\N	0	0	0
860	215	20262	2	12	6	1	1	0	1	0	\N	0	0	0
861	216	20253	2	12	6	12	1	0	1	0	\N	0	0	0
862	216	20254	2	12	6	12	1	0	1	0	\N	0	0	0
863	216	20261	2	12	6	12	1	0	1	0	\N	0	0	0
864	216	20262	2	12	6	12	1	0	1	0	\N	0	0	0
865	217	20253	2	12	6	4	1	0	1	0	\N	0	0	0
866	217	20254	2	12	6	4	1	0	1	0	\N	0	0	0
867	217	20261	2	12	6	4	1	0	1	0	\N	0	0	0
868	217	20262	2	12	6	4	1	0	1	0	\N	0	0	0
869	218	20253	2	12	6	9	1	0	1	0	\N	0	0	0
870	218	20254	2	12	6	9	1	0	1	0	\N	0	0	0
871	218	20261	2	12	6	9	1	0	1	0	\N	0	0	0
872	218	20262	2	12	6	9	1	0	1	0	\N	0	0	0
873	219	20253	1	12	6	17	1	0	1	0	\N	0	0	0
874	219	20254	1	12	6	17	1	0	1	0	\N	0	0	0
875	219	20261	1	12	6	17	1	0	1	0	\N	0	0	0
876	219	20262	1	12	6	17	1	0	1	0	\N	0	0	0
877	220	20253	2	12	6	17	1	0	1	0	\N	0	0	0
878	220	20254	2	12	6	17	1	0	1	0	\N	0	0	0
879	220	20261	2	12	6	17	1	0	1	0	\N	0	0	0
880	220	20262	2	12	6	17	1	0	1	0	\N	0	0	0
881	221	20253	2	12	6	10	1	0	1	0	\N	0	0	0
882	221	20254	2	12	6	10	1	0	1	0	\N	0	0	0
883	221	20261	2	12	6	10	1	0	1	0	\N	0	0	0
884	221	20262	2	12	6	10	1	0	1	0	\N	0	0	0
885	222	20253	2	12	6	5	1	0	1	0	\N	0	0	0
886	222	20254	2	12	6	5	1	0	1	0	\N	0	0	0
887	222	20261	2	12	6	5	1	0	1	0	\N	0	0	0
888	222	20262	2	12	6	5	1	0	1	0	\N	0	0	0
889	223	20253	2	12	6	5	1	0	1	0	\N	0	0	0
890	223	20254	2	12	6	5	1	0	1	0	\N	0	0	0
891	223	20261	2	12	6	5	1	0	1	0	\N	0	0	0
892	223	20262	2	12	6	5	1	0	1	0	\N	0	0	0
893	224	20253	2	12	6	5	1	0	1	0	\N	0	0	0
894	224	20254	2	12	6	5	1	0	1	0	\N	0	0	0
895	224	20261	2	12	6	5	1	0	1	0	\N	0	0	0
896	224	20262	2	12	6	5	1	0	1	0	\N	0	0	0
897	225	20253	2	12	6	5	1	0	1	0	\N	0	0	0
898	225	20254	2	12	6	5	1	0	1	0	\N	0	0	0
899	225	20261	2	12	6	5	1	0	1	0	\N	0	0	0
900	225	20262	2	12	6	5	1	0	1	0	\N	0	0	0
901	226	20253	2	12	6	5	1	0	1	0	\N	0	0	0
902	226	20254	2	12	6	5	1	0	1	0	\N	0	0	0
903	226	20261	2	12	6	5	1	0	1	0	\N	0	0	0
904	226	20262	2	12	6	5	1	0	1	0	\N	0	0	0
905	227	20253	2	12	6	5	1	0	1	0	\N	0	0	0
906	227	20254	2	12	6	5	1	0	1	0	\N	0	0	0
907	227	20261	2	12	6	5	1	0	1	0	\N	0	0	0
908	227	20262	2	12	6	5	1	0	1	0	\N	0	0	0
909	228	20253	3	1	1	8	1	1	0	0	82.99	1	4	1
910	228	20254	3	1	1	8	1	1	0	1	82.99	1	5	1
911	228	20261	3	1	1	8	1	1	0	0	82.99	0	2	1
912	228	20262	3	1	1	8	1	1	0	2	82.99	0	2	1
913	229	20253	3	1	1	8	1	1	0	2	91.96	0	3	1
914	229	20254	3	1	1	8	1	1	0	5	91.96	0	3	1
915	229	20261	3	1	1	8	1	1	0	0	91.96	1	1	1
916	229	20262	3	1	1	8	1	1	0	0	91.96	1	1	1
917	230	20253	3	1	1	8	1	1	0	3	93.33	0	4	1
918	230	20254	3	1	1	8	1	1	0	22	93.33	0	4	1
919	230	20261	3	1	1	8	1	1	0	0	93.33	0	2	1
920	230	20262	3	1	1	8	1	1	0	2	93.33	0	2	1
921	231	20253	3	1	4	3	1	1	0	1	\N	0	3	1
922	231	20254	3	1	4	3	1	1	0	0	\N	0	3	1
923	231	20261	3	1	4	3	1	1	0	0	\N	1	2	1
924	231	20262	3	1	4	3	1	1	0	1	\N	1	2	1
925	232	20253	3	1	4	3	1	1	0	0	91.95	0	4	1
926	232	20254	3	1	4	3	1	1	0	5	91.95	0	4	1
927	232	20261	3	1	4	3	1	1	0	0	91.95	1	1	1
928	232	20262	3	1	4	3	1	1	0	0	91.95	2	1	1
929	233	20253	3	5	4	8	1	1	0	2	86.63	0	7	1
930	233	20254	3	5	4	8	1	1	0	1	86.63	0	7	1
931	233	20261	3	5	4	8	1	1	0	1	86.63	1	3	1
932	233	20262	3	5	4	8	1	1	0	0	86.63	1	3	1
933	234	20253	3	3	4	8	1	1	0	3	85.90	2	5	1
934	234	20254	3	3	4	8	1	1	0	1	85.90	2	5	1
935	234	20261	3	3	4	8	1	1	0	0	85.90	1	2	1
936	234	20262	3	3	4	8	1	1	0	0	85.90	2	2	1
937	235	20253	3	1	4	3	1	1	0	1	92.54	0	2	1
938	235	20254	3	1	4	3	1	1	0	15	92.54	0	2	1
939	235	20261	3	1	4	3	1	1	0	0	92.54	2	1	1
940	235	20262	3	1	4	3	1	1	0	0	92.54	2	1	1
941	236	20253	3	1	1	8	1	1	0	3	94.24	0	3	1
942	236	20254	3	1	1	8	1	1	0	13	94.24	0	3	1
943	236	20261	3	1	1	8	1	1	0	0	94.24	0	1	1
944	236	20262	3	1	1	8	1	1	0	0	94.24	0	1	1
945	237	20253	4	2	4	11	1	1	0	0	88.80	0	0	0
946	237	20254	4	2	4	11	1	1	0	0	88.80	0	0	0
947	237	20261	4	2	4	11	1	1	0	0	88.80	0	0	0
948	237	20262	4	2	4	11	1	1	0	0	88.80	0	0	0
949	238	20253	3	5	4	3	1	1	0	1	84.33	1	4	1
950	238	20254	3	5	4	3	1	1	0	1	84.33	1	4	1
951	238	20261	3	5	4	3	1	1	0	1	84.33	0	2	1
952	238	20262	3	5	4	3	1	1	0	0	84.33	0	2	1
953	239	20253	3	1	1	8	1	1	0	3	92.12	2	5	1
954	239	20254	3	1	1	8	1	1	0	12	92.12	2	6	1
955	239	20261	3	1	1	8	1	1	0	0	92.12	1	2	1
956	239	20262	3	1	1	8	1	1	0	2	92.12	1	2	1
957	240	20253	3	5	4	8	1	1	0	1	84.44	1	4	1
958	240	20254	3	5	4	8	1	1	0	2	84.44	1	4	1
959	240	20261	3	5	4	8	1	1	0	1	84.44	2	3	1
960	240	20262	3	5	4	8	1	1	0	0	84.44	2	3	1
961	241	20253	3	5	4	8	1	1	0	1	\N	1	5	1
962	241	20254	3	5	4	8	1	1	0	1	\N	4	5	1
963	241	20261	3	5	4	8	1	1	0	2	\N	5	3	1
964	241	20262	3	5	4	8	1	1	0	3	\N	5	3	1
965	242	20253	3	5	4	8	1	1	0	0	\N	0	2	1
966	242	20254	3	5	4	8	1	1	0	2	\N	4	2	1
967	242	20261	3	5	4	8	1	1	0	0	\N	6	2	1
968	242	20262	3	5	4	8	1	1	0	1	\N	7	2	1
969	243	20253	3	3	4	8	1	1	0	0	\N	0	1	1
970	243	20254	3	3	4	8	1	1	0	8	\N	2	1	1
971	243	20261	3	3	4	8	1	1	0	1	\N	3	2	1
972	243	20262	3	3	4	8	1	1	0	1	\N	4	2	1
973	244	20253	3	1	4	8	1	1	0	2	\N	0	2	1
974	244	20254	3	1	4	8	1	1	0	9	\N	2	2	1
975	244	20261	3	1	4	8	1	1	0	1	\N	3	2	1
976	244	20262	3	1	4	8	1	1	0	0	\N	3	2	1
977	245	20253	4	6	5	2	1	1	0	0	82.26	0	0	0
978	245	20254	4	6	5	2	1	1	0	0	82.26	0	0	0
979	245	20261	4	6	5	2	1	1	0	0	82.26	0	0	0
980	245	20262	4	6	5	2	1	1	0	0	82.26	0	0	0
981	246	20253	4	3	4	4	1	1	0	0	78.20	0	0	0
982	246	20254	4	3	4	4	1	1	0	0	78.20	0	0	0
983	246	20261	4	3	4	4	1	1	0	0	78.20	0	0	0
984	246	20262	4	3	4	4	1	1	0	0	78.20	0	0	0
985	247	20253	4	6	5	2	1	1	0	0	\N	0	0	0
986	247	20254	4	6	5	2	1	1	0	0	\N	0	0	0
987	247	20261	4	6	5	2	1	1	0	0	\N	0	0	0
988	247	20262	4	6	5	2	1	1	0	0	\N	0	0	0
989	248	20253	4	6	5	2	1	1	0	0	\N	0	0	0
990	248	20254	4	6	5	2	1	1	0	0	\N	0	0	0
991	248	20261	4	6	5	2	1	1	0	0	\N	0	0	0
992	248	20262	4	6	5	2	1	1	0	0	\N	0	0	0
993	249	20253	3	6	5	7	1	1	0	0	88.21	0	0	0
994	249	20254	3	6	5	7	1	1	0	0	88.21	0	0	0
995	249	20261	3	6	5	7	1	1	0	0	88.21	0	0	0
996	249	20262	3	6	5	7	1	1	0	0	88.21	0	0	0
997	250	20253	3	6	5	7	1	1	0	0	\N	0	0	0
998	250	20254	3	6	5	7	1	1	0	0	\N	0	0	0
999	250	20261	3	6	5	7	1	1	0	0	\N	0	0	0
1000	250	20262	3	6	5	7	1	1	0	0	\N	0	0	0
1001	251	20253	3	8	1	2	1	1	0	0	\N	0	0	0
1002	251	20254	3	8	1	2	1	1	0	0	\N	0	0	0
1003	251	20261	3	8	1	2	1	1	0	0	\N	0	0	0
1004	251	20262	3	8	1	2	1	1	0	0	\N	0	0	0
1005	252	20253	4	14	7	4	1	1	0	0	\N	0	0	0
1006	252	20254	4	14	7	4	1	1	0	0	\N	0	0	0
1007	252	20261	4	14	7	4	1	1	0	0	\N	0	0	0
1008	252	20262	4	14	7	4	1	1	0	0	\N	0	0	0
\.


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 222
-- Name: dim_education_education_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_education_education_key_seq', 1, false);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 226
-- Name: dim_employment_status_employment_status_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_employment_status_employment_status_key_seq', 1, false);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 224
-- Name: dim_position_position_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_position_position_key_seq', 1, false);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 219
-- Name: dim_staff_staff_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_staff_staff_key_seq', 1, false);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 228
-- Name: dim_unit_unit_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_unit_unit_key_seq', 1, false);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 230
-- Name: fact_staff_performance_fact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_staff_performance_fact_id_seq', 1008, true);


--
-- TOC entry 4906 (class 2606 OID 17448)
-- Name: dim_education dim_education_education_level_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_education
    ADD CONSTRAINT dim_education_education_level_key UNIQUE (education_level);


--
-- TOC entry 4908 (class 2606 OID 17446)
-- Name: dim_education dim_education_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_education
    ADD CONSTRAINT dim_education_pkey PRIMARY KEY (education_key);


--
-- TOC entry 4914 (class 2606 OID 17471)
-- Name: dim_employment_status dim_employment_status_employment_status_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_employment_status
    ADD CONSTRAINT dim_employment_status_employment_status_name_key UNIQUE (employment_status_name);


--
-- TOC entry 4916 (class 2606 OID 17469)
-- Name: dim_employment_status dim_employment_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_employment_status
    ADD CONSTRAINT dim_employment_status_pkey PRIMARY KEY (employment_status_key);


--
-- TOC entry 4910 (class 2606 OID 17458)
-- Name: dim_position dim_position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_position
    ADD CONSTRAINT dim_position_pkey PRIMARY KEY (position_key);


--
-- TOC entry 4912 (class 2606 OID 17460)
-- Name: dim_position dim_position_position_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_position
    ADD CONSTRAINT dim_position_position_name_key UNIQUE (position_name);


--
-- TOC entry 4900 (class 2606 OID 17424)
-- Name: dim_staff dim_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_staff
    ADD CONSTRAINT dim_staff_pkey PRIMARY KEY (staff_key);


--
-- TOC entry 4904 (class 2606 OID 17436)
-- Name: dim_time dim_time_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_time
    ADD CONSTRAINT dim_time_pkey PRIMARY KEY (time_key);


--
-- TOC entry 4918 (class 2606 OID 17481)
-- Name: dim_unit dim_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_unit
    ADD CONSTRAINT dim_unit_pkey PRIMARY KEY (unit_key);


--
-- TOC entry 4920 (class 2606 OID 17483)
-- Name: dim_unit dim_unit_unit_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_unit
    ADD CONSTRAINT dim_unit_unit_name_key UNIQUE (unit_name);


--
-- TOC entry 4922 (class 2606 OID 17511)
-- Name: fact_staff_performance fact_staff_performance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance
    ADD CONSTRAINT fact_staff_performance_pkey PRIMARY KEY (fact_id);


--
-- TOC entry 4924 (class 2606 OID 17513)
-- Name: fact_staff_performance uq_fact_staff_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance
    ADD CONSTRAINT uq_fact_staff_time UNIQUE (staff_key, time_key);


--
-- TOC entry 4901 (class 1259 OID 17426)
-- Name: idx_dim_staff_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dim_staff_id ON public.dim_staff USING btree (staff_id);


--
-- TOC entry 4902 (class 1259 OID 17425)
-- Name: idx_dim_staff_nip; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dim_staff_nip ON public.dim_staff USING btree (nip);


--
-- TOC entry 4925 (class 2606 OID 17524)
-- Name: fact_staff_performance fact_staff_performance_education_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance
    ADD CONSTRAINT fact_staff_performance_education_key_fkey FOREIGN KEY (education_key) REFERENCES public.dim_education(education_key);


--
-- TOC entry 4926 (class 2606 OID 17534)
-- Name: fact_staff_performance fact_staff_performance_employment_status_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance
    ADD CONSTRAINT fact_staff_performance_employment_status_key_fkey FOREIGN KEY (employment_status_key) REFERENCES public.dim_employment_status(employment_status_key);


--
-- TOC entry 4927 (class 2606 OID 17529)
-- Name: fact_staff_performance fact_staff_performance_position_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance
    ADD CONSTRAINT fact_staff_performance_position_key_fkey FOREIGN KEY (position_key) REFERENCES public.dim_position(position_key);


--
-- TOC entry 4928 (class 2606 OID 17514)
-- Name: fact_staff_performance fact_staff_performance_staff_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance
    ADD CONSTRAINT fact_staff_performance_staff_key_fkey FOREIGN KEY (staff_key) REFERENCES public.dim_staff(staff_key);


--
-- TOC entry 4929 (class 2606 OID 17519)
-- Name: fact_staff_performance fact_staff_performance_time_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance
    ADD CONSTRAINT fact_staff_performance_time_key_fkey FOREIGN KEY (time_key) REFERENCES public.dim_time(time_key);


--
-- TOC entry 4930 (class 2606 OID 17539)
-- Name: fact_staff_performance fact_staff_performance_unit_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_staff_performance
    ADD CONSTRAINT fact_staff_performance_unit_key_fkey FOREIGN KEY (unit_key) REFERENCES public.dim_unit(unit_key);


-- Completed on 2026-11-24 21:36:11

--
-- PostgreSQL database dump complete
--

\unrestrict HJc7clF5XSARR7wVKFGrNDBffFk9Ij7TpZUmexZuSkS4cFFYabt5ERQBTcrY5hB

