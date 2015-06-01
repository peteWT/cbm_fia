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
-- Name: owngrpcd; Type: TABLE; Schema: public; Owner: peter; Tablespace: 
--

CREATE TABLE owngrpcd (
    index bigint,
    owngrpcd bigint,
    ogc_desc text,
    cbm_ogcd text
);


ALTER TABLE owngrpcd OWNER TO peter;

--
-- Data for Name: owngrpcd; Type: TABLE DATA; Schema: public; Owner: peter
--

COPY owngrpcd (index, owngrpcd, ogc_desc, cbm_ogcd) FROM stdin;
0	10	Forest Service	FS
1	20	Other federal	OF
2	30	State and local government	SLPub
3	40	Private	PR
\.


--
-- Name: ix_owngrpcd_index; Type: INDEX; Schema: public; Owner: peter; Tablespace: 
--

CREATE INDEX ix_owngrpcd_index ON owngrpcd USING btree (index);


--
-- PostgreSQL database dump complete
--

