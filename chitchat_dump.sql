--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.range DROP CONSTRAINT fk_range_conversationid;
ALTER TABLE ONLY public.message DROP CONSTRAINT fk_message_conversationid;
DROP INDEX public.idx_textdoc_name;
DROP INDEX public.idx_message_timestamp;
ALTER TABLE ONLY public.textdoc DROP CONSTRAINT textdoc_pkey;
ALTER TABLE ONLY public.range DROP CONSTRAINT range_pkey;
ALTER TABLE ONLY public.message DROP CONSTRAINT message_pkey;
ALTER TABLE ONLY public.jsondoc DROP CONSTRAINT jsondoc_pkey;
ALTER TABLE ONLY public.databasechangeloglock DROP CONSTRAINT databasechangeloglock_pkey;
ALTER TABLE ONLY public.conversation DROP CONSTRAINT conversation_pkey;
DROP TABLE public.textdoc;
DROP SEQUENCE public.jsondoc_id_seq;
DROP TABLE public.jsondoc;
DROP TABLE public.databasechangeloglock;
DROP TABLE public.databasechangelog;
DROP VIEW public.conversationtimes;
DROP TABLE public.message;
DROP VIEW public.conversationlabels;
DROP TABLE public.range;
DROP TABLE public.conversation;
DROP FUNCTION public.truncm(character varying, integer);
DROP EXTENSION "uuid-ossp";
DROP EXTENSION pgcrypto;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: chitchat
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO chitchat;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: chitchat
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: truncm(character varying, integer); Type: FUNCTION; Schema: public; Owner: chitchat
--

CREATE FUNCTION public.truncm(character varying, integer) RETURNS character varying
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT CASE WHEN length($1) > $2
  THEN left($1, $2/2-4) || ' [...] ' || right($1, $2/2-4)
           ELSE $1 END;
$_$;


ALTER FUNCTION public.truncm(character varying, integer) OWNER TO chitchat;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: conversation; Type: TABLE; Schema: public; Owner: chitchat
--

CREATE TABLE public.conversation (
    id character varying(128) NOT NULL,
    lang character varying(9),
    botid character varying(128),
    userid character varying(128),
    channel character varying(128)
);


ALTER TABLE public.conversation OWNER TO chitchat;

--
-- Name: range; Type: TABLE; Schema: public; Owner: chitchat
--

CREATE TABLE public.range (
    id character varying(128) NOT NULL,
    label character varying(128),
    value text,
    conversationid character varying(128),
    tokenstart integer,
    tokenend integer,
    charstart integer,
    charend integer,
    props jsonb,
    section integer
);


ALTER TABLE public.range OWNER TO chitchat;

--
-- Name: conversationlabels; Type: VIEW; Schema: public; Owner: chitchat
--

CREATE VIEW public.conversationlabels AS
 SELECT tmp.conversationid,
    string_agg((tmp.label)::text, ', '::text) AS labels
   FROM ( SELECT DISTINCT range.conversationid,
            range.label
           FROM public.range
          ORDER BY range.label) tmp
  GROUP BY tmp.conversationid;


ALTER TABLE public.conversationlabels OWNER TO chitchat;

--
-- Name: message; Type: TABLE; Schema: public; Owner: chitchat
--

