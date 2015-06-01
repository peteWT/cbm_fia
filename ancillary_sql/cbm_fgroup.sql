--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cbm_fgroup; Type: TABLE; Schema: public; Owner: peter; Tablespace: 
--

CREATE TABLE cbm_fgroup (
    index bigint,
    cbm_spcd text,
    description text,
    typgrpcd bigint
);


ALTER TABLE cbm_fgroup OWNER TO peter;

--
-- Data for Name: cbm_fgroup; Type: TABLE DATA; Schema: public; Owner: peter
--

COPY cbm_fgroup (index, cbm_spcd, description, typgrpcd) FROM stdin;
0	MC	California mixed conifer	370
1	PP	Ponderosa pine	220
2	DF	Douglas-fir	200
3	RW	Redwood	340
4	OS	Other softwood	180
5	OS	Other softwood	240
6	OS	Other softwood	260
7	OS	Other softwood	280
8	OS	Other softwood	300
9	OS	Other softwood	360
10	HW	Other hardwood	700
11	HW	Other hardwood	900
12	HW	Other hardwood	910
13	HW	Other hardwood	920
14	HW	Other hardwood	940
15	HW	Other hardwood	960
16	HW	Other hardwood	970
17	HW	Other hardwood	990
18	NS	Non-stocked	999
\.


--
-- Name: ix_cbm_fgroup_index; Type: INDEX; Schema: public; Owner: peter; Tablespace: 
--

CREATE INDEX ix_cbm_fgroup_index ON cbm_fgroup USING btree (index);


--
-- PostgreSQL database dump complete
--

