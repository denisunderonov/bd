PGDMP  '                    |            courseDB    16.3    16.2 1    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16642    courseDB    DATABASE     ~   CREATE DATABASE "courseDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "courseDB";
                postgres    false            �            1259    16667    animes    TABLE        CREATE TABLE public.animes (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    duration integer,
    genres character varying(255),
    year integer,
    rating numeric(3,2),
    url text,
    seasons integer
);
    DROP TABLE public.animes;
       public         heap    postgres    false            �            1259    16666    animes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.animes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.animes_id_seq;
       public          postgres    false    220            �           0    0    animes_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.animes_id_seq OWNED BY public.animes.id;
          public          postgres    false    219            �            1259    16658    movies    TABLE     �   CREATE TABLE public.movies (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    duration integer,
    genres character varying(255),
    year integer,
    rating numeric(3,2),
    url text
);
    DROP TABLE public.movies;
       public         heap    postgres    false            �            1259    16657    movies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.movies_id_seq;
       public          postgres    false    218            �           0    0    movies_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;
          public          postgres    false    217            �            1259    24590    recommendations    TABLE     �   CREATE TABLE public.recommendations (
    user_id integer NOT NULL,
    films_rec text,
    series_rec text,
    animes_rec text
);
 #   DROP TABLE public.recommendations;
       public         heap    postgres    false            �            1259    16676    series    TABLE        CREATE TABLE public.series (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    duration integer,
    genres character varying(255),
    year integer,
    rating numeric(3,2),
    url text,
    seasons integer
);
    DROP TABLE public.series;
       public         heap    postgres    false            �            1259    16675    series_id_seq    SEQUENCE     �   CREATE SEQUENCE public.series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.series_id_seq;
       public          postgres    false    222            �           0    0    series_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.series_id_seq OWNED BY public.series.id;
          public          postgres    false    221            �            1259    16644    users    TABLE     C  CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    favourites jsonb
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16643    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    216            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    215            �            1259    24603    watched    TABLE     �   CREATE TABLE public.watched (
    id integer NOT NULL,
    user_id integer NOT NULL,
    series_id integer,
    movie_id integer,
    anime_id integer,
    watched_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.watched;
       public         heap    postgres    false            �            1259    24602    watched_id_seq    SEQUENCE     �   CREATE SEQUENCE public.watched_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.watched_id_seq;
       public          postgres    false    225            �           0    0    watched_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.watched_id_seq OWNED BY public.watched.id;
          public          postgres    false    224            6           2604    16670 	   animes id    DEFAULT     f   ALTER TABLE ONLY public.animes ALTER COLUMN id SET DEFAULT nextval('public.animes_id_seq'::regclass);
 8   ALTER TABLE public.animes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            5           2604    16661 	   movies id    DEFAULT     f   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            7           2604    16679 	   series id    DEFAULT     f   ALTER TABLE ONLY public.series ALTER COLUMN id SET DEFAULT nextval('public.series_id_seq'::regclass);
 8   ALTER TABLE public.series ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            2           2604    16647    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            8           2604    24606 
   watched id    DEFAULT     h   ALTER TABLE ONLY public.watched ALTER COLUMN id SET DEFAULT nextval('public.watched_id_seq'::regclass);
 9   ALTER TABLE public.watched ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �          0    16667    animes 
   TABLE DATA           f   COPY public.animes (id, title, description, duration, genres, year, rating, url, seasons) FROM stdin;
    public          postgres    false    220   �7       �          0    16658    movies 
   TABLE DATA           ]   COPY public.movies (id, title, description, duration, genres, year, rating, url) FROM stdin;
    public          postgres    false    218   >       �          0    24590    recommendations 
   TABLE DATA           U   COPY public.recommendations (user_id, films_rec, series_rec, animes_rec) FROM stdin;
    public          postgres    false    223   �c       �          0    16676    series 
   TABLE DATA           f   COPY public.series (id, title, description, duration, genres, year, rating, url, seasons) FROM stdin;
    public          postgres    false    222   sd       �          0    16644    users 
   TABLE DATA           d   COPY public.users (id, login, email, password_hash, created_at, updated_at, favourites) FROM stdin;
    public          postgres    false    216   E�       �          0    24603    watched 
   TABLE DATA           [   COPY public.watched (id, user_id, series_id, movie_id, anime_id, watched_date) FROM stdin;
    public          postgres    false    225   }�       �           0    0    animes_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.animes_id_seq', 7, true);
          public          postgres    false    219            �           0    0    movies_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.movies_id_seq', 17, true);
          public          postgres    false    217            �           0    0    series_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.series_id_seq', 9, true);
          public          postgres    false    221            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
          public          postgres    false    215            �           0    0    watched_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.watched_id_seq', 26, true);
          public          postgres    false    224            C           2606    16674    animes animes_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.animes
    ADD CONSTRAINT animes_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.animes DROP CONSTRAINT animes_pkey;
       public            postgres    false    220            A           2606    16665    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            postgres    false    218            G           2606    24596 $   recommendations recommendations_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (user_id);
 N   ALTER TABLE ONLY public.recommendations DROP CONSTRAINT recommendations_pkey;
       public            postgres    false    223            E           2606    16683    series series_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.series DROP CONSTRAINT series_pkey;
       public            postgres    false    222            ;           2606    16655    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    216            =           2606    16653    users users_login_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_login_key;
       public            postgres    false    216            ?           2606    16651    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            I           2606    24609    watched watched_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.watched
    ADD CONSTRAINT watched_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.watched DROP CONSTRAINT watched_pkey;
       public            postgres    false    225            J           2606    24597 ,   recommendations recommendations_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 V   ALTER TABLE ONLY public.recommendations DROP CONSTRAINT recommendations_user_id_fkey;
       public          postgres    false    4671    216    223            K           2606    24625    watched watched_anime_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.watched
    ADD CONSTRAINT watched_anime_id_fkey FOREIGN KEY (anime_id) REFERENCES public.animes(id);
 G   ALTER TABLE ONLY public.watched DROP CONSTRAINT watched_anime_id_fkey;
       public          postgres    false    220    225    4675            L           2606    24620    watched watched_movie_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.watched
    ADD CONSTRAINT watched_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 G   ALTER TABLE ONLY public.watched DROP CONSTRAINT watched_movie_id_fkey;
       public          postgres    false    225    4673    218            M           2606    24615    watched watched_series_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.watched
    ADD CONSTRAINT watched_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.series(id);
 H   ALTER TABLE ONLY public.watched DROP CONSTRAINT watched_series_id_fkey;
       public          postgres    false    222    225    4677            N           2606    24610    watched watched_user_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.watched
    ADD CONSTRAINT watched_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 F   ALTER TABLE ONLY public.watched DROP CONSTRAINT watched_user_id_fkey;
       public          postgres    false    216    4671    225            �   o  x��W�n�V|���`H�$Rv���P��e�IQ7A� }�丱'N�[zG�破,Fԍ���?��,%Krb�����9{vggg��{�w]�F.��%���e�繷y�Y~���}������C�?s)��.ɻXv�&Xx�M�]��K|,����K}�Iܘ����6|������<g��2���i�����|�Ժ����9ޞ�.ON�A����k��|�܈q4��'�qC�}���w��^�Ǚ0�`I��R�;�
