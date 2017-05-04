--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: rpvs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA rpvs;


--
-- Name: upvs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA upvs;


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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


SET search_path = rpvs, pg_catalog;

--
-- Name: authorizedpersons; Type: TABLE; Schema: rpvs; Owner: -
--

CREATE TABLE authorizedpersons (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    authperson_id integer NOT NULL,
    first_name character varying,
    family_name character varying,
    birth_date timestamp without time zone,
    title_front character varying,
    title_back character varying,
    business_name character varying,
    cin character varying,
    business_form character varying,
    valid_from timestamp without time zone,
    valid_to timestamp without time zone,
    address_street_name character varying,
    address_street_number character varying,
    address_reg_number character varying,
    address_city character varying,
    address_code character varying,
    address_psc character varying,
    address_identifikator character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authorizedpersons_id_seq; Type: SEQUENCE; Schema: rpvs; Owner: -
--

CREATE SEQUENCE authorizedpersons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorizedpersons_id_seq; Type: SEQUENCE OWNED BY; Schema: rpvs; Owner: -
--

ALTER SEQUENCE authorizedpersons_id_seq OWNED BY authorizedpersons.id;


--
-- Name: endusers; Type: TABLE; Schema: rpvs; Owner: -
--

CREATE TABLE endusers (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    enduser_id integer NOT NULL,
    first_name character varying,
    family_name character varying,
    birth_date timestamp without time zone,
    title_front character varying,
    title_back character varying,
    is_public_figure boolean,
    business_name character varying,
    cin character varying,
    valid_from timestamp without time zone,
    valid_to timestamp without time zone,
    address_street_name character varying,
    address_street_number character varying,
    address_reg_number character varying,
    address_city character varying,
    address_code character varying,
    address_psc character varying,
    address_identifikator character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: endusers_id_seq; Type: SEQUENCE; Schema: rpvs; Owner: -
--

CREATE SEQUENCE endusers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: endusers_id_seq; Type: SEQUENCE OWNED BY; Schema: rpvs; Owner: -
--

ALTER SEQUENCE endusers_id_seq OWNED BY endusers.id;


--
-- Name: partners; Type: TABLE; Schema: rpvs; Owner: -
--

CREATE TABLE partners (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    line integer NOT NULL,
    removal_id integer,
    reason character varying,
    note character varying,
    removal_date timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: partners_id_seq; Type: SEQUENCE; Schema: rpvs; Owner: -
--

CREATE SEQUENCE partners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: partners_id_seq; Type: SEQUENCE OWNED BY; Schema: rpvs; Owner: -
--

ALTER SEQUENCE partners_id_seq OWNED BY partners.id;


--
-- Name: publicsectorpartners; Type: TABLE; Schema: rpvs; Owner: -
--

CREATE TABLE publicsectorpartners (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    publicsectorpartner_id integer NOT NULL,
    first_name character varying,
    family_name character varying,
    birth_date timestamp without time zone,
    title_front character varying,
    title_back character varying,
    business_name character varying,
    cin character varying,
    business_form character varying,
    valid_from timestamp without time zone,
    valid_to timestamp without time zone,
    address_street_name character varying,
    address_street_number character varying,
    address_reg_number character varying,
    address_city character varying,
    address_code character varying,
    address_psc character varying,
    address_identifikator character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: publicsectorpartners_id_seq; Type: SEQUENCE; Schema: rpvs; Owner: -
--

CREATE SEQUENCE publicsectorpartners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publicsectorpartners_id_seq; Type: SEQUENCE OWNED BY; Schema: rpvs; Owner: -
--

ALTER SEQUENCE publicsectorpartners_id_seq OWNED BY publicsectorpartners.id;


SET search_path = upvs, pg_catalog;

--
-- Name: public_authority_edesks; Type: TABLE; Schema: upvs; Owner: -
--

CREATE TABLE public_authority_edesks (
    id integer NOT NULL,
    cin bigint NOT NULL,
    uri character varying NOT NULL,
    name character varying NOT NULL,
    street character varying,
    street_number character varying,
    postal_code character varying,
    city character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: public_authority_edesks_id_seq; Type: SEQUENCE; Schema: upvs; Owner: -
--

CREATE SEQUENCE public_authority_edesks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: public_authority_edesks_id_seq; Type: SEQUENCE OWNED BY; Schema: upvs; Owner: -
--

ALTER SEQUENCE public_authority_edesks_id_seq OWNED BY public_authority_edesks.id;


SET search_path = rpvs, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: rpvs; Owner: -
--

ALTER TABLE ONLY authorizedpersons ALTER COLUMN id SET DEFAULT nextval('authorizedpersons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: rpvs; Owner: -
--

ALTER TABLE ONLY endusers ALTER COLUMN id SET DEFAULT nextval('endusers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: rpvs; Owner: -
--

ALTER TABLE ONLY partners ALTER COLUMN id SET DEFAULT nextval('partners_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: rpvs; Owner: -
--

ALTER TABLE ONLY publicsectorpartners ALTER COLUMN id SET DEFAULT nextval('publicsectorpartners_id_seq'::regclass);


SET search_path = upvs, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: upvs; Owner: -
--

ALTER TABLE ONLY public_authority_edesks ALTER COLUMN id SET DEFAULT nextval('public_authority_edesks_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


SET search_path = rpvs, pg_catalog;

--
-- Name: authorizedpersons_pkey; Type: CONSTRAINT; Schema: rpvs; Owner: -
--

ALTER TABLE ONLY authorizedpersons
    ADD CONSTRAINT authorizedpersons_pkey PRIMARY KEY (id);


--
-- Name: endusers_pkey; Type: CONSTRAINT; Schema: rpvs; Owner: -
--

ALTER TABLE ONLY endusers
    ADD CONSTRAINT endusers_pkey PRIMARY KEY (id);


--
-- Name: partners_pkey; Type: CONSTRAINT; Schema: rpvs; Owner: -
--

ALTER TABLE ONLY partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: publicsectorpartners_pkey; Type: CONSTRAINT; Schema: rpvs; Owner: -
--

ALTER TABLE ONLY publicsectorpartners
    ADD CONSTRAINT publicsectorpartners_pkey PRIMARY KEY (id);


SET search_path = upvs, pg_catalog;

--
-- Name: public_authority_edesks_pkey; Type: CONSTRAINT; Schema: upvs; Owner: -
--

ALTER TABLE ONLY public_authority_edesks
    ADD CONSTRAINT public_authority_edesks_pkey PRIMARY KEY (id);


SET search_path = rpvs, pg_catalog;

--
-- Name: index_rpvs.authorizedpersons_on_authperson_id; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE UNIQUE INDEX "index_rpvs.authorizedpersons_on_authperson_id" ON authorizedpersons USING btree (authperson_id);


--
-- Name: index_rpvs.authorizedpersons_on_cin; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE INDEX "index_rpvs.authorizedpersons_on_cin" ON authorizedpersons USING btree (cin);


--
-- Name: index_rpvs.authorizedpersons_on_partner_id; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE INDEX "index_rpvs.authorizedpersons_on_partner_id" ON authorizedpersons USING btree (partner_id);


--
-- Name: index_rpvs.endusers_on_cin; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE INDEX "index_rpvs.endusers_on_cin" ON endusers USING btree (cin);


--
-- Name: index_rpvs.endusers_on_enduser_id; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE UNIQUE INDEX "index_rpvs.endusers_on_enduser_id" ON endusers USING btree (enduser_id);


--
-- Name: index_rpvs.endusers_on_partner_id; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE INDEX "index_rpvs.endusers_on_partner_id" ON endusers USING btree (partner_id);


--
-- Name: index_rpvs.partners_on_line; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE UNIQUE INDEX "index_rpvs.partners_on_line" ON partners USING btree (line);


--
-- Name: index_rpvs.partners_on_partner_id; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE UNIQUE INDEX "index_rpvs.partners_on_partner_id" ON partners USING btree (partner_id);


--
-- Name: index_rpvs.publicsectorpartners_on_cin; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE INDEX "index_rpvs.publicsectorpartners_on_cin" ON publicsectorpartners USING btree (cin);


--
-- Name: index_rpvs.publicsectorpartners_on_partner_id; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE INDEX "index_rpvs.publicsectorpartners_on_partner_id" ON publicsectorpartners USING btree (partner_id);


--
-- Name: index_rpvs.publicsectorpartners_on_publicsectorpartner_id; Type: INDEX; Schema: rpvs; Owner: -
--

CREATE UNIQUE INDEX "index_rpvs.publicsectorpartners_on_publicsectorpartner_id" ON publicsectorpartners USING btree (publicsectorpartner_id);


SET search_path = upvs, pg_catalog;

--
-- Name: index_upvs.public_authority_edesks_on_cin; Type: INDEX; Schema: upvs; Owner: -
--

CREATE INDEX "index_upvs.public_authority_edesks_on_cin" ON public_authority_edesks USING btree (cin);


--
-- Name: index_upvs.public_authority_edesks_on_uri; Type: INDEX; Schema: upvs; Owner: -
--

CREATE UNIQUE INDEX "index_upvs.public_authority_edesks_on_uri" ON public_authority_edesks USING btree (uri);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES
('20170222131821'),
('20170223074140'),
('20170417162350');


