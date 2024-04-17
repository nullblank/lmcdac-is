PGDMP  -        	            |            postgres     15.1 (Ubuntu 15.1-1.pgdg20.04+1)    16.2 K    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    5    postgres    DATABASE     p   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    4020            �           0    0    DATABASE postgres    ACL     2   GRANT ALL ON DATABASE postgres TO dashboard_user;
                   postgres    false    4020            �           0    0    postgres    DATABASE PROPERTIES     �   ALTER DATABASE postgres SET "app.settings.jwt_secret" TO 'your-super-secret-jwt-token-with-at-least-32-characters-long';
ALTER DATABASE postgres SET "app.settings.jwt_exp" TO '3600';
                     postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    16            �           0    0    SCHEMA public    ACL     �   GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;
                   pg_database_owner    false    16            m           1255    34789    handle_new_user()    FUNCTION        CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
begin
  insert into public.profiles (id, full_name, avatar_url)
  values (new.id, new.raw_user_meta_data->>'first_name', new.raw_user_meta_data->>'last_name');
  return new;
end;
$$;
 (   DROP FUNCTION public.handle_new_user();
       public          supabase_admin    false    16            �           0    0    FUNCTION handle_new_user()    ACL     �   GRANT ALL ON FUNCTION public.handle_new_user() TO postgres;
GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;
          public          supabase_admin    false    621            }           1259    34982    AppSheetSampe    TABLE     �   CREATE TABLE public."AppSheetSampe" (
    id text NOT NULL,
    name text NOT NULL,
    address text,
    "_RowNumber" smallint
);
 #   DROP TABLE public."AppSheetSampe";
       public         heap    supabase_admin    false    16            �           0    0    TABLE "AppSheetSampe"    ACL     �   GRANT ALL ON TABLE public."AppSheetSampe" TO postgres;
GRANT ALL ON TABLE public."AppSheetSampe" TO anon;
GRANT ALL ON TABLE public."AppSheetSampe" TO authenticated;
GRANT ALL ON TABLE public."AppSheetSampe" TO service_role;
          public          supabase_admin    false    381            t           1259    34838 
   activities    TABLE     �   CREATE TABLE public.activities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    cat_id uuid NOT NULL,
    "desc" text,
    is_archived boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.activities;
       public         heap    postgres    false    16            �           0    0    TABLE activities    COMMENT     4   COMMENT ON TABLE public.activities IS 'activities';
          public          postgres    false    372            �           0    0    TABLE activities    ACL     �   GRANT ALL ON TABLE public.activities TO anon;
GRANT ALL ON TABLE public.activities TO authenticated;
GRANT ALL ON TABLE public.activities TO service_role;
          public          postgres    false    372            u           1259    34846 
   categories    TABLE     �   CREATE TABLE public.categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "desc" text,
    is_archived boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.categories;
       public         heap    postgres    false    16            �           0    0    TABLE categories    COMMENT     =   COMMENT ON TABLE public.categories IS 'activity categories';
          public          postgres    false    373            �           0    0    TABLE categories    ACL     �   GRANT ALL ON TABLE public.categories TO anon;
GRANT ALL ON TABLE public.categories TO authenticated;
GRANT ALL ON TABLE public.categories TO service_role;
          public          postgres    false    373            v           1259    34854 
   department    TABLE     �   CREATE TABLE public.department (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    "desc" text
);
    DROP TABLE public.department;
       public         heap    postgres    false    16            �           0    0    TABLE department    COMMENT     <   COMMENT ON TABLE public.department IS 'Program Department';
          public          postgres    false    374            �           0    0    TABLE department    ACL     �   GRANT ALL ON TABLE public.department TO anon;
