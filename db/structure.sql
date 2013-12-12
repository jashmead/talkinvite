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
-- Name: calendars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE calendars (
    id integer NOT NULL,
    talk_id integer,
    name character varying(255),
    description text,
    scale character varying(255) DEFAULT 'day'::character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    person_id integer
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
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    person_id integer,
    talk_id integer,
    comment_text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: credits; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE credits (
    id integer NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    url character varying(255)
);


--
-- Name: credits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE credits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE credits_id_seq OWNED BY credits.id;


--
-- Name: helps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE helps (
    id integer NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255),
    help_type character varying(255) DEFAULT 'page'::character varying
);


--
-- Name: helps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE helps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: helps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE helps_id_seq OWNED BY helps.id;


--
-- Name: maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE maps (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    geometry text DEFAULT '{}'::text,
    settings text DEFAULT '{}'::text,
    history text DEFAULT '{}'::text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    talk_id integer,
    person_id integer
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
-- Name: partners; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE partners (
    id integer NOT NULL,
    talk_id integer,
    person_id integer,
    rsvp_status character varying(255) DEFAULT 'accepted'::character varying NOT NULL,
    partner_type character varying(255) DEFAULT 'partner'::character varying NOT NULL,
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

ALTER SEQUENCE members_id_seq OWNED BY partners.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    sender_id integer,
    receiver_id integer,
    message_type character varying(255) DEFAULT 'talkinvite'::character varying NOT NULL,
    message_text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    talk_id integer,
    service_type character varying(255) DEFAULT 'talkinvite'::character varying,
    received_at timestamp without time zone,
    previous_message_id integer
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


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
    description text,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255)
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
    person_id integer NOT NULL,
    talk_id integer NOT NULL,
    routing character varying(255) DEFAULT 'message'::character varying NOT NULL,
    post_type character varying(255) DEFAULT 'announce'::character varying NOT NULL,
    post_message text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    post_title character varying(255) DEFAULT 'Hi There! Want to talk?'::character varying
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
-- Name: services; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE services (
    id integer NOT NULL,
    person_id integer,
    service_type character varying(255) DEFAULT 'talkinvite'::character varying,
    service_notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE services_id_seq OWNED BY services.id;


--
-- Name: talks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE talks (
    id integer NOT NULL,
    summary character varying(255) NOT NULL,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    person_id integer NOT NULL,
    longitude numeric,
    latitude numeric,
    talk_status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    address character varying(255),
    talk_date date,
    talk_time time without time zone,
    talk_duration integer,
    talk_who text
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

ALTER TABLE ONLY calendars ALTER COLUMN id SET DEFAULT nextval('calendars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY credits ALTER COLUMN id SET DEFAULT nextval('credits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY helps ALTER COLUMN id SET DEFAULT nextval('helps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps ALTER COLUMN id SET DEFAULT nextval('maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY partners ALTER COLUMN id SET DEFAULT nextval('members_id_seq'::regclass);


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

ALTER TABLE ONLY services ALTER COLUMN id SET DEFAULT nextval('services_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talks ALTER COLUMN id SET DEFAULT nextval('talks_id_seq'::regclass);


--
-- Name: calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY calendars
    ADD CONSTRAINT calendars_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: credits_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY credits
    ADD CONSTRAINT credits_pkey PRIMARY KEY (id);


--
-- Name: helps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY helps
    ADD CONSTRAINT helps_pkey PRIMARY KEY (id);


--
-- Name: maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY maps
    ADD CONSTRAINT maps_pkey PRIMARY KEY (id);


--
-- Name: members_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY partners
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


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
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: talks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY talks
    ADD CONSTRAINT talks_pkey PRIMARY KEY (id);


--
-- Name: index_comments_on_person_id_and_talk_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_comments_on_person_id_and_talk_id ON comments USING btree (person_id, talk_id);


--
-- Name: index_credits_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_credits_on_name ON credits USING btree (name);


--
-- Name: index_helps_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_helps_on_name ON helps USING btree (name);


--
-- Name: index_members_on_person_id_and_talk_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_members_on_person_id_and_talk_id ON partners USING btree (person_id, talk_id);


--
-- Name: index_messages_on_previous_message_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_previous_message_id ON messages USING btree (previous_message_id);


--
-- Name: index_messages_on_talk_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_talk_id ON messages USING btree (talk_id);


--
-- Name: index_people_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_people_on_email ON people USING btree (email);


--
-- Name: index_people_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_people_on_name ON people USING btree (name);


--
-- Name: index_people_on_remember_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_people_on_remember_token ON people USING btree (remember_token);


--
-- Name: index_people_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_people_on_reset_password_token ON people USING btree (reset_password_token);


--
-- Name: index_talks_on_person_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_talks_on_person_id_and_created_at ON talks USING btree (person_id, created_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: calendar2person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY calendars
    ADD CONSTRAINT calendar2person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: calendar2talk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY calendars
    ADD CONSTRAINT calendar2talk_fk FOREIGN KEY (talk_id) REFERENCES talks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment2to_person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comment2to_person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment2to_talk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comment2to_talk_fk FOREIGN KEY (talk_id) REFERENCES talks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: map2person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps
    ADD CONSTRAINT map2person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: map2talk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY maps
    ADD CONSTRAINT map2talk_fk FOREIGN KEY (talk_id) REFERENCES talks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member2to_person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY partners
    ADD CONSTRAINT member2to_person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member2to_talk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY partners
    ADD CONSTRAINT member2to_talk_fk FOREIGN KEY (talk_id) REFERENCES talks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: message2receiver_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT message2receiver_fk FOREIGN KEY (receiver_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: message2sender_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT message2sender_fk FOREIGN KEY (sender_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: message2talk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT message2talk_fk FOREIGN KEY (talk_id) REFERENCES talks(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: post2person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT post2person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post2talk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT post2talk_fk FOREIGN KEY (talk_id) REFERENCES talks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service2person_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY services
    ADD CONSTRAINT service2person_fk FOREIGN KEY (person_id) REFERENCES people(id) ON UPDATE CASCADE ON DELETE CASCADE;


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

INSERT INTO schema_migrations (version) VALUES ('20131009152701');

INSERT INTO schema_migrations (version) VALUES ('20131009152706');

INSERT INTO schema_migrations (version) VALUES ('20131009152726');

INSERT INTO schema_migrations (version) VALUES ('20131009153201');

INSERT INTO schema_migrations (version) VALUES ('20131015145638');

INSERT INTO schema_migrations (version) VALUES ('20131015160810');

INSERT INTO schema_migrations (version) VALUES ('20131015161708');

INSERT INTO schema_migrations (version) VALUES ('20131015164703');

INSERT INTO schema_migrations (version) VALUES ('20131015173419');

INSERT INTO schema_migrations (version) VALUES ('20131015190509');

INSERT INTO schema_migrations (version) VALUES ('20131015200208');

INSERT INTO schema_migrations (version) VALUES ('20131015202711');

INSERT INTO schema_migrations (version) VALUES ('20131015221428');

INSERT INTO schema_migrations (version) VALUES ('20131015223919');

INSERT INTO schema_migrations (version) VALUES ('20131015235744');

INSERT INTO schema_migrations (version) VALUES ('20131016011047');

INSERT INTO schema_migrations (version) VALUES ('20131016012217');

INSERT INTO schema_migrations (version) VALUES ('20131016030347');

INSERT INTO schema_migrations (version) VALUES ('20131016133020');

INSERT INTO schema_migrations (version) VALUES ('20131016143201');

INSERT INTO schema_migrations (version) VALUES ('20131016144200');

INSERT INTO schema_migrations (version) VALUES ('20131016154314');

INSERT INTO schema_migrations (version) VALUES ('20131016164651');

INSERT INTO schema_migrations (version) VALUES ('20131016165839');

INSERT INTO schema_migrations (version) VALUES ('20131016172016');

INSERT INTO schema_migrations (version) VALUES ('20131016172957');

INSERT INTO schema_migrations (version) VALUES ('20131018133657');

INSERT INTO schema_migrations (version) VALUES ('20131025151810');

INSERT INTO schema_migrations (version) VALUES ('20131028185404');

INSERT INTO schema_migrations (version) VALUES ('20131028195018');

INSERT INTO schema_migrations (version) VALUES ('20131029163859');

INSERT INTO schema_migrations (version) VALUES ('20131030134603');

INSERT INTO schema_migrations (version) VALUES ('20131030141718');

INSERT INTO schema_migrations (version) VALUES ('20131031142216');

INSERT INTO schema_migrations (version) VALUES ('20131031150054');

INSERT INTO schema_migrations (version) VALUES ('20131031160337');

INSERT INTO schema_migrations (version) VALUES ('20131031160346');

INSERT INTO schema_migrations (version) VALUES ('20131031160705');

INSERT INTO schema_migrations (version) VALUES ('20131031165845');

INSERT INTO schema_migrations (version) VALUES ('20131031172122');

INSERT INTO schema_migrations (version) VALUES ('20131031174854');

INSERT INTO schema_migrations (version) VALUES ('20131031181943');

INSERT INTO schema_migrations (version) VALUES ('20131031191728');

INSERT INTO schema_migrations (version) VALUES ('20131031192217');

INSERT INTO schema_migrations (version) VALUES ('20131103003016');

INSERT INTO schema_migrations (version) VALUES ('20131104151029');

INSERT INTO schema_migrations (version) VALUES ('20131104153940');

INSERT INTO schema_migrations (version) VALUES ('20131104154538');

INSERT INTO schema_migrations (version) VALUES ('20131104162828');

INSERT INTO schema_migrations (version) VALUES ('20131106161020');

INSERT INTO schema_migrations (version) VALUES ('20131111172645');

INSERT INTO schema_migrations (version) VALUES ('20131111181942');

INSERT INTO schema_migrations (version) VALUES ('20131111214007');

INSERT INTO schema_migrations (version) VALUES ('20131115164140');

INSERT INTO schema_migrations (version) VALUES ('20131115165112');

INSERT INTO schema_migrations (version) VALUES ('20131115165825');

INSERT INTO schema_migrations (version) VALUES ('20131115170724');

INSERT INTO schema_migrations (version) VALUES ('20131122001014');

INSERT INTO schema_migrations (version) VALUES ('20131122001348');

INSERT INTO schema_migrations (version) VALUES ('20131122004017');

INSERT INTO schema_migrations (version) VALUES ('20131122005343');

INSERT INTO schema_migrations (version) VALUES ('20131122013253');

INSERT INTO schema_migrations (version) VALUES ('20131122014753');

INSERT INTO schema_migrations (version) VALUES ('20131122022650');

INSERT INTO schema_migrations (version) VALUES ('20131123210454');

INSERT INTO schema_migrations (version) VALUES ('20131124235118');

INSERT INTO schema_migrations (version) VALUES ('20131124235339');

INSERT INTO schema_migrations (version) VALUES ('20131125001516');

INSERT INTO schema_migrations (version) VALUES ('20131125213523');

INSERT INTO schema_migrations (version) VALUES ('20131129215544');

INSERT INTO schema_migrations (version) VALUES ('20131202211752');

INSERT INTO schema_migrations (version) VALUES ('20131203165935');

INSERT INTO schema_migrations (version) VALUES ('20131203202516');

INSERT INTO schema_migrations (version) VALUES ('20131206190903');

INSERT INTO schema_migrations (version) VALUES ('20131206213411');

INSERT INTO schema_migrations (version) VALUES ('20131208195217');

INSERT INTO schema_migrations (version) VALUES ('20131209235705');

INSERT INTO schema_migrations (version) VALUES ('20131210004515');

INSERT INTO schema_migrations (version) VALUES ('20131210192109');

INSERT INTO schema_migrations (version) VALUES ('20131210195137');

INSERT INTO schema_migrations (version) VALUES ('20131212141759');

INSERT INTO schema_migrations (version) VALUES ('20131212142041');

INSERT INTO schema_migrations (version) VALUES ('20131212143720');

INSERT INTO schema_migrations (version) VALUES ('20131212144326');
