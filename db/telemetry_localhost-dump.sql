PGDMP         *                x         	   telemetry    12.1    12.1 F    g           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            h           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            i           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            j           1262    16512 	   telemetry    DATABASE     �   CREATE DATABASE telemetry WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE telemetry;
                postgres    false            �            1259    24788    data_climate    TABLE     �  CREATE TABLE public.data_climate (
    id integer NOT NULL,
    order_num integer,
    uid text,
    id_train integer,
    car_number integer,
    receiver_code integer,
    device_type integer,
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
       public          postgres    false    210            k           0    0    data_climate_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.data_climate_id_seq OWNED BY public.data_climate.id;
          public          postgres    false    209            �            1259    24800    data_energy    TABLE     �  CREATE TABLE public.data_energy (
    id integer NOT NULL,
    order_num integer,
    uid text,
    id_train integer,
    car_number integer,
    receiver_code integer,
    device_type integer,
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
       public          postgres    false    212            l           0    0    data_energy_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.data_energy_id_seq OWNED BY public.data_energy.id;
          public          postgres    false    211            �            1259    24849    devices    TABLE     >  CREATE TABLE public.devices (
    id integer NOT NULL,
    device_uid text,
    system_id integer,
    hw integer,
    sw integer,
    config_link integer,
    type integer DEFAULT 0,
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
       public          postgres    false    205            m           0    0    devices_id_seq    SEQUENCE OWNED BY     D   ALTER SEQUENCE public.devices_id_seq OWNED BY public.devicesold.id;
          public          postgres    false    204            �            1259    24708    hibernate_sequence    SEQUENCE     {   CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hibernate_sequence;
       public          postgres    false            �            1259    16515    measures    TABLE     0  CREATE TABLE public.measures (
    id integer NOT NULL,
    system_id integer,
    coordinates text,
    date date,
    rssi integer,
    status integer,
    hw_ver integer,
    sw_ver integer,
    device_hw_id integer,
    time_day time without time zone,
    temp1 double precision,
    temp2 double precision,
    temp3 double precision,
    temp4 double precision,
    temp5 double precision,
    speed double precision,
    amperage double precision,
    voltage double precision,
    dategsm character varying(255),
    timegsm character varying(255)
);
    DROP TABLE public.measures;
       public         heap    postgres    false            �            1259    16513    measures_id_seq    SEQUENCE     �   CREATE SEQUENCE public.measures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.measures_id_seq;
       public          postgres    false    203            n           0    0    measures_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.measures_id_seq OWNED BY public.measures.id;
          public          postgres    false    202            �            1259    24875    software    TABLE     �   CREATE TABLE public.software (
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
       public          postgres    false    216            o           0    0    software_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.software_id_seq OWNED BY public.software.id;
          public          postgres    false    215            �            1259    24735    systems    TABLE     �   CREATE TABLE public.systems (
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
       public          postgres    false    208            p           0    0    systems_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.systems_id_seq OWNED BY public.systems.id;
          public          postgres    false    207            �            1259    24847    table_name_id_seq    SEQUENCE     �   CREATE SEQUENCE public.table_name_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.table_name_id_seq;
       public          postgres    false    214            q           0    0    table_name_id_seq    SEQUENCE OWNED BY     D   ALTER SEQUENCE public.table_name_id_seq OWNED BY public.devices.id;
          public          postgres    false    213            �
           2604    24791    data_climate id    DEFAULT     r   ALTER TABLE ONLY public.data_climate ALTER COLUMN id SET DEFAULT nextval('public.data_climate_id_seq'::regclass);
 >   ALTER TABLE public.data_climate ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    209    210            �
           2604    24803    data_energy id    DEFAULT     p   ALTER TABLE ONLY public.data_energy ALTER COLUMN id SET DEFAULT nextval('public.data_energy_id_seq'::regclass);
 =   ALTER TABLE public.data_energy ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    212    212            �
           2604    24852 
   devices id    DEFAULT     k   ALTER TABLE ONLY public.devices ALTER COLUMN id SET DEFAULT nextval('public.table_name_id_seq'::regclass);
 9   ALTER TABLE public.devices ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    214    214            �
           2604    16530    devicesold id    DEFAULT     k   ALTER TABLE ONLY public.devicesold ALTER COLUMN id SET DEFAULT nextval('public.devices_id_seq'::regclass);
 <   ALTER TABLE public.devicesold ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    205    205            �
           2604    16518    measures id    DEFAULT     j   ALTER TABLE ONLY public.measures ALTER COLUMN id SET DEFAULT nextval('public.measures_id_seq'::regclass);
 :   ALTER TABLE public.measures ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203            �
           2604    24878    software id    DEFAULT     j   ALTER TABLE ONLY public.software ALTER COLUMN id SET DEFAULT nextval('public.software_id_seq'::regclass);
 :   ALTER TABLE public.software ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            �
           2604    24738 
   systems id    DEFAULT     h   ALTER TABLE ONLY public.systems ALTER COLUMN id SET DEFAULT nextval('public.systems_id_seq'::regclass);
 9   ALTER TABLE public.systems ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    208    208            ^          0    24788    data_climate 
   TABLE DATA           �   COPY public.data_climate (id, order_num, uid, id_train, car_number, receiver_code, device_type, command_type, "time", channel_1, channel_2, channel_3, channel_4, time_received) FROM stdin;
    public          postgres    false    210   �S       `          0    24800    data_energy 
   TABLE DATA           �   COPY public.data_energy (id, order_num, uid, id_train, car_number, receiver_code, device_type, command_type, "time", amperage, voltage, energy_active, energy_passive, time_received) FROM stdin;
    public          postgres    false    212   >T       b          0    24849    devices 
   TABLE DATA           {   COPY public.devices (id, device_uid, system_id, hw, sw, config_link, type, car_number, name, sw_link, updates) FROM stdin;
    public          postgres    false    214   �T       Y          0    16527 
   devicesold 
   TABLE DATA           �   COPY public.devicesold (id, device_hw_id, device_hw_head_id, hw_ver, sw_ver, config_link, train_id, type, car_number, device_head_id, name) FROM stdin;
    public          postgres    false    205   BU       W          0    16515    measures 
   TABLE DATA           �   COPY public.measures (id, system_id, coordinates, date, rssi, status, hw_ver, sw_ver, device_hw_id, time_day, temp1, temp2, temp3, temp4, temp5, speed, amperage, voltage, dategsm, timegsm) FROM stdin;
    public          postgres    false    203   CV       d          0    24875    software 
   TABLE DATA           S   COPY public.software (id, filename, version, path, actual, link, size) FROM stdin;
    public          postgres    false    216   �V       \          0    24735    systems 
   TABLE DATA           m   COPY public.systems (id, train_type, train_number, system_id, status, car_count, head_device_id) FROM stdin;
    public          postgres    false    208   �V       r           0    0    data_climate_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.data_climate_id_seq', 1, false);
          public          postgres    false    209            s           0    0    data_energy_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.data_energy_id_seq', 1, false);
          public          postgres    false    211            t           0    0    devices_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.devices_id_seq', 6, true);
          public          postgres    false    204            u           0    0    hibernate_sequence    SEQUENCE SET     A   SELECT pg_catalog.setval('public.hibernate_sequence', 78, true);
          public          postgres    false    206            v           0    0    measures_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.measures_id_seq', 16, true);
          public          postgres    false    202            w           0    0    software_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.software_id_seq', 1, false);
          public          postgres    false    215            x           0    0    systems_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.systems_id_seq', 5, false);
          public          postgres    false    207            y           0    0    table_name_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.table_name_id_seq', 1, true);
          public          postgres    false    213            �
           2606    24797    data_climate data_climate_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.data_climate
    ADD CONSTRAINT data_climate_pk PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.data_climate DROP CONSTRAINT data_climate_pk;
       public            postgres    false    210            �
           2606    24809    data_energy data_energy_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.data_energy
    ADD CONSTRAINT data_energy_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.data_energy DROP CONSTRAINT data_energy_pk;
       public            postgres    false    212            �
           2606    16536    devicesold devices_pk 
   CONSTRAINT     S   ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT devices_pk PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.devicesold DROP CONSTRAINT devices_pk;
       public            postgres    false    205            �
           2606    16524    measures measures_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.measures
    ADD CONSTRAINT measures_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.measures DROP CONSTRAINT measures_pk;
       public            postgres    false    203            �
           2606    24884    software software_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.software DROP CONSTRAINT software_pk;
       public            postgres    false    216            �
           2606    24744    systems systems_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.systems DROP CONSTRAINT systems_pk;
       public            postgres    false    208            �
           2606    24705 '   devicesold uk_hvjuc0g18nw202rcchri2a2so 
   CONSTRAINT     j   ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT uk_hvjuc0g18nw202rcchri2a2so UNIQUE (device_hw_id);
 Q   ALTER TABLE ONLY public.devicesold DROP CONSTRAINT uk_hvjuc0g18nw202rcchri2a2so;
       public            postgres    false    205            �
           1259    24795    data_climate_id_uindex    INDEX     T   CREATE UNIQUE INDEX data_climate_id_uindex ON public.data_climate USING btree (id);
 *   DROP INDEX public.data_climate_id_uindex;
       public            postgres    false    210            �
           1259    24807    data_energy_id_uindex    INDEX     R   CREATE UNIQUE INDEX data_energy_id_uindex ON public.data_energy USING btree (id);
 )   DROP INDEX public.data_energy_id_uindex;
       public            postgres    false    212            �
           1259    16553    devices_device_hw_id_uindex    INDEX     a   CREATE UNIQUE INDEX devices_device_hw_id_uindex ON public.devicesold USING btree (device_hw_id);
 /   DROP INDEX public.devices_device_hw_id_uindex;
       public            postgres    false    205            �
           1259    24866    devices_device_uid_uindex    INDEX     Z   CREATE UNIQUE INDEX devices_device_uid_uindex ON public.devices USING btree (device_uid);
 -   DROP INDEX public.devices_device_uid_uindex;
       public            postgres    false    214            �
           1259    16534    devices_id_uindex    INDEX     M   CREATE UNIQUE INDEX devices_id_uindex ON public.devicesold USING btree (id);
 %   DROP INDEX public.devices_id_uindex;
       public            postgres    false    205            �
           1259    16522    measures_id_uindex    INDEX     L   CREATE UNIQUE INDEX measures_id_uindex ON public.measures USING btree (id);
 &   DROP INDEX public.measures_id_uindex;
       public            postgres    false    203            �
           1259    24882    software_id_uindex    INDEX     L   CREATE UNIQUE INDEX software_id_uindex ON public.software USING btree (id);
 &   DROP INDEX public.software_id_uindex;
       public            postgres    false    216            �
           1259    24742    systems_id_uindex    INDEX     J   CREATE UNIQUE INDEX systems_id_uindex ON public.systems USING btree (id);
 %   DROP INDEX public.systems_id_uindex;
       public            postgres    false    208            �
           1259    24774    systems_system_id_uindex    INDEX     X   CREATE UNIQUE INDEX systems_system_id_uindex ON public.systems USING btree (system_id);
 ,   DROP INDEX public.systems_system_id_uindex;
       public            postgres    false    208            �
           1259    24853    table_name_id_uindex    INDEX     M   CREATE UNIQUE INDEX table_name_id_uindex ON public.devices USING btree (id);
 (   DROP INDEX public.table_name_id_uindex;
       public            postgres    false    214            �
           2606    24867 $   devices devices_systems_system_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_systems_system_id_fk FOREIGN KEY (system_id) REFERENCES public.systems(system_id);
 N   ALTER TABLE ONLY public.devices DROP CONSTRAINT devices_systems_system_id_fk;
       public          postgres    false    208    2759    214            �
           2606    24780    devicesold devices_train_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT devices_train_fk FOREIGN KEY (train_id) REFERENCES public.systems(system_id);
 E   ALTER TABLE ONLY public.devicesold DROP CONSTRAINT devices_train_fk;
       public          postgres    false    205    208    2759            �
           2606    24710 $   measures fke542pg0echtc7ey5to0r693cl    FK CONSTRAINT     �   ALTER TABLE ONLY public.measures
    ADD CONSTRAINT fke542pg0echtc7ey5to0r693cl FOREIGN KEY (device_hw_id) REFERENCES public.devicesold(device_hw_id);
 N   ALTER TABLE ONLY public.measures DROP CONSTRAINT fke542pg0echtc7ey5to0r693cl;
       public          postgres    false    2750    205    203            �
           2606    24728 &   devicesold fkhrh1srvv6t1ikm0293ej4j3a0    FK CONSTRAINT     �   ALTER TABLE ONLY public.devicesold
    ADD CONSTRAINT fkhrh1srvv6t1ikm0293ej4j3a0 FOREIGN KEY (device_hw_head_id) REFERENCES public.devicesold(device_hw_id);
 P   ALTER TABLE ONLY public.devicesold DROP CONSTRAINT fkhrh1srvv6t1ikm0293ej4j3a0;
       public          postgres    false    2750    205    205            �
           2606    24775    measures measures_system_if_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.measures
    ADD CONSTRAINT measures_system_if_fk FOREIGN KEY (system_id) REFERENCES public.systems(system_id);
 H   ALTER TABLE ONLY public.measures DROP CONSTRAINT measures_system_if_fk;
       public          postgres    false    2759    208    203            ^   R   x�����0��,�v���L��� 	

*��NW\
�w2���ކ*�B��hl���T�紫%��:$��epR?�k��a      `   �   x��ұ�0��M��{ @HCd�?G�%wN.�h�w�1M'@;`�^��( ;H �`��� �M� V��!L���ޗu�8d�_˖��0g�/�����*xT�Q�"�Q�8�w�|��T������{9�������5�+˵��*˽�|T�Ge�����)ޟ��7��|      b   3   x�3�4001600�00��!,NNCN#NN��in�Y����� )	=      Y   �   x���M��0���a���4�Ĝ�m�EQP�s.D��.9�iZ�DCi��^*@������ݾ=��]�[V�O��F��*��V�G|�ÐU���98>N�\Pz��/>��8@�~��픎�>�C�������!5��"��D��4�dCQ�L�S��M@꾥�(������Uu?4�w�,[���y��g���|�|�
�^hU瞉�[V5��W?Ƙu��      W   J   x�5���0�7�%6��2D'��s�yT�B\ܘ�D��H&;ճ�?҃�
-�EB0�">Y�$u�Cvۣ���L�      d      x������ � �      \   e   x�E̱�0Eњ��I�N�X���.IHa��>L�͇s'wf9]g�&'!��o0w�
��ZV�{-]���a�g!�+� ��>��F�&^G)�i�&�     