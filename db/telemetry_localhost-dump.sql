--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

-- Started on 2020-04-24 18:51:23

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 24788)
-- Name: data_climate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_climate (
    id integer NOT NULL,
    order_num integer,
    uid text,
    id_train integer,
    car_number integer,
    receiver_code integer,
    device_type integer,
    command_type integer,
    "time" timestamp without time zone,
    channel_1 integer,
    channel_2 integer,
    channel_3 integer,
    channel_4 integer,
    time_received timestamp without time zone
);


ALTER TABLE public.data_climate OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 24786)
-- Name: data_climate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_climate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_climate_id_seq OWNER TO postgres;

--
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 209
-- Name: data_climate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_climate_id_seq OWNED BY public.data_climate.id;


--
-- TOC entry 212 (class 1259 OID 24800)
-- Name: data_energy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_energy (
    id integer NOT NULL,
    order_num integer,
    uid text,
    id_train integer,
    car_number integer,
    receiver_code integer,
    device_type integer,
    command_type integer,
    "time" timestamp without time zone,
    amperage integer,
    voltage integer,
    energy_active integer,
    energy_passive integer,
    time_received timestamp without time zone
);


ALTER TABLE public.data_energy OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24798)
-- Name: data_energy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_energy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_energy_id_seq OWNER TO postgres;

--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 211
-- Name: data_energy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_energy_id_seq OWNED BY public.data_energy.id;


--
-- TOC entry 214 (class 1259 OID 24849)
-- Name: devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devices (
    id integer NOT NULL,
    device_uid text,
    system_id integer,
    hw integer,
    sw integer,
    config_link integer,
    type integer DEFAULT 0,
    car_number integer DEFAULT 0,
    name character varying(255),
    sw_link integer,
    updates boolean DEFAULT false NOT NULL
);


ALTER TABLE public.devices OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16527)
-- Name: devicesold; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devicesold (
    id integer NOT NULL,
    device_hw_id integer DEFAULT 0,
    device_hw_head_id integer DEFAULT 0,
    hw_ver integer DEFAULT 0,
    sw_ver integer DEFAULT 0,
    config_link text,
    train_id integer,
    type integer,
    car_number integer,
    device_head_id integer,
    name text
);


ALTER TABLE public.devicesold OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16525)
-- Name: devices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.devices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.devices_id_seq OWNER TO postgres;

--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 204
-- Name: devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.devices_id_seq OWNED BY public.devicesold.id;


--
-- TOC entry 206 (class 1259 OID 24708)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16515)
-- Name: measures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measures (
    id integer NOT NULL,
    system_id integer,
    coordinates text,
    date date,
    rssi integer,
    status integer,
    hw_ver integer,
    sw_ver integer,
    device_hw_id integer,
    time_day time without time zone,
    temp1 double precision,
    temp2 double precision,
    temp3 double precision,
    temp4 double precision,
    temp5 double precision,
    speed double precision,
    amperage double precision,
    voltage double precision,
    dategsm character varying(255),
    timegsm character varying(255)
);


ALTER TABLE public.measures OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16513)
-- Name: measures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.measures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.measures_id_seq OWNER TO postgres;

--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 202
-- Name: measures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measures_id_seq OWNED BY public.measures.id;


--
-- TOC entry 216 (class 1259 OID 24875)
-- Name: software; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.software (
    id integer NOT NULL,
    filename text,
    version integer,
    path text,
    actual boolean DEFAULT true,
    link text,
    size bigint
);


ALTER TABLE public.software OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24873)
-- Name: software_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.software_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.software_id_seq OWNER TO postgres;

--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 215
-- Name: software_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.software_id_seq OWNED BY public.software.id;


--
-- TOC entry 208 (class 1259 OID 24735)
-- Name: systems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.systems (
    id integer NOT NULL,
    train_type text,
    train_number text,
    system_id integer,
    status integer,
    car_count integer,
    head_device_id text
);


