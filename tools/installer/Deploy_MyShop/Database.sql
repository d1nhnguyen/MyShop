--
-- PostgreSQL database dump
-- Dumped from database version 15.15
-- Dumped by pg_dump version 15.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS "products_categoryId_fkey";
ALTER TABLE IF EXISTS ONLY public.product_images DROP CONSTRAINT IF EXISTS "product_images_productId_fkey";
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS "orders_userId_fkey";
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS "orders_discountId_fkey";
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS "orders_customerId_fkey";
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS "order_items_productId_fkey";
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS "order_items_orderId_fkey";
DROP INDEX IF EXISTS public.users_username_key;
DROP INDEX IF EXISTS public.users_username_idx;
DROP INDEX IF EXISTS public.users_role_idx;
DROP INDEX IF EXISTS public.users_email_key;
DROP INDEX IF EXISTS public.users_email_idx;
DROP INDEX IF EXISTS public.sales_targets_year_month_idx;
DROP INDEX IF EXISTS public."sales_targets_userId_month_year_key";
DROP INDEX IF EXISTS public."sales_targets_userId_idx";
DROP INDEX IF EXISTS public.products_sku_key;
DROP INDEX IF EXISTS public.products_sku_idx;
DROP INDEX IF EXISTS public.products_name_idx;
DROP INDEX IF EXISTS public."products_categoryId_idx";
DROP INDEX IF EXISTS public.products_barcode_key;
DROP INDEX IF EXISTS public.products_barcode_idx;
DROP INDEX IF EXISTS public."product_images_productId_idx";
DROP INDEX IF EXISTS public."product_images_isMain_idx";
DROP INDEX IF EXISTS public."product_images_displayOrder_idx";
DROP INDEX IF EXISTS public."orders_userId_idx";
DROP INDEX IF EXISTS public.orders_status_idx;
DROP INDEX IF EXISTS public."orders_orderNumber_key";
DROP INDEX IF EXISTS public."orders_orderNumber_idx";
DROP INDEX IF EXISTS public."orders_customerId_idx";
DROP INDEX IF EXISTS public."orders_createdAt_idx";
DROP INDEX IF EXISTS public."order_items_productId_idx";
DROP INDEX IF EXISTS public."order_items_orderId_idx";
DROP INDEX IF EXISTS public.discounts_type_idx;
DROP INDEX IF EXISTS public.discounts_code_key;
DROP INDEX IF EXISTS public.discounts_code_idx;
DROP INDEX IF EXISTS public.customers_phone_idx;
DROP INDEX IF EXISTS public.customers_name_idx;
DROP INDEX IF EXISTS public.customers_email_key;
DROP INDEX IF EXISTS public.customers_email_idx;
DROP INDEX IF EXISTS public."commissions_userId_idx";
DROP INDEX IF EXISTS public."commissions_orderId_key";
DROP INDEX IF EXISTS public."commissions_isPaid_idx";
DROP INDEX IF EXISTS public."commissions_createdAt_idx";
DROP INDEX IF EXISTS public.categories_name_key;
DROP INDEX IF EXISTS public.categories_name_idx;
DROP INDEX IF EXISTS public."app_licenses_licenseKey_key";
DROP INDEX IF EXISTS public."app_licenses_licenseKey_idx";
DROP INDEX IF EXISTS public."app_licenses_expiresAt_idx";
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.sales_targets DROP CONSTRAINT IF EXISTS sales_targets_pkey;
ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS products_pkey;
ALTER TABLE IF EXISTS ONLY public.product_images DROP CONSTRAINT IF EXISTS product_images_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.order_items DROP CONSTRAINT IF EXISTS order_items_pkey;
ALTER TABLE IF EXISTS ONLY public.discounts DROP CONSTRAINT IF EXISTS discounts_pkey;
ALTER TABLE IF EXISTS ONLY public.customers DROP CONSTRAINT IF EXISTS customers_pkey;
ALTER TABLE IF EXISTS ONLY public.commissions DROP CONSTRAINT IF EXISTS commissions_pkey;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_pkey;
ALTER TABLE IF EXISTS ONLY public.app_licenses DROP CONSTRAINT IF EXISTS app_licenses_pkey;
ALTER TABLE IF EXISTS ONLY public._prisma_migrations DROP CONSTRAINT IF EXISTS _prisma_migrations_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sales_targets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.products ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.product_images ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.order_items ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.discounts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.customers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.commissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.app_licenses ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.sales_targets_id_seq;
DROP TABLE IF EXISTS public.sales_targets;
DROP SEQUENCE IF EXISTS public.products_id_seq;
DROP TABLE IF EXISTS public.products;
DROP SEQUENCE IF EXISTS public.product_images_id_seq;
DROP TABLE IF EXISTS public.product_images;
DROP SEQUENCE IF EXISTS public.orders_id_seq;
DROP TABLE IF EXISTS public.orders;
DROP SEQUENCE IF EXISTS public.order_items_id_seq;
DROP TABLE IF EXISTS public.order_items;
DROP SEQUENCE IF EXISTS public.discounts_id_seq;
DROP TABLE IF EXISTS public.discounts;
DROP SEQUENCE IF EXISTS public.customers_id_seq;
DROP TABLE IF EXISTS public.customers;
DROP SEQUENCE IF EXISTS public.commissions_id_seq;
DROP TABLE IF EXISTS public.commissions;
DROP SEQUENCE IF EXISTS public.categories_id_seq;
DROP TABLE IF EXISTS public.categories;
DROP SEQUENCE IF EXISTS public.app_licenses_id_seq;
DROP TABLE IF EXISTS public.app_licenses;
DROP TABLE IF EXISTS public._prisma_migrations;
DROP TYPE IF EXISTS public."UserRole";
DROP TYPE IF EXISTS public."OrderStatus";
DROP TYPE IF EXISTS public."DiscountType";
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: admin
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO admin;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON SCHEMA public IS '';


--
-- Name: DiscountType; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public."DiscountType" AS ENUM (
    'PERCENTAGE',
    'FIXED_AMOUNT',
    'BUY_X_GET_Y',
    'MEMBER_DISCOUNT',
    'WHOLESALE_DISCOUNT'
);


ALTER TYPE public."DiscountType" OWNER TO admin;

--
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'PENDING',
    'PROCESSING',
    'COMPLETED',
    'CANCELLED'
);


ALTER TYPE public."OrderStatus" OWNER TO admin;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public."UserRole" AS ENUM (
    'ADMIN',
    'MANAGER',
    'STAFF'
);


ALTER TYPE public."UserRole" OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO admin;

--
-- Name: app_licenses; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.app_licenses (
    id integer NOT NULL,
    "licenseKey" character varying(100) NOT NULL,
    "deviceId" character varying(100),
    "activatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.app_licenses OWNER TO admin;

--
-- Name: app_licenses_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.app_licenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_licenses_id_seq OWNER TO admin;

--
-- Name: app_licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.app_licenses_id_seq OWNED BY public.app_licenses.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO admin;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO admin;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: commissions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.commissions (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "orderId" integer NOT NULL,
    "orderTotal" numeric(10,2) NOT NULL,
    "commissionRate" numeric(5,2) NOT NULL,
    "commissionAmount" numeric(10,2) NOT NULL,
    "isPaid" boolean DEFAULT false NOT NULL,
    "paidAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.commissions OWNER TO admin;

--
-- Name: commissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.commissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commissions_id_seq OWNER TO admin;

--
-- Name: commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.commissions_id_seq OWNED BY public.commissions.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100),
    phone character varying(20) NOT NULL,
    address text,
    "isMember" boolean DEFAULT false NOT NULL,
    "memberSince" timestamp(3) without time zone,
    "totalSpent" numeric(12,2) DEFAULT 0 NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.customers OWNER TO admin;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO admin;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: discounts; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.discounts (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    type public."DiscountType" NOT NULL,
    value numeric(10,2) NOT NULL,
    "minPurchase" numeric(10,2),
    "maxDiscount" numeric(10,2),
    "buyQuantity" integer,
    "getQuantity" integer,
    "isActive" boolean DEFAULT true NOT NULL,
    "startDate" timestamp(3) without time zone,
    "endDate" timestamp(3) without time zone,
    "usageLimit" integer,
    "usageCount" integer DEFAULT 0 NOT NULL,
    "applicableToAll" boolean DEFAULT true NOT NULL,
    "memberOnly" boolean DEFAULT false NOT NULL,
    "wholesaleMinQty" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.discounts OWNER TO admin;

--
-- Name: discounts_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.discounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discounts_id_seq OWNER TO admin;

--
-- Name: discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.discounts_id_seq OWNED BY public.discounts.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    "orderId" integer NOT NULL,
    "productId" integer NOT NULL,
    quantity integer NOT NULL,
    "unitPrice" numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    "discountAmount" numeric(10,2) DEFAULT 0 NOT NULL,
    total numeric(10,2) NOT NULL
);


ALTER TABLE public.order_items OWNER TO admin;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO admin;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    "orderNumber" character varying(50) NOT NULL,
    "customerId" integer,
    "userId" integer NOT NULL,
    status public."OrderStatus" DEFAULT 'PENDING'::public."OrderStatus" NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    "discountId" integer,
    "discountAmount" numeric(10,2) DEFAULT 0 NOT NULL,
    "taxAmount" numeric(10,2) DEFAULT 0 NOT NULL,
    total numeric(10,2) NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "completedAt" timestamp(3) without time zone
);


