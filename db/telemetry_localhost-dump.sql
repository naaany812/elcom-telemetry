PGDMP     9                    x         	   telemetry    12.1    12.1 6    d           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            e           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            f           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            g           1262    16512 	   telemetry    DATABASE     �   CREATE DATABASE telemetry WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE telemetry;
                postgres    false            �            1259    24788    data_climate    TABLE     �  CREATE TABLE public.data_climate (
    id integer NOT NULL,
    order_num integer,
    uid text,
    id_train integer,
    car_number integer,
    receiver_code integer,
    device_type character varying(5) DEFAULT '00'::text,
    command_type integer,
    "time" timestamp without time zone,
    channel_1 integer,
    channel_2 integer,
    channel_3 integer,
    channel_4 integer,
    time_received timestamp without time zone
);
     DROP TABLE public.data_climate;
       public         heap    postgres    false            �            1259    24786    data_climate_id_seq    SEQUENCE     �   CREATE SEQUENCE public.data_climate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.data_climate_id_seq;
       public          postgres    false    208            h           0    0    data_climate_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.data_climate_id_seq OWNED BY public.data_climate.id;
          public          postgres    false    207            �            1259    24800    data_energy    TABLE     �  CREATE TABLE public.data_energy (
    id integer NOT NULL,
    order_num integer,
    uid text,
    id_train integer,
    car_number integer,
    receiver_code integer,
    device_type character varying(5) DEFAULT '00'::text,
    command_type integer,
    "time" timestamp without time zone,
    amperage integer,
    voltage integer,
    energy_active integer,
    energy_passive integer,
    time_received timestamp without time zone
);
    DROP TABLE public.data_energy;
       public         heap    postgres    false            �            1259    24798    data_energy_id_seq    SEQUENCE     �   CREATE SEQUENCE public.data_energy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.data_energy_id_seq;
       public          postgres    false    210            i           0    0    data_energy_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.data_energy_id_seq OWNED BY public.data_energy.id;
          public          postgres    false    209            �            1259    25006    data_geo    TABLE     �  CREATE TABLE public.data_geo (
    id integer,
    order_num integer,
    uid text,
    id_train integer,
    car_number integer,
    receiver_code integer,
    device_type character varying(5) DEFAULT '00'::text,
    command_type integer,
    "time" timestamp without time zone,
    latitude text,
    longitude text,
    alt double precision,
    speed double precision,
    course double precision,
    time_received timestamp without time zone,
    device_id character varying(255),
    car_num integer
);
    DROP TABLE public.data_geo;
       public         heap    postgres    false            �            1259    24998 	   data_rssi    TABLE     �  CREATE TABLE public.data_rssi (
    id integer,
    order_num integer,
    uid text,
    id_train integer,
    car_number integer,
    receiver_code integer,
    device_type character varying(5) DEFAULT '00'::text,
    command_type integer,
    "time" timestamp without time zone,
    rssi integer,
    rssi_reverse integer,
    received_count integer,
    total_count integer,
    time_received timestamp without time zone,
    device_id character varying(255),
    car_num integer
);
    DROP TABLE public.data_rssi;
       public         heap    postgres    false            �            1259    24849    devices    TABLE     D  CREATE TABLE public.devices (
    id integer NOT NULL,
    device_uid text,
    system_id integer,
    hw integer,
    sw integer,
    config_link integer,
    type text DEFAULT '00'::text,
    car_number integer DEFAULT 0,
    name character varying(255),
    sw_link integer,
    updates boolean DEFAULT false NOT NULL
);
    DROP TABLE public.devices;
       public         heap    postgres    false            �            1259    16527 
   devicesold    TABLE     F  CREATE TABLE public.devicesold (
    id integer NOT NULL,
    device_hw_id integer DEFAULT 0,
    device_hw_head_id integer DEFAULT 0,
    hw_ver integer DEFAULT 0,
    sw_ver integer DEFAULT 0,
    config_link text,
    train_id integer,
    type integer,
    car_number integer,
    device_head_id integer,
    name text
);
    DROP TABLE public.devicesold;
       public         heap    postgres    false            �            1259    16525    devices_id_seq    SEQUENCE     �   CREATE SEQUENCE public.devices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.devices_id_seq;
       public          postgres    false    203            j           0    0    devices_id_seq    SEQUENCE OWNED BY     D   ALTER SEQUENCE public.devices_id_seq OWNED BY public.devicesold.id;
          public          postgres    false    202            �            1259    24924    flyway_schema_history    TABLE     �  CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);
 )   DROP TABLE public.flyway_schema_history;
       public         heap    postgres    false            �            1259    24708    hibernate_sequence    SEQUENCE     {   CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hibernate_sequence;
       public          postgres    false            �            1259    24875    software    TABLE     �   CREATE TABLE public.software (
    id integer NOT NULL,
    filename text,
    version integer,
    path text,
    actual boolean DEFAULT true,
    link text,
    size bigint
);
    DROP TABLE public.software;
       public         heap    postgres    false            �            1259    24873    software_id_seq    SEQUENCE     �   CREATE SEQUENCE public.software_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.software_id_seq;
       public          postgres    false    214            k           0    0    software_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.software_id_seq OWNED BY public.software.id;
          public          postgres    false    213            �            1259    24735    systems    TABLE     �   CREATE TABLE public.systems (
    id integer NOT NULL,
    train_type text,
    train_number text,
    system_id integer,
    status integer,
    car_count integer,
    head_device_id text
);
    DROP TABLE public.systems;
       public         heap    postgres    false            �            1259    24733    systems_id_seq    SEQUENCE     �   CREATE SEQUENCE public.systems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.systems_id_seq;
       public          postgres    false    206            l           0    0    systems_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.systems_id_seq OWNED BY public.systems.id;
          public          postgres    false    205            �            1259    24847    table_name_id_seq    SEQUENCE     �   CREATE SEQUENCE public.table_name_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.table_name_id_seq;
       public          postgres    false    212            m           0    0    table_name_id_seq    SEQUENCE OWNED BY     D   ALTER SEQUENCE public.table_name_id_seq OWNED BY public.devices.id;
          public          postgres    false    211            �
           2604    24791    data_climate id    DEFAULT     r   ALTER TABLE ONLY public.data_climate ALTER COLUMN id SET DEFAULT nextval('public.data_climate_id_seq'::regclass);
 >   ALTER TABLE public.data_climate ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    207    208            �
           2604    24803    data_energy id    DEFAULT     p   ALTER TABLE ONLY public.data_energy ALTER COLUMN id SET DEFAULT nextval('public.data_energy_id_seq'::regclass);
 =   ALTER TABLE public.data_energy ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            �
           2604    24852 
   devices id    DEFAULT     k   ALTER TABLE ONLY public.devices ALTER COLUMN id SET DEFAULT nextval('public.table_name_id_seq'::regclass);
 9   ALTER TABLE public.devices ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    212    212            �
           2604    16530    devicesold id    DEFAULT     k   ALTER TABLE ONLY public.devicesold ALTER COLUMN id SET DEFAULT nextval('public.devices_id_seq'::regclass);
 <   ALTER TABLE public.devicesold ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            �
           2604    24878    software id    DEFAULT     j   ALTER TABLE ONLY public.software ALTER COLUMN id SET DEFAULT nextval('public.software_id_seq'::regclass);
 :   ALTER TABLE public.software ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    213    214            �
           2604    24738 
   systems id    DEFAULT     h   ALTER TABLE ONLY public.systems ALTER COLUMN id SET DEFAULT nextval('public.systems_id_seq'::regclass);
 9   ALTER TABLE public.systems ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    205    206            �
           2606    24797    data_climate data_climate_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.data_climate
    ADD CONSTRAINT data_climate_pk PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.data_climate DROP CONSTRAINT data_climate_pk;
       public            postgres    false    208            �
           2606    24809    data_energy data_energy_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.data_energy
    ADD CONSTRAINT data_energy_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.data_energy DROP CONSTRAINT data_energy_pk;
       public            postgres    false    210            �
           2606    16536    devicesold devices_pk 
   CONSTRAINT     S   ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT devices_pk PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.devicesold DROP CONSTRAINT devices_pk;
       public            postgres    false    203            �
           2606    24932 .   flyway_schema_history flyway_schema_history_pk 
   CONSTRAINT     x   ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);
 X   ALTER TABLE ONLY public.flyway_schema_history DROP CONSTRAINT flyway_schema_history_pk;
       public            postgres    false    215            �
           2606    24884    software software_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.software DROP CONSTRAINT software_pk;
       public            postgres    false    214            �
           2606    24744    systems systems_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.systems DROP CONSTRAINT systems_pk;
       public            postgres    false    206            �
           2606    24705 '   devicesold uk_hvjuc0g18nw202rcchri2a2so 
   CONSTRAINT     j   ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT uk_hvjuc0g18nw202rcchri2a2so UNIQUE (device_hw_id);
 Q   ALTER TABLE ONLY public.devicesold DROP CONSTRAINT uk_hvjuc0g18nw202rcchri2a2so;
       public            postgres    false    203            �
           1259    24795    data_climate_id_uindex    INDEX     T   CREATE UNIQUE INDEX data_climate_id_uindex ON public.data_climate USING btree (id);
 *   DROP INDEX public.data_climate_id_uindex;
       public            postgres    false    208            �
           1259    24807    data_energy_id_uindex    INDEX     R   CREATE UNIQUE INDEX data_energy_id_uindex ON public.data_energy USING btree (id);
 )   DROP INDEX public.data_energy_id_uindex;
       public            postgres    false    210            �
           1259    25013    data_geo_id_uindex    INDEX     L   CREATE UNIQUE INDEX data_geo_id_uindex ON public.data_geo USING btree (id);
 &   DROP INDEX public.data_geo_id_uindex;
       public            postgres    false    217            �
           1259    25005    data_rssi_id_uindex    INDEX     N   CREATE UNIQUE INDEX data_rssi_id_uindex ON public.data_rssi USING btree (id);
 '   DROP INDEX public.data_rssi_id_uindex;
       public            postgres    false    216            �
           1259    16553    devices_device_hw_id_uindex    INDEX     a   CREATE UNIQUE INDEX devices_device_hw_id_uindex ON public.devicesold USING btree (device_hw_id);
 /   DROP INDEX public.devices_device_hw_id_uindex;
       public            postgres    false    203            �
           1259    24866    devices_device_uid_uindex    INDEX     Z   CREATE UNIQUE INDEX devices_device_uid_uindex ON public.devices USING btree (device_uid);
 -   DROP INDEX public.devices_device_uid_uindex;
       public            postgres    false    212            �
           1259    16534    devices_id_uindex    INDEX     M   CREATE UNIQUE INDEX devices_id_uindex ON public.devicesold USING btree (id);
 %   DROP INDEX public.devices_id_uindex;
       public            postgres    false    203            �
           1259    24933    flyway_schema_history_s_idx    INDEX     `   CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);
 /   DROP INDEX public.flyway_schema_history_s_idx;
       public            postgres    false    215            �
           1259    24882    software_id_uindex    INDEX     L   CREATE UNIQUE INDEX software_id_uindex ON public.software USING btree (id);
 &   DROP INDEX public.software_id_uindex;
       public            postgres    false    214            �
           1259    24742    systems_id_uindex    INDEX     J   CREATE UNIQUE INDEX systems_id_uindex ON public.systems USING btree (id);
 %   DROP INDEX public.systems_id_uindex;
       public            postgres    false    206            �
           1259    24774    systems_system_id_uindex    INDEX     X   CREATE UNIQUE INDEX systems_system_id_uindex ON public.systems USING btree (system_id);
 ,   DROP INDEX public.systems_system_id_uindex;
       public            postgres    false    206            �
           1259    24853    table_name_id_uindex    INDEX     M   CREATE UNIQUE INDEX table_name_id_uindex ON public.devices USING btree (id);
 (   DROP INDEX public.table_name_id_uindex;
       public            postgres    false    212            �
           2606    24867 $   devices devices_systems_system_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_systems_system_id_fk FOREIGN KEY (system_id) REFERENCES public.systems(system_id);
 N   ALTER TABLE ONLY public.devices DROP CONSTRAINT devices_systems_system_id_fk;
       public          postgres    false    206    212    2768            �
           2606    24780    devicesold devices_train_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT devices_train_fk FOREIGN KEY (train_id) REFERENCES public.systems(system_id);
 E   ALTER TABLE ONLY public.devicesold DROP CONSTRAINT devices_train_fk;
       public          postgres    false    2768    206    203            �
           2606    24728 &   devicesold fkhrh1srvv6t1ikm0293ej4j3a0    FK CONSTRAINT     �   ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT fkhrh1srvv6t1ikm0293ej4j3a0 FOREIGN KEY (device_hw_head_id) REFERENCES public.devicesold(device_hw_id);
 P   ALTER TABLE ONLY public.devicesold DROP CONSTRAINT fkhrh1srvv6t1ikm0293ej4j3a0;
       public          postgres    false    203    203    2759           