GRANT ALL ON TABLE public.department TO authenticated;
GRANT ALL ON TABLE public.department TO service_role;
          public          postgres    false    374            w           1259    34861    noi    TABLE     �   CREATE TABLE public.noi (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "desc" text,
    points real,
    is_archived boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.noi;
       public         heap    postgres    false    16            �           0    0 	   TABLE noi    COMMENT     8   COMMENT ON TABLE public.noi IS 'Nature of Involvement';
          public          postgres    false    375            �           0    0 	   TABLE noi    ACL     �   GRANT ALL ON TABLE public.noi TO anon;
GRANT ALL ON TABLE public.noi TO authenticated;
GRANT ALL ON TABLE public.noi TO service_role;
          public          postgres    false    375            x           1259    34869    office    TABLE     �   CREATE TABLE public.office (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    "desc" text,
    is_active boolean DEFAULT true
);
    DROP TABLE public.office;
       public         heap    postgres    false    16            �           0    0    TABLE office    ACL     �   GRANT ALL ON TABLE public.office TO anon;
GRANT ALL ON TABLE public.office TO authenticated;
GRANT ALL ON TABLE public.office TO service_role;
          public          postgres    false    376            y           1259    34877    participation    TABLE     �  CREATE TABLE public.participation (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id uuid DEFAULT auth.uid(),
    noi_id uuid,
    is_institutional boolean DEFAULT true,
    is_verified boolean DEFAULT false,
    schoolyear bigint,
    is_active boolean DEFAULT true,
    activity_id uuid,
    remarks text
);
 !   DROP TABLE public.participation;
       public         heap    postgres    false    16            �           0    0    TABLE participation    COMMENT     B   COMMENT ON TABLE public.participation IS 'participation records';
          public          postgres    false    377            �           0    0    TABLE participation    ACL     �   GRANT ALL ON TABLE public.participation TO anon;
GRANT ALL ON TABLE public.participation TO authenticated;
GRANT ALL ON TABLE public.participation TO service_role;
          public          postgres    false    377            z           1259    34888    roles    TABLE     �   CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    "desc" text,
    access_lvl bigint,
    is_active boolean DEFAULT true
);
    DROP TABLE public.roles;
       public         heap    postgres    false    16            �           0    0    TABLE roles    ACL     �   GRANT ALL ON TABLE public.roles TO anon;
GRANT ALL ON TABLE public.roles TO authenticated;
GRANT ALL ON TABLE public.roles TO service_role;
          public          postgres    false    378            {           1259    34896 
   schoolyear    TABLE     �   CREATE TABLE public.schoolyear (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    "desc" text,
    yearvalue bigint,
    is_active boolean DEFAULT false
);
    DROP TABLE public.schoolyear;
       public         heap    postgres    false    16            �           0    0    TABLE schoolyear    COMMENT     5   COMMENT ON TABLE public.schoolyear IS 'School year';
          public          postgres    false    379            �           0    0    TABLE schoolyear    ACL     �   GRANT ALL ON TABLE public.schoolyear TO anon;
GRANT ALL ON TABLE public.schoolyear TO authenticated;
GRANT ALL ON TABLE public.schoolyear TO service_role;
          public          postgres    false    379            |           1259    34904 	   user_logs    TABLE     E  CREATE TABLE public.user_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id uuid DEFAULT auth.uid(),
    action_short text DEFAULT '''Illegal Action'''::text,
    action_long text DEFAULT '''Illegal Action : WARNING! UNKNOWN ACTION!'''::text
);
    DROP TABLE public.user_logs;
       public         heap    postgres    false    16            �           0    0    TABLE user_logs    ACL     �   GRANT ALL ON TABLE public.user_logs TO anon;