|�ÅC�E��g��]���a���3-�;��(��h�����wp6�
�R򪡗?�_0@x3���K�<e��{_L\�U+A��*mU�{�?|�Y�����A{�A��������f��l�k��{r����jX��V�O~���k������G������U݋j�J�a=K_=���U��I@�N����e~�Ry��t������<1��e#��k�Q@`#&�F�@���M�m�3,S s���'<d���p��W�4Qb����2V@=P�h#YΕR��L��� f�$%�����c�U	)U�p�=:���]��.�r3E�������e���6�߈�/h2>�?ՊN1֞�&�G8�3/�O3j�y`U�
V��Ua����ޫF�`��n�<��*�`�-�	��`z��q_9Nȋ"�)��w����	�6$.?v��W%��-t:/�b��e�Qp�i���i@�ѯ厥Oz+�p���"?�S���a�GzfT�>��X�
��ɢ��]h]j*�AA:���tn�8�*0�Q�&��7V�}�K��j)Z���Vt
�D�7�q��Wkx�@�aGټ��Yc���A��]���v�f��섍0��+��Qo4D�`�ɔ��������9�KHG�;D]Q�>"��@>���TB�ՔX۝�q��B���-��$⪌�hEs�+c��"P&���,��j]2���k]��"! 	�f9����SjX������v��ٖ"��9��]�Ƀ�H�L�f�b�X�_E����ODPG���1h"���"ĶB�y�ۼ���lo���nZa�U	�{�\kw{�֨A^���BϽ6%�HT7C�j�1���V�āߐ��x�_?K=�7v�'�q�P}X+�����%�/�5ؒ�3Sv�y��H_5��°.�@��ß���H�J-���`�o�͑��z!MK��'�y`zբS�ԫE�]v���(m�Q��J=��Z{Ͷ�'ڀ��D���W��:�Y�!4c}ݥ��K��^ C,d�7��ݴ<�;�xy&�}4׼���F9�F*�b�)vdl��i�lI���K�r�(aJ7X\4N5R���,}cY΀�L뺢�[o}��U�Lt7Y�bd(
b>�-&�e��Ɩ�j.���v_�$s���u���73��?�z7�جo�Za#j�P����5_�ñ�C	/B��{0���
����f�_�-�Mk�]��������6*�׼&Д�:���T��thɵ�f�Б���[c]'���#�.CQ��]nh�g��@N���]�$��6�e�~�hz��RE4�4U�z������/�H��oE����t�Z�5���a�Q=l4�!�ׂZ�h�_�666�a�h�      �      x��|َ�X��u�S�w6P����$j����(	�HI�(��(����tuU#�*]3m�h�=�3����2*###"�y��W�'��P
EfO��|U@e����������������p�y�2s�����ˇ�/�^�Q�(d��>�������;p�����m��������zx��O�����,8~����~w}���d�/2�����|�n���p�p��p|ΤD��� �<y��py���~\�1����fҮ?���^�/�}Q�`B��G����s<����k��9����+O�����-x
��Cc}��*�^���3��&��O����y:y2��֏P��q����Q��hn�#�_�s��������W.q7P@$��U����<#��x���1(ۻ��_�Q Q��
��]#Y�fo����A�WhzP��u��R���o~@:�w� s�������u:c�5����:���`A���^�����;�T+�%��4����#n����]j"W_d��@g�H/��/�o�� +A�S������
� vv����T_�Ot�Zi��	�0�:@f��-z��ȏH�H����� G���CC�#<ʸ<܇����
t
[��Ƞy^�a���Kd:���	<|䃞�}��ޟ�\����T�G�,>���"���G�3��?���?�!~��	h���kpt�����-U��Hʷج�@%����m	(��'��cjeW`���F�u����3�aQ��S=h"s��}����#�P� s�>����/`��F_�١F.2�ڀ8��s$T����a�@����,�4�(�"_���M�G������G����"��+l]~D�D7�#q_|����#��C|�F1�[��kh�$�G��H6��q_����o����c��z�ě�,n2�V�Z���3S�]|�ğvp�"	��i=�~���9h����G���={��ɳ�ZB�!�B�F�I���\�Z����7_��9��3���3�I�M�k?������\�a�laG�si;�gKg�|⬉��\�+7��8�)��YNz΍N4G$!�܈`�$I�;&(��E�d(zl=gHr�r䯤3`�0�_`7F+R+��PsPNg����Wh�@�N��-�?���0Z��{�ݩ��ӏ0t<|ł��;�. 6`���.�(!�PXE���O8v��s���-d�?�u�����Q��.s��a'#����.��dwǰ�����JQ|�S������-eh��6�95Rݠ��#S���h���ta�!Ƿ�O� C��+�n�>J���{�_����o�]�j��;l����p=x��o��V0��~��zz�/��Z�%�������7��L��H�/r*�Ɔ��Jܙ�L|t�G�	�g#/Z�B�<ȩ�D�d���Q�ӗv��u�!{�%c����e��ڬZaG�J�m>�ٙkhA��U���u;ynP�2��gl2Ç�>a�'���/�{o�J�:�Q����Q�YTh�<��/E9�*ҾV77R{��爚VG�zY���YP|w�̂]DZR�����[�T��]Z%�Q+���l˷��ؐ8>���l�hI�P�*���,�劧ܲ%:^3�9�r�����5���J�á�.�E��=�W�E�L'�����V��ߎ?U�ĬZqy/�kE{"��J��j�LI:ӱEw�����-T����bkR.V������JU��IQ�fl��F�F9��u������:ܰ�lX)�ۍ�i�P��E�%��+{��ki��"k���1���v���6[��b'�Vs�[ME��0������hr7o��T�<�LT�e�,���F��#{s/���&M�mj#m�9����aU�1!��^@��K?��YOc��`� ������l��D��ؚ�����p9=*Փ��/$I�4m��g*[cfF<�o��Z�,K���ncN�l6^�̱R�q����c����\k��^O�\S�e"βAX�-a�-�qy����g�>�TFŖY#ݐo���ߎw՞Umȋ~�W���zCI��]������˜��~������Nr�����\	zU�L�8�����l}� �^��V���r4��>#NtP�\wS�)���m[�p���.�{�Xo,�j֕\Mݫ�\�7��z(�m�/��<�^�UE%�	��)!����ܸW*h՜�n��|P��U�j�`&���ߪn�=o�z���ռc��%3�������ϙ�LK��]�+SuRr�f�b�vG�VJ�R�$�]���a�*�fZls!�������
�v���W�,W�d1�T�#�n�dV�84�ib���`ӕVmV�,��d���;LjK*bՎ�� L��q���TWz�����6�����|��S2����.6�����ߥd�_4�l/\֚&Yq��b��~Q�oU�քw{I����1S�f���#�o�9��:��ŗR^�n��z���&S�����E�VC}+.��n��h>i��j����8��f<�U۵��|P�7qu���Դ���uae�YP�Ț�w	�]�ױ�/H�Ѵ6��A�,ȫM�-Mw������W'�����ƕΈ�뤠Z���yӞC�\��)�H��* F�yԢ&�E5Qc���u٨T=��3�ԓ����B���s�6iڃ�8�m�ʸ��텧K�F�z�kZ9G��5���x[=KL��P*��WJJ�)�S�����;�K�l6̞���e_rG����}��'��c[��n��[��ݐ����pmIiʡ��.��Ɇ�vb��UԨ�K�|94K|i���~�Ok���[N�[tz|� F핕ma�O��@u�_
t^s�b�R����RޠFl��̈�LݹJ�2CnTK�DO����h�t&c�6vUU*f�ʨ��j4���ۄ�����3��Ԩ��:ʬ)udQ��v��v�0PwcSlS���u[����ۮt{:�,;Ui+UW}�N6�z<<�эJs���qܡ��ڻ��X(������O0��w�a��ݷ<�|<8�M����9��f��-Vƹ��n~F[�~?��3˭l=���{*�k䖹�AL �Ӽ%�>�e{%?���@��D�&�@��|��5�Ld���zD��ۤG52�*��[6*�*F�R�:~��n�ig�P�������a7Z�]�٤���̄*�\�C�3�B�R�F�b��]��g3]��;�	����rđ;I
�����'=���Rg�52��J~�{�����|��V��\�k���������ΌF���54�������m7��_���ْnh�^<mnȲ��O�uu%��*
9kU��BV�������JĤ*��>;i�'j���f�ӷf�FoVlk;��A��W�-QӍ(+M�s-�FՒgi5M�V*֬;���`�l���r�Qo{�f7z�UZ*Ni�	��VgU��m�]����l���`Pw��f4㩡x�}���!S�R���Cݗ�-����j�1���%zA�nΓk7�a�����޲��;�/5k8`���_\1�n-�4Du��E3��q�/;eZ�!�]���3iZ�oГX���R����%�m��s��󉿍����ǡ��ss�%n��vC;v]n�o�n����'j�	^��1�6<�[��mmEs��=]��!��T����B��=r��{;V[��M��5�dU���Vw���>?)�}Y�'�l<H�}}ش%b�+�Fe�#�y�טv޳�R�92��Խk�h=\�<ҍ�Em1���:XD"�S�"eL����bV��0��}�k�$�㈚��N��n�.�V�-'T���.o�7��A�6�̥_���i�mm?,�ɝ���%E��|5f�~�`�����!cGi�%�j^����x���WD���S��w0�H�C�����J[�E�J%�PV��M�@9��9�&׏y�z��;���%�NqI�n�Jf8��L�d�BQҶ�ӹ"�
��_C���5�d`������p%�\`�m&M�/��� `0����.�wޢl�ƻp�P���0�L�    .'�
�5Ȯ�$љc��.�	ڜ*%������rՏ҂p�A���x���ׇ	\ �B`�8�K0��C�P���������7��^�����1�\��XzF��m��#��W�9���*����:�Չi�M�5�ȚA.�B i�~���4��|q���B�=��œ$�
�Y�$Yڱ��%�)�0�$ �Ē�I���AQ����a�L���8Dj���S8���)OJPn�� %�U
a}��������i/�T�ª¹A�:?�tЧ8X�t�����>|�,s�?p��	�y�Z�#Ni���9�_����|��ܤ^��牵�R�CHo\V��SP��k��r�G���1x<�RW�"豧a�|�`<����}	�Xî����%�5��t���X�`䙀֑��28�"�<O�H��;T�;O�����^'e��%����!�\P��Qnht�b�MKp臠���#�{�5�b�h�Z��Q;7Oj}�jC�,�_��~���5�s��Dt׃��/�m+�wO���H⇓�v�bړX*��Q�iE�U+0j|	Ex�[�(y��A��!�w���I����1�H�/F�A�bx�zΏl��61�H�`�iBdL���1C���8�1\��K����:���O�+��Q�xt���"�d�]�5*)����ݿ���O��C|Df�-.$�C*��<��9X�~�k���t��x�ߠ�q8�#^z��W0���P��ʱL�˝�:�F.h�oO��&�����%��'�ǂɱ��^.�����T��;�Eev
��DQ8���\]����I�x��1=Z��$��װ�9����٤�*�~L��¿EP���o�_��?:�Oi�-^�/�~�Ru{\�P��p|�|�<}���3(��z���3(�^�"�i��+~�Ďv��o��3�n�X����[Mn^�W+��Õx<��*b��b"���x�P��PDB�N߃>-�a	`���s�˳3�CQV=��_Bx�����N���>����$�r�J_k8'���B -����sӱđ�+v�*�Q��>)j��jjI�j�*jc��0��ʮ���g �2Noc�J[֫K���Ia`P�\ح�I���V�Sl�Yl��|`+�`���z;�i0�%b�Z)�Ys�$�R��j´'�)#�RG_ɻ�L]�M�&��Z+!CSŤ:e;�pSZ�e��b����f��ǭ��vF���j.���g�Z+T^���J,gA��R����l5d�K܀��Y-�v#kT}wF��f��[f/Uݽ����ܒc�A�p��b�������1�������.�4mX;ɬ��5k�[�촓]փZ[Y��i4�~ɨkB$�����i�p���	����ʌ��˲�ąaw��JQMi-�P�rr�o+��R+�I7t�k���3���Q��t��t�]V�'A���v6�f���WӮ+=�Ϛƚ�j�IAw}+7b�Q�#V�6%�B�kG��A��5�^^.l�A�#̸]��3!tf_ڛ�I9h�ǔ��7��w缡zK�_j,WF>��X�l�c&��+S9��Tb�aA`��Y�l�[��������^�%U��x�+.y����Z�q�ZW� �W�i�e����c�r��֣tCX�j8��]��hv�I<۩�]�(�'-[�}!���]��҂�z���
����5���l4XC���R-���[�A-��F�Z���F�e���q����Rh���>�/}&��C��d�y�!*]qWʕ�~Ñ�+��������R)���V(������="��������
I��=J�7�&͸iy�`\�rC_��J鸳�S��A6W�Z�F�̰'��R�Ӗ�	EUrUm�f׫���Vɝ4�ͭt���STͦn�b���C=_�j�.��6����")LFTs@W�,��qNβ��zi;�Д���������MA���c�g��?Y:B�V��J~S٬y�]�%�JT)���~�q~���m`�;DUCQw��iE�IF%�>�}�0���Y5�kt��@��]ET݉���d��Z���o��h��ݪ��DI-��2;�k��-q���ub�^^~@�l{�W�I���Ᾱ�
ag����mH��5{Ӊ�~�0pJ�eYjb��\u����Hw�ds\V�Q��S�dZb�M�� �:��g��If�%��X���<���-�g�|�o.ڂ�H��qD�B�0l���ՠ4��b�%)��ZV��a;�Y�)�D8Z����s5ei{~,Ot���i?��͆R�Ǿ*�5�V%��b���^giw8��Ғ
;*XUl�jĜ?.�\sE�����X͈�Q|q�2�t��l��%_����jՀm*a 6�,�Jg9U��+�`2��d%n	J�TjAt<U��K �o7h��ĳ
z���FM�,�B`��Et=�j��8��{c��A7��|E�j����K�:��Q-��l�{y��nD
\�]�j���vcG):Q��\5�GtV��]��c�N�3��=#���nrto�ʜ�+r���V\��i��%^���["�(�Z����c���ܬ%W�:�Fq4.u����e��pJ?���aY��Ҋ!�n��������/���6�m����hS�z�DT��1�[c���+z֣��$_	�S���]-�+z�_�Vً��/UoПKInR��,�t猹�z>?�Y=�kq�MCP7���I�ܰ8�Q���x\g�y�%z<��}��8Y.V�,ͫ[�Kzv���\���zq�ۮ�����L��x��D�׋Ƹ�$KBb��6W,*���)��n8�-u;�"qo��֠<�)�Z��Ci��|��R3�zv�LeKK�P�7�GuE�-%MsP̫dTj�~P�/�Bݏ��ҙ��ަ����j���@�(7���F���W�]M^or;��%j�e;��ܪ��1��5)b��aUv�P(*�4� �-7�	]�V�����y�dM�Dߤim�^����+{/*�Ǵ���~���be�/DסLj��&�̴#	�D��(Ԙz+���`��)���2���;�ŉ.p� �D�ڗ&E�D�J���;;�\���TNu;lDi*�ũ���TV�A����i�%��EY+�#Y�r�aJ�14��t���ަVtM�2�u:~nD�=:�
�檩ѕR�����Q �*�tU���k{BMb�E�����!�Q�X���k�J����b�g�Y_3s=�o:%�[�V�y�䊓0;�$�z�6WT�5��ܜoI4튣�8XU蚼��V{M�T#)���+�q���t{�_�f��y����ˋ�j���zX�Ո���l��}�5����uca�[}K���*mF|G��:ב
���
�ͦ�f#oa�J}3�X~Fׄ�F�`�(�P&['oo�\}�o�ᶕ�=�E
Όؖ��~���6��x)��Ĳ���FQXN�Rs����;5Gئ>�t�)��tQ�ŎR�W�ɸI��X�Y�p��ւWP:���-���C�q���j��^3qn���1f��+�9��=��|�0�;"E�0܉�g��������+�q����G���t)���C������ ��χt�*=��N�~���#����S&*��P�Қ��4�"Ta:;ۿ͠l�����ߢ�0����
�H���m� �cZ���ÿ<�J��Ï���a�0;�H �.�ҿ�o��~L#�1u�{����>?�Uc�a�@��6�N����v�0m��0;�
�������Q���g��&��C,JHC�Ȕ��������]����#Ge�1���	��c�0�l���\��Sz���@�?>EY/��ש¿L��W����g���&�3�:^��<��jZ�q�'Ӂ�A����H��#c�=�>�����<x����9�[�@��
[�������G"'��.p����S����_>;�h��)$H��$ZN�HZ|��c��L�`%�&Xnd�46	��h��MQ�F�� {v���O\���o�x�nـ�o�����*��Qm�D�5�t����SU#"'F�>�P)\u�p�۔��)�?�" �  ��+�(b�X�)}�����������L�	�Fi���Ж�cS��rƄ��4��#�fv�������@�A���2^�x��̀Y�LW����%�;\e���/8���=��4r`]��p�(��W�՛[<B̥�AN���" �[�9׏�>G2!���/~�y�
M��4^�a)+�
�O���KW��s�n�֏wi<Em�O�i��mZj|�+���	��>s(ơKߧ��	�.S��ъ>"&���������_�r�ފ�@�]�X�C�-.�}LQ�#����p�E�zZ�Ð,���i�E��gp�[�ʟE��<�v��x�]�9�1�gN��xp�+\�9G} �ߤ\o�M���ZuRgIw0��/w�j�O7���L�{�s��!μ<�+�DXN�.����NǕ��qs��G�<5<4:��?�3�46��]�lVɎ[FƓ���%+I}_��~�{��|`K#"�9��H���4��B�]]]]]]]]]]]��ʟ��#"�a��%d����f� ��s���*�w�?��F��n
��8�~$�=�k��[L�;�mN?{�:�ԏ�=�Q���O�o���,�<�����\U|�I>|��zy �`l�:�߁�}�]a�񏏛}�O��}8ɿΟ�����C�Y�w�E��EJeF
 �~�9�z��RƯS���@�C���I8���>�<�q��p�>Q�Qp�P�>G�$ڀ�	��&^�y
��E�v�#i���@[=��ۏ��]���s��DA O�� 0=���H����
��O���.oS��O�b�x)�D��~ 3fO��ωJ���Ĭ�=تR��j��G�߆pr<i	�@Hxc9gD�cqD�4#	4#�c�~�܄����"4�"�����+�9�4ӧyD��J)~�?�HG
����WH����CO?��
'GG�7�#����O׀/�"�#��(ӧ�������S\|�u���#��*��~���>� )xs��.�M�}JZ��B~���E�y��<��͓/q��ħ���t񔟎i���'tϔԎ�u���o �gO���3x���<�4p�5�������C"@��)�s>G�دp��{��������xB���^_�����^���iE�����.�OQɓ�(G�Zfʸ���[���6��� �%f�f�'��c�n�5��@���r�	��9��p�īL���m�M�+�ş���9y�9POw�dҊ�Z���Z�+'��Z����]:x�E�%����	�k"?�!�YлO���'%�I��w����G}�\�V�?�>����gu��b��>-'}� �iu�*8�ԇ�ALg�3\VĵЇ����;0bK bY�%Q���3&r$4'� b�$��"C���8iD
"u����W��տ _�r      �   �   x�����0D��*R@��h�b D��'�X(˟�����$�v������3;�<�چ=(">�$�ٱG�r� k�0cԚW�Ŗj�(͓W�K5t�X�Ӛu�l��w�+�:E����7��r�iǝ�}�:�S      �      x��|َ�H���W�#)�b�(R��7 p7��(Jz�ȨܐY�Յ�FwWw�� Ӄ� ��@}��/���H�{�R� S/��.�hv�ڵk:��rr�������7O�/No>�y~��������������~{�����o�_��<�������p�����U�������;7��gׯo>��_�p����滛���|���Gz��]�;��4o��:����{0���O����Q��ǟ��ƽ�۽�{{��M>j�qn����yq1���)#��;0����Tp���*������|�p�W��`q~?���M~�2w�7�?�On���W�3����a���}����4����`��8308��x$o�\�U�O�y���~��8�}���h�e?o�1s���f/�Wr{��pM�!���|^�aO���+�M>�5��8���3�X�˼�ܒ���]���ј|V�� E |S�u
Wx	���N�^~]~� p�� ڟ�@/��9���~+�)����r��k�����}�_>����s�L
������|�O�|�r���0������@P�h�����	A���ϧ�i����y�/a�^��  w߂պ��C��I�	��؛M���O<���I<$N��dĪe>���'�9V�����`f�n)��'5n!�����~�E�� iU	ٵ��Q�b1�,���D#Q�U�O�r�ŃwዙiQ���6�̏4�C��HKI��,���T�Q�)��
		T���#��$6���jR㱬�^��8Q���h�c�ٯdu��|{���2���ZI����?h����hWW5��Ǉ��k����+5jo�樫%=Qi�}}H�hmki:�L����Z[bKMΚ��V;���f"�mf�$�D�f�6h5:��]�e�\�;I�"�w�
