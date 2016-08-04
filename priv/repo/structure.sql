--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actes_legs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE actes_legs (
    uid character varying(255) NOT NULL,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: amendements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE amendements (
    uid character varying(255) NOT NULL,
    depute_uid character varying(255) NOT NULL,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: citoyen_follows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE citoyen_follows (
    id integer NOT NULL,
    citoyen_uid integer NOT NULL,
    depute_uid character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: citoyen_follows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE citoyen_follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: citoyen_follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE citoyen_follows_id_seq OWNED BY citoyen_follows.id;


--
-- Name: citoyens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE citoyens (
    id integer NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: citoyens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE citoyens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: citoyens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE citoyens_id_seq OWNED BY citoyens.id;


--
-- Name: communes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE communes (
    id integer NOT NULL,
    nom character varying(255),
    code_postaux integer[],
    numero_departement character varying(255),
    numero_circonscription integer,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: communes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE communes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: communes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE communes_id_seq OWNED BY communes.id;


--
-- Name: deputes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE deputes (
    uid character varying(255) NOT NULL,
    nom character varying(255),
    prenom character varying(255),
    date_naissance timestamp without time zone,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: dos_legs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE dos_legs (
    uid character varying(255) NOT NULL,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: mandats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mandats (
    uid character varying(255) NOT NULL,
    depute_uid character varying(255) NOT NULL,
    organe_uid character varying(255) NOT NULL,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: organes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organes (
    uid character varying(255) NOT NULL,
    type character varying(255),
    code_type character varying(255),
    libelle character varying(255),
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE questions (
    uid character varying(255) NOT NULL,
    depute_uid character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: scrutin_depute_votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE scrutin_depute_votes (
    scrutin_uid character varying(255) NOT NULL,
    depute_uid character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: scrutins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE scrutins (
    uid character varying(255) NOT NULL,
    titre text,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: textes_legs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE textes_legs (
    uid character varying(255) NOT NULL,
    raw_json jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY citoyen_follows ALTER COLUMN id SET DEFAULT nextval('citoyen_follows_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY citoyens ALTER COLUMN id SET DEFAULT nextval('citoyens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY communes ALTER COLUMN id SET DEFAULT nextval('communes_id_seq'::regclass);


--
-- Name: actes_legs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actes_legs
    ADD CONSTRAINT actes_legs_pkey PRIMARY KEY (uid);


--
-- Name: amendements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY amendements
    ADD CONSTRAINT amendements_pkey PRIMARY KEY (uid);


--
-- Name: citoyen_follows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY citoyen_follows
    ADD CONSTRAINT citoyen_follows_pkey PRIMARY KEY (id);


--
-- Name: citoyens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY citoyens
    ADD CONSTRAINT citoyens_pkey PRIMARY KEY (id);


--
-- Name: communes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY communes
    ADD CONSTRAINT communes_pkey PRIMARY KEY (id);


--
-- Name: deputes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deputes
    ADD CONSTRAINT deputes_pkey PRIMARY KEY (uid);


--
-- Name: dos_legs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dos_legs
    ADD CONSTRAINT dos_legs_pkey PRIMARY KEY (uid);


--
-- Name: mandats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mandats
    ADD CONSTRAINT mandats_pkey PRIMARY KEY (uid);


--
-- Name: organes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organes
    ADD CONSTRAINT organes_pkey PRIMARY KEY (uid);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (uid);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: scrutin_depute_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scrutin_depute_votes
    ADD CONSTRAINT scrutin_depute_votes_pkey PRIMARY KEY (scrutin_uid, depute_uid);


--
-- Name: scrutins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scrutins
    ADD CONSTRAINT scrutins_pkey PRIMARY KEY (uid);


--
-- Name: textes_legs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY textes_legs
    ADD CONSTRAINT textes_legs_pkey PRIMARY KEY (uid);


--
-- Name: amendements_depute_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX amendements_depute_uid_index ON amendements USING btree (depute_uid);


--
-- Name: citoyen_follows_citoyen_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX citoyen_follows_citoyen_uid_index ON citoyen_follows USING btree (citoyen_uid);


--
-- Name: citoyen_follows_depute_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX citoyen_follows_depute_uid_index ON citoyen_follows USING btree (depute_uid);


--
-- Name: mandats_depute_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mandats_depute_uid_index ON mandats USING btree (depute_uid);


--
-- Name: questions_depute_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX questions_depute_uid_index ON questions USING btree (depute_uid);


--
-- Name: scrutin_depute_votes_depute_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scrutin_depute_votes_depute_uid_index ON scrutin_depute_votes USING btree (depute_uid);


--
-- Name: scrutin_depute_votes_scrutin_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scrutin_depute_votes_scrutin_uid_index ON scrutin_depute_votes USING btree (scrutin_uid);


--
-- Name: amendements_depute_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY amendements
    ADD CONSTRAINT amendements_depute_uid_fkey FOREIGN KEY (depute_uid) REFERENCES deputes(uid);


--
-- Name: citoyen_follows_citoyen_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY citoyen_follows
    ADD CONSTRAINT citoyen_follows_citoyen_uid_fkey FOREIGN KEY (citoyen_uid) REFERENCES citoyens(id);


--
-- Name: citoyen_follows_depute_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY citoyen_follows
    ADD CONSTRAINT citoyen_follows_depute_uid_fkey FOREIGN KEY (depute_uid) REFERENCES deputes(uid);


--
-- Name: mandats_depute_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mandats
    ADD CONSTRAINT mandats_depute_uid_fkey FOREIGN KEY (depute_uid) REFERENCES deputes(uid);


--
-- Name: mandats_organe_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mandats
    ADD CONSTRAINT mandats_organe_uid_fkey FOREIGN KEY (organe_uid) REFERENCES organes(uid);


--
-- Name: questions_depute_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_depute_uid_fkey FOREIGN KEY (depute_uid) REFERENCES deputes(uid);


--
-- Name: scrutin_depute_votes_depute_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scrutin_depute_votes
    ADD CONSTRAINT scrutin_depute_votes_depute_uid_fkey FOREIGN KEY (depute_uid) REFERENCES deputes(uid);


--
-- Name: scrutin_depute_votes_scrutin_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scrutin_depute_votes
    ADD CONSTRAINT scrutin_depute_votes_scrutin_uid_fkey FOREIGN KEY (scrutin_uid) REFERENCES scrutins(uid);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20160804164905), (20160806124814), (20160807084927), (20160807130927), (20160807173501), (20160808204846), (20160813171319), (20160818151924), (20160827194510), (20160913130734), (20160913134440), (20160924140354), (20160925181956);