ALTER TABLE public.systems OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 24733)
-- Name: systems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.systems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.systems_id_seq OWNER TO postgres;

--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 207
-- Name: systems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.systems_id_seq OWNED BY public.systems.id;


--
-- TOC entry 213 (class 1259 OID 24847)
-- Name: table_name_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.table_name_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.table_name_id_seq OWNER TO postgres;

--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 213
-- Name: table_name_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.table_name_id_seq OWNED BY public.devices.id;


--
-- TOC entry 2739 (class 2604 OID 24791)
-- Name: data_climate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_climate ALTER COLUMN id SET DEFAULT nextval('public.data_climate_id_seq'::regclass);


--
-- TOC entry 2740 (class 2604 OID 24803)
-- Name: data_energy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_energy ALTER COLUMN id SET DEFAULT nextval('public.data_energy_id_seq'::regclass);


--
-- TOC entry 2741 (class 2604 OID 24852)
-- Name: devices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices ALTER COLUMN id SET DEFAULT nextval('public.table_name_id_seq'::regclass);


--
-- TOC entry 2733 (class 2604 OID 16530)
-- Name: devicesold id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devicesold ALTER COLUMN id SET DEFAULT nextval('public.devices_id_seq'::regclass);


--
-- TOC entry 2732 (class 2604 OID 16518)
-- Name: measures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures ALTER COLUMN id SET DEFAULT nextval('public.measures_id_seq'::regclass);


--
-- TOC entry 2745 (class 2604 OID 24878)
-- Name: software id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software ALTER COLUMN id SET DEFAULT nextval('public.software_id_seq'::regclass);


--
-- TOC entry 2738 (class 2604 OID 24738)
-- Name: systems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systems ALTER COLUMN id SET DEFAULT nextval('public.systems_id_seq'::regclass);


--
-- TOC entry 2910 (class 0 OID 24788)
-- Dependencies: 210
-- Data for Name: data_climate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_climate (id, order_num, uid, id_train, car_number, receiver_code, device_type, command_type, "time", channel_1, channel_2, channel_3, channel_4, time_received) FROM stdin;
52	8	004300580400430051040043	8800	0	1	16	64	2020-04-07 11:47:24	27	127	127	127	\N
53	8	004300580400430051040043	8800	0	1	16	64	2020-04-07 11:50:01	27	127	127	127	\N
\.


--
-- TOC entry 2912 (class 0 OID 24800)
-- Dependencies: 212
-- Data for Name: data_energy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_energy (id, order_num, uid, id_train, car_number, receiver_code, device_type, command_type, "time", amperage, voltage, energy_active, energy_passive, time_received) FROM stdin;
51	96	004300580400430051040043	8800	0	1	16	80	2020-05-06 11:02:35	908	17	1454040	13721	\N
54	96	004300580400430051040043	8800	0	1	16	80	2020-04-07 11:50:01	908	17	1454040	13721	\N
55	1	004300580400430051040043	8800	0	1	16	80	2020-04-16 16:26:55	897	17	1454046	13721	\N
56	1	004300580400430051040043	8800	0	1	16	80	2020-04-16 16:26:55	897	17	1454046	13721	\N
57	1	004300580400430051040043	8800	0	1	16	80	2020-04-16 16:26:55	897	17	1454046	13721	\N
58	1	004300580400430051040043	8800	0	1	16	80	2020-04-16 16:26:55	897	17	1454046	13721	\N
59	1	004300580400430051040043	8800	0	1	16	80	2020-04-16 16:26:55	897	17	1454046	13721	\N
60	1	004300580400430051040043	8800	0	1	16	80	2020-04-16 16:26:55	897	17	1454046	13721	\N
61	10000	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:44	901	17	1454040	13721	\N
62	10256	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:45	901	17	1454040	13721	\N
63	10000	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:44	901	17	1454040	13721	\N
64	10256	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:45	901	17	1454040	13721	\N
65	10000	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:44	901	17	1454040	13721	\N
66	10256	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:45	901	17	1454040	13721	\N
67	10000	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:44	901	17	1454040	13721	\N
68	10256	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:45	901	17	1454040	13721	\N
69	0	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:44	901	17	1454040	13721	\N
70	6	004300580400430051040043	8800	0	1	16	80	2020-04-17 13:42:45	901	17	1454040	13721	\N
\.


