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
-- Name: members; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE members (
    id integer NOT NULL,
    talk_id integer,
    person_id integer,
    rsvp_status character varying(255) DEFAULT 'accepted'::character varying NOT NULL,
    member_type character varying(255) DEFAULT 'member'::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE members_id_seq OWNED BY members.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE people (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_digest character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    remember_token character varying(255),
    admin boolean DEFAULT false NOT NULL,
    sub boolean DEFAULT false NOT NULL
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
-- Name: relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE relationships (
    id integer NOT NULL,
    follower_id integer,
    followed_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE relationships_id_seq OWNED BY relationships.id;


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
    person_id integer NOT NULL
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

ALTER TABLE ONLY members ALTER COLUMN id SET DEFAULT nextval('members_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY relationships ALTER COLUMN id SET DEFAULT nextval('relationships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talks ALTER COLUMN id SET DEFAULT nextval('talks_id_seq'::regclass);


--
-- Name: members_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: talks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY talks
    ADD CONSTRAINT talks_pkey PRIMARY KEY (id);


--
-- Name: index_members_on_person_id_and_talk_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_members_on_person_id_and_talk_id ON members USING btree (person_id, talk_id);


--
-- Name: index_people_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_people_on_email ON people USING btree (email);


--
-- Name: index_people_on_remember_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_people_on_remember_token ON people USING btree (remember_token);


--
-- Name: index_relationships_on_followed_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_relationships_on_followed_id ON relationships USING btree (followed_id);


--
-- Name: index_relationships_on_follower_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_relationships_on_follower_id ON relationships USING btree (follower_id);


--
-- Name: index_relationships_on_follower_id_and_followed_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_relationships_on_follower_id_and_followed_id ON relationships USING btree (follower_id, followed_id);


--
-- Name: index_talks_on_person_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_talks_on_person_id_and_created_at ON talks USING btree (person_id, created_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: member2to_person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY members
    ADD CONSTRAINT member2to_person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member2to_talk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY members
    ADD CONSTRAINT member2to_talk_fk FOREIGN KEY (talk_id) REFERENCES talks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: relationship2from_person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT relationship2from_person_fk FOREIGN KEY (followed_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: relationship2to_person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT relationship2to_person_fk FOREIGN KEY (follower_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: talk2to_person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY talks
    ADD CONSTRAINT talk2to_person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130823224936');

INSERT INTO schema_migrations (version) VALUES ('20130823225757');

INSERT INTO schema_migrations (version) VALUES ('20130823230903');

INSERT INTO schema_migrations (version) VALUES ('20130824002444');

INSERT INTO schema_migrations (version) VALUES ('20130824005326');

INSERT INTO schema_migrations (version) VALUES ('20130824171751');

INSERT INTO schema_migrations (version) VALUES ('20130824182913');

INSERT INTO schema_migrations (version) VALUES ('20130824193702');

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

INSERT INTO schema_migrations (version) VALUES ('20130911201231');

INSERT INTO schema_migrations (version) VALUES ('20130912180352');

INSERT INTO schema_migrations (version) VALUES ('20130922165558');

INSERT INTO schema_migrations (version) VALUES ('20130922170750');

INSERT INTO schema_migrations (version) VALUES ('20130922171946');

INSERT INTO schema_migrations (version) VALUES ('20130922172401');

INSERT INTO schema_migrations (version) VALUES ('20130922192727');

INSERT INTO schema_migrations (version) VALUES ('20130922203248');

INSERT INTO schema_migrations (version) VALUES ('20131009152706');

INSERT INTO schema_migrations (version) VALUES ('20131009152726');

INSERT INTO schema_migrations (version) VALUES ('20131009153201');

INSERT INTO schema_migrations (version) VALUES ('20131015145638');

INSERT INTO schema_migrations (version) VALUES ('20131015160810');

INSERT INTO schema_migrations (version) VALUES ('20131015161708');

INSERT INTO schema_migrations (version) VALUES ('20131015164703');