GRANT ALL ON TABLE public.user_logs TO authenticated;
GRANT ALL ON TABLE public.user_logs TO service_role;
          public          postgres    false    380            �          0    34982    AppSheetSampe 
   TABLE DATA           J   COPY public."AppSheetSampe" (id, name, address, "_RowNumber") FROM stdin;
    public          supabase_admin    false    381   �]       �          0    34838 
   activities 
   TABLE DATA           Q   COPY public.activities (id, cat_id, "desc", is_archived, created_at) FROM stdin;
    public          postgres    false    372   1^       �          0    34846 
   categories 
   TABLE DATA           I   COPY public.categories (id, "desc", is_archived, created_at) FROM stdin;
    public          postgres    false    373   �d       �          0    34854 
   department 
   TABLE DATA           <   COPY public.department (id, created_at, "desc") FROM stdin;
    public          postgres    false    374   �f       �          0    34861    noi 
   TABLE DATA           J   COPY public.noi (id, "desc", points, is_archived, created_at) FROM stdin;
    public          postgres    false    375   �g       �          0    34869    office 
   TABLE DATA           C   COPY public.office (id, created_at, "desc", is_active) FROM stdin;
    public          postgres    false    376   �h       �          0    34877    participation 
   TABLE DATA           �   COPY public.participation (id, created_at, user_id, noi_id, is_institutional, is_verified, schoolyear, is_active, activity_id, remarks) FROM stdin;
    public          postgres    false    377   �i       �          0    34888    roles 
   TABLE DATA           N   COPY public.roles (id, created_at, "desc", access_lvl, is_active) FROM stdin;
    public          postgres    false    378   �j       �          0    34896 
   schoolyear 
   TABLE DATA           R   COPY public.schoolyear (id, created_at, "desc", yearvalue, is_active) FROM stdin;
    public          postgres    false    379   �k       �          0    34904 	   user_logs 
   TABLE DATA           W   COPY public.user_logs (id, created_at, user_id, action_short, action_long) FROM stdin;
    public          postgres    false    380   ol                  2606    34988     AppSheetSampe AppSheetSampe_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."AppSheetSampe"
    ADD CONSTRAINT "AppSheetSampe_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."AppSheetSampe" DROP CONSTRAINT "AppSheetSampe_pkey";
       public            supabase_admin    false    381            �           2606    34915    activities activities_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.activities DROP CONSTRAINT activities_pkey;
       public            postgres    false    372            �           2606    34917    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    373            �           2606    34919    department department_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.department DROP CONSTRAINT department_pkey;
       public            postgres    false    374            �           2606    34921    noi noi_pkey 
   CONSTRAINT     J   ALTER TABLE ONLY public.noi
    ADD CONSTRAINT noi_pkey PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.noi DROP CONSTRAINT noi_pkey;
       public            postgres    false    375            �           2606    34923    office office_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.office
    ADD CONSTRAINT office_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.office DROP CONSTRAINT office_pkey;
       public            postgres    false    376            �           2606    34925     participation participation_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.participation
    ADD CONSTRAINT participation_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.participation DROP CONSTRAINT participation_pkey;
       public            postgres    false    377            �           2606    34927    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    378            �           2606    34929    schoolyear schoolyear_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.schoolyear
    ADD CONSTRAINT schoolyear_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.schoolyear DROP CONSTRAINT schoolyear_pkey;
       public            postgres    false    379                        2606    34931    user_logs user_logs_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.user_logs
    ADD CONSTRAINT user_logs_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.user_logs DROP CONSTRAINT user_logs_pkey;
       public            postgres    false    380                       2606    35015 ,   participation participation_activity_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.participation
    ADD CONSTRAINT participation_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id);
 V   ALTER TABLE ONLY public.participation DROP CONSTRAINT participation_activity_id_fkey;
       public          postgres    false    3824    377    372                       2606    35010 '   participation participation_noi_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.participation
    ADD CONSTRAINT participation_noi_id_fkey FOREIGN KEY (noi_id) REFERENCES public.noi(id);
 Q   ALTER TABLE ONLY public.participation DROP CONSTRAINT participation_noi_id_fkey;
       public          postgres    false    377    375    3830                       2606    34932 (   activities public_activities_cat_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.activities
    ADD CONSTRAINT public_activities_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.activities DROP CONSTRAINT public_activities_cat_id_fkey;
       public          postgres    false    372    3826    373            �           3256    34952 4   user_logs Enable insert for authenticated users only    POLICY     ~   CREATE POLICY "Enable insert for authenticated users only" ON public.user_logs FOR INSERT TO authenticated WITH CHECK (true);
 N   DROP POLICY "Enable insert for authenticated users only" ON public.user_logs;
       public          postgres    false    380            �           3256    34953 +   activities Enable read access for all users    POLICY     _   CREATE POLICY "Enable read access for all users" ON public.activities FOR SELECT USING (true);
 E   DROP POLICY "Enable read access for all users" ON public.activities;
       public          postgres    false    372            �           3256    34954 +   categories Enable read access for all users    POLICY     _   CREATE POLICY "Enable read access for all users" ON public.categories FOR SELECT USING (true);
 E   DROP POLICY "Enable read access for all users" ON public.categories;
       public          postgres    false    373            �           3256    34955 +   department Enable read access for all users    POLICY     _   CREATE POLICY "Enable read access for all users" ON public.department FOR SELECT USING (true);
 E   DROP POLICY "Enable read access for all users" ON public.department;
       public          postgres    false    374            �           3256    34956 $   noi Enable read access for all users    POLICY     X   CREATE POLICY "Enable read access for all users" ON public.noi FOR SELECT USING (true);
 >   DROP POLICY "Enable read access for all users" ON public.noi;
       public          postgres    false    375            �           3256    34957 '   office Enable read access for all users    POLICY     [   CREATE POLICY "Enable read access for all users" ON public.office FOR SELECT USING (true);
 A   DROP POLICY "Enable read access for all users" ON public.office;
       public          postgres    false    376            �           3256    34958 .   participation Enable read access for all users    POLICY     g   CREATE POLICY "Enable read access for all users" ON public.participation FOR INSERT WITH CHECK (true);
 H   DROP POLICY "Enable read access for all users" ON public.participation;
       public          postgres    false    377            �           3256    34959 2   participation Enable read access for all users lol    POLICY     f   CREATE POLICY "Enable read access for all users lol" ON public.participation FOR SELECT USING (true);
 L   DROP POLICY "Enable read access for all users lol" ON public.participation;
       public          postgres    false    377            S
           826    16453     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;
          public          postgres    false    16            T
           826    16454     DEFAULT PRIVILEGES FOR SEQUENCES    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;
          public          supabase_admin    false    16            R
           826    16452     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;
          public          postgres    false    16            V
           826    16456     DEFAULT PRIVILEGES FOR FUNCTIONS    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;
          public          supabase_admin    false    16            Q
           826    16451    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     y  ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;
          public          postgres    false    16            U
           826    16455    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     �  ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;
          public          supabase_admin    false    16            �   8   x�3O14J304��H�����/�I���J141O3N6�t���,��,	��qqq c�H      �   �  x��W�n�}�����.�&�~�u��Qم������ђC;گϙ��]/�� ��̨�TթS��Y.�w4JƩ���M�U�yH��<ɦp��R%���%G�В;Ƽ�i��|�v�Y��릟ԉ`BQ&(��ə�3.��[f��؛�L�WXQT�Ĩ�SC�!(!呁/��nM�� �}�|�$��,ʪ��җͺiC�t�k���j�&�D(�F�J.T%Q�3��j%P�>��e��m�=��ݪ�m�
��m�7������)w^35`���ld�1�L�O��-FJf���\�Om��\�����av����)��2=֑�$Qo*�l��dC�5��\�6e�L�F�c��NC`�?�J)��VOn�w䲔ܴKr�閛�>�nfRM�Q��!zR4��H�H��h�@Gb`��Ĥ:��-Z�����[�w(�H�/=)���7rZ
��LR�	c �Lȩe܍ܨ���b���J㊆b%-�ƪ�K�Xn<��o:�����]�f�|�~��|�a~sBΘ�z-��c*�\q��Sy�1��(E0�da�HV���-?��?|��q	`(���d��}>@#ԌT�R�M�9$Q5�Z�ah8�h�YJ��E���Y���H�0?{��y�7h� +�my��S��C�Uq��P^��b6�҂f��͊�.;��.�1��f�,4��5)tV����ܶ�>lJ9ޑE�˥��|��h�6e���wI=�qx�ܭB���~�: ,�\65�Y��lp1�*h	�5�S'��Z]��sy���CIO[rՑ+�i��3S��ϼ�%�
rW���3H���Y����go��t�,C>l�٬�i��#���c�%Ѥ �L�GY�R�Dudؿ�Igo/�;��	1U��YM,
�r�Ș�
T� �(�x~d���[ҁ\l?~.�p�@��Z��q�QY�����4r��ꤍJ�S��0?%�Ӯ��fq��߃�w�����-�}�vS/�E�%t:�Q�C��1b�8������q�nwd�􅜭�~��c	�� �=l��62��t�}. ��F�ͼ:.�+e����fAk'��E@=�+���01�=H��ҩ`���	�=��wu�*���ݥr^�u���	���<= �ܠ�Zqc��3L��F%Qɠ\�����e�)��'.��l�I*A�!��hO��pk
Wl�Y�aK� ��.���w~��6,˖�u�}B+�$�S��?�,�z�B��+� �E뜍���-�L�I�a��jx)i�>G�~؍�Q�0#W�sr���p��]�@�G�?7(�z;�|xy~�`.��/�[���+��Q[��QQga\l ,���O�����)g�#�P�5LoU:�X��~�`���������x�k���=ߜ6����[�p2������-9E>�o֝������l���������"1�pJ��@��q`�6�L�!5؁���=+�7{����p����O?8`����]�ͧ&�����΂Em�c{��6M��D����'x�Ôt_��:���.���ޏ�?H\��rV>�
&%0{��h������=ƥ�mH���G�auBΡx}lo���
�n�c~�X����/����5��O�`V�kϕMMAlU �q��^z/3\MxM.��[U�!I�O��,CM�@�2���'���n3�g��}W$|��3��ϱ����q��͛����      �   �  x�}�Ok1���O�ǖ�E�����
&)�ҋ����nX�駯l�Ph݋@hx?�y/YV�Љ �A'��VNJr:6_v�]:�����O������+Ok�[���_�܀��V��Ѐ�#R�蓔��:�}0u"+��VՃz�5��M�p����w�ȧ��2O7�u�t�V�9�����:�~�I�"V@��9h�<�/�#���T�y�e�&�d�h�/\�)��F��+�!�0�^����/X���rxi9�-#�lD����Sd�K�TH(I^ �H2R��&��5�����w��e��&�@�Fӕ�rt=��Mݗ&-����s�t���/����h?l�u᷅�#/ŏ�|��<�XoO/e����r�Q�!�n�����qR���mɒ!��S����,vu��R1_�T�r����ku���fk���H�W������P�* ���Xͱ�%i#d�ͶFx��<_��?�K� ��t������2      �   �   x�e�9n1@��:E��EQ\�M N��.�h�����)� ���>����:�w�0�v2Z˂.�Ā�oX���H��/����L�j���{����
��,���*�yS�t?��69W٠:p���I�X�%�<C̹Za����{-�D��6�wE����Ӝ��NÌX����;��~ �WB      �   7  x�mлN1���y��h�����FTH ���2F(A�����@�p>��Ml�ȍ@(T�+$���j�\���\��-����rz����t[\p�� xޣH�'�p��K�[����z�
�Ph�1E���?*����SVU�gY�Z��� ����Z�Yt���mi�ۼ��t>��n�u��?�y��5�m�qP�U@D6���"�����ʲ�m~/��х�x�8ēr&+␎݇
��V:���j��j%���v��t<�wv�Q'/~[M�;��ԑ@�)U���{���m��1&���4�v�/�B��      �   �   x�e�;
�@ �:{
{�0;;��t�
� �6�l<��ǤN��-Q��Y ���0X�4`��g5.!1 A�� 8�3�K>#v�m|w�䫫�(�zV�atq�D�'�}Ew�}�?��2������g���M�ڈ��x��.���u}M�m��)�?�N1�      �     x���Kj�@D��)z4���ϑM �B�x�=��>�UN�QQ���������j�VY���x�BH���!o7���czA\B�BA��
�*�%�{�X����B�J�`�J �;�
D�5kJ�-ל�ſys�:�<���n�"$"Z���s[^�y����[���� ���F�)����C�Q�(��g�W�`��1�Q�f�c %�yJ�\����꽹kwG?���q���y��=�q:�j�x��u��u] �s�      �   �   x�m�1n�0���>E��)R��'萵�$J@�E�ܿJ��=�����28B�:@H�V���{���%b�d'�]��9 )�!.��w�9�����r�X���<�O�&�Q q�Z����LL,���'F��Ѝ�)�$q�Z���\��D�W�w⠖"�;�1ƥ���(c�NS��<'n��k�!2w�1�3i�d�����xb�s)H��]�|�P���7���+&;KȲe�O���z,2�ϰ��/B`�      �   �   x�e�A1@ѵ=��Rha��v�	��nt/!�A��,�;�?'�&>��!1`���m���M�\_W�`;W]^�ԧ�Ns�#p�\� ��<��-�N�U�U?e~�ey!��y)��C`�>D�t��1�u�/c��Z����]��G����;�      �      x������ � �     