--
-- TOC entry 2914 (class 0 OID 24849)
-- Dependencies: 214
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.devices (id, device_uid, system_id, hw, sw, config_link, type, car_number, name, sw_link, updates) FROM stdin;
1	004300580400430051040043	8800	1	2	0	0	1	\N	76	t
\.


--
-- TOC entry 2905 (class 0 OID 16527)
-- Dependencies: 205
-- Data for Name: devicesold; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.devicesold (id, device_hw_id, device_hw_head_id, hw_ver, sw_ver, config_link, train_id, type, car_number, device_head_id, name) FROM stdin;
4	228	2281337	1	1	elsewhere	8800	0	4	\N	БКТ
5	322	2281337	1	1	nowhere	8800	0	3	\N	БИУ
3	1337	2281337	1	1	there	8800	0	2	\N	БКТЭ
1	2281337	2281337	1	1	here	8800	0	1	\N	МУО
6	1488	1488	1	1	hellothere	8801	0	1	\N	ДТ
24	441467	2281337	0	0		8800	1	15	\N	МУО
25	414144	414144	0	0		8800	0	19	\N	БИУ
26	414131	414131	0	0		357913949	0	4	\N	БКТЭ
29	41414	41414	0	0		357913949	0	4	\N	БКТЭ
30	41555	41555	0	0		357913949	1	5	\N	БКТ
32	41554	41555	0	0		357913949	0	6	\N	МУО
33	414147	2281337	0	0		8800	1	4	\N	БКТЭ
34	4113	2281337	0	0		8800	0	4	\N	БИУ
35	1674434	414144	0	0		8800	2	4	\N	БКТ
36	4144690	414144	0	0		8800	1	5	\N	БКТЭ
\.


--
-- TOC entry 2903 (class 0 OID 16515)
-- Dependencies: 203
-- Data for Name: measures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measures (id, system_id, coordinates, date, rssi, status, hw_ver, sw_ver, device_hw_id, time_day, temp1, temp2, temp3, temp4, temp5, speed, amperage, voltage, dategsm, timegsm) FROM stdin;
16	8800	123123	2020-03-20	1	1	1	1	1337	14:13:44	\N	2	3	4	5	120.4	880	220	200320	141344
\.


--
-- TOC entry 2916 (class 0 OID 24875)
-- Dependencies: 216
-- Data for Name: software; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.software (id, filename, version, path, actual, link, size) FROM stdin;
\.


--
-- TOC entry 2908 (class 0 OID 24735)
-- Dependencies: 208
-- Data for Name: systems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.systems (id, train_type, train_number, system_id, status, car_count, head_device_id) FROM stdin;
0	ЭД4М	6007	8800	1	8	\N
1	ЭД4М	6810	8801	1	4	\N
14	ЭД4М	1488	351120146	0	12	\N
18	ЭД4М	6273	351267143	0	10	\N
21	414	1414	357913949	0	3	\N
\.


--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 209
-- Name: data_climate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_climate_id_seq', 1, false);


--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 211
-- Name: data_energy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_energy_id_seq', 1, false);


--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 204
-- Name: devices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.devices_id_seq', 6, true);


--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 206
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 78, true);


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 202
-- Name: measures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measures_id_seq', 16, true);


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 215
-- Name: software_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.software_id_seq', 1, false);


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 207
-- Name: systems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.systems_id_seq', 5, false);


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 213
-- Name: table_name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.table_name_id_seq', 1, true);


--
-- TOC entry 2762 (class 2606 OID 24797)
-- Name: data_climate data_climate_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_climate
    ADD CONSTRAINT data_climate_pk PRIMARY KEY (id);