���U�B�Y��zk��z:Ȧ�8���v�f_����I�"��[aZ�4��`yF9mF�[��#Q�[�fc�f/w;���+U�A�Tvq;1���3FSvLSQ(�uA�f�Hͧ٦��-��&����zo6��̉�o�vW�%�d�e�{4OG�GS۱wI��"�h3�;"�.ۅ���uۨXfdvCtV�N#Hh�Ƈ��0a�HoM�^w�:l���R����-���D_v���h�(�v��v�T����v���fF��u��h4��=�qY�$���n��} U]pG�I"6�7��b�Z����$U��Co#(��UH��9����C��[JM$�bwI�f��k��͐����d���d`�n{&-ծ�Uvc�y���/S5�V3\�T����D �)�=d3��6���Vݞ�Ξ���mC����R��a��~�y���*b��SCV�����٪��+����x�,��`�� ���\襬��"Ӣj�x�1\	�P�gS���v�qR��o/+����v���?��l��<s��@���2���!yU����[=kIg�{��j'�PegS���i��q^�w��8\Up���ӑ�:CF��p��z���t��Rխ�$�C�3��bh7�?IjS�P�ɖ]+yJf�#WW�t�qf���V$�E�=��h��~�Cd�;������y֌2ty��%9`Ck0N	����&qz;wk��jWl#;4�����o&��o(%iJ1�����5�I&�d�3��d��mσT�Rq?��%�J����gD<�{�y+��26g�}�ݢ��Sɉ���x��d�dny�f^O�o�f��n��/S��D��D�[]�m���	�	�j�h��qɂ���R�5]k��,"��jg*l"��`;�I�X��I<ЧhHn0�蹙Ag.9��y���;��]�跶��ZBbe����J�d�rɵ��lW��F6�hr��k�Wk,Nc�x�N4#�.��w�͈У�$r��姑6,9>���&Co>P����ç�֧ٖ���I+&G��7�C>j�^s�.��e���S7;��N�2������BlK�s�!Bٱ��׷��°/�s��t7���UGI�ul���O+� O��-��獬�F|�6�a�n��x�n*m_TCv�����'7�$n�6��v��&��$COm�����fک�(��b9�y��03u_qH���?i��nR��$K�|��I�Ӯ?J�~#���W���C/φ����`��(���O�T�)F��A�m�a1AH;���^���(��Џ�q�u7f�R�2�&�N�_�J<!�E��z��r����Aw�]�8�g�;�K����#����kj[]T:��(��Dd1������d�Hf,d��]����	�ɨ�	���n��(�ϰA� ��)��n��ɦY�:�q��>?��Hq3ƽ�B���o�H+�r�]a�������d�-����bv�5?h�.�������3��M�QilKՑ��/W�
Σb���:�}�Z� �I�f�&�؞��[���#i�i|�oԙ榺1I�����{m6�6y���-�
�P�	sȫ�#��"#\]Ղ^��rLO��z��:3��=I�=l4��ȏ��ׇ��y�ͬ�L+�4(�����g^"S���u>!+�͎���0>��}�G��=�	U�zK���䠍I$�ac}'%6M�W�Y��Y{*�m��k9-��9�Id�������ӣ����]a��_ljcː��7Æ�EQ��&��灒&���E5��ɠ��w�ڷ�]��ԗ�̬���-ٔ��g
���6�*��^��bҟ�=�n3�#M̈�u˵�a5�n#AG�꼢�T�Ca�[=����V�>�pR���^��T�=���Xs���t��"��2��_������B��7����Deך)*�փ������<k����|c��ۅ��+�����V�1�{�`�;d�n
��V���nU��(��:����)UW� �V3��Uk�J=�&F����F�Mc=�9.�C٘4�	d��&18�x-L�:��۪Υ��b/r.h��J�I}՗����6]�R=$bC1+G�y���UK3��:H�J�VYl�J�^�]S���PMuI'�t8�pB��r��6�ݚ"�ݵ%ښ�������������7��������%��7��|���� �\�7�_�P��.���#$,�@������ rW��F]B�����d󦀥��P_@���3��U�?&p�i�z!2�1n� ! ����Q0�9c��~�xn���(
Z{��qy��$2�I�NR��F��'k#y�W}��A�d��B9�;}R!Ū�Кf`�DL���(D�P��:���1�Ew��0������ t�����\��+L�z
� ��-������`eʥν�Op�g����/s 	
ࡼO�����:�FX�7�q�L ��ѯ�Ŋ�B�zĞ���'�~�	�mo�$����C4�:�ܓ_���f���d�*���_$B�B��y���q�3����yD>-�hs~��ly���zW23��S�?]	�B������}���y�(�P/��?�s���Vp�C�2D��!���u�D�(��p������Ei�i9�/@��|]�PGb�EII���rU,.��Y�a���q�q~(G>�y~Ǆ� ���-�귐��m��%ܩ�
���}@� ��5\�˒�C�B"�m�R�9+v��eV�(Y�C�`�x
��s��7���-�Mɪ�,�x֬X���9$͞|�?qV�vf�}��|������E�*fUp�W���AB�
����p�MA�C(ov�H	}(y������NK��%���x>ڭ�B���o��E��*w�K��^�)�ßJ��(�g�+/��&~W������ �Aw�\���tc~�nH?I��l����V񣰻xrB2 �ޣ���L�&O�տ.��9�"�Op��� �n0��:�Vq!��^��DES��t[yD�\����҄ӟzw{�����Ų��)x�9�w�D����y�/��w��d:E`Z[��A�^A2���MG��l�G�R��yQ8��%��}�o�?����^��;��I�ŗ�L,    >�C^���,�%XH��_�[u�oo~�/�e����q���`f��<�v�Q�ϟ���_�7�0EZ�%���š��`t�?���.�x�o`|>����ȱ�Y��x��d�A��O���2����x0��
�����`ܗ0�� ����&�8�ߗI.7��}]��Ea�38�"忀��'9��@Jk\n�|���?��lI�� >��F�k�&���`���W >+���H��W�c�ɤ|��%<�
J�~���ha�����5=.V�-��Vߤ�|kSƙW�,����w���_Px3������{�g�!,T���H�IKx`�����q~`�����q~`����/0��u�c�D^��}��\���#�(�'��ppȝ�����II�}���E^B��|����'��"����\���!M�ٔ��o!}��'��#�Qķ���	.�� �=-9'@k�;��ܤ�+���~lzA���v��w_��$R�^��H�-_�4��_��~�H��Ξ�����$ ��r�/���$���F���� �q����}����}�!f�dP�W	�ϡ&�(e�O1]�c�~Dt�+����Dɑ-h�#�e{��r7_��PN�H��$ԍ������s(��6�-b3������k�@���E���pK��+�勒p��w���o���$7ny��˼��?+��B���?��^��o�ID�YI[�U��.�ۂ����ۍq|�V��{<�q-���˟<��Q����hԛϟ�`�I���a�Ar��ǧ?f�{g%_P���ǿ���"�O�����ޞ��7�Ic����ӡ�T��ʘ��9��~u��^l����,:A2ڷ;IM�{Λ.��A����D;��W��?�Sr��]c�q6�,ӕx�Ӵ4����A0Yn(u*���^o�|(�Y׫�	�8T%;^���9�4���F9��p=�!"?��I�����fC1�zӥю��kA,-ҽ�Zis�c}��2�����mۯ��+���ݞ��n]�F	Ô�W�E�&E⪼s�ڢìF�(e��1ͦ���6ƍ��.���j������MmfH��OdL��^���G�P���肠��`DǦ�qI0�4g��iU�ƴj�쁫/����Rs�ލP�IV�(�j�MYTF3ʬ�5J��Y��0�pQ"<�_�c��S���V���Z0��i������嗩�:T$nP�i�Y���ꍚk)��Hc�I�H5D?�?�3��d��ʞջ�u�8+����9q/�!Ag�طC�#j������j�H�롱�ۋ�'�~6_��a�U--=4������&7U��Q}70��H�!1��Զ���E�Sucfz=m�e�W"Z�0���fOV��.�Z۟̸f�;�ɭp�_6-c�X���!+���9{g5]vj�²n*�.4p�����d��2v���o�p%E�GV�4mF�f���J��t��lk�L��GC�=��m�����丳��8��F�+V:�G��ٴ�������1��i�FX�K�d��gp��T݈��X��v�L�ݪ��p�����8���Q3%�oMwͲ����=F�ۙ���I��H�Y�mCSlS]s�6���&�W-_�HN�}��Uf#y�nvZt�QÅ7I2;H�vߙ��6�F�h��֬?T|��t(eB�l�����b���I��w&خ"����H]�)�M.�.���[b<>�%zK�J[��1%͵^��w8U��;�
�	�5�d;1���l�l�i����0;�'yT��T���K#��4��5v�U(�Kq����Z�&B��b�?�����NkvHY6��<�	XfK���Md��O��*�ӧ��8�m� lN6tok��$��L͛7��RT\͕���V��~�$s���z�֩��2�����1�IOS/��m���M�W\�?�<_P�|��]١G�11�it�e��k�q�e�6��H���OۡUT��жF<c�U���cHK�iӇ�j^���EL��͞Z�D�F�;���b٫`eov�Jk�M�UL7]�hMb���I�8oմ�J\�v���f|��Z{�cYRo�,���[��	�U-hն㮤�c����Y�Qso�$ʺ߉0�D{>�����l�l�f�S_���N%�����zHV3�]�v�q�+�|&�Τ���U-��YcoO#[$-�g�l��Ά�W�C��8�r��7��N�[�֕$:b�V5��xb��̈́&MbX_ԛ.��~����?0~�fX���bG�2����S�]�T��F�>���J8�����نIG[j'u����޶��v��MdN�h�g���`�5�ǌ�W(���ȱ��L�m�^+U3��t��a�]i�љ�Ia��C�q�Q��=�G���m�i�F����Lcx��Y�ĳ�:ڇ��Z1�)���Q���U6u�F~��[�����_ΐ��Y�{�Y-����-I��4ŎT��D�IF���*�A��F5�=����ގ��Cy��vbE��Sf#�����+���ބ���̘?��Of�ݐ�U�8�zN-%/�eqU0XC�N[�x@�d��^�����5�9��t���=n����W��ik/�Y�p�	MMm���$5���û{�CP�`��0���BC�A~X�Q4Y�°�Xt$�\x�~��-��P���4�h���u�^#lC��oVɢL�Φ�C�J P�I��9q����0�mm*�[aSR����`�D�Վru!�m���s��b�vj�}�6�J�p����p��PRi8߄�z��4���=;]��T����b�����E�|�����N˜O���L;��;m���9^�m"F���!Eoq���T5^iөĨ�L"9K�7>�i���U:+���j����~M���p�.�l��I�	����K��z�!^���.BO~8Bi5"��5_�1����u�b��7��UK�~_��~�(5�Yf���ң=Us�b
��,M�n#T�2��W���i�W�Q#�}#5G�N`�J4�J�aZ��p^I[���M�m��b��x~:��`]�Zx@-�U2�{z�0#�^TG��!�=ͅ��-���i���caE�o������]�U뇶�.۝�E��p����tĹЙ�|!q7�P�95?����iF�Yeh�]�@�z{@J�]�T���>�O���	��o����"�[=������}	+>�; @���V��3 �N8�X��]��������xW�?4��Nq��r�����Pa����? �TT��UgP�sY�
�O~�����!:?�-q���	����7G��ݬ�/���WЖ|U��
��pM%�j��B�DTg���;���-X}z밋��������K�w5pq��<Ԟ��*
�����e��T�Vj�]|~��q�\����������\�r��x����~`��퓓L������O�ݗ������ꯎb����4N�'X�
'�<A8RUu!uehU'5J�������0�.�z�=��������[¨,>�Һ����_�������z��)y���%;Wh8A�|u��v̪́�(�*6\ɦ]������o��/8�w���ˢ�O��@MR,�r��ʫ���Q����.J�^�;��x�8�[�`=��sw<.�1h�|+w�S�O����>��_�]pU��XnT6��ڕ�=�R~����~�;өP�� ���bp\���~	���Z��@��
>��J���Sh��j2&F"�VA[�C�&B4J/uJ�hw�M?"N����/A���r�p�'�{"��B�Y��x�S���9R	���d*��,���ҭ`,�� $YP�z��fqN��?����5�ȍ��?��e����%!|q-�P�9��-?�% �@Ï�Pp�<7���GZ�B�
yʌ��g����E��g�OS�����`G��������P����e�00涳ǿ0>�߫�)A�e������ҡߜB���ǜ{��#p��1x�[_��R��EG�4�>j��ڰ�懟�2�n�N�'�߂����l��޸׍4>80*^K,)��s�!3S �  �7��;����TDfh4��Oҧ�Ӄ��A�� }z�>=H��Oҧ��_�>a�����Z���0�9�,�<{|�z�P�ăE�eQ���1�ŗ�4�k�*0���g���-̀|�ۢ8������,F�jP��W�ף����ٕ�����戇� t�����]�0��$�a	��i���_�R�,���0��Wx�l�R=+K�T���L*��/J��3�>��C���^�G �ߕZ�gPCp�׀p��>���R�s	�[�۾-�{]�]Xj�����P�a��Ut�K���K�?��,SK��(�</)��^E=αt�ww�U��?[!0;A��� A��M�?s�
R����Ŋ�.�H����gEiO	��A�h�"�5���G��G�(fY(�>�_pv�eJ�6��Wݾ�!��(��5�E���O�aP0?vQIY����E��*�R�UP�����h-*��:���ŐR�uYV��pW(Y��;�E���a��,�<��qg\_��m� LAd�0/O��J!����}OIxU����eg�:�#���qU��w/�<Rj���rK�J�������-�-7�K�-�8�>���'Bƾ�3{�wk�Z�+��S8�a��_�E��m�����K�{1������@�<!D��@�<!D��@�<!��ѯ�<z��� + �      �   (  x���Mo�@���
��ݝeAN[)�ڪ!�"˪��X,��4m�F�4s��{y2�˔P`���Oi,�,�^��r7O�Hd�F�F-�[a���jҵ��59�p�/,y���;t7���Q��xI9c��Q�b�ژ�14�f2݄���q��:*���K \76џ�qU.��`����I򲗯�n�T#⨩����~��*է_�716	7)Cs�w~
���\�.�ke�`R����<[겴�i�
����]����D;C,��thm�MB̚R�|+���r�Ey���      �   j   x�}���0DѳXE0��"J,"��:B�7'��3*c��}��~�<�_��(��RR�e��d-Rm�$8����eIj��O%�ql�ݿ~;|F�ӗ�d"� R%�     