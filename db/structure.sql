--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: people; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE people (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    about_me text,
    screen_name character varying(255),
    settings character varying(255),
    password_digest character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    remember_token character varying(255),
    admin boolean DEFAULT false,
    sub boolean DEFAULT false
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: talks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE talks (
    id integer NOT NULL,
    summary character varying(255) NOT NULL,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    person_id integer
);


--
-- Name: talks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE talks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: talks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE talks_id_seq OWNED BY talks.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talks ALTER COLUMN id SET DEFAULT nextval('talks_id_seq'::regclass);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: talks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY talks
    ADD CONSTRAINT talks_pkey PRIMARY KEY (id);


--
-- Name: index_people_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_people_on_email ON people USING btree (email);


--
-- Name: index_people_on_remember_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_people_on_remember_token ON people USING btree (remember_token);


--
-- Name: index_talks_on_person_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_talks_on_person_id_and_created_at ON talks USING btree (person_id, created_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130823224936');

INSERT INTO schema_migrations (version) VALUES ('20130823225757');

INSERT INTO schema_migrations (version) VALUES ('20130823230903');

INSERT INTO schema_migrations (version) VALUES ('20130824000642');

INSERT INTO schema_migrations (version) VALUES ('20130824002444');

INSERT INTO schema_migrations (version) VALUES ('20130824005326');

INSERT INTO schema_migrations (version) VALUES ('20130824011824');

INSERT INTO schema_migrations (version) VALUES ('20130824012341');

INSERT INTO schema_migrations (version) VALUES ('20130824171751');

INSERT INTO schema_migrations (version) VALUES ('20130824182826');

INSERT INTO schema_migrations (version) VALUES ('20130824182913');

INSERT INTO schema_migrations (version) VALUES ('20130824192206');

INSERT INTO schema_migrations (version) VALUES ('20130824193221');

INSERT INTO schema_migrations (version) VALUES ('20130824193702');

INSERT INTO schema_migrations (version) VALUES ('20130824201412');

INSERT INTO schema_migrations (version) VALUES ('20130824203337');

INSERT INTO schema_migrations (version) VALUES ('20130824212540');

INSERT INTO schema_migrations (version) VALUES ('20130825145151');

INSERT INTO schema_migrations (version) VALUES ('20130825211813');

INSERT INTO schema_migrations (version) VALUES ('20130825213527');

INSERT INTO schema_migrations (version) VALUES ('20130825221120');

INSERT INTO schema_migrations (version) VALUES ('20130825223009');

INSERT INTO schema_migrations (version) VALUES ('20130825231529');

INSERT INTO schema_migrations (version) VALUES ('20130826000933');

INSERT INTO schema_migrations (version) VALUES ('20130826183518');

INSERT INTO schema_migrations (version) VALUES ('20130827215657');

INSERT INTO schema_migrations (version) VALUES ('20130827230026');

INSERT INTO schema_migrations (version) VALUES ('20130901000749');

INSERT INTO schema_migrations (version) VALUES ('20130909202157');

INSERT INTO schema_migrations (version) VALUES ('20130910001125');

INSERT INTO schema_migrations (version) VALUES ('20130910010159');

INSERT INTO schema_migrations (version) VALUES ('20130911171511');

INSERT INTO schema_migrations (version) VALUES ('20130911194218');

INSERT INTO schema_migrations (version) VALUES ('20130911194853');