CREATE TABLE public.message (
    id character varying(128) NOT NULL,
    incoming boolean,
    conversationid character varying(128),
    senderid character varying(128),
    recipientid character varying(128),
    text character varying(65536),
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.message OWNER TO chitchat;

--
-- Name: conversationtimes; Type: VIEW; Schema: public; Owner: chitchat
--

CREATE VIEW public.conversationtimes AS
 SELECT message.conversationid,
    min(message."timestamp") AS min,
    max(message."timestamp") AS max
   FROM public.message
  GROUP BY message.conversationid;


ALTER TABLE public.conversationtimes OWNER TO chitchat;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: chitchat
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO chitchat;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: chitchat
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO chitchat;

--
-- Name: jsondoc; Type: TABLE; Schema: public; Owner: chitchat
--

CREATE TABLE public.jsondoc (
    id character varying(128) NOT NULL,
    name character varying(128),
    type character varying(128),
    created timestamp with time zone,
    updated timestamp with time zone,
    body jsonb
);


ALTER TABLE public.jsondoc OWNER TO chitchat;

--
-- Name: jsondoc_id_seq; Type: SEQUENCE; Schema: public; Owner: chitchat
--

CREATE SEQUENCE public.jsondoc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jsondoc_id_seq OWNER TO chitchat;

--
-- Name: textdoc; Type: TABLE; Schema: public; Owner: chitchat
--

CREATE TABLE public.textdoc (
    id character varying(128) NOT NULL,
    name character varying(128),
    type character varying(128),
    created timestamp with time zone,
    updated timestamp with time zone,
    body text
);


ALTER TABLE public.textdoc OWNER TO chitchat;

--
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: chitchat
--

COPY public.conversation (id, lang, botid, userid, channel) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: chitchat
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	arvid	migrations.yml	2019-02-12 12:39:06.397288	1	EXECUTED	8:842a753306ca1f3f7e7ec7e1f9340262	createTable tableName=textdoc; createIndex indexName=idx_textdoc_name, tableName=textdoc; createSequence sequenceName=jsondoc_id_seq; createTable tableName=jsondoc; createTable tableName=conversation; createTable tableName=message; addForeignKeyCo...		\N	3.6.1	\N	\N	9975146276
addColumn-range-section	arvid	migrations.yml	2019-02-12 12:39:06.430117	2	EXECUTED	8:b327ebc1caba00ce8f0933e109f4d25c	addColumn tableName=range		\N	3.6.1	\N	\N	9975146276
1	arvid	migrations.yml	2019-02-12 12:39:06.397288	1	EXECUTED	8:842a753306ca1f3f7e7ec7e1f9340262	createTable tableName=textdoc; createIndex indexName=idx_textdoc_name, tableName=textdoc; createSequence sequenceName=jsondoc_id_seq; createTable tableName=jsondoc; createTable tableName=conversation; createTable tableName=message; addForeignKeyCo...		\N	3.6.1	\N	\N	9975146276
addColumn-range-section	arvid	migrations.yml	2019-02-12 12:39:06.430117	2	EXECUTED	8:b327ebc1caba00ce8f0933e109f4d25c	addColumn tableName=range		\N	3.6.1	\N	\N	9975146276
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: chitchat
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: jsondoc; Type: TABLE DATA; Schema: public; Owner: chitchat
--

COPY public.jsondoc (id, name, type, created, updated, body) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: chitchat
--

COPY public.message (id, incoming, conversationid, senderid, recipientid, text, "timestamp") FROM stdin;
\.


--
-- Data for Name: range; Type: TABLE DATA; Schema: public; Owner: chitchat
--

COPY public.range (id, label, value, conversationid, tokenstart, tokenend, charstart, charend, props, section) FROM stdin;
\.


--
-- Data for Name: textdoc; Type: TABLE DATA; Schema: public; Owner: chitchat
--

COPY public.textdoc (id, name, type, created, updated, body) FROM stdin;
\.


--
-- Name: jsondoc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chitchat
--

SELECT pg_catalog.setval('public.jsondoc_id_seq', 1, false);


--
-- Name: conversation conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: chitchat
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: chitchat
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: jsondoc jsondoc_pkey; Type: CONSTRAINT; Schema: public; Owner: chitchat
--

ALTER TABLE ONLY public.jsondoc
    ADD CONSTRAINT jsondoc_pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: chitchat
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: range range_pkey; Type: CONSTRAINT; Schema: public; Owner: chitchat
--

ALTER TABLE ONLY public.range
    ADD CONSTRAINT range_pkey PRIMARY KEY (id);


--
-- Name: textdoc textdoc_pkey; Type: CONSTRAINT; Schema: public; Owner: chitchat
--

ALTER TABLE ONLY public.textdoc
    ADD CONSTRAINT textdoc_pkey PRIMARY KEY (id);


--
-- Name: idx_message_timestamp; Type: INDEX; Schema: public; Owner: chitchat
--

CREATE INDEX idx_message_timestamp ON public.message USING btree ("timestamp");


--
-- Name: idx_textdoc_name; Type: INDEX; Schema: public; Owner: chitchat
--

CREATE INDEX idx_textdoc_name ON public.textdoc USING btree (name);


--
-- Name: message fk_message_conversationid; Type: FK CONSTRAINT; Schema: public; Owner: chitchat
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fk_message_conversationid FOREIGN KEY (conversationid) REFERENCES public.conversation(id) ON UPDATE RESTRICT ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: range fk_range_conversationid; Type: FK CONSTRAINT; Schema: public; Owner: chitchat
--

ALTER TABLE ONLY public.range
    ADD CONSTRAINT fk_range_conversationid FOREIGN KEY (conversationid) REFERENCES public.conversation(id) ON UPDATE RESTRICT ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: chitchat
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

