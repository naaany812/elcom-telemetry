--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devices (
    id integer NOT NULL,
    device_hw_id integer DEFAULT 0,
    device_hw_head_id integer DEFAULT 0,
    hw_ver integer DEFAULT 0,
    sw_ver integer DEFAULT 0,
    config_link text,
    device_head_id integer
);


ALTER TABLE public.devices OWNER TO postgres;

--
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
-- Name: devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.devices_id_seq OWNED BY public.devices.id;


--
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
-- Name: measures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measures (
    id integer NOT NULL,
    system_id integer,
    coordinates text,
    date date,
    rssi integer,
    wattage double precision,
    temperature double precision,
    status integer,
    hw_ver integer,
    sw_ver integer,
    device_hw_id integer,
    time_day time without time zone
);


ALTER TABLE public.measures OWNER TO postgres;

--
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
-- Name: measures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measures_id_seq OWNED BY public.measures.id;


--
-- Name: systems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.systems (
    id integer NOT NULL,
    train_type text,
    train_number text,
    system_id integer,
    status integer,
    head_device_id integer
);


ALTER TABLE public.systems OWNER TO postgres;

--
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
-- Name: systems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.systems_id_seq OWNED BY public.systems.id;


--
-- Name: devices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices ALTER COLUMN id SET DEFAULT nextval('public.devices_id_seq'::regclass);


--
-- Name: measures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures ALTER COLUMN id SET DEFAULT nextval('public.measures_id_seq'::regclass);


--
-- Name: systems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systems ALTER COLUMN id SET DEFAULT nextval('public.systems_id_seq'::regclass);


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.devices (id, device_hw_id, device_hw_head_id, hw_ver, sw_ver, config_link, device_head_id) FROM stdin;
1	2281337	2281337	1	1	here	\N
3	1337	2281337	1	1	there	\N
4	228	2281337	1	1	elsewhere	\N
5	322	2281337	1	1	nowhere	\N
6	1488	1488	1	1	hellothere	\N
\.


--
-- Data for Name: measures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measures (id, system_id, coordinates, date, rssi, wattage, temperature, status, hw_ver, sw_ver, device_hw_id, time_day) FROM stdin;
1	8800	1	2020-02-20	1	250	26	1	1	1	1337	01:14:53
5	8800	1	2020-02-20	1	133	26.3	1	1	1	1337	02:13:12
9	8800	1	2020-02-20	1	420	25.2	1	1	1	1337	05:31:57
4	8800	1	2020-02-20	1	700	27	1	1	1	322	01:49:30
7	8800	1	2020-02-20	1	555	28.1	1	1	1	322	02:01:16
3	8800	1	2020-02-20	1	367	26.4	1	1	1	228	01:14:53
8	8800	1	2020-02-20	1	520	30.2	1	1	1	228	04:28:34
6	8800	1	2020-02-20	1	424	26.7	1	1	1	228	02:43:41
10	8800	1	2020-02-20	1	555	28.1	1	1	1	322	06:01:16
11	8800	1	2020-02-20	1	250	26.7	1	1	1	228	02:12:53
12	8800	1	2020-02-20	1	250	27	1	1	1	322	02:19:00
13	8800	1	2020-02-20	1	250	28	1	1	1	228	05:37:13
14	8800	1	2020-02-20	1	250	26.6	1	1	1	1337	00:46:04
15	8800	1	2020-02-20	1	250	26.7	1	1	1	1337	03:58:17
\.


--
-- Data for Name: systems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.systems (id, train_type, train_number, system_id, status, head_device_id) FROM stdin;
1	РЖОМБА	1488	8800	1	2281337
2	ТОМАС	41-45 повторим?	8801	1	1488
\.


--
-- Name: devices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.devices_id_seq', 6, true);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- Name: measures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measures_id_seq', 15, true);


--
-- Name: systems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.systems_id_seq', 2, true);


--
-- Name: devices devices_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pk PRIMARY KEY (id);


--
-- Name: measures measures_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures
    ADD CONSTRAINT measures_pk PRIMARY KEY (id);


--
-- Name: systems systems_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_pk PRIMARY KEY (id);


--
-- Name: devices uk_hvjuc0g18nw202rcchri2a2so; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT uk_hvjuc0g18nw202rcchri2a2so UNIQUE (device_hw_id);


--
-- Name: devices_device_hw_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX devices_device_hw_id_uindex ON public.devices USING btree (device_hw_id);


--
-- Name: devices_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX devices_id_uindex ON public.devices USING btree (id);


--
-- Name: measures_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX measures_id_uindex ON public.measures USING btree (id);


--
-- Name: systems_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX systems_id_uindex ON public.systems USING btree (id);


--
-- Name: systems_system_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX systems_system_id_uindex ON public.systems USING btree (system_id);


--
-- Name: measures fke542pg0echtc7ey5to0r693cl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures
    ADD CONSTRAINT fke542pg0echtc7ey5to0r693cl FOREIGN KEY (device_hw_id) REFERENCES public.devices(device_hw_id);


--
-- Name: devices fkhrh1srvv6t1ikm0293ej4j3a0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT fkhrh1srvv6t1ikm0293ej4j3a0 FOREIGN KEY (device_hw_head_id) REFERENCES public.devices(device_hw_id);


--
-- Name: measures measures_system_if_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measures
    ADD CONSTRAINT measures_system_if_fk FOREIGN KEY (system_id) REFERENCES public.systems(system_id);


--
-- Name: systems systems_head_device_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_head_device_fk FOREIGN KEY (head_device_id) REFERENCES public.devices(device_hw_id);


--
-- PostgreSQL database dump complete
--