--
-- TOC entry 2765 (class 2606 OID 24809)
-- Name: data_energy data_energy_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_energy
    ADD CONSTRAINT data_energy_pk PRIMARY KEY (id);


--
-- TOC entry 2753 (class 2606 OID 16536)
-- Name: devicesold devices_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT devices_pk PRIMARY KEY (id);


--
-- TOC entry 2749 (class 2606 OID 16524)
-- Name: measures measures_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures
    ADD CONSTRAINT measures_pk PRIMARY KEY (id);


--
-- TOC entry 2770 (class 2606 OID 24884)
-- Name: software software_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_pk PRIMARY KEY (id);


--
-- TOC entry 2758 (class 2606 OID 24744)
-- Name: systems systems_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_pk PRIMARY KEY (id);


--
-- TOC entry 2755 (class 2606 OID 24705)
-- Name: devicesold uk_hvjuc0g18nw202rcchri2a2so; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT uk_hvjuc0g18nw202rcchri2a2so UNIQUE (device_hw_id);


--
-- TOC entry 2760 (class 1259 OID 24795)
-- Name: data_climate_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX data_climate_id_uindex ON public.data_climate USING btree (id);


--
-- TOC entry 2763 (class 1259 OID 24807)
-- Name: data_energy_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX data_energy_id_uindex ON public.data_energy USING btree (id);


--
-- TOC entry 2750 (class 1259 OID 16553)
-- Name: devices_device_hw_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX devices_device_hw_id_uindex ON public.devicesold USING btree (device_hw_id);


--
-- TOC entry 2766 (class 1259 OID 24866)
-- Name: devices_device_uid_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX devices_device_uid_uindex ON public.devices USING btree (device_uid);


--
-- TOC entry 2751 (class 1259 OID 16534)
-- Name: devices_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX devices_id_uindex ON public.devicesold USING btree (id);


--
-- TOC entry 2747 (class 1259 OID 16522)
-- Name: measures_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX measures_id_uindex ON public.measures USING btree (id);


--
-- TOC entry 2768 (class 1259 OID 24882)
-- Name: software_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX software_id_uindex ON public.software USING btree (id);


--
-- TOC entry 2756 (class 1259 OID 24742)
-- Name: systems_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX systems_id_uindex ON public.systems USING btree (id);


--
-- TOC entry 2759 (class 1259 OID 24774)
-- Name: systems_system_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX systems_system_id_uindex ON public.systems USING btree (system_id);


--
-- TOC entry 2767 (class 1259 OID 24853)
-- Name: table_name_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX table_name_id_uindex ON public.devices USING btree (id);


--
-- TOC entry 2775 (class 2606 OID 24867)
-- Name: devices devices_systems_system_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_systems_system_id_fk FOREIGN KEY (system_id) REFERENCES public.systems(system_id);


--
-- TOC entry 2774 (class 2606 OID 24780)
-- Name: devicesold devices_train_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT devices_train_fk FOREIGN KEY (train_id) REFERENCES public.systems(system_id);


--
-- TOC entry 2771 (class 2606 OID 24710)
-- Name: measures fke542pg0echtc7ey5to0r693cl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures
    ADD CONSTRAINT fke542pg0echtc7ey5to0r693cl FOREIGN KEY (device_hw_id) REFERENCES public.devicesold(device_hw_id);


--
-- TOC entry 2773 (class 2606 OID 24728)
-- Name: devicesold fkhrh1srvv6t1ikm0293ej4j3a0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT fkhrh1srvv6t1ikm0293ej4j3a0 FOREIGN KEY (device_hw_head_id) REFERENCES public.devicesold(device_hw_id);


--
-- TOC entry 2772 (class 2606 OID 24775)
-- Name: measures measures_system_if_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures
    ADD CONSTRAINT measures_system_if_fk FOREIGN KEY (system_id) REFERENCES public.systems(system_id);


-- Completed on 2020-04-24 18:51:24

--
-- PostgreSQL database dump complete
--

