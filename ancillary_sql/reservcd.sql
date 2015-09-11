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
-- Name: reservcd; Type: TABLE; Schema: public; Owner: peter; Tablespace: 
--

CREATE TABLE reservcd (
    index bigint,
    reservcd bigint,
    "desc" text,
    cbm_cd text
);


ALTER TABLE reservcd OWNER TO peter;

--
-- Data for Name: reservcd; Type: TABLE DATA; Schema: public; Owner: peter
--

COPY reservcd (index, reservcd, "desc", cbm_cd) FROM stdin;
0	0	not reserved	NR
1	1	reserved	R
\.


--
-- Name: ix_reservcd_index; Type: INDEX; Schema: public; Owner: peter; Tablespace: 
--

CREATE INDEX ix_reservcd_index ON reservcd USING btree (index);


--
-- PostgreSQL database dump complete
--