ALTER TABLE public.orders OWNER TO admin;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO admin;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: product_images; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.product_images (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    "imageUrl" character varying(500) NOT NULL,
    "displayOrder" integer DEFAULT 0 NOT NULL,
    "isMain" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.product_images OWNER TO admin;

--
-- Name: product_images_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.product_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_images_id_seq OWNER TO admin;

--
-- Name: product_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.product_images_id_seq OWNED BY public.product_images.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    sku character varying(50) NOT NULL,
    barcode character varying(50),
    price numeric(10,2) NOT NULL,
    "costPrice" numeric(10,2),
    stock integer DEFAULT 0 NOT NULL,
    "minStock" integer DEFAULT 0 NOT NULL,
    "categoryId" integer NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    popularity integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.products OWNER TO admin;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO admin;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: sales_targets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sales_targets (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    month integer NOT NULL,
    year integer NOT NULL,
    "targetAmount" numeric(12,2) NOT NULL,
    "achievedAmount" numeric(12,2) DEFAULT 0 NOT NULL,
    "commissionRate" numeric(5,2) NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.sales_targets OWNER TO admin;

--
-- Name: sales_targets_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.sales_targets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_targets_id_seq OWNER TO admin;

--
-- Name: sales_targets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.sales_targets_id_seq OWNED BY public.sales_targets.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    role public."UserRole" DEFAULT 'STAFF'::public."UserRole" NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: app_licenses id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.app_licenses ALTER COLUMN id SET DEFAULT nextval('public.app_licenses_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: commissions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.commissions ALTER COLUMN id SET DEFAULT nextval('public.commissions_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: discounts id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.discounts ALTER COLUMN id SET DEFAULT nextval('public.discounts_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: product_images id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_images ALTER COLUMN id SET DEFAULT nextval('public.product_images_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: sales_targets id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sales_targets ALTER COLUMN id SET DEFAULT nextval('public.sales_targets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('1ae8134b-8bc0-4019-a7d7-4c0c8b5a2ea4', 'fb747652571aeed99d858541db997e334a484f8436be5e9ac878ba7570055b61', '2025-12-25 18:23:10.741934+00', '20251225182310_init', NULL, NULL, '2025-12-25 18:23:10.307054+00', 1);
INSERT INTO public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('8a3f1a8d-ae02-4811-b378-bb3f4457f9c2', '6100051154c506ceae3867c309f9c4342a223c8018a0031ea7939b23efa0b383', '2025-12-31 16:18:56.672484+00', '20251231161856_add_product_images', NULL, NULL, '2025-12-31 16:18:56.57601+00', 1);


--
-- Data for Name: app_licenses; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.app_licenses (id, "licenseKey", "deviceId", "activatedAt", "expiresAt", "isActive", "createdAt") VALUES (4, 'MYSHOP-TRIAL-0001', NULL, '2026-01-07 11:12:04.881', '2026-01-22 11:12:04.881', true, '2026-01-07 11:12:04.883');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.categories (id, name, description, "isActive", "createdAt", "updatedAt") VALUES (19, 'iPhone', 'Apple Smartphones', true, '2026-01-07 11:12:02.245', '2026-01-07 11:12:02.245');
INSERT INTO public.categories (id, name, description, "isActive", "createdAt", "updatedAt") VALUES (20, 'iPad', 'Apple Tablets', true, '2026-01-07 11:12:02.252', '2026-01-07 11:12:02.252');
INSERT INTO public.categories (id, name, description, "isActive", "createdAt", "updatedAt") VALUES (21, 'Laptop', 'Portable computers', true, '2026-01-07 11:12:02.256', '2026-01-07 11:12:02.256');
INSERT INTO public.categories (id, name, description, "isActive", "createdAt", "updatedAt") VALUES (22, 'Tablet', 'Android and other tablets', true, '2026-01-07 11:12:02.258', '2026-01-07 11:12:02.258');
INSERT INTO public.categories (id, name, description, "isActive", "createdAt", "updatedAt") VALUES (23, 'PC', 'Desktop computers', true, '2026-01-07 11:12:02.261', '2026-01-07 11:12:02.261');
INSERT INTO public.categories (id, name, description, "isActive", "createdAt", "updatedAt") VALUES (24, 'TV', 'Smart Televisions', true, '2026-01-07 11:12:02.264', '2026-01-07 11:12:02.264');


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (60, 18, 203, 4495.00, 3.00, 134.85, false, '2026-01-04 23:41:33.221', '2026-01-04 23:41:33.221');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (61, 19, 204, 5374.00, 3.00, 161.22, false, '2025-12-31 11:49:20.168', '2025-12-31 11:49:20.168');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (62, 17, 205, 3166.00, 3.00, 94.98, false, '2026-01-02 13:30:33.05', '2026-01-02 13:30:33.05');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (63, 19, 206, 5996.00, 3.00, 179.88, false, '2026-01-06 16:06:57.028', '2026-01-06 16:06:57.028');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (64, 17, 211, 7994.00, 3.00, 239.82, true, NULL, '2026-01-02 12:48:16.43');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (65, 17, 212, 2597.00, 3.00, 77.91, false, '2026-01-01 23:55:38.197', '2026-01-01 23:55:38.197');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (66, 18, 213, 750.00, 3.00, 22.50, true, '2026-01-03 14:19:00.35', '2026-01-03 14:19:00.35');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (67, 17, 215, 6553.00, 3.00, 196.59, false, '2026-01-01 11:05:20.262', '2026-01-01 11:05:20.262');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (68, 17, 216, 5444.00, 3.00, 163.32, true, NULL, '2025-12-15 01:31:11.692');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (69, 17, 217, 6046.00, 3.00, 181.38, true, '2026-01-07 00:25:13.046', '2026-01-07 00:25:13.046');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (70, 18, 220, 5313.00, 3.00, 159.39, false, NULL, '2026-01-02 21:12:29.972');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (71, 19, 223, 12594.00, 3.00, 377.82, true, '2026-01-07 03:17:17.654', '2026-01-07 03:17:17.654');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (72, 19, 226, 6396.00, 3.00, 191.88, true, NULL, '2026-01-06 09:28:35.466');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (73, 17, 227, 4897.00, 3.00, 146.91, true, '2026-01-07 04:00:05.911', '2026-01-07 04:00:05.911');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (74, 19, 229, 3795.00, 3.00, 113.85, false, NULL, '2026-01-05 02:40:57.649');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (75, 17, 230, 10193.00, 3.00, 305.79, true, '2026-01-02 20:36:09.914', '2026-01-02 20:36:09.914');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (76, 19, 231, 2448.00, 3.00, 73.44, false, NULL, '2026-01-04 21:29:05.406');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (77, 17, 234, 6494.00, 3.00, 194.82, true, NULL, '2026-01-06 12:12:26.835');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (78, 17, 238, 5997.00, 3.00, 179.91, false, '2026-01-04 06:45:36.357', '2026-01-04 06:45:36.357');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (79, 18, 240, 3697.00, 3.00, 110.91, false, '2025-12-31 15:09:20.424', '2025-12-31 15:09:20.424');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (80, 17, 242, 5296.00, 3.00, 158.88, true, '2026-01-06 23:48:03.683', '2026-01-06 23:48:03.683');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (81, 19, 243, 5894.00, 3.00, 176.82, false, NULL, '2025-12-20 18:51:49.093');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (82, 17, 244, 9574.00, 3.00, 287.22, true, NULL, '2026-01-06 17:12:41.137');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (83, 17, 245, 3418.00, 3.00, 102.54, true, '2025-12-31 21:18:51.832', '2025-12-31 21:18:51.832');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (84, 17, 246, 2797.00, 3.00, 83.91, false, NULL, '2026-01-01 07:18:42.803');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (85, 19, 249, 4497.00, 3.00, 134.91, false, NULL, '2026-01-04 17:42:34.275');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (86, 19, 251, 2998.00, 3.00, 89.94, false, NULL, '2025-12-14 21:23:33.005');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (87, 17, 253, 11295.00, 3.00, 338.85, false, '2026-01-06 15:44:34.268', '2026-01-06 15:44:34.268');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (88, 17, 255, 7794.00, 3.00, 233.82, false, NULL, '2026-01-01 01:10:43.99');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (89, 18, 256, 699.00, 3.00, 20.97, false, '2025-12-25 02:27:03.602', '2025-12-25 02:27:03.602');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (90, 19, 257, 1396.00, 3.00, 41.88, true, '2025-12-31 14:07:55.836', '2025-12-31 14:07:55.836');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (91, 18, 258, 3798.00, 3.00, 113.94, true, NULL, '2026-01-04 22:09:28.031');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (92, 17, 261, 1099.00, 3.00, 32.97, false, NULL, '2026-01-02 12:08:39.795');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (93, 19, 265, 8152.00, 3.00, 244.56, true, NULL, '2026-01-04 12:46:50.406');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (94, 18, 266, 999.00, 3.00, 29.97, false, NULL, '2026-01-02 08:43:45.326');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (95, 17, 267, 6296.00, 3.00, 188.88, true, NULL, '2025-12-30 05:11:54.221');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (96, 17, 269, 3695.00, 3.00, 110.85, false, NULL, '2025-12-31 14:41:42.172');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (97, 19, 270, 6198.00, 3.00, 185.94, true, '2025-12-20 20:20:59.447', '2025-12-20 20:20:59.447');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (98, 18, 271, 998.00, 3.00, 29.94, false, NULL, '2026-01-01 02:44:49.632');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (99, 18, 272, 11592.00, 3.00, 347.76, false, NULL, '2026-01-01 19:04:33.516');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (100, 17, 275, 3997.00, 3.00, 119.91, false, '2026-01-03 02:56:07.454', '2026-01-03 02:56:07.454');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (101, 17, 277, 5596.00, 3.00, 167.88, false, NULL, '2025-12-13 06:51:17.55');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (102, 17, 280, 5992.00, 3.00, 179.76, true, NULL, '2026-01-01 21:00:23.331');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (103, 17, 281, 5695.00, 3.00, 170.85, false, NULL, '2025-12-26 17:20:27.431');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (104, 17, 282, 2297.00, 3.00, 68.91, false, '2026-01-01 12:06:10.68', '2026-01-01 12:06:10.68');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (105, 19, 285, 2997.00, 3.00, 89.91, false, NULL, '2026-01-01 19:51:11.754');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (106, 17, 286, 2996.00, 3.00, 89.88, true, NULL, '2025-12-31 12:46:33.721');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (107, 18, 287, 1599.00, 3.00, 47.97, true, '2025-12-09 16:53:58.025', '2025-12-09 16:53:58.025');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (108, 19, 288, 4598.00, 3.00, 137.94, false, '2026-01-04 19:43:48.715', '2026-01-04 19:43:48.715');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (109, 17, 289, 4196.00, 3.00, 125.88, true, NULL, '2026-01-01 19:07:27.288');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (110, 18, 292, 5396.00, 3.00, 161.88, true, '2026-01-04 18:31:36.125', '2026-01-04 18:31:36.125');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (111, 18, 293, 6216.00, 3.00, 186.48, true, '2026-01-07 09:45:56.573', '2026-01-07 09:45:56.573');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (112, 17, 294, 2898.00, 3.00, 86.94, true, '2026-01-03 11:21:56.521', '2026-01-03 11:21:56.521');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (113, 18, 295, 858.00, 3.00, 25.74, true, NULL, '2026-01-03 08:36:06.599');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (114, 19, 297, 2596.00, 3.00, 77.88, true, '2026-01-06 11:22:11.508', '2026-01-06 11:22:11.508');
INSERT INTO public.commissions (id, "userId", "orderId", "orderTotal", "commissionRate", "commissionAmount", "isPaid", "paidAt", "createdAt") VALUES (115, 19, 298, 4496.00, 3.00, 134.88, true, NULL, '2025-12-29 17:14:17.59');


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (36, 'John Smith', 'john.smith@example.com', '0901234567', '123 Main St, New York, NY', true, '2025-04-22 04:24:13.109', 27056.00, NULL, '2026-01-07 11:12:03.608', '2026-01-07 11:12:04.77');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (37, 'Emily Johnson', 'emily.j@example.com', '0902345678', '456 Market St, San Francisco, CA', false, NULL, 27031.00, NULL, '2026-01-07 11:12:03.615', '2026-01-07 11:12:04.776');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (38, 'Michael Williams', 'mike.w@example.com', '0903456789', '789 Broadway, Los Angeles, CA', true, '2025-07-23 06:23:03.807', 19112.00, NULL, '2026-01-07 11:12:03.62', '2026-01-07 11:12:04.782');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (39, 'Sarah Brown', 'sarah.b@example.com', '0904567890', '321 Elm St, Chicago, IL', false, NULL, 11189.00, NULL, '2026-01-07 11:12:03.623', '2026-01-07 11:12:04.787');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (40, 'David Jones', 'david.j@example.com', '0905678901', '654 Pine St, Houston, TX', true, '2025-10-03 14:26:45.549', 5596.00, NULL, '2026-01-07 11:12:03.626', '2026-01-07 11:12:04.793');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (41, 'Jennifer Garcia', 'jen.garcia@example.com', '0906789012', '987 Oak Ave, Miami, FL', true, '2025-05-06 06:16:10.903', 13190.00, NULL, '2026-01-07 11:12:03.629', '2026-01-07 11:12:04.8');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (42, 'Robert Miller', 'rob.miller@example.com', '0907890123', '147 Maple Dr, Seattle, WA', false, NULL, 8192.00, NULL, '2026-01-07 11:12:03.64', '2026-01-07 11:12:04.806');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (43, 'Jessica Davis', 'jess.davis@example.com', '0908901234', '258 Cedar Ln, Boston, MA', false, NULL, 4497.00, NULL, '2026-01-07 11:12:03.645', '2026-01-07 11:12:04.81');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (44, 'William Rodriguez', 'will.rod@example.com', '0909012345', '369 Birch Rd, Denver, CO', true, '2025-06-22 19:08:13.006', 7591.00, NULL, '2026-01-07 11:12:03.653', '2026-01-07 11:12:04.815');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (45, 'Elizabeth Martinez', 'liz.martinez@example.com', '0900123456', '741 Spruce Ct, Atlanta, GA', true, '2025-09-16 19:05:29.837', 10694.00, NULL, '2026-01-07 11:12:03.659', '2026-01-07 11:12:04.82');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (46, 'James Anderson', 'james.a@example.com', '0911234567', '852 Willow Way, Phoenix, AZ', false, NULL, 7496.00, NULL, '2026-01-07 11:12:03.663', '2026-01-07 11:12:04.824');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (47, 'Linda Taylor', 'linda.t@example.com', '0912345678', '963 Aspen Pl, Portland, OR', false, NULL, 4897.00, NULL, '2026-01-07 11:12:03.667', '2026-01-07 11:12:04.829');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (48, 'Christopher Lee', 'chris.lee@example.com', '0913456789', '159 Valley Rd, Austin, TX', true, '2025-12-09 06:14:04.896', 6553.00, NULL, '2026-01-07 11:12:03.671', '2026-01-07 11:12:04.834');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (49, 'Patricia White', 'pat.white@example.com', '0914567890', '753 Hill St, Nashville, TN', false, NULL, 10193.00, NULL, '2026-01-07 11:12:03.674', '2026-01-07 11:12:04.839');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (50, 'Daniel Harris', 'dan.harris@example.com', '0915678901', '951 Lake Dr, Detroit, MI', true, '2025-10-25 21:15:45.532', 21250.00, NULL, '2026-01-07 11:12:03.677', '2026-01-07 11:12:04.844');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (51, 'Nancy Clark', 'nancy.clark@example.com', '0916789012', '357 River Ln, Minneapolis, MN', false, NULL, 7394.00, NULL, '2026-01-07 11:12:03.681', '2026-01-07 11:12:04.849');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (52, 'Matthew Lewis', 'matt.lewis@example.com', '0917890123', '486 Forest Ave, Tampa, FL', true, '2025-10-30 22:29:34.897', 6296.00, NULL, '2026-01-07 11:12:03.685', '2026-01-07 11:12:04.854');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (53, 'Karen Walker', 'karen.w@example.com', '0918901234', '624 Mountain Rd, Cleveland, OH', false, NULL, 7909.00, NULL, '2026-01-07 11:12:03.689', '2026-01-07 11:12:04.858');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (54, 'Thomas Hall', 'tom.hall@example.com', '0919012345', '792 Beach Blvd, San Diego, CA', true, '2025-05-04 04:36:06.856', 11442.00, NULL, '2026-01-07 11:12:03.692', '2026-01-07 11:12:04.862');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (55, 'Betty Allen', 'betty.allen@example.com', '0920123456', '135 Park Ave, Philadelphia, PA', false, NULL, 11592.00, NULL, '2026-01-07 11:12:03.695', '2026-01-07 11:12:04.867');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (56, 'Charles Young', 'charles.y@example.com', '0921234567', '246 Garden St, Charlotte, NC', true, '2025-11-10 14:03:56.691', 6854.00, NULL, '2026-01-07 11:12:03.698', '2026-01-07 11:12:04.872');
INSERT INTO public.customers (id, name, email, phone, address, "isMember", "memberSince", "totalSpent", notes, "createdAt", "updatedAt") VALUES (57, 'Sandra King', 'sandra.king@example.com', '0922345678', '864 Sunset Dr, Indianapolis, IN', true, '2025-06-01 18:30:08.463', 35123.00, NULL, '2026-01-07 11:12:03.701', '2026-01-07 11:12:04.878');


--
-- Data for Name: discounts; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.discounts (id, code, name, description, type, value, "minPurchase", "maxDiscount", "buyQuantity", "getQuantity", "isActive", "startDate", "endDate", "usageLimit", "usageCount", "applicableToAll", "memberOnly", "wholesaleMinQty", "createdAt", "updatedAt") VALUES (12, 'WELCOME2025', 'First Time User', 'Welcome gift for new users', 'FIXED_AMOUNT', 10.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, true, false, NULL, '2026-01-07 11:12:02.269', '2026-01-07 11:12:02.269');
INSERT INTO public.discounts (id, code, name, description, type, value, "minPurchase", "maxDiscount", "buyQuantity", "getQuantity", "isActive", "startDate", "endDate", "usageLimit", "usageCount", "applicableToAll", "memberOnly", "wholesaleMinQty", "createdAt", "updatedAt") VALUES (13, 'FREESHIP', 'Free Shipping', 'Free shipping on all orders', 'FIXED_AMOUNT', 5.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, true, false, NULL, '2026-01-07 11:12:02.281', '2026-01-07 11:12:02.281');
INSERT INTO public.discounts (id, code, name, description, type, value, "minPurchase", "maxDiscount", "buyQuantity", "getQuantity", "isActive", "startDate", "endDate", "usageLimit", "usageCount", "applicableToAll", "memberOnly", "wholesaleMinQty", "createdAt", "updatedAt") VALUES (14, 'MERRYXMAS', 'Merry Christmas', 'Holiday season special', 'PERCENTAGE', 20.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, true, false, NULL, '2026-01-07 11:12:02.284', '2026-01-07 11:12:02.284');
INSERT INTO public.discounts (id, code, name, description, type, value, "minPurchase", "maxDiscount", "buyQuantity", "getQuantity", "isActive", "startDate", "endDate", "usageLimit", "usageCount", "applicableToAll", "memberOnly", "wholesaleMinQty", "createdAt", "updatedAt") VALUES (15, 'FLASH50', 'Flash Sale', 'Limited time offer', 'PERCENTAGE', 50.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, false, false, NULL, '2026-01-07 11:12:02.287', '2026-01-07 11:12:02.287');
INSERT INTO public.discounts (id, code, name, description, type, value, "minPurchase", "maxDiscount", "buyQuantity", "getQuantity", "isActive", "startDate", "endDate", "usageLimit", "usageCount", "applicableToAll", "memberOnly", "wholesaleMinQty", "createdAt", "updatedAt") VALUES (16, 'VIPMEMBER', 'VIP Discount', 'Exclusive for members', 'PERCENTAGE', 15.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, true, false, NULL, '2026-01-07 11:12:02.343', '2026-01-07 11:12:02.343');


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (479, 201, 339, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (480, 201, 362, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (481, 201, 363, 1, 1599.00, 1599.00, 0.00, 1599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (482, 202, 362, 1, 1299.00, 1299.00, 0.00, 1299.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (483, 202, 373, 2, 1699.00, 3398.00, 0.00, 3398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (484, 203, 344, 2, 749.00, 1498.00, 0.00, 1498.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (485, 203, 336, 1, 799.00, 799.00, 0.00, 799.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (486, 203, 379, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (487, 204, 450, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (488, 204, 378, 2, 1799.00, 3598.00, 0.00, 3598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (489, 204, 399, 2, 189.00, 378.00, 0.00, 378.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (490, 205, 344, 1, 749.00, 749.00, 0.00, 749.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (491, 205, 349, 2, 329.00, 658.00, 0.00, 658.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (492, 205, 360, 2, 180.00, 360.00, 0.00, 360.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (493, 205, 425, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (494, 206, 335, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (495, 206, 378, 2, 1799.00, 3598.00, 0.00, 3598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (496, 206, 385, 1, 1499.00, 1499.00, 0.00, 1499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (497, 207, 377, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (498, 207, 406, 2, 239.00, 478.00, 0.00, 478.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (499, 207, 319, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (500, 208, 381, 1, 649.00, 649.00, 0.00, 649.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (501, 208, 334, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (502, 208, 356, 1, 500.00, 500.00, 0.00, 500.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (503, 208, 423, 2, 1599.00, 3198.00, 0.00, 3198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (504, 209, 310, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (505, 209, 419, 1, 2499.00, 2499.00, 0.00, 2499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (506, 210, 383, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (507, 210, 352, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (508, 210, 431, 1, 1699.00, 1699.00, 0.00, 1699.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (509, 210, 370, 1, 1299.00, 1299.00, 0.00, 1299.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (510, 211, 373, 2, 1699.00, 3398.00, 0.00, 3398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (511, 211, 312, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (512, 211, 408, 2, 299.00, 598.00, 0.00, 598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (513, 211, 429, 1, 2999.00, 2999.00, 0.00, 2999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (514, 212, 412, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (515, 212, 377, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (516, 213, 354, 1, 300.00, 300.00, 0.00, 300.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (517, 213, 353, 1, 450.00, 450.00, 0.00, 450.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (518, 214, 378, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (519, 214, 443, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (520, 214, 354, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (521, 215, 349, 2, 329.00, 658.00, 0.00, 658.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (522, 215, 366, 2, 1399.00, 2798.00, 0.00, 2798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (523, 215, 418, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (524, 215, 381, 2, 649.00, 1298.00, 0.00, 1298.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (525, 216, 384, 2, 1599.00, 3198.00, 0.00, 3198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (526, 216, 454, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (527, 216, 403, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (528, 216, 395, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (529, 217, 431, 2, 1699.00, 3398.00, 0.00, 3398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (530, 217, 333, 1, 1199.00, 1199.00, 0.00, 1199.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (531, 217, 374, 1, 1449.00, 1449.00, 0.00, 1449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (532, 218, 436, 1, 2799.00, 2799.00, 0.00, 2799.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (533, 218, 412, 1, 599.00, 599.00, 0.00, 599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (534, 218, 359, 2, 220.00, 440.00, 0.00, 440.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (535, 218, 453, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (536, 219, 317, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (537, 219, 431, 2, 1699.00, 3398.00, 0.00, 3398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (538, 219, 395, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (539, 219, 347, 2, 449.00, 898.00, 0.00, 898.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (540, 220, 405, 1, 199.00, 199.00, 0.00, 199.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (541, 220, 350, 2, 479.00, 958.00, 0.00, 958.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (542, 220, 350, 2, 479.00, 958.00, 0.00, 958.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (543, 220, 363, 2, 1599.00, 3198.00, 0.00, 3198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (544, 221, 310, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (545, 221, 332, 2, 200.00, 400.00, 0.00, 400.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (546, 221, 355, 2, 600.00, 1200.00, 0.00, 1200.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (547, 222, 313, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (548, 222, 425, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (549, 222, 316, 2, 799.00, 1598.00, 0.00, 1598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (550, 222, 380, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (551, 223, 342, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (552, 223, 415, 2, 3999.00, 7998.00, 0.00, 7998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (553, 223, 425, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (554, 223, 340, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (555, 224, 352, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (556, 224, 374, 2, 1449.00, 2898.00, 0.00, 2898.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (557, 224, 399, 1, 189.00, 189.00, 0.00, 189.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (558, 224, 393, 1, 499.00, 499.00, 0.00, 499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (559, 225, 454, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (560, 226, 418, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (561, 226, 357, 2, 200.00, 400.00, 0.00, 400.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (562, 226, 363, 1, 1599.00, 1599.00, 0.00, 1599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (563, 226, 413, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (564, 227, 427, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (565, 227, 414, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (566, 228, 427, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (567, 229, 410, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (568, 229, 400, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (569, 229, 345, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (570, 230, 430, 2, 2499.00, 4998.00, 0.00, 4998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (571, 230, 322, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (572, 230, 449, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (573, 230, 377, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (574, 231, 342, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (575, 231, 328, 1, 550.00, 550.00, 0.00, 550.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (576, 231, 410, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (577, 232, 333, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (578, 232, 375, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (579, 232, 321, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (580, 232, 342, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (581, 233, 433, 2, 1799.00, 3598.00, 0.00, 3598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (582, 233, 404, 2, 149.00, 298.00, 0.00, 298.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (583, 234, 423, 1, 1599.00, 1599.00, 0.00, 1599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (584, 234, 368, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (585, 234, 400, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (586, 234, 381, 2, 649.00, 1298.00, 0.00, 1298.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (587, 235, 386, 1, 1449.00, 1449.00, 0.00, 1449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (588, 236, 419, 1, 2499.00, 2499.00, 0.00, 2499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (589, 236, 322, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (590, 237, 407, 2, 249.00, 498.00, 0.00, 498.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (591, 237, 330, 1, 300.00, 300.00, 0.00, 300.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (592, 238, 438, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (593, 238, 414, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (594, 239, 352, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (595, 239, 327, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (596, 239, 315, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (597, 239, 333, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (598, 240, 342, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (599, 240, 366, 2, 1399.00, 2798.00, 0.00, 2798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (600, 241, 381, 1, 649.00, 649.00, 0.00, 649.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (601, 242, 353, 2, 450.00, 900.00, 0.00, 900.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (602, 242, 324, 1, 499.00, 499.00, 0.00, 499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (603, 242, 373, 1, 1699.00, 1699.00, 0.00, 1699.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (604, 242, 443, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (605, 243, 395, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (606, 243, 416, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (607, 243, 424, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (608, 243, 452, 2, 299.00, 598.00, 0.00, 598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (609, 244, 406, 2, 239.00, 478.00, 0.00, 478.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (610, 244, 329, 2, 650.00, 1300.00, 0.00, 1300.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (611, 244, 421, 2, 2899.00, 5798.00, 0.00, 5798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (612, 244, 402, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (613, 245, 359, 1, 220.00, 220.00, 0.00, 220.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (614, 245, 356, 2, 500.00, 1000.00, 0.00, 1000.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (615, 245, 375, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (616, 245, 361, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (617, 246, 376, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (618, 246, 327, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (619, 247, 394, 2, 479.00, 958.00, 0.00, 958.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (620, 248, 384, 1, 1599.00, 1599.00, 0.00, 1599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (621, 248, 319, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (622, 248, 454, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (623, 249, 396, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (624, 249, 386, 2, 1449.00, 2898.00, 0.00, 2898.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (625, 249, 354, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (626, 249, 330, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (627, 250, 370, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (628, 250, 329, 1, 650.00, 650.00, 0.00, 650.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (629, 250, 320, 1, 799.00, 799.00, 0.00, 799.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (630, 250, 458, 1, 2399.00, 2399.00, 0.00, 2399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (631, 251, 369, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (632, 252, 313, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (633, 252, 320, 2, 799.00, 1598.00, 0.00, 1598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (634, 253, 421, 2, 2899.00, 5798.00, 0.00, 5798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (635, 253, 430, 1, 2499.00, 2499.00, 0.00, 2499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (636, 253, 448, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (637, 254, 434, 1, 1499.00, 1499.00, 0.00, 1499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (638, 255, 427, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (639, 255, 371, 2, 2199.00, 4398.00, 0.00, 4398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (640, 255, 320, 2, 799.00, 1598.00, 0.00, 1598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (641, 256, 352, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (642, 257, 393, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (643, 257, 405, 2, 199.00, 398.00, 0.00, 398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (644, 258, 435, 2, 1899.00, 3798.00, 0.00, 3798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (645, 259, 409, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (646, 260, 383, 2, 449.00, 898.00, 0.00, 898.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (647, 260, 336, 1, 799.00, 799.00, 0.00, 799.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (648, 261, 375, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (649, 262, 327, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (650, 262, 356, 1, 500.00, 500.00, 0.00, 500.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (651, 262, 326, 1, 479.00, 479.00, 0.00, 479.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (652, 263, 430, 2, 2499.00, 4998.00, 0.00, 4998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (653, 263, 361, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (654, 263, 374, 2, 1449.00, 2898.00, 0.00, 2898.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (655, 264, 397, 1, 229.00, 229.00, 0.00, 229.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (656, 264, 338, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (657, 264, 405, 2, 199.00, 398.00, 0.00, 398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (658, 265, 412, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (659, 265, 440, 2, 1699.00, 3398.00, 0.00, 3398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (660, 265, 394, 2, 479.00, 958.00, 0.00, 958.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (661, 265, 370, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (662, 266, 312, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (663, 267, 407, 2, 249.00, 498.00, 0.00, 498.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (664, 267, 421, 2, 2899.00, 5798.00, 0.00, 5798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (665, 268, 321, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (666, 268, 352, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (667, 268, 380, 1, 599.00, 599.00, 0.00, 599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (668, 269, 387, 1, 1599.00, 1599.00, 0.00, 1599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (669, 269, 392, 2, 449.00, 898.00, 0.00, 898.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (670, 269, 357, 1, 200.00, 200.00, 0.00, 200.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (671, 269, 445, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (672, 270, 436, 2, 2799.00, 5598.00, 0.00, 5598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (673, 270, 330, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (674, 271, 323, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (675, 272, 373, 2, 1699.00, 3398.00, 0.00, 3398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (676, 272, 389, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (677, 272, 370, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (678, 272, 423, 2, 1599.00, 3198.00, 0.00, 3198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (679, 273, 343, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (680, 273, 443, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (681, 273, 315, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (682, 274, 403, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (683, 274, 450, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (684, 274, 415, 2, 3999.00, 7998.00, 0.00, 7998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (685, 274, 409, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (686, 275, 448, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (687, 275, 372, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (688, 276, 410, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (689, 277, 370, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (690, 277, 448, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (691, 278, 437, 2, 1599.00, 3198.00, 0.00, 3198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (692, 278, 388, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (693, 278, 416, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (694, 278, 324, 1, 499.00, 499.00, 0.00, 499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (695, 279, 402, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (696, 279, 399, 2, 189.00, 378.00, 0.00, 378.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (697, 279, 453, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (698, 280, 404, 2, 149.00, 298.00, 0.00, 298.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (699, 280, 374, 2, 1449.00, 2898.00, 0.00, 2898.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (700, 280, 321, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (701, 280, 428, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (702, 281, 441, 1, 3499.00, 3499.00, 0.00, 3499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (703, 281, 327, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (704, 281, 401, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (705, 282, 347, 2, 449.00, 898.00, 0.00, 898.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (706, 282, 366, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (707, 283, 447, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (708, 283, 380, 1, 599.00, 599.00, 0.00, 599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (709, 284, 444, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (710, 285, 389, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (711, 285, 348, 1, 599.00, 599.00, 0.00, 599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (712, 286, 318, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (713, 286, 327, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (714, 287, 384, 1, 1599.00, 1599.00, 0.00, 1599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (715, 288, 432, 1, 2599.00, 2599.00, 0.00, 2599.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (716, 288, 459, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (717, 289, 342, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (718, 289, 309, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (719, 290, 445, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (720, 290, 352, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (721, 290, 371, 1, 2199.00, 2199.00, 0.00, 2199.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (722, 290, 386, 1, 1449.00, 1449.00, 0.00, 1449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (723, 291, 354, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (724, 291, 395, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (725, 291, 429, 1, 2999.00, 2999.00, 0.00, 2999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (726, 292, 392, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (727, 292, 386, 1, 1449.00, 1449.00, 0.00, 1449.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (728, 292, 312, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (729, 292, 364, 1, 2499.00, 2499.00, 0.00, 2499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (730, 293, 364, 2, 2499.00, 4998.00, 0.00, 4998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (731, 293, 359, 1, 220.00, 220.00, 0.00, 220.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (732, 293, 382, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (733, 294, 390, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (734, 294, 355, 2, 600.00, 1200.00, 0.00, 1200.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (735, 294, 428, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (736, 295, 325, 2, 429.00, 858.00, 0.00, 858.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (737, 296, 377, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (738, 297, 351, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (739, 297, 453, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (740, 298, 324, 1, 499.00, 499.00, 0.00, 499.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (741, 298, 362, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (742, 298, 310, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (743, 299, 367, 2, 1899.00, 3798.00, 0.00, 3798.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (744, 300, 372, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (745, 300, 404, 2, 149.00, 298.00, 0.00, 298.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (746, 300, 382, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items (id, "orderId", "productId", quantity, "unitPrice", subtotal, "discountAmount", total) VALUES (747, 300, 429, 1, 2999.00, 2999.00, 0.00, 2999.00);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (201, 'ORD-2026-001', 47, 19, 'CANCELLED', 6595.00, NULL, 0.00, 0.00, 6595.00, NULL, '2026-01-03 11:19:06.666', '2026-01-07 11:12:03.705', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (202, 'ORD-2026-002', 53, 19, 'CANCELLED', 4697.00, NULL, 0.00, 0.00, 4697.00, NULL, '2026-01-01 20:40:57.172', '2026-01-07 11:12:03.724', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (203, 'ORD-2026-003', 42, 18, 'COMPLETED', 4495.00, NULL, 0.00, 0.00, 4495.00, NULL, '2026-01-04 23:41:33.221', '2026-01-07 11:12:03.733', '2026-01-04 23:41:33.221');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (204, 'ORD-2026-004', 36, 19, 'COMPLETED', 5374.00, NULL, 0.00, 0.00, 5374.00, NULL, '2025-12-31 11:49:20.168', '2026-01-07 11:12:03.749', '2025-12-31 11:49:20.168');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (205, 'ORD-2026-005', 38, 17, 'COMPLETED', 3166.00, NULL, 0.00, 0.00, 3166.00, NULL, '2026-01-02 13:30:33.05', '2026-01-07 11:12:03.76', '2026-01-02 13:30:33.05');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (206, 'ORD-2026-006', 56, 19, 'COMPLETED', 5996.00, NULL, 0.00, 0.00, 5996.00, NULL, '2026-01-06 16:06:57.028', '2026-01-07 11:12:03.773', '2026-01-06 16:06:57.028');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (207, 'ORD-2026-007', 45, 17, 'CANCELLED', 3875.00, NULL, 0.00, 0.00, 3875.00, NULL, '2025-12-20 20:33:46.598', '2026-01-07 11:12:03.788', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (208, 'ORD-2026-008', 54, 18, 'PENDING', 6345.00, NULL, 0.00, 0.00, 6345.00, NULL, '2026-01-04 06:19:05.998', '2026-01-07 11:12:03.798', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (209, 'ORD-2026-009', 54, 18, 'PROCESSING', 3898.00, NULL, 0.00, 0.00, 3898.00, NULL, '2026-01-05 22:42:03.921', '2026-01-07 11:12:03.809', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (210, 'ORD-2026-010', 45, 19, 'PENDING', 4146.00, NULL, 0.00, 0.00, 4146.00, NULL, '2026-01-05 04:36:46.081', '2026-01-07 11:12:03.818', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (211, 'ORD-2026-011', 57, 17, 'COMPLETED', 7994.00, NULL, 0.00, 0.00, 7994.00, NULL, '2026-01-02 12:48:16.43', '2026-01-07 11:12:03.828', '2026-01-02 12:48:16.43');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (212, 'ORD-2026-012', 57, 17, 'COMPLETED', 2597.00, NULL, 0.00, 0.00, 2597.00, NULL, '2026-01-01 23:55:38.197', '2026-01-07 11:12:03.843', '2026-01-01 23:55:38.197');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (213, 'ORD-2026-013', 57, 18, 'COMPLETED', 750.00, NULL, 0.00, 0.00, 750.00, NULL, '2026-01-03 14:19:00.35', '2026-01-07 11:12:03.856', '2026-01-03 14:19:00.35');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (214, 'ORD-2026-014', 57, 17, 'PENDING', 3498.00, NULL, 0.00, 0.00, 3498.00, NULL, '2026-01-05 07:22:12.445', '2026-01-07 11:12:03.868', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (215, 'ORD-2026-015', 48, 17, 'COMPLETED', 6553.00, NULL, 0.00, 0.00, 6553.00, NULL, '2026-01-01 11:05:20.262', '2026-01-07 11:12:03.877', '2026-01-01 11:05:20.262');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (216, 'ORD-2026-016', 50, 17, 'COMPLETED', 5444.00, NULL, 0.00, 0.00, 5444.00, NULL, '2025-12-15 01:31:11.692', '2026-01-07 11:12:03.893', '2025-12-15 01:31:11.692');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (217, 'ORD-2026-017', 54, 17, 'COMPLETED', 6046.00, NULL, 0.00, 0.00, 6046.00, NULL, '2026-01-07 00:25:13.046', '2026-01-07 11:12:03.908', '2026-01-07 00:25:13.046');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (218, 'ORD-2026-018', 43, 18, 'CANCELLED', 4636.00, NULL, 0.00, 0.00, 4636.00, NULL, '2026-01-05 10:04:24.932', '2026-01-07 11:12:03.92', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (219, 'ORD-2026-019', 50, 17, 'CANCELLED', 6593.00, NULL, 0.00, 0.00, 6593.00, NULL, '2025-12-30 04:44:46.034', '2026-01-07 11:12:03.929', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (220, 'ORD-2026-020', 53, 18, 'COMPLETED', 5313.00, NULL, 0.00, 0.00, 5313.00, NULL, '2026-01-02 21:12:29.972', '2026-01-07 11:12:03.938', '2026-01-02 21:12:29.972');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (221, 'ORD-2026-021', 55, 19, 'PENDING', 2999.00, NULL, 0.00, 0.00, 2999.00, NULL, '2026-01-04 13:08:12.637', '2026-01-07 11:12:03.949', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (222, 'ORD-2026-022', 38, 19, 'CANCELLED', 6393.00, NULL, 0.00, 0.00, 6393.00, NULL, '2025-12-16 09:33:08.981', '2026-01-07 11:12:03.96', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (223, 'ORD-2026-023', 37, 19, 'COMPLETED', 12594.00, NULL, 0.00, 0.00, 12594.00, NULL, '2026-01-07 03:17:17.654', '2026-01-07 11:12:03.968', '2026-01-07 03:17:17.654');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (224, 'ORD-2026-024', 46, 18, 'PROCESSING', 4285.00, NULL, 0.00, 0.00, 4285.00, NULL, '2026-01-03 21:40:39.782', '2026-01-07 11:12:03.979', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (225, 'ORD-2026-025', 45, 17, 'PENDING', 449.00, NULL, 0.00, 0.00, 449.00, NULL, '2025-12-27 19:02:14.701', '2026-01-07 11:12:03.989', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (226, 'ORD-2026-026', 51, 19, 'COMPLETED', 6396.00, NULL, 0.00, 0.00, 6396.00, NULL, '2026-01-06 09:28:35.466', '2026-01-07 11:12:03.999', '2026-01-06 09:28:35.466');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (227, 'ORD-2026-027', 40, 17, 'COMPLETED', 4897.00, NULL, 0.00, 0.00, 4897.00, NULL, '2026-01-07 04:00:05.911', '2026-01-07 11:12:04.012', '2026-01-07 04:00:05.911');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (228, 'ORD-2026-028', 47, 19, 'PENDING', 1798.00, NULL, 0.00, 0.00, 1798.00, NULL, '2026-01-01 12:07:06.316', '2026-01-07 11:12:04.024', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (229, 'ORD-2026-029', 44, 19, 'COMPLETED', 3795.00, NULL, 0.00, 0.00, 3795.00, NULL, '2026-01-05 02:40:57.649', '2026-01-07 11:12:04.033', '2026-01-05 02:40:57.649');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (230, 'ORD-2026-030', 41, 17, 'COMPLETED', 10193.00, NULL, 0.00, 0.00, 10193.00, NULL, '2026-01-02 20:36:09.914', '2026-01-07 11:12:04.046', '2026-01-02 20:36:09.914');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (231, 'ORD-2026-031', 37, 19, 'COMPLETED', 2448.00, NULL, 0.00, 0.00, 2448.00, NULL, '2026-01-04 21:29:05.406', '2026-01-07 11:12:04.06', '2026-01-04 21:29:05.406');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (232, 'ORD-2026-032', 46, 19, 'PROCESSING', 5794.00, NULL, 0.00, 0.00, 5794.00, NULL, '2026-01-04 21:27:26.574', '2026-01-07 11:12:04.072', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (233, 'ORD-2026-033', 54, 17, 'PENDING', 3896.00, NULL, 0.00, 0.00, 3896.00, NULL, '2026-01-06 05:05:10.054', '2026-01-07 11:12:04.081', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (234, 'ORD-2026-034', 50, 17, 'COMPLETED', 6494.00, NULL, 0.00, 0.00, 6494.00, NULL, '2026-01-06 12:12:26.835', '2026-01-07 11:12:04.092', '2026-01-06 12:12:26.835');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (235, 'ORD-2026-035', 53, 19, 'PENDING', 1449.00, NULL, 0.00, 0.00, 1449.00, NULL, '2026-01-05 01:55:39.723', '2026-01-07 11:12:04.103', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (236, 'ORD-2026-036', 37, 17, 'CANCELLED', 3697.00, NULL, 0.00, 0.00, 3697.00, NULL, '2026-01-06 12:30:10.416', '2026-01-07 11:12:04.111', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (237, 'ORD-2026-037', 43, 19, 'PENDING', 798.00, NULL, 0.00, 0.00, 798.00, NULL, '2026-01-05 15:34:31.733', '2026-01-07 11:12:04.12', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (238, 'ORD-2026-038', 37, 17, 'COMPLETED', 5997.00, NULL, 0.00, 0.00, 5997.00, NULL, '2026-01-04 06:45:36.357', '2026-01-07 11:12:04.129', '2026-01-04 06:45:36.357');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (239, 'ORD-2026-039', 37, 17, 'PROCESSING', 5194.00, NULL, 0.00, 0.00, 5194.00, NULL, '2025-12-26 18:17:18.249', '2026-01-07 11:12:04.141', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (240, 'ORD-2026-040', 42, 18, 'COMPLETED', 3697.00, NULL, 0.00, 0.00, 3697.00, NULL, '2025-12-31 15:09:20.424', '2026-01-07 11:12:04.151', '2025-12-31 15:09:20.424');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (241, 'ORD-2026-041', 38, 17, 'PROCESSING', 649.00, NULL, 0.00, 0.00, 649.00, NULL, '2026-01-04 15:59:56.448', '2026-01-07 11:12:04.163', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (242, 'ORD-2026-042', 36, 17, 'COMPLETED', 5296.00, NULL, 0.00, 0.00, 5296.00, NULL, '2026-01-06 23:48:03.683', '2026-01-07 11:12:04.172', '2026-01-06 23:48:03.683');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (243, 'ORD-2026-043', 50, 19, 'COMPLETED', 5894.00, NULL, 0.00, 0.00, 5894.00, NULL, '2025-12-20 18:51:49.093', '2026-01-07 11:12:04.185', '2025-12-20 18:51:49.093');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (244, 'ORD-2026-044', 57, 17, 'COMPLETED', 9574.00, NULL, 0.00, 0.00, 9574.00, NULL, '2026-01-06 17:12:41.137', '2026-01-07 11:12:04.195', '2026-01-06 17:12:41.137');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (245, 'ORD-2026-045', 50, 17, 'COMPLETED', 3418.00, NULL, 0.00, 0.00, 3418.00, NULL, '2025-12-31 21:18:51.832', '2026-01-07 11:12:04.206', '2025-12-31 21:18:51.832');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (246, 'ORD-2026-046', 44, 17, 'COMPLETED', 2797.00, NULL, 0.00, 0.00, 2797.00, NULL, '2026-01-01 07:18:42.803', '2026-01-07 11:12:04.216', '2026-01-01 07:18:42.803');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (247, 'ORD-2026-047', 54, 17, 'PENDING', 958.00, NULL, 0.00, 0.00, 958.00, NULL, '2025-12-31 01:03:15.862', '2026-01-07 11:12:04.226', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (248, 'ORD-2026-048', 50, 17, 'PENDING', 4046.00, NULL, 0.00, 0.00, 4046.00, NULL, '2026-01-02 04:00:31.181', '2026-01-07 11:12:04.232', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (249, 'ORD-2026-049', 43, 19, 'COMPLETED', 4497.00, NULL, 0.00, 0.00, 4497.00, NULL, '2026-01-04 17:42:34.275', '2026-01-07 11:12:04.24', '2026-01-04 17:42:34.275');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (250, 'ORD-2026-050', 44, 17, 'CANCELLED', 6446.00, NULL, 0.00, 0.00, 6446.00, NULL, '2026-01-04 17:14:51.911', '2026-01-07 11:12:04.254', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (251, 'ORD-2026-051', 49, 19, 'COMPLETED', 2998.00, NULL, 0.00, 0.00, 2998.00, NULL, '2025-12-14 21:23:33.005', '2026-01-07 11:12:04.261', '2025-12-14 21:23:33.005');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (252, 'ORD-2026-052', 45, 19, 'CANCELLED', 2697.00, NULL, 0.00, 0.00, 2697.00, NULL, '2025-12-10 20:13:51.384', '2026-01-07 11:12:04.272', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (253, 'ORD-2026-053', 36, 17, 'COMPLETED', 11295.00, NULL, 0.00, 0.00, 11295.00, NULL, '2026-01-06 15:44:34.268', '2026-01-07 11:12:04.28', '2026-01-06 15:44:34.268');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (254, 'ORD-2026-054', 37, 17, 'CANCELLED', 1499.00, NULL, 0.00, 0.00, 1499.00, NULL, '2025-12-30 11:38:18.951', '2026-01-07 11:12:04.294', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (255, 'ORD-2026-055', 38, 17, 'COMPLETED', 7794.00, NULL, 0.00, 0.00, 7794.00, NULL, '2026-01-01 01:10:43.99', '2026-01-07 11:12:04.303', '2026-01-01 01:10:43.99');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (256, 'ORD-2026-056', 40, 18, 'COMPLETED', 699.00, NULL, 0.00, 0.00, 699.00, NULL, '2025-12-25 02:27:03.602', '2026-01-07 11:12:04.314', '2025-12-25 02:27:03.602');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (257, 'ORD-2026-057', 36, 19, 'COMPLETED', 1396.00, NULL, 0.00, 0.00, 1396.00, NULL, '2025-12-31 14:07:55.836', '2026-01-07 11:12:04.325', '2025-12-31 14:07:55.836');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (258, 'ORD-2026-058', 47, 18, 'COMPLETED', 3798.00, NULL, 0.00, 0.00, 3798.00, NULL, '2026-01-04 22:09:28.031', '2026-01-07 11:12:04.336', '2026-01-04 22:09:28.031');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (259, 'ORD-2026-059', 43, 17, 'CANCELLED', 399.00, NULL, 0.00, 0.00, 399.00, NULL, '2026-01-04 03:34:29.249', '2026-01-07 11:12:04.346', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (260, 'ORD-2026-060', 42, 18, 'PROCESSING', 1697.00, NULL, 0.00, 0.00, 1697.00, NULL, '2026-01-04 23:39:12.847', '2026-01-07 11:12:04.354', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (261, 'ORD-2026-061', 47, 17, 'COMPLETED', 1099.00, NULL, 0.00, 0.00, 1099.00, NULL, '2026-01-02 12:08:39.795', '2026-01-07 11:12:04.363', '2026-01-02 12:08:39.795');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (262, 'ORD-2026-062', 45, 17, 'PROCESSING', 1777.00, NULL, 0.00, 0.00, 1777.00, NULL, '2026-01-06 07:29:13.518', '2026-01-07 11:12:04.373', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (263, 'ORD-2026-063', 45, 17, 'PROCESSING', 8995.00, NULL, 0.00, 0.00, 8995.00, NULL, '2025-12-31 14:10:27.339', '2026-01-07 11:12:04.38', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (264, 'ORD-2026-064', 56, 19, 'PENDING', 1726.00, NULL, 0.00, 0.00, 1726.00, NULL, '2026-01-05 03:22:54.989', '2026-01-07 11:12:04.39', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (265, 'ORD-2026-065', 38, 19, 'COMPLETED', 8152.00, NULL, 0.00, 0.00, 8152.00, NULL, '2026-01-04 12:46:50.406', '2026-01-07 11:12:04.399', '2026-01-04 12:46:50.406');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (266, 'ORD-2026-066', 44, 18, 'COMPLETED', 999.00, NULL, 0.00, 0.00, 999.00, NULL, '2026-01-02 08:43:45.326', '2026-01-07 11:12:04.411', '2026-01-02 08:43:45.326');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (267, 'ORD-2026-067', 52, 17, 'COMPLETED', 6296.00, NULL, 0.00, 0.00, 6296.00, NULL, '2025-12-30 05:11:54.221', '2026-01-07 11:12:04.421', '2025-12-30 05:11:54.221');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (268, 'ORD-2026-068', 45, 18, 'PROCESSING', 2696.00, NULL, 0.00, 0.00, 2696.00, NULL, '2026-01-01 09:19:01.24', '2026-01-07 11:12:04.434', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (269, 'ORD-2026-069', 36, 17, 'COMPLETED', 3695.00, NULL, 0.00, 0.00, 3695.00, NULL, '2025-12-31 14:41:42.172', '2026-01-07 11:12:04.444', '2025-12-31 14:41:42.172');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (270, 'ORD-2026-070', 45, 19, 'COMPLETED', 6198.00, NULL, 0.00, 0.00, 6198.00, NULL, '2025-12-20 20:20:59.447', '2026-01-07 11:12:04.455', '2025-12-20 20:20:59.447');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (271, 'ORD-2026-071', 51, 18, 'COMPLETED', 998.00, NULL, 0.00, 0.00, 998.00, NULL, '2026-01-01 02:44:49.632', '2026-01-07 11:12:04.466', '2026-01-01 02:44:49.632');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (272, 'ORD-2026-072', 55, 18, 'COMPLETED', 11592.00, NULL, 0.00, 0.00, 11592.00, NULL, '2026-01-01 19:04:33.516', '2026-01-07 11:12:04.476', '2026-01-01 19:04:33.516');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (273, 'ORD-2026-073', 49, 18, 'PENDING', 4395.00, NULL, 0.00, 0.00, 4395.00, NULL, '2026-01-03 12:14:54.809', '2026-01-07 11:12:04.489', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (274, 'ORD-2026-074', 40, 18, 'PENDING', 10593.00, NULL, 0.00, 0.00, 10593.00, NULL, '2026-01-02 02:04:19.833', '2026-01-07 11:12:04.497', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (275, 'ORD-2026-075', 39, 17, 'COMPLETED', 3997.00, NULL, 0.00, 0.00, 3997.00, NULL, '2026-01-03 02:56:07.454', '2026-01-07 11:12:04.505', '2026-01-03 02:56:07.454');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (276, 'ORD-2026-076', 47, 19, 'PENDING', 999.00, NULL, 0.00, 0.00, 999.00, NULL, '2025-12-12 19:57:27.486', '2026-01-07 11:12:04.515', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (277, 'ORD-2026-077', 49, 17, 'COMPLETED', 5596.00, NULL, 0.00, 0.00, 5596.00, NULL, '2025-12-13 06:51:17.55', '2026-01-07 11:12:04.522', '2025-12-13 06:51:17.55');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (278, 'ORD-2026-078', 40, 19, 'PENDING', 8293.00, NULL, 0.00, 0.00, 8293.00, NULL, '2025-12-15 17:39:41.103', '2026-01-07 11:12:04.536', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (279, 'ORD-2026-079', 46, 18, 'CANCELLED', 3174.00, NULL, 0.00, 0.00, 3174.00, NULL, '2025-12-31 21:57:40.626', '2026-01-07 11:12:04.546', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (280, 'ORD-2026-080', 37, 17, 'COMPLETED', 5992.00, NULL, 0.00, 0.00, 5992.00, NULL, '2026-01-01 21:00:23.331', '2026-01-07 11:12:04.555', '2026-01-01 21:00:23.331');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (281, 'ORD-2026-081', 57, 17, 'COMPLETED', 5695.00, NULL, 0.00, 0.00, 5695.00, NULL, '2025-12-26 17:20:27.431', '2026-01-07 11:12:04.566', '2025-12-26 17:20:27.431');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (282, 'ORD-2026-082', 57, 17, 'COMPLETED', 2297.00, NULL, 0.00, 0.00, 2297.00, NULL, '2026-01-01 12:06:10.68', '2026-01-07 11:12:04.575', '2026-01-01 12:06:10.68');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (283, 'ORD-2026-083', 52, 18, 'CANCELLED', 2997.00, NULL, 0.00, 0.00, 2997.00, NULL, '2026-01-06 19:16:53.113', '2026-01-07 11:12:04.585', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (284, 'ORD-2026-084', 36, 18, 'PENDING', 999.00, NULL, 0.00, 0.00, 999.00, NULL, '2026-01-07 02:05:39.551', '2026-01-07 11:12:04.593', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (285, 'ORD-2026-085', 41, 19, 'COMPLETED', 2997.00, NULL, 0.00, 0.00, 2997.00, NULL, '2026-01-01 19:51:11.754', '2026-01-07 11:12:04.6', '2026-01-01 19:51:11.754');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (286, 'ORD-2026-086', 39, 17, 'COMPLETED', 2996.00, NULL, 0.00, 0.00, 2996.00, NULL, '2025-12-31 12:46:33.721', '2026-01-07 11:12:04.609', '2025-12-31 12:46:33.721');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (287, 'ORD-2026-087', 49, 18, 'COMPLETED', 1599.00, NULL, 0.00, 0.00, 1599.00, NULL, '2025-12-09 16:53:58.025', '2026-01-07 11:12:04.618', '2025-12-09 16:53:58.025');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (288, 'ORD-2026-088', 46, 19, 'COMPLETED', 4598.00, NULL, 0.00, 0.00, 4598.00, NULL, '2026-01-04 19:43:48.715', '2026-01-07 11:12:04.627', '2026-01-04 19:43:48.715');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (289, 'ORD-2026-089', 39, 17, 'COMPLETED', 4196.00, NULL, 0.00, 0.00, 4196.00, NULL, '2026-01-01 19:07:27.288', '2026-01-07 11:12:04.64', '2026-01-01 19:07:27.288');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (290, 'ORD-2026-090', 53, 17, 'PROCESSING', 6044.00, NULL, 0.00, 0.00, 6044.00, NULL, '2025-12-10 22:39:46.984', '2026-01-07 11:12:04.652', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (291, 'ORD-2026-091', 38, 17, 'CANCELLED', 4997.00, NULL, 0.00, 0.00, 4997.00, NULL, '2025-12-31 22:59:12.573', '2026-01-07 11:12:04.659', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (292, 'ORD-2026-092', 54, 18, 'COMPLETED', 5396.00, NULL, 0.00, 0.00, 5396.00, NULL, '2026-01-04 18:31:36.125', '2026-01-07 11:12:04.668', '2026-01-04 18:31:36.125');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (293, 'ORD-2026-093', 57, 18, 'COMPLETED', 6216.00, NULL, 0.00, 0.00, 6216.00, NULL, '2026-01-07 09:45:56.573', '2026-01-07 11:12:04.679', '2026-01-07 09:45:56.573');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (294, 'ORD-2026-094', 46, 17, 'COMPLETED', 2898.00, NULL, 0.00, 0.00, 2898.00, NULL, '2026-01-03 11:21:56.521', '2026-01-07 11:12:04.693', '2026-01-03 11:21:56.521');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (295, 'ORD-2026-095', 56, 18, 'COMPLETED', 858.00, NULL, 0.00, 0.00, 858.00, NULL, '2026-01-03 08:36:06.599', '2026-01-07 11:12:04.708', '2026-01-03 08:36:06.599');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (296, 'ORD-2026-096', 41, 19, 'CANCELLED', 1399.00, NULL, 0.00, 0.00, 1399.00, NULL, '2026-01-05 11:12:12.921', '2026-01-07 11:12:04.717', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (297, 'ORD-2026-097', 53, 19, 'COMPLETED', 2596.00, NULL, 0.00, 0.00, 2596.00, NULL, '2026-01-06 11:22:11.508', '2026-01-07 11:12:04.723', '2026-01-06 11:22:11.508');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (298, 'ORD-2026-098', 45, 19, 'COMPLETED', 4496.00, NULL, 0.00, 0.00, 4496.00, NULL, '2025-12-29 17:14:17.59', '2026-01-07 11:12:04.733', '2025-12-29 17:14:17.59');
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (299, 'ORD-2026-099', 48, 18, 'CANCELLED', 3798.00, NULL, 0.00, 0.00, 3798.00, NULL, '2026-01-03 04:02:52.075', '2026-01-07 11:12:04.746', NULL);
INSERT INTO public.orders (id, "orderNumber", "customerId", "userId", status, subtotal, "discountId", "discountAmount", "taxAmount", total, notes, "createdAt", "updatedAt", "completedAt") VALUES (300, 'ORD-2026-100', 38, 19, 'PROCESSING', 5294.00, NULL, 0.00, 0.00, 5294.00, NULL, '2026-01-06 22:00:13.272', '2026-01-07 11:12:04.753', NULL);


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (457, 309, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', 0, true, '2026-01-07 11:12:02.37');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (458, 309, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 1, false, '2026-01-07 11:12:02.37');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (459, 309, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 2, false, '2026-01-07 11:12:02.37');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (460, 310, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_5.png', 0, true, '2026-01-07 11:12:02.42');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (461, 310, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 1, false, '2026-01-07 11:12:02.42');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (462, 310, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 2, false, '2026-01-07 11:12:02.42');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (463, 311, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_2__5_2_1_1_1_1_2_1_1.jpg', 0, true, '2026-01-07 11:12:02.437');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (464, 311, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 1, false, '2026-01-07 11:12:02.437');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (465, 311, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 2, false, '2026-01-07 11:12:02.437');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (466, 312, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-plus_1_.png', 0, true, '2026-01-07 11:12:02.445');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (467, 312, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 1, false, '2026-01-07 11:12:02.445');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (468, 312, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 2, false, '2026-01-07 11:12:02.445');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (469, 313, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_2__5_2_1_1_1_1_2_1_1.jpg', 0, true, '2026-01-07 11:12:02.454');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (470, 313, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 1, false, '2026-01-07 11:12:02.454');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (471, 313, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 2, false, '2026-01-07 11:12:02.454');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (472, 314, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2023_9_13_638302007249847040_iPhone_15_Plus_Blue_Pure_Back_iPhone_15_Plus_Blue_Pure_Front_2up_Screen__USEN.jpg', 0, true, '2026-01-07 11:12:02.462');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (473, 314, 'https://cdn.tgdd.vn/Products/Images/42/303891/iphone-15-plus-1-750x500.jpg', 1, false, '2026-01-07 11:12:02.462');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (474, 314, 'https://cdn.tgdd.vn/Products/Images/42/303891/s16/iphone-15-plus-vang-1-650x650.jpg', 2, false, '2026-01-07 11:12:02.462');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (475, 315, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/dien-thoai-iphone-15-plus-256gb-3.jpg', 0, true, '2026-01-07 11:12:02.47');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (476, 315, 'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-130923-014953.jpg', 1, false, '2026-01-07 11:12:02.47');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (477, 315, 'https://cdn.tgdd.vn/Products/Images/42/303823/iphone-15-plus-256gb-xanh-thumb-600x600.jpg', 2, false, '2026-01-07 11:12:02.47');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (478, 316, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/n/vn_iphone_15_yellow_pdp_image_position-1a_yellow_color_1_4_1_1.jpg', 0, true, '2026-01-07 11:12:02.478');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (479, 316, 'https://clickbuy.com.vn/uploads/pro/2_51654.jpg', 1, false, '2026-01-07 11:12:02.478');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (480, 316, 'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-1-3-750x500.jpg', 2, false, '2026-01-07 11:12:02.478');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (481, 317, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/dien-thoai-iphone-15-256gb-8.jpg', 0, true, '2026-01-07 11:12:02.49');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (482, 317, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/n/vn_iphone_15_pink_pdp_image_position-9_accessory_1.jpg', 1, false, '2026-01-07 11:12:02.49');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (483, 317, 'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-1-3-750x500.jpg', 2, false, '2026-01-07 11:12:02.49');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (484, 318, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/_/t_m_18_1_3_2.png', 0, true, '2026-01-07 11:12:02.499');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (485, 318, 'https://bachlongstore.vn/vnt_upload/product/11_2023/5646.jpg', 1, false, '2026-01-07 11:12:02.499');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (486, 318, 'https://thangtaostore.com/watermark/product/540x540x2/upload/product/14prm-nen-6822.png', 2, false, '2026-01-07 11:12:02.499');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (487, 319, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/_/v_ng_12_1_2_1.png', 0, true, '2026-01-07 11:12:02.506');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (488, 319, 'https://bachlongstore.vn/vnt_upload/product/11_2023/5646.jpg', 1, false, '2026-01-07 11:12:02.506');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (489, 319, 'https://thangtaostore.com/watermark/product/540x540x2/upload/product/14prm-nen-6822.png', 2, false, '2026-01-07 11:12:02.506');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (490, 320, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/h/photo_2022-09-28_21-58-51_4_1_2_2.jpg', 0, true, '2026-01-07 11:12:02.515');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (491, 320, 'https://cdn2.fptshop.com.vn/unsafe/564x0/filters:quality(80)/Uploads/images/2015/Tin-Tuc/02/iPhone-14-Plus.jpg', 1, false, '2026-01-07 11:12:02.515');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (492, 320, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkM7pjbtU7CkTq6yJNNpS_VBvfYvEjRwH_JA&s', 2, false, '2026-01-07 11:12:02.515');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (493, 321, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/h/photo_2022-09-28_21-58-56_11_1.jpg', 0, true, '2026-01-07 11:12:02.523');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (494, 321, 'https://www.didongmy.com/vnt_upload/product/09_2022/thumbs/(600x600)_14xam_didongmy_600x600.png', 1, false, '2026-01-07 11:12:02.523');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (495, 321, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkM7pjbtU7CkTq6yJNNpS_VBvfYvEjRwH_JA&s', 2, false, '2026-01-07 11:12:02.523');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (496, 322, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-13_2_2.jpg', 0, true, '2026-01-07 11:12:02.531');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (497, 322, 'https://mac24h.vn/images/detailed/92/iPhone13-2021.png', 1, false, '2026-01-07 11:12:02.531');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (498, 322, 'https://trangthienlong.com.vn/wp-content/uploads/2024/11/iphone-13-thuong-vs-iphone-13-mini-128gb-256gb-512gb.jpg', 2, false, '2026-01-07 11:12:02.531');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (499, 323, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/4/14_1_9_2_6.jpg', 0, true, '2026-01-07 11:12:02.54');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (500, 323, 'https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111872_iphone13-mini-colors-480.png', 1, false, '2026-01-07 11:12:02.54');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (501, 323, 'https://cdn.tgdd.vn/Products/Images/42/236780/Kit/iphone-13-mini-n.jpg', 2, false, '2026-01-07 11:12:02.54');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (502, 324, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12.png', 0, true, '2026-01-07 11:12:02.547');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (503, 324, 'https://trangthienlong.com.vn/wp-content/uploads/2024/11/iphone-12-thuong-vs-iphone-12-mini-64gb-128gb-256gb.jpg', 1, false, '2026-01-07 11:12:02.547');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (504, 324, 'https://bvtmobile.com/uploads/source/iphone12-1/iphone-12-purple.jpg', 2, false, '2026-01-07 11:12:02.547');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (505, 325, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_359_1.png', 0, true, '2026-01-07 11:12:02.555');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (506, 325, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8NgCLku1R6mXVtCPnfcJ69eCVlKUTDw2F9A&s', 1, false, '2026-01-07 11:12:02.555');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (507, 325, 'https://cdn.tgdd.vn/Files/2022/01/18/1411437/265266695_455337209385670_598702_1280x1596-800-resize.jpg', 2, false, '2026-01-07 11:12:02.555');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (508, 326, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2022_4_15_637856361035158510_iPhone%20SE%20(8).jpg', 0, true, '2026-01-07 11:12:02.562');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (509, 326, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8NgCLku1R6mXVtCPnfcJ69eCVlKUTDw2F9A&s', 1, false, '2026-01-07 11:12:02.562');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (510, 326, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG4irNnFC0x8E0XZWuOjNEhbuP4f3gEKF75g&s', 2, false, '2026-01-07 11:12:02.562');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (511, 327, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-11.png', 0, true, '2026-01-07 11:12:02.569');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (512, 327, 'https://product.hstatic.net/200000768357/product/_thuong__-_color_321d25895d074fcb834639ed7bd57c89.png', 1, false, '2026-01-07 11:12:02.569');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (513, 327, 'https://cdn.hstatic.net/products/1000359786/dsc04242_b7d12b5a18804611994a2973ddcc37da_master.jpg', 2, false, '2026-01-07 11:12:02.569');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (514, 328, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/d/o/download_4_2_2.png', 0, true, '2026-01-07 11:12:02.576');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (515, 328, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTORePfP_KQXTOlzpv1KwOIkGftpyXwe-kfw&s', 1, false, '2026-01-07 11:12:02.576');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (516, 328, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfGa9_vOfQFnIp4khLHO_CUX7J6kqOJQ3N_Q&s', 2, false, '2026-01-07 11:12:02.576');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (517, 329, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/d/o/download_2__1_27.png', 0, true, '2026-01-07 11:12:02.585');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (518, 329, 'https://qkm.vn/wp-content/uploads/2024/07/iphone-12-pro-128gb-256gb-512gb-cu-like-new-9-qkm-1.jpg', 1, false, '2026-01-07 11:12:02.585');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (519, 329, 'https://images.tokopedia.net/img/cache/700/VqbcmM/2024/3/26/15fe9df0-1b80-491f-8095-df4973d45416.jpg', 2, false, '2026-01-07 11:12:02.585');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (520, 330, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone_xs_max_512gb_1_1.jpg', 0, true, '2026-01-07 11:12:02.593');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (521, 330, 'https://bizweb.dktcdn.net/thumb/grande/100/372/421/products/apple-iphone-xs-black-92641fd4-2491-46ce-8443-6ec1a6b50b74.png?v=1741951045827', 1, false, '2026-01-07 11:12:02.593');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (522, 330, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9LyRziohMSb_26zq7VG6IxCg1Br0-tW-R8g&s', 2, false, '2026-01-07 11:12:02.593');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (523, 331, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone_xr_64gb_1.png', 0, true, '2026-01-07 11:12:02.601');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (524, 331, 'https://truonggiang.vn/wp-content/uploads/2022/05/iphone-xr-64gb-cu-1.jpg', 1, false, '2026-01-07 11:12:02.601');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (525, 331, 'https://cdn.tgdd.vn/Products/Images/42/230406/Kit/iphone-xr-64gb-hop-moi-note-1.jpg', 2, false, '2026-01-07 11:12:02.601');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (526, 332, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone8-plus-silver-select-2018_6_3.png', 0, true, '2026-01-07 11:12:02.609');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (527, 332, 'https://truonggiang.vn/wp-content/uploads/2021/02/iphone-8-plus-64gb-2.jpg', 1, false, '2026-01-07 11:12:02.609');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (528, 332, 'https://24hstore.vn/images/products/2025/05/30/large/iphone-8-plus-64gb-cu-98.jpg', 2, false, '2026-01-07 11:12:02.609');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (529, 333, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/p/h/photo_2024-10-02_13-59-00_1.jpg', 0, true, '2026-01-07 11:12:02.618');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (530, 333, 'https://rauvang.com/data/Product/iphone-16-pro-max-all.htm_1726020874.jpg', 1, false, '2026-01-07 11:12:02.618');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (531, 333, 'https://hdmobi.vn/wp-content/uploads/2024/11/iphone-16-pro-max-400x400.jpg', 2, false, '2026-01-07 11:12:02.618');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (532, 334, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro_1.png', 0, true, '2026-01-07 11:12:02.628');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (533, 334, 'https://rauvang.com/data/Product/iphone-16-pro-max-all.htm_1726020874.jpg', 1, false, '2026-01-07 11:12:02.628');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (534, 334, 'https://hdmobi.vn/wp-content/uploads/2024/11/iphone-16-pro-max-400x400.jpg', 2, false, '2026-01-07 11:12:02.628');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (535, 335, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-plus-1.png', 0, true, '2026-01-07 11:12:02.636');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (536, 335, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-plus-6.png', 1, false, '2026-01-07 11:12:02.636');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (537, 335, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/329138/iphone-16-plus-1-638639830699738117.jpg', 2, false, '2026-01-07 11:12:02.636');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (538, 336, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-1.png', 0, true, '2026-01-07 11:12:02.643');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (539, 336, 'https://bvtmobile.com/uploads/source/ip16/3ead4148a56b2b136ab7581af5df98af.jpg', 1, false, '2026-01-07 11:12:02.643');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (540, 336, 'https://www.didongmy.com/vnt_upload/product/09_2024/thumbs/(600x600)_iphone_16_mau_trang_didongmy_thumb_600x600.jpg', 2, false, '2026-01-07 11:12:02.643');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (541, 337, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16e-128gb.png', 0, true, '2026-01-07 11:12:02.649');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (542, 337, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV6a2rHtKofwe4LaZwa9tmLrKhAGQiczbBKQ&s', 1, false, '2026-01-07 11:12:02.649');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (543, 337, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIR0kuICiJMkpgh7VxokXayX3Jx9WBY5yneg&s', 2, false, '2026-01-07 11:12:02.649');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (544, 338, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-spacegray-202210-02_3_3_1_1_1_4.jpg', 0, true, '2026-01-07 11:12:02.656');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (545, 338, 'https://hoangsonstore.com/wp-content/uploads/2023/01/ipad-pro-m2-12-9-inch-2022-wifi-128gb-moi-100-4498-9.jpg', 1, false, '2026-01-07 11:12:02.656');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (546, 338, 'https://phucanhcdn.com/media/product/49294_wifi_128gbb.jpg', 2, false, '2026-01-07 11:12:02.656');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (547, 339, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-13-select-202210_3_1.png', 0, true, '2026-01-07 11:12:02.662');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (548, 339, 'https://cdn.tgdd.vn/Products/Images/522/295468/Slider/ipad-pro-m2-12.9-inch-wifi-cellular-256gb638030923425442302.jpg', 1, false, '2026-01-07 11:12:02.662');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (549, 339, 'https://product.hstatic.net/200000525189/product/ipad_pro_xam_1f32e1ae3df44c35b5b3b65cbbae9c94_1024x1024.png', 2, false, '2026-01-07 11:12:02.662');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (550, 340, 'https://cdn.tgdd.vn/Products/Images/522/295464/ipad-pro-m2-12.5-wifi-xam-thumb-600x600.jpg', 0, true, '2026-01-07 11:12:02.668');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (551, 340, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm81Tp_UUt-55DSUzXRuHPEqye7el7SxUsvQ&s', 1, false, '2026-01-07 11:12:02.668');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (552, 340, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRR4WRkax6esH-dLzqJX2NxCCOKUQ5nUEFswA&s', 2, false, '2026-01-07 11:12:02.668');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (553, 341, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01_4.jpg', 0, true, '2026-01-07 11:12:02.676');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (554, 341, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIWAz27a_a3nqmpNV0twAHy7e5zIM7whm0ww&s', 1, false, '2026-01-07 11:12:02.676');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (555, 341, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRR4WRkax6esH-dLzqJX2NxCCOKUQ5nUEFswA&s', 2, false, '2026-01-07 11:12:02.676');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (556, 342, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-13-select-202210_1_1_1.png', 0, true, '2026-01-07 11:12:02.683');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (557, 342, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDst8InmVt2Cv-8_KE-jlbsch99V6JBWho0w&s', 1, false, '2026-01-07 11:12:02.683');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (558, 342, 'https://product.hstatic.net/1000329106/product/ipad-pro-m2-wifi-bac-4_c431a0f9999a4c1e84f87eb9efd385fa_master.jpg', 2, false, '2026-01-07 11:12:02.683');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (559, 343, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-air-5.png', 0, true, '2026-01-07 11:12:02.69');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (560, 343, 'https://bachlongstore.vn/vnt_upload/product/11_2023/thumbs/1000_43543.jpg', 1, false, '2026-01-07 11:12:02.69');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (561, 343, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe11ZOYkPc9x8kxEZXwptVw50MYraBpZ1kRA&s', 2, false, '2026-01-07 11:12:02.69');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (562, 344, 'https://cdn.tgdd.vn/Products/Images/522/274154/ipad-air-5-wifi-blue-thumb-1-600x600.jpg', 0, true, '2026-01-07 11:12:02.697');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (563, 344, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0iDUvTzRZcx7B5tD4_3WNsHpgAGMemqYKFw&s', 1, false, '2026-01-07 11:12:02.697');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (564, 344, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTbOsDPRvn7Cjx-7BxOQjqqspjyvdpAwwihA&s', 2, false, '2026-01-07 11:12:02.697');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (565, 345, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/_/t_i_xu_ng_2__1_8_1_1.png', 0, true, '2026-01-07 11:12:02.704');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (566, 345, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-mini-6-5.jpg', 1, false, '2026-01-07 11:12:02.704');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (567, 345, 'https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg', 2, false, '2026-01-07 11:12:02.704');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (568, 346, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-mini-6-5_1_1_1_1.jpg', 0, true, '2026-01-07 11:12:02.709');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (569, 346, 'https://minhdatstore.vn/public/uploads/ipad-mini-6-glr-1.jpg', 1, false, '2026-01-07 11:12:02.709');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (570, 346, 'https://laptop360.net/wp-content/uploads/2023/04/Apple-iPad-Mini-6-4.jpg', 2, false, '2026-01-07 11:12:02.709');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (571, 347, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-10-9-inch-2022.png', 0, true, '2026-01-07 11:12:02.716');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (572, 347, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/tablet/iPad/iPad-gen-10/ipad-10-9-inch-2022-7.jpg', 1, false, '2026-01-07 11:12:02.716');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (573, 347, 'https://mac24h.vn/images/detailed/92/IPAD_GEN_10_MAC24H.png', 2, false, '2026-01-07 11:12:02.716');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (574, 348, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-2022-hero-blue-wifi-select_1.png', 0, true, '2026-01-07 11:12:02.722');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (575, 348, 'https://mac24h.vn/images/detailed/92/IPAD_GEN_10_MAC24H.png', 1, false, '2026-01-07 11:12:02.722');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (576, 348, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzjN61i55zCHHpH35T7mOVY37YdkPQsSHkUA&s', 2, false, '2026-01-07 11:12:02.722');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (577, 349, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/c/2c_v.png', 0, true, '2026-01-07 11:12:02.728');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (578, 349, 'https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg', 1, false, '2026-01-07 11:12:02.728');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (579, 349, 'https://phucanhcdn.com/media/lib/09-10-2021/ipadgen9102bvh8.jpg', 2, false, '2026-01-07 11:12:02.728');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (580, 350, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/401/951/products/dacdiemnoibatad7358efe2ed47aa9-6fd11bbc-2a77-4216-b94b-08369a6a8e34.png?v=1749147182043', 0, true, '2026-01-07 11:12:02.735');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (581, 350, 'https://phucanhcdn.com/media/lib/09-10-2021/ipadgen9102bvh8.jpg', 1, false, '2026-01-07 11:12:02.735');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (582, 350, 'https://www.civip.com.vn/media/product/10281_10050587_ipad_gen_9_wifi_256gb_10_2_inch_mk2p3za_a_bac_2021_4.jpg', 2, false, '2026-01-07 11:12:02.735');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (583, 351, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-12-9-2021_1_1_2_1_1_2.jpg', 0, true, '2026-01-07 11:12:02.744');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (584, 351, 'https://dienthoaigiakho.vn/_next/image?url=https%3A%2F%2Fcdn.dienthoaigiakho.vn%2Fphotos%2F1678077654796-ipad-12.9-2021-128-1.jpg&w=3840&q=75', 1, false, '2026-01-07 11:12:02.744');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (585, 351, 'https://cdn.viettablet.com/images/companies/1/0-hinh-moi/tin-tuc/2021/thang-1/13-1/ipad-pro-2021.jpg?1610621599027', 2, false, '2026-01-07 11:12:02.744');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (586, 352, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-11-2021-2_1_1_1_1_1_1_1_1_1_1_1_1_1_1.jpg', 0, true, '2026-01-07 11:12:02.753');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (587, 352, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3vHN-tGsrVWq25QaavkiD9SDzHRK2gQyxfg&s', 1, false, '2026-01-07 11:12:02.753');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (588, 352, 'https://product.hstatic.net/200000373523/product/-tinh-bang-ipad-pro-m1-2021-11-inch-wifi-8gb-128gb-mhqr3za-a-xam-01_1__a02b1bc769cc4ccd85faee6a5820b984_grande.jpg', 2, false, '2026-01-07 11:12:02.753');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (589, 353, 'https://ttcenter.com.vn/uploads/product/zsr37jz9-364-ipad-air-4-10-9-inch-wifi-64gb-like-new.jpg', 0, true, '2026-01-07 11:12:02.761');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (590, 353, 'https://assets.kogan.com/images/brus-australia/BRS-APPLE-IPAD-AIR-4-64GB-W-ANY-G/1-90785cef98-apple_ipad_air_4_any_colour_new.jpg?auto=webp&bg-color=fff&canvas=1200%2C800&dpr=1&enable=upscale&fit=bounds&height=800&quality=90&width=1200', 1, false, '2026-01-07 11:12:02.761');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (591, 353, 'https://cdn.viettablet.com/images/companies/1/0-hinh-moi/tin-tuc/2020/17-9/ipad-air-4-mau-sac.jpg?1600340943574', 2, false, '2026-01-07 11:12:02.761');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (592, 354, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-mini-select-wifi-silver-201903_7_1.png', 0, true, '2026-01-07 11:12:02.768');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (593, 354, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-mini-5_3_1.jpg', 1, false, '2026-01-07 11:12:02.768');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (594, 354, 'https://macvn.com.vn/wp-content/uploads/2023/10/ipad-mini-gen-5-1.jpg', 2, false, '2026-01-07 11:12:02.768');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (595, 355, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-ipad-pro-11-2020-wifi-256-gb-2_2_1_1.jpg', 0, true, '2026-01-07 11:12:02.775');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (596, 355, 'https://2tmobile.com/wp-content/uploads/2022/07/ipad_pro_12_9_inch_2021_2tmobile.jpg', 1, false, '2026-01-07 11:12:02.775');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (597, 355, 'https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-8.jpg', 2, false, '2026-01-07 11:12:02.775');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (598, 356, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_bac_3_1_2.jpg', 0, true, '2026-01-07 11:12:02.785');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (599, 356, 'https://cdn.tgdd.vn/Products/Images/522/220163/Slider/ipad-pro-11-inch-2020-073220-033200-788.jpg', 1, false, '2026-01-07 11:12:02.785');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (600, 356, 'https://2tmobile.com/wp-content/uploads/2022/10/ipad-pro-11-inch-m2-series.jpg', 2, false, '2026-01-07 11:12:02.785');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (601, 357, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/9/19268_ipadgen8sliver_ok_3.jpg', 0, true, '2026-01-07 11:12:02.794');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (602, 357, 'https://bizweb.dktcdn.net/thumb/grande/100/401/951/products/ipad-gen-8-2.png?v=1730041219287', 1, false, '2026-01-07 11:12:02.794');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (603, 357, 'https://i.ebayimg.com/images/g/caIAAOSw5DpgOTCx/s-l400.jpg', 2, false, '2026-01-07 11:12:02.794');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (604, 358, 'https://hoangtrungmobile.vn/wp-content/uploads/2021/03/ipad-air-3-bac.jpg', 0, true, '2026-01-07 11:12:02.803');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (605, 358, 'https://hoangtrungmobile.vn/wp-content/uploads/2021/03/ipad-air-3-1.png', 1, false, '2026-01-07 11:12:02.803');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (606, 358, 'https://cellphones.com.vn/media/wysiwyg/tablet/apple/apple-ipad-air-105-wifi-64gb-chinh-hang-2.jpg', 2, false, '2026-01-07 11:12:02.803');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (607, 359, 'https://didongthongminh.vn/images/products/2025/09/19/original/2(4).jpg', 0, true, '2026-01-07 11:12:02.812');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (608, 359, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpVa9xWhpe-lggq2UlEEtghDF-OS1Qf3udKA&s', 1, false, '2026-01-07 11:12:02.812');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (609, 359, 'https://2tmobile.com/wp-content/uploads/2022/10/ipad-pro-10-5-2017-rose-gold.jpg', 2, false, '2026-01-07 11:12:02.812');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (610, 360, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-9in-gold_3_1_2_1.jpg', 0, true, '2026-01-07 11:12:02.821');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (611, 360, 'https://24hstore.vn/images/products/2024/10/30/large/ipad-pro-9-7-2016-wifi-cellular-cu.jpg', 1, false, '2026-01-07 11:12:02.821');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (612, 360, 'https://shopdunk.com/images/thumbs/0016536_DSC06746-1-800x450_1600.jpeg', 2, false, '2026-01-07 11:12:02.821');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (613, 361, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/b/mba13-m3-midnight-gallery1-202402_3_1_2_1.jpg', 0, true, '2026-01-07 11:12:02.83');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (614, 361, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9ciFFwk8JAZzSj_HnhFmw7R9V0VFcUET99w&s', 1, false, '2026-01-07 11:12:02.83');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (615, 361, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzcw-AOkamn41r6w98MjF_GgPYGMBN2k7XiQ&s', 2, false, '2026-01-07 11:12:02.83');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (616, 362, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/laptop/macbook/Air/M3-2024/macbook-air-m3-15-inch-2024-1_1.jpg', 0, true, '2026-01-07 11:12:02.84');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (617, 362, 'https://cdn.tgdd.vn/News/1562806/1-1280x720.jpg', 1, false, '2026-01-07 11:12:02.84');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (618, 362, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfgklLIT3u0jp1zknXIoVcOYGWCfXck8Qk6A&s', 2, false, '2026-01-07 11:12:02.84');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (619, 363, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/laptop/macbook/macbook-pro-7.jpg', 0, true, '2026-01-07 11:12:02.848');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (620, 363, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0LaLe2Dxa6uVFmI1mmdTO4EkcbnYa1Jq7aQ&s', 1, false, '2026-01-07 11:12:02.848');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (621, 363, 'https://helios-i.mashable.com/imagery/reviews/04xYfyZ1mk1LcppkgmbOzG5/images-14.fill.size_2000x1125.v1701668675.jpg', 2, false, '2026-01-07 11:12:02.848');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (622, 364, 'https://bizweb.dktcdn.net/100/318/659/products/7-5581399e-3267-456a-8d4f-9259ac8f5dc0.jpg?v=1699430082770', 0, true, '2026-01-07 11:12:02.858');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (623, 364, 'https://macone.vn/wp-content/uploads/2023/12/apple-macbook-pro-2023-4.jpeg', 1, false, '2026-01-07 11:12:02.858');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (624, 364, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS28xgUz1fbA0-xerg3SyMgoIvava19dSAn9w&s', 2, false, '2026-01-07 11:12:02.858');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (625, 365, 'https://cdn2.fptshop.com.vn/unsafe/macbook_air_13_m2_midnight_1_35053fbcf9.png', 0, true, '2026-01-07 11:12:02.867');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (626, 365, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHPmPFYftfJXaQvAPdwjZDxLfusqCZpVJW9g&s', 1, false, '2026-01-07 11:12:02.867');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (627, 365, 'https://shopdunk.com/images/thumbs/0018828_so-sanh-macbook-air-m2-13-inch-va-15-inch_1600.jpeg', 2, false, '2026-01-07 11:12:02.867');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (628, 366, 'https://cellphones.com.vn/sforum/wp-content/uploads/2022/01/tren-tay-Dell-XPS-13-Plus-13.jpg', 0, true, '2026-01-07 11:12:02.88');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (629, 366, 'https://cellphones.com.vn/sforum/wp-content/uploads/2022/01/tren-tay-Dell-XPS-13-Plus-12.jpg', 1, false, '2026-01-07 11:12:02.88');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (630, 366, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_3__7_102.png', 2, false, '2026-01-07 11:12:02.88');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (631, 367, 'https://media.wired.com/photos/6169f03b58660fcbc5f4ec3b/master/w_1600%2Cc_limit/Gear-Dell-XPS-15-OLED-1.jpg', 0, true, '2026-01-07 11:12:02.894');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (632, 367, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSwRbnCnclo9IzxAzIdB1v2r2-jPIVF7DRSw&s', 1, false, '2026-01-07 11:12:02.894');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (633, 367, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5JJ7qgZP-lZq8X05QvJEObTdoWK7g6OrFaw&s', 2, false, '2026-01-07 11:12:02.894');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (634, 368, 'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2023/11/10-6.jpg', 0, true, '2026-01-07 11:12:02.902');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (635, 368, 'https://www.laptopvip.vn/images/companies/1/JVS/LENOVO/TP-X1C-G11/10006.jpg?1680061438462', 1, false, '2026-01-07 11:12:02.902');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (636, 368, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRltvy2CyXoprbFFNwIYQ22jFcoklCJaBdv1w&s', 2, false, '2026-01-07 11:12:02.902');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (637, 369, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/a/laptop-hp-spectre-x360-14-ea0023xd-cu-dep-3_1.jpg', 0, true, '2026-01-07 11:12:02.911');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (638, 369, 'https://khoaquan.vn/wp-content/uploads/2023/12/803M6EA-ABU_14_1750x1285.webp', 1, false, '2026-01-07 11:12:02.911');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (639, 369, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJsFo4sNurYpNvb2Xlkmm7E13Dc4GeHrHU3g&s', 2, false, '2026-01-07 11:12:02.911');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (640, 370, 'https://nguyencongpc.vn/media/product/20151-asus-zenbook-duo-14-ux482eg-ka166t-6.jpg', 0, true, '2026-01-07 11:12:02.922');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (641, 370, 'https://dlcdnwebimgs.asus.com/gain/e1c062dc-b3ad-4b84-b310-eda9f5984d2c/', 1, false, '2026-01-07 11:12:02.922');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (642, 370, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBsXHWAG648DddEZ-ShffoL3w3vx3FcB1uTQ&s', 2, false, '2026-01-07 11:12:02.922');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (643, 371, 'https://laptops.vn/wp-content/uploads/2024/06/razer-blade-14-2024-1710487813_1711595620-1.jpg', 0, true, '2026-01-07 11:12:02.933');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (644, 371, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHrfvgh-p4VzqO_ukL1RFy_dSL7VTITruJ3Q&s', 1, false, '2026-01-07 11:12:02.933');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (645, 371, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4IlJyBL2ICq8x16wOPdvtUxMrka3nMeBYpA&s', 2, false, '2026-01-07 11:12:02.933');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (646, 372, 'https://vhost53003.vhostcdn.com/wp-content/uploads/2022/10/microsoft-surface-laptop-5-2.jpg', 0, true, '2026-01-07 11:12:02.941');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (647, 372, 'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2022/11/Microsoft-Surface-Laptop-5-20.jpg', 1, false, '2026-01-07 11:12:02.941');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (648, 372, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7MkaUHUjsps5gFKJWbC8MuinVcQSPybyRbw&s', 2, false, '2026-01-07 11:12:02.941');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (649, 373, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_55__2_11.png', 0, true, '2026-01-07 11:12:02.947');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (650, 373, 'https://mac24h.vn/images/detailed/94/LG_GRAM_17.jpg', 1, false, '2026-01-07 11:12:02.947');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (651, 373, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr4OucSL4UoxtCNtv_h8eiJF8W28_cAS_DVw&s', 2, false, '2026-01-07 11:12:02.947');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (652, 374, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/6/360pro_1.png', 0, true, '2026-01-07 11:12:02.953');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (653, 374, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/g/b/gb3_pro-2-configurator-800x600_1_2.png', 1, false, '2026-01-07 11:12:02.953');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (654, 374, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScwPLewEHjR5BC8ANjydiYyMSEC3JMLrQLZA&s', 2, false, '2026-01-07 11:12:02.953');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (655, 375, 'https://cellphones.com.vn/sforum/wp-content/uploads/2020/06/Acer-Swift-5-SF514-55-Standard_01.png', 0, true, '2026-01-07 11:12:02.96');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (656, 375, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/a/laptop-acer-swift-5-sf514-55t-51nz-2.jpg', 1, false, '2026-01-07 11:12:02.96');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (657, 375, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYQ869QAlPAQX_FyX8HJfDNMUiKfvVrSmdog&s', 2, false, '2026-01-07 11:12:02.96');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (658, 376, 'https://product.hstatic.net/200000722513/product/057vn_9630c86ceec944c49425ef01bb5c879d_master.png', 0, true, '2026-01-07 11:12:02.968');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (659, 376, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_mR-FETn-GwuAM8dMT0RpjJLHkBORjMZcwg&s', 1, false, '2026-01-07 11:12:02.968');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (660, 376, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfqk2m7tRGH-ImM1uqXkrG4bkilwjxetbDdg&s', 2, false, '2026-01-07 11:12:02.968');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (661, 377, 'https://cdn-media.sforum.vn/storage/app/media/chidung/yoga-9i/danh-gia-yoga-9i-2024-14.jpg', 0, true, '2026-01-07 11:12:02.974');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (662, 377, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_19__4_11.png', 1, false, '2026-01-07 11:12:02.974');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (663, 377, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1qo2a1bop9KKSVMh8FIwH6HC4e-Mbu5HAaA&s', 2, false, '2026-01-07 11:12:02.974');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (664, 378, 'https://www.laptopvip.vn/images/ab__webp/detailed/32/notebook-alienware-x14-r2-gray-gallery-6-www.laptopvip.vn-1686985486.webp', 0, true, '2026-01-07 11:12:02.984');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (665, 378, 'https://laptop15.vn/wp-content/uploads/2023/08/Dell-Alienware-X14-R1-2.png', 1, false, '2026-01-07 11:12:02.984');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (666, 378, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/a/laptop-alienware-x14-r1-3.png', 2, false, '2026-01-07 11:12:02.984');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (667, 379, 'https://product.hstatic.net/200000768357/product/gray_fab6e9b0c7374bfd86b9189632447680.png', 0, true, '2026-01-07 11:12:02.991');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (668, 379, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAYJ8TYeoCN6rNc9ymhjhgw46k7_Aj3aDwqQ&s', 1, false, '2026-01-07 11:12:02.991');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (669, 379, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiVkQY_qplE2tLMlAPIfS3wTuy_rT2L-5xfA&s', 2, false, '2026-01-07 11:12:02.991');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (670, 380, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/44/330075/dell-inspiron-15-3520-i5-n3520-i5u085w11slu-1-638627942653445825-750x500.jpg', 0, true, '2026-01-07 11:12:02.998');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (671, 380, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYIV3NYrS7zeOBD7mGLu5305ky5Ss45qjlvg&s', 1, false, '2026-01-07 11:12:02.998');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (672, 380, 'https://www.laptopvip.vn/images/ab__webp/detailed/31/ava-x8q4-0b-www.laptopvip.vn-1678677543.webp', 2, false, '2026-01-07 11:12:02.998');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (673, 381, 'https://www.laptopvip.vn/images/companies/1/JVS/HP/HP-Pavilion-15T/71lc66S1jqL._AC_SL1500_.jpg?1666681642506', 0, true, '2026-01-07 11:12:03.004');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (674, 381, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdAuOwmtb2G1uy9U7DDpZk2IhAhisOZq-dvw&s', 1, false, '2026-01-07 11:12:03.004');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (675, 381, 'https://laptopbaoloc.vn/wp-content/uploads/2023/02/Laptop-HP-Pavilion-15-eg0507TU-3.jpg', 2, false, '2026-01-07 11:12:03.004');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (676, 382, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_1__5_16_1.png', 0, true, '2026-01-07 11:12:03.011');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (677, 382, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/329/122/products/laptop-asus-vivobook-15-x1504va-nj070w-4.jpg?v=1696089769407', 1, false, '2026-01-07 11:12:03.011');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (678, 382, 'https://vt.net.vn/wp-content/uploads/2020/10/asus-vivo15-a1505va-l1114w-1.jpg', 2, false, '2026-01-07 11:12:03.011');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (679, 383, 'https://p3-ofp.static.pub/fes/cms/2022/12/28/cbsimp9kdhc8w1tw2t7pytz6exsvvv545729.jpg', 0, true, '2026-01-07 11:12:03.017');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (680, 383, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDgTiw21igwZMsUXiUsbcZHdXNC-oDr1f0HA&s', 1, false, '2026-01-07 11:12:03.017');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (681, 383, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSL2uB2sPHgWesRdvJPxCnqB6JEdtLPEYfKaQ&s', 2, false, '2026-01-07 11:12:03.017');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (682, 384, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/laptop/macbook/macbook-pro-7.jpg', 0, true, '2026-01-07 11:12:03.024');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (683, 384, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/macbook_pro_14_inch_m4_chip_silver_pdp_image_position_2_vn_vi.jpg', 1, false, '2026-01-07 11:12:03.024');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (684, 384, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSObbZAo9rBWO4d3gnK7bE3eIrk-FoddFLkSg&s', 2, false, '2026-01-07 11:12:03.024');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (685, 385, 'https://hungphatlaptop.com/wp-content/uploads/2024/01/DELL-XPS-14-9440-2024-Platinum-H1-1.jpeg', 0, true, '2026-01-07 11:12:03.033');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (686, 385, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK253slDwNKaR1CF_P5Y07C2LOLhhAI8m8GA&s', 1, false, '2026-01-07 11:12:03.033');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (687, 385, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrx-QJYF4Rg8UE2-dviGO0MfhdAbq0gj7BlQ&s', 2, false, '2026-01-07 11:12:03.033');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (688, 386, 'https://cdn2.fptshop.com.vn/unsafe/800x0/hp_omnibook_ultra_flip_14_fh0040tu_b13vhpa_6_2a358fe388.jpg', 0, true, '2026-01-07 11:12:03.04');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (689, 386, 'https://2tmobile.com/wp-content/uploads/2025/05/hp-omnibook-ultra-flip-2024-2tmobile.webp', 1, false, '2026-01-07 11:12:03.04');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (690, 386, 'https://www.pcworld.com/wp-content/uploads/2025/04/HP-OmiBook-Ultra-Flip-14-tablet-mode.jpg?quality=50&strip=all&w=1024', 2, false, '2026-01-07 11:12:03.04');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (691, 387, 'https://dlcdnwebimgs.asus.com/gain/E90DE227-7002-48C1-A940-B6E952D0BCCC', 0, true, '2026-01-07 11:12:03.046');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (692, 387, 'https://lapvip.vn/upload/products/original/asus-gaming-rog-zephyrus-g14-windows-10-1597659277.jpg', 1, false, '2026-01-07 11:12:03.046');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (693, 387, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6WCnBRFZF-mVz8vdU7DUAbkcm52uPiyE4rw&s', 2, false, '2026-01-07 11:12:03.046');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (694, 388, 'https://surfaceviet.vn/wp-content/uploads/2024/05/Surface-Laptop-7-Black-15-inch.jpg', 0, true, '2026-01-07 11:12:03.054');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (695, 388, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm-PQBOqfnRaqtr0G46MBSI-lYIkLxQNK5xA&s', 1, false, '2026-01-07 11:12:03.054');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (696, 388, 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1724683162-1722447273-microsoft-surface-laptop-2024-001-66aa759807ea4.jpg?crop=0.712xw:0.949xh;0.106xw,0.0342xh&resize=980:*', 2, false, '2026-01-07 11:12:03.054');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (697, 389, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tab-s9-ultra-kem-2_1_1.png', 0, true, '2026-01-07 11:12:03.06');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (698, 389, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbLFI74_smEYhr-YQcuYCQWT-2CAGcqnqrCA&s', 1, false, '2026-01-07 11:12:03.06');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (699, 389, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG5-j-Zk08C5eKFICM-FhrAFJjsH0qtbip-w&s', 2, false, '2026-01-07 11:12:03.06');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (700, 390, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/e/p/eprice_1_b7620c148ab010a64546e96a356978b2_2_1.jpg', 0, true, '2026-01-07 11:12:03.067');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (701, 390, 'https://cdn.tgdd.vn/Products/Images/522/307178/Slider/samsung-galaxy-tab-s9-plus-thumb-yt-1020x570.jpg', 1, false, '2026-01-07 11:12:03.067');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (702, 390, 'https://cdn-v2.didongviet.vn/files/default/2024/11/17/0/1734426091261_2_samsung_galaxy_tab_s9_plus_256gb_didongviet.jpg', 2, false, '2026-01-07 11:12:03.067');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (703, 391, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/s/ss-tab-s9_1.png', 0, true, '2026-01-07 11:12:03.075');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (704, 391, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWIurcQN_FHag_Kc3f4tbLSflbL_LceBKxRg&s', 1, false, '2026-01-07 11:12:03.075');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (705, 391, 'https://bachlongstore.vn/vnt_upload/product/10_2023/thumbs/1000_732176.png', 2, false, '2026-01-07 11:12:03.075');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (706, 392, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tab-s9-fe-xam_2_1_1.png', 0, true, '2026-01-07 11:12:03.082');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (707, 392, 'https://happyphone.vn/wp-content/uploads/2024/03/Samsung-Galaxy-Tab-S9-FE-Wifi-128GB-Xanh-mint.png', 1, false, '2026-01-07 11:12:03.082');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (708, 392, 'https://cdn.tgdd.vn/Products/Images/522/309819/Slider/samsung-galaxy-tab-s9-fe-plus-tongquan-1020x570.jpg', 2, false, '2026-01-07 11:12:03.082');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (709, 393, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/g/o/google_pixel_tablet.jpg', 0, true, '2026-01-07 11:12:03.089');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (710, 393, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/tablet/Google/google-pixel-tablet-4.jpg', 1, false, '2026-01-07 11:12:03.089');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (711, 393, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz6SEJwyMo1YdZ3nlSMHgojasS7pnR-LG3QQ&s', 2, false, '2026-01-07 11:12:03.089');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (712, 394, 'https://cdn.viettablet.com/images/thumbnails/480/516/detailed/56/oneplus-pad-chinh-hang.jpg', 0, true, '2026-01-07 11:12:03.095');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (713, 394, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSinNk73b8swO4DX16Le9UCXMx59RUXThZfSw&s', 1, false, '2026-01-07 11:12:03.095');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (714, 394, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWiCI9Q92F0PDblHbMwoKORXuRKgpQaUFj-Q&s', 2, false, '2026-01-07 11:12:03.095');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (715, 395, 'https://p4-ofp.static.pub/fes/cms/2023/03/28/7dch8vg9lz0tzeg74u3x9paoln4o8z319478.png', 0, true, '2026-01-07 11:12:03.102');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (716, 395, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/07/Lenovo-Tab-P12-3.jpeg', 1, false, '2026-01-07 11:12:03.102');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (717, 395, 'https://p2-ofp.static.pub/fes/cms/2023/03/28/8wauc5kf0e16qej7g7cmhrspz7e2ov405745.jpg', 2, false, '2026-01-07 11:12:03.102');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (718, 396, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/m/i/mi-pad-6-cps-doc-quyen-xanh_3_1_1.jpg', 0, true, '2026-01-07 11:12:03.108');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (719, 396, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_pad6_-_1.png', 1, false, '2026-01-07 11:12:03.108');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (720, 396, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBIB74sMizNbFsFBamVCKLmRUXZA8JdLiZ6A&s', 2, false, '2026-01-07 11:12:03.108');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (721, 397, 'https://product.hstatic.net/200000730863/product/51gj5oqxbnl._ac_sl1000__f75a5ec479ef4fc1ac2f78b17c6da98d_master.jpg', 0, true, '2026-01-07 11:12:03.115');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (722, 397, 'https://kindlehanoi.vn/wp-content/uploads/2023/08/Fire-Max-11-2023-2024-model.jpg', 1, false, '2026-01-07 11:12:03.115');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (723, 397, 'https://m.media-amazon.com/images/I/51-hmSQ2FsL._UF1000,1000_QL80_.jpg', 2, false, '2026-01-07 11:12:03.115');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (724, 398, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-galaxy-tab-a9_11__1.png', 0, true, '2026-01-07 11:12:03.121');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (725, 398, 'https://cdn.tgdd.vn/Products/Images/522/315590/Slider/samsung-galaxy-tab-a9-plus-thumb-1020x570.jpg', 1, false, '2026-01-07 11:12:03.121');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (726, 398, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUJm3ql3pJ6k2YlTw1nXXTTddlDg7O13hSeg&s', 2, false, '2026-01-07 11:12:03.121');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (727, 399, 'https://p2-ofp.static.pub/fes/cms/2023/03/29/8rz4mn5wzzx3s29zfcffctkb2xcwjj602719.png', 0, true, '2026-01-07 11:12:03.128');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (728, 399, 'https://cdn.tgdd.vn/Files/2021/03/19/1336509/lenovotabm10hd-2_800x450.jpg', 1, false, '2026-01-07 11:12:03.128');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (729, 399, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc1qdbZMQHw9FzagItRiCuGjKEzl2vB-U9og&s', 2, false, '2026-01-07 11:12:03.128');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (730, 400, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/h/t/https___bucketeer_e05bbc84_baa3_437e_9518_adb32be77984.s3.amazonaws.com_public_images_b08df22d_4b5e_46a8_87c5_fc303e133f8a_1500x1500_1_1_1_1.jpg', 0, true, '2026-01-07 11:12:03.136');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (731, 400, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR06MlEDQr-ItwYbVMhDASbC0FAs_IefMXuQA&s', 1, false, '2026-01-07 11:12:03.136');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (732, 400, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnhyMRMNvOEwWJPqlO-DWpVHGzV6FVbF2-sA&s', 2, false, '2026-01-07 11:12:03.136');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (733, 401, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/e/series_tab_s8001_1_2.jpg', 0, true, '2026-01-07 11:12:03.147');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (734, 401, 'https://files.refurbed.com/ii/samsung-galaxy-tab-s8-plus-1666339074.jpg?t=fitdesign&h=600&w=800', 1, false, '2026-01-07 11:12:03.147');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (735, 401, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrc9d2K5eYzLkn9H-xzFjZ2Pa4TJKGdweXCw&s', 2, false, '2026-01-07 11:12:03.147');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (736, 402, 'https://surfacecity.vn/wp-content/uploads/microsoft-surface-pro-9-5g.jpg', 0, true, '2026-01-07 11:12:03.157');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (737, 402, 'https://surfacestore.com.vn/wp-content/uploads/2022/10/microsoft-surface-pro-9-1.jpg', 1, false, '2026-01-07 11:12:03.157');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (738, 402, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGG1Do0cRbDI-6IAY7-bbaq7FeA_FmoJzCIg&s', 2, false, '2026-01-07 11:12:03.157');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (739, 403, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/5/6/5650372_surface_go_3_under_embargo_until_22.jpg', 0, true, '2026-01-07 11:12:03.163');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (740, 403, 'https://hanoilab.com/wp-content/uploads/2024/10/Surface-Laptop-Go-3-New-Open-Box-Ha-Noi-Lab-5.jpg', 1, false, '2026-01-07 11:12:03.163');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (741, 403, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJCJshmeKQ9OJMsAyClsHXuYV2ic-piYrhuQ&s', 2, false, '2026-01-07 11:12:03.163');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (742, 404, 'https://www.chuwi.com/public/upload/image/20221229/52bc2a3d58a50a2bb14171419cc30094.png', 0, true, '2026-01-07 11:12:03.169');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (743, 404, 'https://dt24h.com/wp-content/uploads/2023/09/CHUWI-HiPad-XPro-15.jpg', 1, false, '2026-01-07 11:12:03.169');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (744, 404, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxXrVcWEH0zMNdKDHucFk1c8nRWZCul9iczQ&s', 2, false, '2026-01-07 11:12:03.169');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (745, 405, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/m/a/may-tinh-bang-teclast-t50-plus_1_.png', 0, true, '2026-01-07 11:12:03.175');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (746, 405, 'https://cdn-media.sforum.vn/storage/app/media/ace%20chu%20tu/tren-tay-teclast-t50-plus/ava.jpg', 1, false, '2026-01-07 11:12:03.175');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (747, 405, 'https://en.teclast.com/cdn/shop/files/10_acd659ea-17cb-4b0f-9626-31788d36421b.jpg?v=1686395318&width=1000', 2, false, '2026-01-07 11:12:03.175');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (748, 406, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-t21_12_.png', 0, true, '2026-01-07 11:12:03.183');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (749, 406, 'https://cdn.tgdd.vn/Files/2022/09/01/1461522/nokia-t21_1280x720-800-resize.jpg', 1, false, '2026-01-07 11:12:03.183');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (750, 406, 'https://cdn.tgdd.vn/Files/2023/03/21/1519337/a2-210323-065518-800-resize.jpg', 2, false, '2026-01-07 11:12:03.183');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (751, 407, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/r/e/realme-pad-2.png', 0, true, '2026-01-07 11:12:03.193');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (752, 407, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqxAYc62sIRw4x-H53FnJVbOo3suSyy4p22w&s', 1, false, '2026-01-07 11:12:03.193');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (753, 407, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlPuADAMojDUV_RmBf3lBhZtraWG6z1NgXuA&s', 2, false, '2026-01-07 11:12:03.193');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (754, 408, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-pad-air-128gb.jpg', 0, true, '2026-01-07 11:12:03.201');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (755, 408, 'https://cdn.tgdd.vn/Products/Images/522/281821/Slider/oppo-pad-air-thumb-YT-1020x570.jpg', 1, false, '2026-01-07 11:12:03.201');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (756, 408, 'https://cdn.tgdd.vn/Products/Images/522/281821/oppo-pad-air-1-1-750x500.jpg', 2, false, '2026-01-07 11:12:03.201');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (757, 409, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/i/vivo-pad-2_2_.jpg', 0, true, '2026-01-07 11:12:03.207');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (758, 409, 'https://cdn.tgdd.vn//News/0//vivo-pad-2-ra-mat-lo-dien-3-730x408.jpg', 1, false, '2026-01-07 11:12:03.207');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (759, 409, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkgzolOndfQzUnYtzWEdLdKdX6llp48SSTyQ&s', 2, false, '2026-01-07 11:12:03.207');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (760, 410, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/Huawei-Matepad-Pro-13.9-3.jpg', 0, true, '2026-01-07 11:12:03.213');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (761, 410, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_48_20.jpg', 1, false, '2026-01-07 11:12:03.213');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (762, 410, 'https://cdn.tgdd.vn/News/1558700/10-1280x720.jpg', 2, false, '2026-01-07 11:12:03.213');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (763, 411, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/may-tinh-bang-honor-pad-9-pro_3_.png', 0, true, '2026-01-07 11:12:03.219');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (764, 411, 'https://cdn.tgdd.vn/News/0/d-1280x720.jpg', 1, false, '2026-01-07 11:12:03.219');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (765, 411, 'https://www.notebookcheck.net/fileadmin/_processed_/a/a/csm_20240315_144254_5048161306.jpg', 2, false, '2026-01-07 11:12:03.219');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (766, 412, 'https://mac24h.vn/images/companies/1/12inch%20rose/Macbook%2012%20inch%20gold/macminipost.png?1598064081104', 0, true, '2026-01-07 11:12:03.226');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (767, 412, 'https://macone.vn/wp-content/uploads/2023/01/m2-mac-mini-copy.jpg', 1, false, '2026-01-07 11:12:03.226');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (768, 412, 'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2023/03/Mac-mini-2023-2.jpg', 2, false, '2026-01-07 11:12:03.226');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (769, 413, 'https://cdn2.cellphones.com.vn/200x/media/catalog/product/m/a/macbook_33_.png', 0, true, '2026-01-07 11:12:03.233');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (770, 413, 'https://macone.vn/wp-content/uploads/2023/02/mac-mini-m2-pro.png', 1, false, '2026-01-07 11:12:03.233');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (771, 413, 'https://cdn.tgdd.vn/Files/2023/01/20/1504319/macminitrolaimanhmehonkhiduoctrangbichipapplem2pro_1280x720-800-resize.jpg', 2, false, '2026-01-07 11:12:03.233');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (772, 414, 'https://product.hstatic.net/200000348419/product/mac_studio_m2_max_2023_chinh_hang_21aed22940d54b5f8c6bc1e92f721ab1_large.png', 0, true, '2026-01-07 11:12:03.241');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (773, 414, 'https://shopdunk.com/images/thumbs/0018104_mac-studio-m2-max.jpeg', 1, false, '2026-01-07 11:12:03.241');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (774, 414, 'https://laptop15.vn/wp-content/uploads/2023/08/Mac-Studio-M1-Max-1.png', 2, false, '2026-01-07 11:12:03.241');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (775, 415, 'https://macstores.vn/wp-content/uploads/2023/06/mac-studio-m2-4.jpg', 0, true, '2026-01-07 11:12:03.248');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (776, 415, 'https://macmall.vn/uploads/screen_shot_2024-06-05_at_16_1717580424.29.17.png', 1, false, '2026-01-07 11:12:03.248');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (777, 415, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHReyPkahn7iL_EZFqHxA9DqTBiow747DXHg&s', 2, false, '2026-01-07 11:12:03.248');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (778, 416, 'https://shopdunk.com/images/thumbs/0022756_imac-m3-2023-24-inch-8-core-gpu8gb256gb.jpeg', 0, true, '2026-01-07 11:12:03.254');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (779, 416, 'https://www.apple.com/newsroom/images/2023/10/apple-supercharges-24-inch-imac-with-new-m3-chip/article/Apple-iMac-M3-colors-231030_big.jpg.large.jpg', 1, false, '2026-01-07 11:12:03.254');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (780, 416, 'https://mac24h.vn/images/companies/1/phu%CC%A3%20kie%CC%A3%CC%82n/Hyperdrive/imac%2024%20inch/IMAC%2024%20INCH.jpg?1718860710656', 2, false, '2026-01-07 11:12:03.254');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (781, 417, 'https://www.laptopvip.vn/images/ab__webp/detailed/10/dell-xps-27.webp', 0, true, '2026-01-07 11:12:03.261');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (782, 417, 'https://khoavang.vn/resources/cache/800xx1/data/dell/DEll-G5-5090/Dell-XPS-8940--4-1633518499.webp', 1, false, '2026-01-07 11:12:03.261');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (783, 417, 'https://i.pcmag.com/imagery/reviews/061gj28ssJiSsCmgbTfUojq-6.fit_lim.size_1050x.jpg', 2, false, '2026-01-07 11:12:03.261');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (784, 418, 'https://images-na.ssl-images-amazon.com/images/I/71C+ewM2JjL.jpg', 0, true, '2026-01-07 11:12:03.268');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (785, 418, 'https://sm.pcmag.com/pcmag_me/photo/default/078fwui2ishfdtodnicyblr-6_353v.jpg', 1, false, '2026-01-07 11:12:03.268');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (786, 418, 'https://images-na.ssl-images-amazon.com/images/I/61rLBkZzFJL.jpg', 2, false, '2026-01-07 11:12:03.268');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (787, 419, 'https://kaas.hpcloud.hp.com/PROD/v2/renderbinary/7477130/5038347/con-win-dt-p-omen-45l-gt22-1009nf-product-specifications/articuno-desktop', 0, true, '2026-01-07 11:12:03.274');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (788, 419, 'https://www.tnc.com.vn/uploads/news/20220729/omen-45l-may-bo-hp-gaming-de-dang-nang-cap%202.png', 1, false, '2026-01-07 11:12:03.274');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (789, 419, 'https://cdn.mos.cms.futurecdn.net/G9H9NhYMwFL3pszTEJrctG.jpg', 2, false, '2026-01-07 11:12:03.274');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (790, 420, 'https://p2-ofp.static.pub//fes/cms/2024/11/27/em8bpvjffmescc7mck5snjp1g73otp127407.png', 0, true, '2026-01-07 11:12:03.28');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (791, 420, 'https://p4-ofp.static.pub//fes/cms/2024/02/29/pcuk3jaes0a1yst8mollyq0nt8fn2c820605.jpg', 1, false, '2026-01-07 11:12:03.28');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (792, 420, 'https://p4-ofp.static.pub//fes/cms/2025/03/28/fxl0ptkilucyo10w6zpmy4ev6cv32h744429.jpg', 2, false, '2026-01-07 11:12:03.28');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (793, 421, 'https://res.cloudinary.com/corsair-pwa/image/upload/v1684950787/products/Vengeance-PC/CS-9050047-NA/Gallery/common/Vengeance__i7400_01.webp', 0, true, '2026-01-07 11:12:03.288');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (794, 421, 'https://thegadgetflow.com/wp-content/uploads/2023/03/CORSAIR-Vengeance-i7400-Frost-Edition-Gaming-PC-01.jpg', 1, false, '2026-01-07 11:12:03.288');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (795, 421, 'https://assets.corsair.com/image/upload/c_pad,q_85,h_1100,w_1100,f_auto/products/Vengeance-PC/CS-9050062-NA/Vengeance_i7400_Frost_Edition_01.webp', 2, false, '2026-01-07 11:12:03.288');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (796, 422, 'https://asset.msi.com/resize/image/global/product/product_1669160633809914962a2cb40d02df74877b17555b.png62405b38c58fe0f07fcef2367d8a9ba1/1024.png', 0, true, '2026-01-07 11:12:03.295');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (797, 422, 'https://i.pcmag.com/imagery/reviews/032R5yzbNKqbXJAXNujVkBu-2..v1616773109.jpg', 1, false, '2026-01-07 11:12:03.295');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (798, 422, 'https://asset.msi.com/resize/image/global/product/product_164989404970502cdd1b0b28ad95c2afe110e916bf.png62405b38c58fe0f07fcef2367d8a9ba1/600.png', 2, false, '2026-01-07 11:12:03.295');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (799, 423, 'https://m.media-amazon.com/images/I/71gtoidr0kL._AC_UF894,1000_QL80_.jpg', 0, true, '2026-01-07 11:12:03.3');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (800, 423, 'https://i.ytimg.com/vi/KFxk20EoSpc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA_XaIvA9VnqC2qcK58EFAmdMrS1Q', 1, false, '2026-01-07 11:12:03.3');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (801, 423, 'https://i5.walmartimages.com/seo/Skytech-Azure-Gaming-PC-Desktop-AMD-Ryzen-7-7800X3D-NVIDIA-Geforce-RTX-5070-2TB-Gen4-NVMe-SSD-32GB-RAM-AIO-Liquid-Cooling-Windows-11_91f306ac-8b09-46f3-8570-feba113218e0.37f582a20f6174efbf56f4317992e1fe.jpeg', 2, false, '2026-01-07 11:12:03.3');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (802, 424, 'https://m.media-amazon.com/images/I/818SNa1ruZL.jpg', 0, true, '2026-01-07 11:12:03.306');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (803, 424, 'https://shopsimpletronics.com/cdn/shop/products/PhotoRoom_20220119_181729_1946x.png?v=1642637923', 1, false, '2026-01-07 11:12:03.306');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (804, 424, 'https://cdn.panacompu.com/cdn-img/pv/cyberpowerpc-gamer-supreme-v6-preview.jpg?width=550&height=400&fixedwidthheight=false', 2, false, '2026-01-07 11:12:03.306');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (805, 425, 'https://m.media-amazon.com/images/I/81xlNPKMrQL._AC_UF1000,1000_QL80_.jpg', 0, true, '2026-01-07 11:12:03.312');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (806, 425, 'https://cdn.mos.cms.futurecdn.net/JQjSid2RWWUuieqcRfCXPC.jpg', 1, false, '2026-01-07 11:12:03.312');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (807, 425, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhcE-zDY9Jo2ZkuWqohQxy1qJABibm1wrWpA&s', 2, false, '2026-01-07 11:12:03.312');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (808, 426, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/329/122/products/may-tinh-mini-pc-intel-nuc-13-extreme-kit-i7-13700k-rnuc13rngi70000-6.jpg?v=1680947667597', 0, true, '2026-01-07 11:12:03.318');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (809, 426, 'https://dlcdnwebimgs.asus.com/gain/da443026-2c2c-4101-b960-0753d97d5429/', 1, false, '2026-01-07 11:12:03.318');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (810, 426, 'https://sb.tinhte.vn/2022/11/6199989_intel-nuc-13-extreme-raptor-canyon-tinhte-2.jpg', 2, false, '2026-01-07 11:12:03.318');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (811, 427, 'https://images-na.ssl-images-amazon.com/images/I/71fOGgAce-L.jpg', 0, true, '2026-01-07 11:12:03.325');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (812, 427, 'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/HP_Envy_Desktop_Header.jpg', 1, false, '2026-01-07 11:12:03.325');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (813, 427, 'https://support.hp.com/wcc-assets/document/images/211/c05240709.jpg', 2, false, '2026-01-07 11:12:03.325');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (814, 428, 'https://cdn1615.cdn4s4.io.vn/media/products/may-tinh-de-ban/dell/inspiron/3020mt/inspiron-3020-desktop.webp', 0, true, '2026-01-07 11:12:03.333');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (815, 428, 'https://sm.pcmag.com/pcmag_au/review/d/dell-inspi/dell-inspiron-small-desktop-3471_kz9r.jpg', 1, false, '2026-01-07 11:12:03.333');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (816, 428, 'https://sieuviet.vn/hm_content/uploads/anh-san-pham/pc/dell/1_2.webp', 2, false, '2026-01-07 11:12:03.333');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (817, 429, 'https://cdn.assets.prezly.com/346d8126-820e-4ee0-8b60-a0077acee526/PREDATOR-ORION-7000-PO7-660-02.jpg', 0, true, '2026-01-07 11:12:03.339');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (818, 429, 'https://file.hstatic.net/200000722513/article/predator-orion-7000-po7-640-lifestyle-03-scaled_fa4d2f201ba4484096f0f5acbcc6fc3d.jpg', 1, false, '2026-01-07 11:12:03.339');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (819, 429, 'https://nghenhinvietnam.vn/uploads/global/quanghuy/2024/9/6/acer/nghenhin__acer-predator-orion-7000-1.jpg', 2, false, '2026-01-07 11:12:03.339');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (820, 430, 'https://nzxt.com/cdn/shop/files/Player-Three-Prime-ASUS-WW-10.14.25-HERO-WHITE-BADGE_cf7be002-234d-43e0-a2b8-c78f0a7b1844.png?v=1764659862', 0, true, '2026-01-07 11:12:03.346');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (821, 430, 'https://9to5toys.com/wp-content/uploads/sites/5/2023/03/nzxt-player-three-9.png?w=1200&h=600&crop=1', 1, false, '2026-01-07 11:12:03.346');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (822, 430, 'https://i.pcmag.com/imagery/reviews/01qbCBNLmuSqLiLmSdQY6Xk-3..v1681409799.jpg', 2, false, '2026-01-07 11:12:03.346');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (823, 431, 'https://cdn.mos.cms.futurecdn.net/HF5NFDnzAF8NDE8znsB5JJ.jpg', 0, true, '2026-01-07 11:12:03.353');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (824, 431, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR37aO6vYZv4QdS2NpI3Fu84JKk-NxP4Q9c3Q&s', 1, false, '2026-01-07 11:12:03.353');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (825, 431, 'https://petapixel.com/assets/uploads/2024/06/maingear-mg-1-angle-petapixel-front.jpg', 2, false, '2026-01-07 11:12:03.353');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (826, 432, 'https://www.originpc.com/blog/wp-content/uploads/2019/12/neuron-hero-red.jpg', 0, true, '2026-01-07 11:12:03.36');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (827, 432, 'https://cdn.originpc.com/img/pdp/gaming/desktops/neuron/neuron-3500x-uv-prints.jpg', 1, false, '2026-01-07 11:12:03.36');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (828, 432, 'https://cdn.mos.cms.futurecdn.net/Et8JN39PXwXws5SzXHpCDX.jpg', 2, false, '2026-01-07 11:12:03.36');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (829, 433, 'https://dlcdnwebimgs.asus.com/gain/95E413EB-A725-4131-82B8-FF76A880EE0D', 0, true, '2026-01-07 11:12:03.367');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (830, 433, 'https://microless.com/cdn/products/255b85a6527a4dc4fee9a1901124670b-hi.jpg', 1, false, '2026-01-07 11:12:03.367');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (831, 433, 'https://dlcdnwebimgs.asus.com/gain/F5A260D0-CB75-45E2-A632-521DDC5F28BE/w260/fwebp', 2, false, '2026-01-07 11:12:03.367');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (832, 434, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/7/1/71557.png', 0, true, '2026-01-07 11:12:03.375');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (833, 434, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/mtsp/dien-tu/smart-tivi-lg-oled-4k-55-inch-oled55c3psa.jpg', 1, false, '2026-01-07 11:12:03.375');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (834, 434, 'https://img.websosanh.vn/v2/users/root_product/images/oled-tivi-lg-4k-55-inch-55c3ps/219d335ca6184.jpg', 2, false, '2026-01-07 11:12:03.375');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (835, 435, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWKs4_XrvUIeDRFuognIRCTV-7JIUCPgwRWw&s', 0, true, '2026-01-07 11:12:03.383');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (836, 435, 'https://www.cnet.com/a/img/resize/ded6920d086391e7e24b8e8a77a64e4031a0002f/hub/2023/06/09/b3b35284-1d0c-4c27-8676-954abc2fad8a/lg-c3-oled-tv-2023-07.jpg?auto=webp&fit=crop&height=1200&width=1200', 1, false, '2026-01-07 11:12:03.383');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (837, 435, 'https://i5.walmartimages.com/asr/0680c9f0-304d-4b92-85ca-51cae212f046.5b1fc8050441bf9820a3c5922feffd9b.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF', 2, false, '2026-01-07 11:12:03.383');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (838, 436, 'https://cdn.tgdd.vn/Products/Images/1942/306581/smart-tivi-oled-lg-4k-65-inch-65g3psa-1-700x467.jpg', 0, true, '2026-01-07 11:12:03.394');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (839, 436, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tivi/oled65g3psa_atv_eavh_vn_c/gallery/D-02.jpg', 1, false, '2026-01-07 11:12:03.394');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (840, 436, 'https://www.cnet.com/a/img/resize/29626605caa770187edbdec3f678249ccd8c47ff/hub/2023/08/11/e2255be8-d8c3-4d3b-ada4-07454ab16b77/lg-g3-oled-tv-2023-02.jpg?auto=webp&width=1200', 2, false, '2026-01-07 11:12:03.394');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (841, 437, 'https://images.samsung.com/is/image/samsung/p6pim/ph/qa55s90cagxxp/gallery/ph-oled-s90c-qa55s90cagxxp-536185455', 0, true, '2026-01-07 11:12:03.403');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (842, 437, 'https://nghenhinvietnam.vn/uploads/global/quanghuy/2023/21/samsung/nghenhinvietnam_tv_samsung_s90c_3.jpg', 1, false, '2026-01-07 11:12:03.403');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (843, 437, 'https://nghenhinvietnam.vn/uploads/global/quanghuy/2023/21/samsung/nghenhinvietnam_tv_samsung_s90c_1.jpg', 2, false, '2026-01-07 11:12:03.403');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (844, 438, 'https://images.samsung.com/is/image/samsung/p6pim/ae/qa65s90cauxzn/gallery/ae-oled-tv-qa65s90cauxzn-front-black-titanium-536504295', 0, true, '2026-01-07 11:12:03.409');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (845, 438, 'https://dienmay247.com.vn/wp-content/uploads/2024/01/s90c-b1-600x400-1.jpg', 1, false, '2026-01-07 11:12:03.409');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (846, 438, 'https://i.insider.com/652e8e998bed706e837e201b?width=700', 2, false, '2026-01-07 11:12:03.409');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (847, 439, 'https://images.samsung.com/is/image/samsung/p6pim/ae/qa65s90cauxzn/gallery/ae-oled-tv-qa65s90cauxzn-front-black-titanium-536504295', 0, true, '2026-01-07 11:12:03.417');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (848, 439, 'https://image.anhducdigital.vn/hightech/tivi/qn90c-2023/qn90c-5.png', 1, false, '2026-01-07 11:12:03.417');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (849, 439, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/439/998/products/qn95d-fbb22d2c-bb9b-476e-a476-dbd09e24ab69.png?v=1713174876603', 2, false, '2026-01-07 11:12:03.417');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (850, 440, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/425/687/products/1-a6f4dd7b-9abb-4656-bf44-d498e101dca2.jpg?v=1764054897643', 0, true, '2026-01-07 11:12:03.423');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (851, 440, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/g/o/google-tivi-oled-sony-xr-55a80l-4k-55-inch_8_.png', 1, false, '2026-01-07 11:12:03.423');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (852, 440, 'https://sony.scene7.com/is/image/sonyglobalsolutions/TVFY23_A80L_65_WW_0_insitu_M?$productIntroPlatemobile$&fmt=png-alpha', 2, false, '2026-01-07 11:12:03.423');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (853, 441, 'https://logico.com.vn/images/products/2023/03/23/original/a95l-2_1679544846.png', 0, true, '2026-01-07 11:12:03.431');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (854, 441, 'https://cdn.mos.cms.futurecdn.net/Lk6dCXJhznwxULbqQj8U4P.jpg', 1, false, '2026-01-07 11:12:03.431');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (855, 441, 'https://cdn.tgdd.vn/Products/Images/1942/308548/x95l-700x467.jpg', 2, false, '2026-01-07 11:12:03.431');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (856, 442, 'https://i.rtings.com/assets/products/ygyrdRw8/tcl-qm8-qm850g-qled/design-medium.jpg?format=auto', 0, true, '2026-01-07 11:12:03.44');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (857, 442, 'https://m.media-amazon.com/images/I/91WXzWVVGsL._AC_UF894,1000_QL80_.jpg', 1, false, '2026-01-07 11:12:03.44');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (858, 442, 'https://i.rtings.com/assets/products/FxuLZKva/tcl-qm8-qm851g-qled/design-medium.jpg?format=auto', 2, false, '2026-01-07 11:12:03.44');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (859, 443, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv6ocmGcD3vR2p-W45Dt85ucV7DBxbalIrJw&s', 0, true, '2026-01-07 11:12:03.447');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (860, 443, 'https://m.media-amazon.com/images/I/714LAhAd8RL._AC_UF894,1000_QL80_.jpg', 1, false, '2026-01-07 11:12:03.447');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (861, 443, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVwQCb0tg9JZAMBa5StcbMndc4rdLm2Y_Rzg&s', 2, false, '2026-01-07 11:12:03.447');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (862, 444, 'https://www.vizio.com/content/dam/vizio/us/en/images/product/2020/tvs/p-series/p65q9-h1/gallery/2020_P-Series_P65Q9-H1_Front_OS_Newsweek-Best-Holiday-Gifts-2020.jpg/_jcr_content/renditions/cq5dam.web.640.480.png', 0, true, '2026-01-07 11:12:03.455');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (863, 444, 'https://www.vizio.com/content/dam/vizio/us/en/images/product/2021/tv/p-series/p65q9-j01/gallery/2022_PQ9-Series_Carton.jpg/_jcr_content/renditions/cq5dam.web.640.480.png', 1, false, '2026-01-07 11:12:03.455');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (864, 444, 'https://www.bhphotovideo.com/images/fb/vizio_pq65_f1_p_series_quantum_65_class_1439029.jpg', 2, false, '2026-01-07 11:12:03.455');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (865, 445, 'https://image.roku.com/w/rapid/images/meta-image/51c68c6e-4f37-4204-8bfb-6c9357793922.jpg', 0, true, '2026-01-07 11:12:03.462');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (866, 445, 'https://www.cnet.com/a/img/resize/c7d369847505bec9468fc04f16d71a96658cbe6e/hub/2023/04/06/cb4769b9-48d9-4b08-93bd-ff961575aaa4/roku-tv-23-02.jpg?auto=webp&width=1200', 1, false, '2026-01-07 11:12:03.462');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (867, 445, 'https://m.media-amazon.com/images/I/711mObDMN1L._AC_UF894,1000_QL80_.jpg', 2, false, '2026-01-07 11:12:03.462');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (868, 446, 'https://m.media-amazon.com/images/I/61wsF9lZJmL._AC_UF1000,1000_QL80_.jpg', 0, true, '2026-01-07 11:12:03.469');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (869, 446, 'https://m.media-amazon.com/images/I/81JIfxZb14L._AC_UF1000,1000_QL80_.jpg', 1, false, '2026-01-07 11:12:03.469');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (870, 446, 'https://m.media-amazon.com/images/G/01/kindle/journeys/RLLnvZrYJrpztidamPzsM2FUe2FYBetwtpWHnjNYR6l9g3D/Mzc4NDUwYjct._CB608418078_.jpg', 2, false, '2026-01-07 11:12:03.469');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (871, 447, 'https://www.lg.com/content/dam/channel/wcms/th/oled-tv/2023/b3-pdp-update/gallery/55-b3-a/TV-OLED-55-B3-A-Gallery-01.jpg/jcr:content/renditions/thum-1600x1062.jpeg', 0, true, '2026-01-07 11:12:03.476');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (872, 447, 'https://www.lg.com/content/dam/channel/wcms/sg/images/tv/features/oled2023/TV-OLED-B3-02-Intro-Visual-Mobile.jpg', 1, false, '2026-01-07 11:12:03.476');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (873, 447, 'https://cdn.nguyenkimmall.com/images/detailed/874/10055510-smart-tivi-oled-lg-4k-55-inch-oled55g3psa-2.jpg', 2, false, '2026-01-07 11:12:03.476');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (874, 448, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/322680/tivi-qled-khung-tranh-samsung-4k-55-inch-qa55ls03d-1-638691037685437659-700x467.jpg', 0, true, '2026-01-07 11:12:03.484');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (875, 448, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/h/thi_t_k_ch_a_c_t_n_6__1.png', 1, false, '2026-01-07 11:12:03.484');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (876, 448, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/k/q/kq75lsb03afxkr_009_l-perspective1_black_2_1_2.png', 2, false, '2026-01-07 11:12:03.484');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (877, 449, 'https://sony.scene7.com/is/image/sonyglobalsolutions/TVFY23_X90L_65_12_Beauty_I_M-1?$productIntroPlatemobile$&fmt=png-alpha', 0, true, '2026-01-07 11:12:03.493');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (878, 449, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/mtsp/dien-tu/chan-de-tivi-sony-xr65x90l.jpg', 1, false, '2026-01-07 11:12:03.493');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (879, 449, 'https://sonyimages.blob.core.windows.net/productr/large/XR65X90LU_0.png', 2, false, '2026-01-07 11:12:03.493');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (880, 450, 'https://m.media-amazon.com/images/I/91ESqVq-i3L.jpg', 0, true, '2026-01-07 11:12:03.499');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (881, 450, 'https://www.skyit-tt.com/wp-content/uploads/2022/11/91Zihsc0coL._AC_SL1500_.jpg', 1, false, '2026-01-07 11:12:03.499');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (882, 450, 'https://www.cnet.com/a/img/resize/5b1159c61c0eaa5d3a38cba6a09b74f30de67c69/hub/2020/09/10/e78939f6-20b4-4f42-b9ef-03c1c618cca8/04-tcl-6-series-2020-65r635.jpg?auto=webp&width=768', 2, false, '2026-01-07 11:12:03.499');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (883, 451, 'https://cdn.nguyenkimmall.com/images/detailed/898/10056785-google-tivi-mini-uled-hisense-4k-55inch-55u7k-1_o1mh-t9.jpg', 0, true, '2026-01-07 11:12:03.507');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (884, 451, 'https://cdn.tgdd.vn/Products/Images/1942/321449/tivi-uled-4k-hisense-55u7k-700x467.jpg', 1, false, '2026-01-07 11:12:03.507');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (885, 451, 'https://vcdn1-sohoa.vnecdn.net/2023/10/27/DSC06576-1698420432.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=sKQ-0Utr5YPRwFAyh-COhA', 2, false, '2026-01-07 11:12:03.507');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (886, 452, 'https://images.samsung.com/is/image/samsung/p6pim/africa_en/ua43cu7000uxly/gallery/africa-en-crystal-uhd-cu7000-ua43cu7000uxly-536771150?$Q90_1248_936_F_PNG$', 0, true, '2026-01-07 11:12:03.515');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (887, 452, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Tivi/Samsung/43-inch/smart-tivi-samsung-uhd-43du7000-4k-43-inch-2024-1.jpg', 1, false, '2026-01-07 11:12:03.515');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (888, 452, 'https://cdn.nguyenkimmall.com/images/thumbnails/290/235/detailed/1163/10057637-Smart_Tivi_Samsung_4K_43_inch_UA43DU7000KXXV__1_.jpg', 2, false, '2026-01-07 11:12:03.515');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (889, 453, 'https://m.media-amazon.com/images/I/91MAjR2HydL._AC_UF894,1000_QL80_.jpg', 0, true, '2026-01-07 11:12:03.522');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (890, 453, 'https://m.media-amazon.com/images/I/519kS8lWBeL._AC_UF894,1000_QL80_.jpg', 1, false, '2026-01-07 11:12:03.522');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (891, 453, 'https://cdn.mos.cms.futurecdn.net/kWbKLdF6AktQ8JkHqUBpRQ.jpg', 2, false, '2026-01-07 11:12:03.522');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (892, 454, 'https://cdn.tgdd.vn/Products/Images/1942/274763/android-sony-4k-43-inch-kd-43x80k-180322-024040-550x340.png', 0, true, '2026-01-07 11:12:03.529');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (893, 454, 'https://cdn.tgdd.vn/Products/Images/1942/274763/android-sony-4k-43-inch-kd-43x80k-240322-025758.jpg', 1, false, '2026-01-07 11:12:03.529');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (894, 454, 'https://bizweb.dktcdn.net/thumb/grande/100/475/305/products/thumbnails-large-asset-plus-hierarchy-consumer-plus-assets-television-plus-assets-braviaa-plus-lcd-plus-hdtv-fy-plus-22-x80k-ecomm-plus-images-43-50-7-plus-frame-png-d40b5cae-a437-4294-a0b6-45b42d8d346f.png?v=1672991042467', 2, false, '2026-01-07 11:12:03.529');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (895, 455, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROQ3i7h3R7eF4Sa0DPzsRNbrnLnJ0CMH0mCQ&s', 0, true, '2026-01-07 11:12:03.539');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (896, 455, 'https://images-na.ssl-images-amazon.com/images/I/91uarXXZ7LL.jpg', 1, false, '2026-01-07 11:12:03.539');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (897, 455, 'https://images.techeblog.com/wp-content/uploads/2023/06/24131916/insignia-50-inch-class-f30-series-led-4k-smart-fire-tv-2023.jpg', 2, false, '2026-01-07 11:12:03.539');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (898, 456, 'https://cdn.tgdd.vn/Products/Images/1942/297318/google-tivi-toshiba-4k-43-inch-43c350lp-10-550x340.jpg', 0, true, '2026-01-07 11:12:03.551');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (899, 456, 'https://cdn.tgdd.vn/Products/Images/1942/341417/Slider/smart-tivi-toshiba-ai-4k-43-inch-43c350rp638978437940164200.jpg', 1, false, '2026-01-07 11:12:03.551');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (900, 456, 'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/5db66e97-e393-4016-bdd1-f92f2c655af2.png;maxHeight=1920;maxWidth=900?format=webp', 2, false, '2026-01-07 11:12:03.551');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (901, 457, 'https://thegioithietbiso.com/data/product/rvo1714620647.jpg', 0, true, '2026-01-07 11:12:03.565');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (902, 457, 'https://www.lg.com/content/dam/channel/wcms/uk/images/tvs-soundbars/oled-evo/oled2024/c4/features/oled-c4-16-ultra-slim-design-m.jpg', 1, false, '2026-01-07 11:12:03.565');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (903, 457, 'https://i5.walmartimages.com/asr/7e1c6b5a-39b4-467a-bbac-fd344d24dd92.54897e0cb4b954bb57b10b349fc57d7f.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF', 2, false, '2026-01-07 11:12:03.565');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (904, 458, 'https://images.samsung.com/is/image/samsung/p6pim/vn/qa65s95dakxxv/gallery/vn-oled-s95d-qa65s95dakxxv-thumb-540978937', 0, true, '2026-01-07 11:12:03.575');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (905, 458, 'https://vcdn1-sohoa.vnecdn.net/2024/08/06/DSC00528-1722936628.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=oyFyac-HLq1Qk6AcQldsKA', 1, false, '2026-01-07 11:12:03.575');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (906, 458, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture/News/News_expe_10229/10229.png?version=220712', 2, false, '2026-01-07 11:12:03.575');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (907, 459, 'https://sony.scene7.com/is/image/sonyglobalsolutions/TVFY24_UP_1_FrontWithStand_M?$productIntroPlatemobile$&fmt=png-alpha', 0, true, '2026-01-07 11:12:03.585');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (908, 459, 'https://m.media-amazon.com/images/I/81i2PtSHrwL._AC_UF1000,1000_QL80_.jpg', 1, false, '2026-01-07 11:12:03.585');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (909, 459, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8oOMmm770XjCFbyNSMPnSoTnZcGFKDUqvCQ&s', 2, false, '2026-01-07 11:12:03.585');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (910, 460, 'https://sm.pcmag.com/t/pcmag_au/review/t/tcl-qm8-cl/tcl-qm8-class-75-inch-tv-75qm851g_m1j9.1920.jpg', 0, true, '2026-01-07 11:12:03.597');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (911, 460, 'https://cdn-fastly.ce-sphere.com/media/2024/07/09/12261/post.jpg?size=720x845&nocrop=1', 1, false, '2026-01-07 11:12:03.597');
INSERT INTO public.product_images (id, "productId", "imageUrl", "displayOrder", "isMain", "createdAt") VALUES (912, 460, 'https://www.flatpanelshd.com/pictures/tcl_qm851g_tvd.jpg', 2, false, '2026-01-07 11:12:03.597');


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (316, 'iPhone 15 128GB', 'Dynamic Island, 48MP Main camera, USB-C.', 'IPH-15-128', '300744675109', 799.00, 600.00, 45, 5, 19, true, 0, '2026-01-07 11:12:02.478', '2026-01-07 11:12:02.478');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (317, 'iPhone 15 256GB', 'Advanced dual-camera system, A16 Bionic chip.', 'IPH-15-256', '634393363343', 899.00, 700.00, 33, 5, 19, true, 0, '2026-01-07 11:12:02.49', '2026-01-07 11:12:02.49');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (318, 'iPhone 14 Pro Max 128GB', 'Always-On display, Dynamic Island, 48MP Main camera.', 'IPH-14PM-128', '407542748338', 1099.00, 850.00, 51, 5, 19, true, 0, '2026-01-07 11:12:02.499', '2026-01-07 11:12:02.499');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (319, 'iPhone 14 Pro 128GB', '6.1-inch display, A16 Bionic, Crash Detection.', 'IPH-14P-128', '774699122900', 999.00, 750.00, 31, 5, 19, true, 0, '2026-01-07 11:12:02.506', '2026-01-07 11:12:02.506');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (320, 'iPhone 14 Plus 128GB', 'Longest battery life ever, 6.7-inch display.', 'IPH-14PL-128', '13794934616', 799.00, 600.00, 14, 5, 19, true, 0, '2026-01-07 11:12:02.515', '2026-01-07 11:12:02.515');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (321, 'iPhone 14 128GB', 'Vibrant Super Retina XDR display, A15 Bionic.', 'IPH-14-128', '383266726263', 699.00, 500.00, 8, 5, 19, true, 0, '2026-01-07 11:12:02.523', '2026-01-07 11:12:02.523');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (322, 'iPhone 13 128GB', 'Dual-camera system, A15 Bionic chip, durable design.', 'IPH-13-128', '849658930871', 599.00, 450.00, 5, 5, 19, true, 0, '2026-01-07 11:12:02.531', '2026-01-07 11:12:02.531');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (323, 'iPhone 13 Mini 128GB', 'Pocket-sized power, 5.4-inch display, A15 Bionic.', 'IPH-13M-128', '884716537254', 499.00, 350.00, 11, 5, 19, true, 0, '2026-01-07 11:12:02.54', '2026-01-07 11:12:02.54');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (324, 'iPhone 12 64GB', 'A14 Bionic, 5G capable, Ceramic Shield front.', 'IPH-12-64', '515135556989', 499.00, 350.00, 33, 5, 19, true, 0, '2026-01-07 11:12:02.547', '2026-01-07 11:12:02.547');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (325, 'iPhone SE (3rd Gen) 64GB', 'Classic design, A15 Bionic chip, 5G connectivity.', 'IPH-SE3-64', '43038022316', 429.00, 300.00, 44, 5, 19, true, 0, '2026-01-07 11:12:02.555', '2026-01-07 11:12:02.555');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (326, 'iPhone SE (3rd Gen) 128GB', 'Touch ID, powerful chip, ample storage.', 'IPH-SE3-128', '397395567263', 479.00, 340.00, 7, 5, 19, true, 0, '2026-01-07 11:12:02.562', '2026-01-07 11:12:02.562');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (327, 'iPhone 11 64GB', 'Dual-camera system, Night mode, all-day battery.', 'IPH-11-64', '764916022582', 399.00, 280.00, 27, 5, 19, true, 0, '2026-01-07 11:12:02.569', '2026-01-07 11:12:02.569');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (328, 'iPhone 12 Pro 128GB Refurb', 'Certified Refurbished, Stainless steel design.', 'IPH-12P-REF', '305544375951', 550.00, 400.00, 38, 5, 19, true, 0, '2026-01-07 11:12:02.576', '2026-01-07 11:12:02.576');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (329, 'iPhone 12 Pro Max 128GB Refurb', 'Certified Refurbished, Largest display.', 'IPH-12PM-REF', '9586442241', 650.00, 500.00, 22, 5, 19, true, 0, '2026-01-07 11:12:02.585', '2026-01-07 11:12:02.585');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (330, 'iPhone XS Max 64GB Used', 'Pre-owned, Super Retina OLED display.', 'IPH-XSM-USED', '219177887364', 300.00, 200.00, 42, 5, 19, true, 0, '2026-01-07 11:12:02.593', '2026-01-07 11:12:02.593');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (309, 'iPhone 15 Pro Max 256GB', 'Titanium design, A17 Pro chip, 48MP Main camera.', 'IPH-15PM-256', '984677746921', 1199.00, 900.00, 45, 5, 19, true, 0, '2026-01-07 11:12:02.37', '2026-01-07 11:12:02.37');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (310, 'iPhone 15 Pro Max 512GB', 'Titanium design, A17 Pro chip, massive 512GB storage.', 'IPH-15PM-512', '546856361499', 1399.00, 1000.00, 32, 5, 19, true, 0, '2026-01-07 11:12:02.42', '2026-01-07 11:12:02.42');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (311, 'iPhone 15 Pro Max 1TB', 'Titanium design, A17 Pro chip, ultimate 1TB storage.', 'IPH-15PM-1TB', '314539709014', 1599.00, 1200.00, 35, 5, 19, true, 0, '2026-01-07 11:12:02.437', '2026-01-07 11:12:02.437');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (312, 'iPhone 15 Pro 128GB', '6.1-inch Super Retina XDR display, ProMotion technology.', 'IPH-15P-128', '442504372531', 999.00, 750.00, 9, 5, 19, true, 0, '2026-01-07 11:12:02.445', '2026-01-07 11:12:02.445');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (313, 'iPhone 15 Pro 256GB', '6.1-inch display, A17 Pro chip, USB-C connector.', 'IPH-15P-256', '452225815173', 1099.00, 850.00, 40, 5, 19, true, 0, '2026-01-07 11:12:02.454', '2026-01-07 11:12:02.454');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (314, 'iPhone 15 Plus 128GB', '6.7-inch display, Dynamic Island, A16 Bionic chip.', 'IPH-15PL-128', '377013524739', 899.00, 700.00, 46, 5, 19, true, 0, '2026-01-07 11:12:02.462', '2026-01-07 11:12:02.462');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (315, 'iPhone 15 Plus 256GB', 'Large 6.7-inch display with extra storage capacity.', 'IPH-15PL-256', '107371769554', 999.00, 800.00, 25, 5, 19, true, 0, '2026-01-07 11:12:02.47', '2026-01-07 11:12:02.47');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (331, 'iPhone XR 64GB Used', 'Pre-owned, Liquid Retina HD display.', 'IPH-XR-USED', '450640265897', 250.00, 150.00, 26, 5, 19, true, 0, '2026-01-07 11:12:02.601', '2026-01-07 11:12:02.601');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (332, 'iPhone 8 Plus 64GB Used', 'Pre-owned, Dual cameras with Portrait mode.', 'IPH-8P-USED', '392876561806', 200.00, 120.00, 53, 5, 19, true, 0, '2026-01-07 11:12:02.609', '2026-01-07 11:12:02.609');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (333, 'iPhone 16 Pro Max 256GB', '6.9-inch display, A18 Pro chip, 48MP Ultra-Wide camera, Camera Control button.', 'IPH-16PM-256', '850620662572', 1199.00, 950.00, 53, 5, 19, true, 0, '2026-01-07 11:12:02.618', '2026-01-07 11:12:02.618');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (334, 'iPhone 16 Pro 128GB', '6.3-inch display, A18 Pro chip, 5x Telephoto zoom, Grade 5 Titanium design.', 'IPH-16P-128', '776116836990', 999.00, 800.00, 36, 5, 19, true, 0, '2026-01-07 11:12:02.628', '2026-01-07 11:12:02.628');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (335, 'iPhone 16 Plus 128GB', '6.7-inch display, A18 chip, Camera Control, Apple Intelligence ready.', 'IPH-16PL-128', '732567416411', 899.00, 700.00, 16, 5, 19, true, 0, '2026-01-07 11:12:02.636', '2026-01-07 11:12:02.636');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (336, 'iPhone 16 128GB', '6.1-inch display, A18 chip, Action button, dual-camera system.', 'IPH-16-128', '564772971045', 799.00, 620.00, 7, 5, 19, true, 0, '2026-01-07 11:12:02.643', '2026-01-07 11:12:02.643');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (337, 'iPhone 16e 128GB', '2025 budget model, A18 chip, single "2-in-1" camera, Apple Intelligence support.', 'IPH-16E-128', '599165441051', 599.00, 450.00, 30, 5, 19, true, 0, '2026-01-07 11:12:02.649', '2026-01-07 11:12:02.649');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (338, 'iPad Pro 12.9 M2 128GB', 'M2 chip, Liquid Retina XDR mini-LED display.', 'IPD-PRO12-M2-128', '34928090946', 1099.00, 850.00, 6, 5, 20, true, 0, '2026-01-07 11:12:02.656', '2026-01-07 11:12:02.656');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (339, 'iPad Pro 12.9 M2 256GB', 'Extreme performance, Apple Pencil hover.', 'IPD-PRO12-M2-256', '577811667094', 1199.00, 950.00, 40, 5, 20, true, 0, '2026-01-07 11:12:02.662', '2026-01-07 11:12:02.662');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (340, 'iPad Pro 12.9 M2 512GB', 'Pro workflows, 512GB storage for creators.', 'IPD-PRO12-M2-512', '449742835262', 1399.00, 1100.00, 41, 5, 20, true, 0, '2026-01-07 11:12:02.668', '2026-01-07 11:12:02.668');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (341, 'iPad Pro 11 M2 128GB', 'M2 chip, 11-inch Liquid Retina display.', 'IPD-PRO11-M2-128', '172753460446', 799.00, 600.00, 16, 5, 20, true, 0, '2026-01-07 11:12:02.676', '2026-01-07 11:12:02.676');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (342, 'iPad Pro 11 M2 256GB', 'Portable pro performance, Face ID.', 'IPD-PRO11-M2-256', '149895571848', 899.00, 700.00, 50, 5, 20, true, 0, '2026-01-07 11:12:02.683', '2026-01-07 11:12:02.683');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (343, 'iPad Air 5 M1 64GB', 'M1 chip, 10.9-inch Liquid Retina, 5G capable.', 'IPD-AIR5-64', '548114687284', 599.00, 450.00, 16, 5, 20, true, 0, '2026-01-07 11:12:02.69', '2026-01-07 11:12:02.69');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (344, 'iPad Air 5 M1 256GB', 'M1 power, Center Stage camera, 256GB.', 'IPD-AIR5-256', '652246244787', 749.00, 600.00, 40, 5, 20, true, 0, '2026-01-07 11:12:02.697', '2026-01-07 11:12:02.697');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (345, 'iPad Mini 6 64GB', '8.3-inch Liquid Retina, A15 Bionic, USB-C.', 'IPD-MINI6-64', '84605218865', 499.00, 380.00, 11, 5, 20, true, 0, '2026-01-07 11:12:02.704', '2026-01-07 11:12:02.704');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (346, 'iPad Mini 6 256GB', 'Small size, huge power, Apple Pencil 2 support.', 'IPD-MINI6-256', '627683351634', 649.00, 500.00, 9, 5, 20, true, 0, '2026-01-07 11:12:02.709', '2026-01-07 11:12:02.709');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (347, 'iPad (10th Gen) 64GB', 'All-screen design, 10.9-inch display, A14 Bionic.', 'IPD-10-64', '789617472484', 449.00, 350.00, 50, 5, 20, true, 0, '2026-01-07 11:12:02.716', '2026-01-07 11:12:02.716');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (348, 'iPad (10th Gen) 256GB', 'Colorful design, Landscape Ultra Wide front camera.', 'IPD-10-256', '654328053135', 599.00, 480.00, 36, 5, 20, true, 0, '2026-01-07 11:12:02.722', '2026-01-07 11:12:02.722');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (349, 'iPad (9th Gen) 64GB', 'A13 Bionic, 10.2-inch Retina display, Touch ID.', 'IPD-9-64', '689170802202', 329.00, 250.00, 5, 5, 20, true, 0, '2026-01-07 11:12:02.728', '2026-01-07 11:12:02.728');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (350, 'iPad (9th Gen) 256GB', 'Essential iPad experience with extra storage.', 'IPD-9-256', '690659642995', 479.00, 380.00, 34, 5, 20, true, 0, '2026-01-07 11:12:02.735', '2026-01-07 11:12:02.735');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (351, 'iPad Pro 12.9 M1 128GB Refurb', 'Refurbished M1 Powerhouse, XDR display.', 'IPD-PRO12-M1-REF', '311087180284', 899.00, 700.00, 45, 5, 20, true, 0, '2026-01-07 11:12:02.744', '2026-01-07 11:12:02.744');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (361, 'MacBook Air M3 13"', 'M3 chip, 13.6-inch Liquid Retina, Midnight finish.', 'MAC-AIR-M3-13', '455296763949', 1099.00, 850.00, 36, 5, 21, true, 0, '2026-01-07 11:12:02.83', '2026-01-07 11:12:02.83');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (352, 'iPad Pro 11 M1 128GB Refurb', 'Refurbished M1 performance, ProMotion.', 'IPD-PRO11-M1-REF', '156248656076', 699.00, 550.00, 27, 5, 20, true, 0, '2026-01-07 11:12:02.753', '2026-01-07 11:12:02.753');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (362, 'MacBook Air M3 15"', 'M3 chip, 15.3-inch Liquid Retina, Super thin.', 'MAC-AIR-M3-15', '157157777722', 1299.00, 1000.00, 45, 5, 21, true, 0, '2026-01-07 11:12:02.84', '2026-01-07 11:12:02.84');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (363, 'MacBook Pro 14 M3', 'M3 chip, 14-inch XDR display, Space Gray.', 'MAC-PRO-14-M3', '705371177605', 1599.00, 1250.00, 48, 5, 21, true, 0, '2026-01-07 11:12:02.848', '2026-01-07 11:12:02.848');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (364, 'MacBook Pro 16 M3 Pro', 'M3 Pro chip, 16-inch XDR, 18GB RAM.', 'MAC-PRO-16-M3P', '307573336796', 2499.00, 2000.00, 29, 5, 21, true, 0, '2026-01-07 11:12:02.858', '2026-01-07 11:12:02.858');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (365, 'MacBook Air M2 13"', 'M2 chip, Redesigned chassis, MagSafe charging.', 'MAC-AIR-M2-13', '744972056207', 999.00, 750.00, 40, 5, 21, true, 0, '2026-01-07 11:12:02.867', '2026-01-07 11:12:02.867');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (366, 'Dell XPS 13 Plus', 'Intel Core i7, OLED touch, invisible touchpad.', 'DELL-XPS-13P', '363355912721', 1399.00, 1100.00, 15, 5, 21, true, 0, '2026-01-07 11:12:02.88', '2026-01-07 11:12:02.88');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (367, 'Dell XPS 15 OLED', '3.5K OLED, RTX 4050, Intel Core i9.', 'DELL-XPS-15', '781316475404', 1899.00, 1500.00, 28, 5, 21, true, 0, '2026-01-07 11:12:02.894', '2026-01-07 11:12:02.894');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (368, 'ThinkPad X1 Carbon Gen 11', 'Ultralight business flagship, Carbon fiber chassis.', 'LEN-X1-G11', '264530176068', 1799.00, 1400.00, 53, 5, 21, true, 0, '2026-01-07 11:12:02.902', '2026-01-07 11:12:02.902');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (369, 'HP Spectre x360 14', '2-in-1 Convertible, OLED display, 9MP camera.', 'HP-SPEC-14', '514750269287', 1499.00, 1150.00, 53, 5, 21, true, 0, '2026-01-07 11:12:02.911', '2026-01-07 11:12:02.911');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (370, 'Asus ZenBook Duo 14', 'Dual screen laptop for productivity.', 'ASUS-ZEN-14', '277407907900', 1299.00, 950.00, 18, 5, 21, true, 0, '2026-01-07 11:12:02.922', '2026-01-07 11:12:02.922');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (371, 'Razer Blade 14', 'AMD Ryzen 9, RTX 4070, 14-inch gaming powerhouse.', 'RAZ-BLD-14', '594866705255', 2199.00, 1800.00, 38, 5, 21, true, 0, '2026-01-07 11:12:02.933', '2026-01-07 11:12:02.933');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (372, 'Microsoft Surface Laptop 5', '13.5-inch Alcantara keyboard, Intel Evo.', 'MS-SURF-L5', '331821727217', 999.00, 750.00, 6, 5, 21, true, 0, '2026-01-07 11:12:02.941', '2026-01-07 11:12:02.941');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (373, 'LG Gram 17', 'Ultra-lightweight 17-inch laptop, long battery.', 'LG-GRAM-17', '467777592229', 1699.00, 1300.00, 32, 5, 21, true, 0, '2026-01-07 11:12:02.947', '2026-01-07 11:12:02.947');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (374, 'Samsung Galaxy Book3 Pro', 'AMOLED 3K display, Intel 13th Gen, thin design.', 'SAM-BOOK3-PRO', '300309382663', 1449.00, 1100.00, 23, 5, 21, true, 0, '2026-01-07 11:12:02.953', '2026-01-07 11:12:02.953');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (375, 'Acer Swift 5', 'Antimicrobial coating, Aerospace-grade aluminum.', 'ACER-SWF-5', '838476153148', 1099.00, 800.00, 54, 5, 21, true, 0, '2026-01-07 11:12:02.96', '2026-01-07 11:12:02.96');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (376, 'MSI Stealth 16 Studio', 'Gaming and Creator laptop, RTX 4060, 240Hz.', 'MSI-ST-16', '639718478411', 1999.00, 1600.00, 44, 5, 21, true, 0, '2026-01-07 11:12:02.968', '2026-01-07 11:12:02.968');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (377, 'Lenovo Yoga 9i', 'Rotating soundbar, 4K OLED, 2-in-1 design.', 'LEN-YOGA-9I', '244329851085', 1399.00, 1100.00, 6, 5, 21, true, 0, '2026-01-07 11:12:02.974', '2026-01-07 11:12:02.974');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (378, 'Alienware x14', 'Thinnest Alienware, RTX 4060, 165Hz display.', 'ALN-X14', '993813011658', 1799.00, 1400.00, 31, 5, 21, true, 0, '2026-01-07 11:12:02.984', '2026-01-07 11:12:02.984');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (379, 'MacBook Pro 13 M2 Refurb', 'Refurbished M2, Touch Bar, active cooling.', 'MAC-PRO13-M2-REF', '433066975046', 1099.00, 850.00, 26, 5, 21, true, 0, '2026-01-07 11:12:02.991', '2026-01-07 11:12:02.991');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (380, 'Dell Inspiron 15', 'Budget friendly, AMD Ryzen 5, 15.6-inch.', 'DELL-INS-15', '23189557598', 599.00, 450.00, 35, 5, 21, true, 0, '2026-01-07 11:12:02.998', '2026-01-07 11:12:02.998');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (381, 'HP Pavilion 15', 'Reliable daily driver, Bang & Olufsen audio.', 'HP-PAV-15', '641817597265', 649.00, 500.00, 8, 5, 21, true, 0, '2026-01-07 11:12:03.004', '2026-01-07 11:12:03.004');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (382, 'Asus Vivobook 15', 'Thin and light, Intel Core i3, NanoEdge display.', 'ASUS-VIVO-15', '589093342520', 499.00, 380.00, 25, 5, 21, true, 0, '2026-01-07 11:12:03.011', '2026-01-07 11:12:03.011');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (383, 'Lenovo IdeaPad 3', 'Entry level, 15.6-inch FHD, privacy shutter.', 'LEN-IDEA-3', '955034736586', 449.00, 350.00, 49, 5, 21, true, 0, '2026-01-07 11:12:03.017', '2026-01-07 11:12:03.017');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (384, 'MacBook Pro 14 M4', 'Latest M4 chip, Nano-texture display option, Space Black.', 'MAC-PRO-14-M4', '948920832769', 1599.00, 1280.00, 36, 5, 21, true, 0, '2026-01-07 11:12:03.024', '2026-01-07 11:12:03.024');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (385, 'Dell XPS 14 (2024)', 'Intel Core Ultra 7, CNC Aluminum, Gorilla Glass 3.', 'DELL-XPS-14-9440', '760931441219', 1499.00, 1200.00, 22, 5, 21, true, 0, '2026-01-07 11:12:03.033', '2026-01-07 11:12:03.033');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (386, 'HP OmniBook Ultra Flip', 'AI-ready 2-in-1, 3K OLED, haptic touchpad.', 'HP-OMNI-FLIP', '324766253564', 1449.00, 1150.00, 48, 5, 21, true, 0, '2026-01-07 11:12:03.04', '2026-01-07 11:12:03.04');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (353, 'iPad Air 4 64GB Refurb', 'Refurbished A14 Bionic, All-screen design.', 'IPD-AIR4-REF', '736162414463', 450.00, 350.00, 15, 5, 20, true, 0, '2026-01-07 11:12:02.761', '2026-01-07 11:12:02.761');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (354, 'iPad Mini 5 64GB Used', 'Used condition, A12 Bionic, 7.9-inch display.', 'IPD-MINI5-USED', '430104601521', 300.00, 200.00, 25, 5, 20, true, 0, '2026-01-07 11:12:02.768', '2026-01-07 11:12:02.768');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (355, 'iPad Pro 12.9 (2020) Used', 'Used condition, A12Z Bionic, LiDAR Scanner.', 'IPD-PRO12-2020', '256413612641', 600.00, 450.00, 12, 5, 20, true, 0, '2026-01-07 11:12:02.775', '2026-01-07 11:12:02.775');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (356, 'iPad Pro 11 (2020) Used', 'Used condition, Face ID, ProMotion.', 'IPD-PRO11-2020', '944419334261', 500.00, 380.00, 36, 5, 20, true, 0, '2026-01-07 11:12:02.785', '2026-01-07 11:12:02.785');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (357, 'iPad (8th Gen) 32GB Used', 'Used condition, A12 Bionic, Apple Pencil 1 support.', 'IPD-8-USED', '185311136927', 200.00, 150.00, 26, 5, 20, true, 0, '2026-01-07 11:12:02.794', '2026-01-07 11:12:02.794');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (358, 'iPad Air 3 64GB Used', 'Used condition, A12 Bionic, Laminated display.', 'IPD-AIR3-USED', '617747171447', 250.00, 180.00, 12, 5, 20, true, 0, '2026-01-07 11:12:02.803', '2026-01-07 11:12:02.803');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (359, 'iPad Pro 10.5 Used', 'Used condition, A10X Fusion, ProMotion.', 'IPD-PRO105-USED', '474441379543', 220.00, 150.00, 16, 5, 20, true, 0, '2026-01-07 11:12:02.812', '2026-01-07 11:12:02.812');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (360, 'iPad Pro 9.7 Used', 'Used condition, 9.7-inch display, A9X.', 'IPD-PRO97-USED', '865152549156', 180.00, 120.00, 41, 5, 20, true, 0, '2026-01-07 11:12:02.821', '2026-01-07 11:12:02.821');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (387, 'ASUS ROG Zephyrus G14', 'OLED Nebula Display, RTX 4060, ultra-portable gaming.', 'ASUS-ROG-G14-24', '485275483786', 1599.00, 1300.00, 54, 5, 21, true, 0, '2026-01-07 11:12:03.046', '2026-01-07 11:12:03.046');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (388, 'Surface Laptop 7th Ed', 'Snapdragon X Elite, Copilot+ PC, 20-hour battery.', 'MS-SURF-L7', '929430178837', 999.00, 780.00, 20, 5, 21, true, 0, '2026-01-07 11:12:03.054', '2026-01-07 11:12:03.054');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (389, 'Samsung Galaxy Tab S9 Ultra', '14.6-inch Dynamic AMOLED 2X, S Pen included.', 'SAM-S9-ULT', '801713279320', 1199.00, 900.00, 52, 5, 22, true, 0, '2026-01-07 11:12:03.06', '2026-01-07 11:12:03.06');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (390, 'Samsung Galaxy Tab S9+', '12.4-inch AMOLED, Snapdragon 8 Gen 2.', 'SAM-S9-PLS', '131098403203', 999.00, 750.00, 7, 5, 22, true, 0, '2026-01-07 11:12:03.067', '2026-01-07 11:12:03.067');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (391, 'Samsung Galaxy Tab S9', '11-inch AMOLED, IP68 water resistance.', 'SAM-S9', '607932294746', 799.00, 600.00, 44, 5, 22, true, 0, '2026-01-07 11:12:03.075', '2026-01-07 11:12:03.075');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (392, 'Samsung Galaxy Tab S9 FE', 'Fan Edition, 10.9-inch LCD, 90Hz.', 'SAM-S9-FE', '276606212304', 449.00, 340.00, 19, 5, 22, true, 0, '2026-01-07 11:12:03.082', '2026-01-07 11:12:03.082');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (393, 'Google Pixel Tablet', 'Includes Charging Speaker Dock, Tensor G2.', 'GOO-PIX-TAB', '678781941546', 499.00, 380.00, 54, 5, 22, true, 0, '2026-01-07 11:12:03.089', '2026-01-07 11:12:03.089');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (394, 'OnePlus Pad', '11.61-inch 144Hz display, 67W fast charging.', 'ONE-PAD', '241743377722', 479.00, 360.00, 17, 5, 22, true, 0, '2026-01-07 11:12:03.095', '2026-01-07 11:12:03.095');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (395, 'Lenovo Tab P12 Pro', '12.6-inch AMOLED 120Hz, Snapdragon 870.', 'LEN-P12-PRO', '501122416655', 699.00, 500.00, 14, 5, 22, true, 0, '2026-01-07 11:12:03.102', '2026-01-07 11:12:03.102');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (416, 'iMac 24" M3', 'All-in-one, 4.5K Retina display, Color-matched accessories.', 'IMAC-24-M3', '863129533199', 1299.00, 1000.00, 32, 5, 23, true, 0, '2026-01-07 11:12:03.254', '2026-01-07 11:12:03.254');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (417, 'Dell XPS Desktop', 'Minimalist design, Liquid cooling, RTX 4070.', 'DELL-XPS-DT', '153472478676', 1499.00, 1100.00, 40, 5, 23, true, 0, '2026-01-07 11:12:03.261', '2026-01-07 11:12:03.261');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (418, 'Alienware Aurora R16', 'Optimized airflow, Legend 3 design, Core i7.', 'ALN-AUR-R16', '174666730994', 1799.00, 1400.00, 34, 5, 23, true, 0, '2026-01-07 11:12:03.268', '2026-01-07 11:12:03.268');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (419, 'HP Omen 45L', 'Cryo Chamber cooling, RTX 4080, Glass side panel.', 'HP-OMEN-45', '334824554143', 2499.00, 2000.00, 28, 5, 23, true, 0, '2026-01-07 11:12:03.274', '2026-01-07 11:12:03.274');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (420, 'Lenovo Legion Tower 7i', 'Coldfront 4.0 cooling, Core i9 K-series.', 'LEN-LEG-T7', '158045293985', 2299.00, 1800.00, 53, 5, 23, true, 0, '2026-01-07 11:12:03.28', '2026-01-07 11:12:03.28');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (421, 'Corsair Vengeance i7400', 'High-airflow case, iCUE RGB lighting.', 'COR-VEN-I7', '943250081941', 2899.00, 2300.00, 41, 5, 23, true, 0, '2026-01-07 11:12:03.288', '2026-01-07 11:12:03.288');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (422, 'MSI Aegis RS', 'Esports ready, Standard components for upgradability.', 'MSI-AEGIS', '774168795652', 1899.00, 1500.00, 21, 5, 23, true, 0, '2026-01-07 11:12:03.295', '2026-01-07 11:12:03.295');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (423, 'Skytech Azure Gaming PC', 'RTX 4070, 1TB NVMe, Mesh front panel.', 'SKY-AZU-GM', '553099166936', 1599.00, 1200.00, 11, 5, 23, true, 0, '2026-01-07 11:12:03.3', '2026-01-07 11:12:03.3');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (396, 'Xiaomi Pad 6', '11-inch WQHD+ 144Hz, Snapdragon 870.', 'XIA-PAD-6', '580477016720', 399.00, 280.00, 32, 5, 22, true, 0, '2026-01-07 11:12:03.108', '2026-01-07 11:12:03.108');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (424, 'CyberPowerPC Gamer Supreme', 'Liquid Cooled, 32GB DDR5, Custom RGB.', 'CYB-GAM-SUP', '264600865024', 1999.00, 1600.00, 49, 5, 23, true, 0, '2026-01-07 11:12:03.306', '2026-01-07 11:12:03.306');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (425, 'iBuyPower SlateMesh', 'High airflow mesh, RTX 4060 Ti.', 'IBP-SLA-MSH', '207029530355', 1399.00, 1000.00, 35, 5, 23, true, 0, '2026-01-07 11:12:03.312', '2026-01-07 11:12:03.312');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (426, 'Intel NUC 13 Extreme', 'Tiny footprint, Supports full-size GPU.', 'INT-NUC-13', '555201903231', 1499.00, 1150.00, 18, 5, 23, true, 0, '2026-01-07 11:12:03.318', '2026-01-07 11:12:03.318');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (427, 'HP Envy Desktop', 'Content creator focused, plenty of ports.', 'HP-ENVY-DT', '907875195964', 899.00, 650.00, 51, 5, 23, true, 0, '2026-01-07 11:12:03.325', '2026-01-07 11:12:03.325');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (428, 'Dell Inspiron Desktop', 'Compact home office PC, Intel Core i5.', 'DELL-INS-DT', '147322553238', 699.00, 500.00, 20, 5, 23, true, 0, '2026-01-07 11:12:03.333', '2026-01-07 11:12:03.333');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (429, 'Acer Predator Orion 7000', 'FrostBlade fans, ARGB, RTX 4090 beast.', 'ACER-PRE-7K', '839833228958', 2999.00, 2400.00, 37, 5, 23, true, 0, '2026-01-07 11:12:03.339', '2026-01-07 11:12:03.339');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (397, 'Amazon Fire Max 11', '11-inch 2K display, 14 hour battery life.', 'AMZ-FIRE-11', '598174036240', 229.00, 150.00, 31, 5, 22, true, 0, '2026-01-07 11:12:03.115', '2026-01-07 11:12:03.115');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (430, 'NZXT Player Three', 'H9 Flow case, Kraken Elite cooler, RTX 4080.', 'NZXT-PL3', '775998676551', 2499.00, 2000.00, 38, 5, 23, true, 0, '2026-01-07 11:12:03.346', '2026-01-07 11:12:03.346');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (431, 'Maingear MG-1', 'Compact chassis, Customizable magnetic front panel.', 'MAIN-MG1', '162912282101', 1699.00, 1300.00, 21, 5, 23, true, 0, '2026-01-07 11:12:03.353', '2026-01-07 11:12:03.353');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (432, 'Origin PC Neuron', 'Custom boutique build, UV printed glass option.', 'ORG-NEURON', '132216376739', 2599.00, 2100.00, 27, 5, 23, true, 0, '2026-01-07 11:12:03.36', '2026-01-07 11:12:03.36');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (433, 'Asus ROG Strix G16CH', 'Headphone holder, Carry handle, Airflow focused.', 'ASUS-ROG-DT', '649428601095', 1799.00, 1400.00, 45, 5, 23, true, 0, '2026-01-07 11:12:03.367', '2026-01-07 11:12:03.367');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (398, 'Samsung Galaxy Tab A9+', '11-inch 90Hz display, Quad speakers.', 'SAM-A9-PLS', '324913061010', 219.00, 160.00, 18, 5, 22, true, 0, '2026-01-07 11:12:03.121', '2026-01-07 11:12:03.121');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (434, 'LG C3 OLED 55"', 'OLED evo, Alpha 9 Gen 6 Processor, Dolby Vision.', 'LG-C3-55', '946052027496', 1499.00, 1100.00, 33, 5, 24, true, 0, '2026-01-07 11:12:03.375', '2026-01-07 11:12:03.375');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (435, 'LG C3 OLED 65"', 'Perfect black, 120Hz refresh rate for gaming.', 'LG-C3-65', '380907655403', 1899.00, 1400.00, 49, 5, 24, true, 0, '2026-01-07 11:12:03.383', '2026-01-07 11:12:03.383');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (399, 'Lenovo Tab M10 Plus', '10.6-inch 2K IPS, Reading mode.', 'LEN-M10-PLS', '705763893609', 189.00, 130.00, 28, 5, 22, true, 0, '2026-01-07 11:12:03.128', '2026-01-07 11:12:03.128');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (400, 'Samsung Galaxy Tab S8 Ultra Refurb', 'Refurbished 14.6-inch giant tablet.', 'SAM-S8-ULT-REF', '130302533547', 899.00, 650.00, 48, 5, 22, true, 0, '2026-01-07 11:12:03.136', '2026-01-07 11:12:03.136');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (401, 'Samsung Galaxy Tab S8+ Refurb', 'Refurbished Super AMOLED display.', 'SAM-S8-PLS-REF', '532312687249', 699.00, 500.00, 16, 5, 22, true, 0, '2026-01-07 11:12:03.147', '2026-01-07 11:12:03.147');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (402, 'Microsoft Surface Pro 9', '2-in-1, Intel Core i5, 13-inch PixelSense.', 'MS-SURF-P9', '340788709056', 999.00, 750.00, 22, 5, 22, true, 0, '2026-01-07 11:12:03.157', '2026-01-07 11:12:03.157');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (403, 'Microsoft Surface Go 3', 'Portable 10.5-inch touchscreen 2-in-1.', 'MS-SURF-G3', '459080157180', 399.00, 300.00, 44, 5, 22, true, 0, '2026-01-07 11:12:03.163', '2026-01-07 11:12:03.163');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (404, 'Chuwi HiPad XPro', 'Budget Android 12, 10.5-inch FHD.', 'CHU-HIPAD', '364067183333', 149.00, 100.00, 29, 5, 22, true, 0, '2026-01-07 11:12:03.169', '2026-01-07 11:12:03.169');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (405, 'Teclast T50', '2K display, Unibody aluminum design.', 'TEC-T50', '161242388758', 199.00, 140.00, 45, 5, 22, true, 0, '2026-01-07 11:12:03.175', '2026-01-07 11:12:03.175');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (406, 'Nokia T21', 'Tough built, 10.4-inch 2K display, 3 days battery.', 'NOK-T21', '612825917646', 239.00, 170.00, 26, 5, 22, true, 0, '2026-01-07 11:12:03.183', '2026-01-07 11:12:03.183');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (436, 'LG G3 OLED 65"', 'Brightness Booster Max, One Wall Design.', 'LG-G3-65', '30913534366', 2799.00, 2100.00, 38, 5, 24, true, 0, '2026-01-07 11:12:03.394', '2026-01-07 11:12:03.394');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (437, 'Samsung S90C OLED 55"', 'QD-OLED technology, LaserSlim design.', 'SAM-S90C-55', '558704962278', 1599.00, 1200.00, 10, 5, 24, true, 0, '2026-01-07 11:12:03.403', '2026-01-07 11:12:03.403');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (407, 'Realme Pad 2', '11.5-inch 120Hz 2K display, 33W charge.', 'REA-PAD-2', '324264364532', 249.00, 180.00, 15, 5, 22, true, 0, '2026-01-07 11:12:03.193', '2026-01-07 11:12:03.193');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (408, 'Oppo Pad Air', 'Ultra thin 6.9mm, Snapdragon 680.', 'OPP-PAD-A', '516092644663', 299.00, 220.00, 34, 5, 22, true, 0, '2026-01-07 11:12:03.201', '2026-01-07 11:12:03.201');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (409, 'Vivo Pad 2', '12.1-inch 144Hz display, Dimensity 9000.', 'VIV-PAD-2', '870899529485', 399.00, 300.00, 45, 5, 22, true, 0, '2026-01-07 11:12:03.207', '2026-01-07 11:12:03.207');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (410, 'Huawei MatePad Pro 13.2', 'Flexible OLED, Near-Link M-Pencil.', 'HUA-MATE-13', '558715179077', 999.00, 750.00, 40, 5, 22, true, 0, '2026-01-07 11:12:03.213', '2026-01-07 11:12:03.213');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (411, 'Honor Pad 9', '12.1-inch Paper-like display protection.', 'HON-PAD-9', '999744865951', 349.00, 250.00, 5, 5, 22, true, 0, '2026-01-07 11:12:03.219', '2026-01-07 11:12:03.219');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (412, 'Mac Mini M2', 'M2 chip, 8-core CPU, 10-core GPU.', 'MAC-MINI-M2', '842450638993', 599.00, 450.00, 24, 5, 23, true, 0, '2026-01-07 11:12:03.226', '2026-01-07 11:12:03.226');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (413, 'Mac Mini M2 Pro', 'M2 Pro chip, 4x Thunderbolt 4 ports.', 'MAC-MINI-M2P', '798156320055', 1299.00, 1000.00, 43, 5, 23, true, 0, '2026-01-07 11:12:03.233', '2026-01-07 11:12:03.233');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (414, 'Mac Studio M2 Max', 'Compact powerhouse for creative pros.', 'MAC-STUDIO-M2', '969643588805', 1999.00, 1600.00, 26, 5, 23, true, 0, '2026-01-07 11:12:03.241', '2026-01-07 11:12:03.241');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (415, 'Mac Studio M2 Ultra', 'The most powerful Mac silicon ever.', 'MAC-STUDIO-ULT', '973872117210', 3999.00, 3200.00, 25, 5, 23, true, 0, '2026-01-07 11:12:03.248', '2026-01-07 11:12:03.248');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (438, 'Samsung S90C OLED 65"', 'Pantone Validated colors, Motion Xcelerator.', 'SAM-S90C-65', '421125172875', 1999.00, 1500.00, 26, 5, 24, true, 0, '2026-01-07 11:12:03.409', '2026-01-07 11:12:03.409');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (439, 'Samsung QN90C Neo QLED 65"', 'Mini LED, Anti-Glare, Ultra Viewing Angle.', 'SAM-QN90C-65', '689271773097', 2199.00, 1700.00, 7, 5, 24, true, 0, '2026-01-07 11:12:03.417', '2026-01-07 11:12:03.417');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (440, 'Sony Bravia XR A80L 55"', 'Cognitive Processor XR, Acoustic Surface Audio.', 'SONY-A80L-55', '394780855712', 1699.00, 1300.00, 34, 5, 24, true, 0, '2026-01-07 11:12:03.423', '2026-01-07 11:12:03.423');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (441, 'Sony Bravia XR A95L 65"', 'QD-OLED flagship, XR Triluminos Max.', 'SONY-A95L-65', '15130632214', 3499.00, 2800.00, 10, 5, 24, true, 0, '2026-01-07 11:12:03.431', '2026-01-07 11:12:03.431');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (442, 'TCL QM8 Mini-LED 65"', '2000+ local dimming zones, 2000 nits peak brightness.', 'TCL-QM8-65', '707212768133', 1199.00, 900.00, 23, 5, 24, true, 0, '2026-01-07 11:12:03.44', '2026-01-07 11:12:03.44');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (443, 'Hisense U8K Mini-LED 65"', '144Hz native refresh, Wi-Fi 6E.', 'HIS-U8K-65', '562018442635', 1099.00, 850.00, 35, 5, 24, true, 0, '2026-01-07 11:12:03.447', '2026-01-07 11:12:03.447');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (444, 'Vizio P-Series Quantum 65"', 'QLED color, Active Full Array backlight.', 'VIZ-PQ-65', '972109427322', 999.00, 750.00, 28, 5, 24, true, 0, '2026-01-07 11:12:03.455', '2026-01-07 11:12:03.455');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (445, 'Roku Plus Series TV 55"', 'Built-in Roku OS, QLED, Voice Remote Pro.', 'ROKU-PLS-55', '642937796272', 499.00, 380.00, 34, 5, 24, true, 0, '2026-01-07 11:12:03.462', '2026-01-07 11:12:03.462');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (446, 'Amazon Fire TV Omni 65"', 'Hands-free Alexa, QLED, Local Dimming.', 'AMZ-OMNI-65', '675143666935', 599.00, 450.00, 38, 5, 24, true, 0, '2026-01-07 11:12:03.469', '2026-01-07 11:12:03.469');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (447, 'LG B3 OLED 55"', 'Entry-level OLED, 120Hz, G-Sync compatible.', 'LG-B3-55', '295548355580', 1199.00, 900.00, 15, 5, 24, true, 0, '2026-01-07 11:12:03.476', '2026-01-07 11:12:03.476');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (448, 'Samsung The Frame 55"', 'Art Mode, Matte Display, Slim Fit Wall Mount.', 'SAM-FRAME-55', '338817616379', 1499.00, 1100.00, 19, 5, 24, true, 0, '2026-01-07 11:12:03.484', '2026-01-07 11:12:03.484');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (449, 'Sony X90L Full Array 65"', 'Full Array LED, Perfect for PS5.', 'SONY-X90L-65', '615517081388', 1299.00, 1000.00, 49, 5, 24, true, 0, '2026-01-07 11:12:03.493', '2026-01-07 11:12:03.493');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (450, 'TCL 6-Series 55"', 'Mini-LED technology, Roku TV built-in.', 'TCL-6S-55', '361040131472', 699.00, 500.00, 39, 5, 24, true, 0, '2026-01-07 11:12:03.499', '2026-01-07 11:12:03.499');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (451, 'Hisense U7K 55"', 'Gaming TV, 144Hz, Game Bar.', 'HIS-U7K-55', '8165591392', 799.00, 600.00, 40, 5, 24, true, 0, '2026-01-07 11:12:03.507', '2026-01-07 11:12:03.507');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (452, 'Samsung CU7000 43"', 'Crystal UHD 4K, Smart Tizen OS.', 'SAM-CU7-43', '982207810748', 299.00, 220.00, 12, 5, 24, true, 0, '2026-01-07 11:12:03.515', '2026-01-07 11:12:03.515');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (453, 'LG UR9000 50"', '4K UHD, HDR10 Pro, Magic Remote.', 'LG-UR9-50', '731825399843', 399.00, 300.00, 6, 5, 24, true, 0, '2026-01-07 11:12:03.522', '2026-01-07 11:12:03.522');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (454, 'Sony X80K 43"', '4K HDR Processor X1, Triluminos Pro.', 'SONY-X80K-43', '260931490156', 449.00, 340.00, 53, 5, 24, true, 0, '2026-01-07 11:12:03.529', '2026-01-07 11:12:03.529');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (455, 'Insignia F30 Fire TV 50"', 'DTS Studio Sound, Voice Remote.', 'INS-F30-50', '2610172083', 249.00, 180.00, 10, 5, 24, true, 0, '2026-01-07 11:12:03.539', '2026-01-07 11:12:03.539');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (456, 'Toshiba C350 43"', 'Regza Engine 4K, Bezel-less design.', 'TOSH-C35-43', '293956439696', 229.00, 170.00, 46, 5, 24, true, 0, '2026-01-07 11:12:03.551', '2026-01-07 11:12:03.551');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (457, 'LG C4 OLED 55"', 'α9 AI Processor Gen7, 144Hz refresh rate, Filmmaker Mode for Dolby Vision.', 'LG-C4-55', '28931689287', 1899.00, 1450.00, 54, 5, 24, true, 0, '2026-01-07 11:12:03.565', '2026-01-07 11:12:03.565');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (458, 'Samsung S95D OLED 65"', 'Glare-free OLED technology, NQ4 AI Gen2 Processor, up to 144Hz refresh rate.', 'SAM-S95D-65', '678412715468', 2399.00, 1850.00, 21, 5, 24, true, 0, '2026-01-07 11:12:03.575', '2026-01-07 11:12:03.575');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (459, 'Sony Bravia 9 Mini-LED 65"', 'Sony’s brightest 4K TV, XR Backlight Master Drive, High Peak Brightness QLED.', 'SONY-B9-65', '487276259379', 1999.00, 1550.00, 17, 5, 24, true, 0, '2026-01-07 11:12:03.585', '2026-01-07 11:12:03.585');
INSERT INTO public.products (id, name, description, sku, barcode, price, "costPrice", stock, "minStock", "categoryId", "isActive", popularity, "createdAt", "updatedAt") VALUES (460, 'TCL QM851G Mini-LED 75"', 'High-end Mini-LED with 5000+ nits peak brightness and 144Hz VRR.', 'TCL-QM851-75', '106353324725', 1499.00, 1100.00, 38, 5, 24, true, 0, '2026-01-07 11:12:03.597', '2026-01-07 11:12:03.597');


--
-- Data for Name: sales_targets; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.users (id, username, email, password, role, "isActive", "createdAt", "updatedAt") VALUES (17, 'manager1', 'manager@myshop.com', '$2a$10$8yFJzt0IPqZj8QsUoFrDKuwDlNi/5wkNChEn1TdspC7eOCnCju1Pu', 'MANAGER', true, '2026-01-07 11:12:02.218', '2026-01-07 11:12:02.218');
INSERT INTO public.users (id, username, email, password, role, "isActive", "createdAt", "updatedAt") VALUES (18, 'admin', 'admin@myshop.com', '$2a$10$ftafSqgNHJxijhKzGLl18u.nrerH6.Ru9U7TVr9BmtwveZz7CM5UW', 'ADMIN', true, '2026-01-07 11:12:02.218', '2026-01-07 11:12:02.218');
INSERT INTO public.users (id, username, email, password, role, "isActive", "createdAt", "updatedAt") VALUES (19, 'staff1', 'staff1@myshop.com', '$2a$10$8yFJzt0IPqZj8QsUoFrDKuwDlNi/5wkNChEn1TdspC7eOCnCju1Pu', 'STAFF', true, '2026-01-07 11:12:02.218', '2026-01-07 11:12:02.218');


--
-- Name: app_licenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.app_licenses_id_seq', 4, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.categories_id_seq', 24, true);


--
-- Name: commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.commissions_id_seq', 115, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.customers_id_seq', 57, true);


--
-- Name: discounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.discounts_id_seq', 16, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.order_items_id_seq', 747, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orders_id_seq', 300, true);


--
-- Name: product_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.product_images_id_seq', 912, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_id_seq', 460, true);


--
-- Name: sales_targets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sales_targets_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 19, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: app_licenses app_licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.app_licenses
    ADD CONSTRAINT app_licenses_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: commissions commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: discounts discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_images product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: sales_targets sales_targets_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sales_targets
    ADD CONSTRAINT sales_targets_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: app_licenses_expiresAt_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "app_licenses_expiresAt_idx" ON public.app_licenses USING btree ("expiresAt");


--
-- Name: app_licenses_licenseKey_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "app_licenses_licenseKey_idx" ON public.app_licenses USING btree ("licenseKey");


--
-- Name: app_licenses_licenseKey_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX "app_licenses_licenseKey_key" ON public.app_licenses USING btree ("licenseKey");


--
-- Name: categories_name_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX categories_name_idx ON public.categories USING btree (name);


--
-- Name: categories_name_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX categories_name_key ON public.categories USING btree (name);


--
-- Name: commissions_createdAt_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "commissions_createdAt_idx" ON public.commissions USING btree ("createdAt");


--
-- Name: commissions_isPaid_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "commissions_isPaid_idx" ON public.commissions USING btree ("isPaid");


--
-- Name: commissions_orderId_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX "commissions_orderId_key" ON public.commissions USING btree ("orderId");


--
-- Name: commissions_userId_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "commissions_userId_idx" ON public.commissions USING btree ("userId");


--
-- Name: customers_email_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX customers_email_idx ON public.customers USING btree (email);


--
-- Name: customers_email_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX customers_email_key ON public.customers USING btree (email);


--
-- Name: customers_name_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX customers_name_idx ON public.customers USING btree (name);


--
-- Name: customers_phone_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX customers_phone_idx ON public.customers USING btree (phone);


--
-- Name: discounts_code_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX discounts_code_idx ON public.discounts USING btree (code);


--
-- Name: discounts_code_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX discounts_code_key ON public.discounts USING btree (code);


--
-- Name: discounts_type_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX discounts_type_idx ON public.discounts USING btree (type);


--
-- Name: order_items_orderId_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "order_items_orderId_idx" ON public.order_items USING btree ("orderId");


--
-- Name: order_items_productId_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "order_items_productId_idx" ON public.order_items USING btree ("productId");


--
-- Name: orders_createdAt_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "orders_createdAt_idx" ON public.orders USING btree ("createdAt");


--
-- Name: orders_customerId_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "orders_customerId_idx" ON public.orders USING btree ("customerId");


--
-- Name: orders_orderNumber_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "orders_orderNumber_idx" ON public.orders USING btree ("orderNumber");


--
-- Name: orders_orderNumber_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX "orders_orderNumber_key" ON public.orders USING btree ("orderNumber");


--
-- Name: orders_status_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX orders_status_idx ON public.orders USING btree (status);


--
-- Name: orders_userId_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "orders_userId_idx" ON public.orders USING btree ("userId");


--
-- Name: product_images_displayOrder_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "product_images_displayOrder_idx" ON public.product_images USING btree ("displayOrder");


--
-- Name: product_images_isMain_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "product_images_isMain_idx" ON public.product_images USING btree ("isMain");


--
-- Name: product_images_productId_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "product_images_productId_idx" ON public.product_images USING btree ("productId");


--
-- Name: products_barcode_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_barcode_idx ON public.products USING btree (barcode);


--
-- Name: products_barcode_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX products_barcode_key ON public.products USING btree (barcode);


--
-- Name: products_categoryId_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "products_categoryId_idx" ON public.products USING btree ("categoryId");


--
-- Name: products_name_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_name_idx ON public.products USING btree (name);


--
-- Name: products_sku_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_sku_idx ON public.products USING btree (sku);


--
-- Name: products_sku_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX products_sku_key ON public.products USING btree (sku);


--
-- Name: sales_targets_userId_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX "sales_targets_userId_idx" ON public.sales_targets USING btree ("userId");


--
-- Name: sales_targets_userId_month_year_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX "sales_targets_userId_month_year_key" ON public.sales_targets USING btree ("userId", month, year);


--
-- Name: sales_targets_year_month_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX sales_targets_year_month_idx ON public.sales_targets USING btree (year, month);


--
-- Name: users_email_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_email_idx ON public.users USING btree (email);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: users_role_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_role_idx ON public.users USING btree (role);


--
-- Name: users_username_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX users_username_idx ON public.users USING btree (username);


--
-- Name: users_username_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username);


--
-- Name: order_items order_items_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "order_items_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_items order_items_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "order_items_productId_fkey" FOREIGN KEY ("productId") REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: orders orders_customerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "orders_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES public.customers(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: orders orders_discountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "orders_discountId_fkey" FOREIGN KEY ("discountId") REFERENCES public.discounts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: orders orders_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "orders_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: product_images product_images_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT "product_images_productId_fkey" FOREIGN KEY ("productId") REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products products_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: admin
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--
