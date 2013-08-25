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
-- Name: attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE attachments (
    id integer NOT NULL,
    person_id integer,
    name character varying(255),
    description text,
    file_type character varying(255),
    pathname character varying(255),
    attachable_type character varying(255),
    attachable_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE attachments_id_seq OWNED BY attachments.id;


--
-- Name: calendars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE calendars (
    id integer NOT NULL,
    person_id integer,
    name character varying(255),
    description text,
    time_point timestamp without time zone,
    source character varying(255),
    settings text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: calendars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE calendars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calendars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE calendars_id_seq OWNED BY calendars.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    name character varying(255),
    description text,
    longitude double precision,
    latitude double precision,
    address character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE maps (
    id integer NOT NULL,
    person_id integer,
    name character varying(255),
    description text,
    location_id integer,
    settings text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    source character varying(255)
);


--
-- Name: maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE maps_id_seq OWNED BY maps.id;


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
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    person_type character varying(255),
    password_digest character varying(255)
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
-- Name: posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    person_id integer,
    talk_id integer,
    post_type character varying(255),
    comment text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    tagable_type character varying(255),
    tabable_id integer,
    tag_type character varying(255),
    tag character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: talks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE talks (
    id integer NOT NULL,
    summary character varying(255),
    description text,
    location_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
-- Name: tweets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tweets (
    id integer NOT NULL,
    person_id integer,
    screen_name character varying(255),
    content character varying(255),
    location_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    post_id integer
);


--
-- Name: tweets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tweets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tweets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tweets_id_seq OWNED BY tweets.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY attachments ALTER COLUMN id SET DEFAULT nextval('attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY calendars ALTER COLUMN id SET DEFAULT nextval('calendars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps ALTER COLUMN id SET DEFAULT nextval('maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talks ALTER COLUMN id SET DEFAULT nextval('talks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tweets ALTER COLUMN id SET DEFAULT nextval('tweets_id_seq'::regclass);


--
-- Name: attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY calendars
    ADD CONSTRAINT calendars_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY maps
    ADD CONSTRAINT maps_pkey PRIMARY KEY (id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: talks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY talks
    ADD CONSTRAINT talks_pkey PRIMARY KEY (id);


--
-- Name: tweets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweets_pkey PRIMARY KEY (id);


--
-- Name: index_people_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_people_on_email ON people USING btree (email);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: attachment2person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachment2person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: calendar2person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY calendars
    ADD CONSTRAINT calendar2person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: map2person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps
    ADD CONSTRAINT map2person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post2talk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT post2talk_fk FOREIGN KEY (talk_id) REFERENCES talks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tweet2location_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweet2location_fk FOREIGN KEY (location_id) REFERENCES locations(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: tweet2person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweet2person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


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
