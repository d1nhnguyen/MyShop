--
-- PostgreSQL database dump
--

\restrict AmNOWEcSWmDz2yu5svhA0nZhRs7pVJKhDe8YIfNXfSfxI21c4B7u3rtGwt5kb5c

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

INSERT INTO public._prisma_migrations VALUES ('1ae8134b-8bc0-4019-a7d7-4c0c8b5a2ea4', 'fb747652571aeed99d858541db997e334a484f8436be5e9ac878ba7570055b61', '2025-12-25 18:23:10.741934+00', '20251225182310_init', NULL, NULL, '2025-12-25 18:23:10.307054+00', 1);
INSERT INTO public._prisma_migrations VALUES ('8a3f1a8d-ae02-4811-b378-bb3f4457f9c2', '6100051154c506ceae3867c309f9c4342a223c8018a0031ea7939b23efa0b383', '2025-12-31 16:18:56.672484+00', '20251231161856_add_product_images', NULL, NULL, '2025-12-31 16:18:56.57601+00', 1);


--
-- Data for Name: app_licenses; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.app_licenses VALUES (3, 'MYSHOP-TRIAL-0001', NULL, '2025-12-31 16:19:19.312', '2026-01-15 16:19:19.312', true, '2025-12-31 16:19:19.315');




--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.users VALUES (1, 'admin', 'admin@myshop.com', '$2a$10$rN7VcQ5TTR7/mIqwCpKU5OQVQr7T1QpOB3qzV6kIHnLLfi1yLRwXK', 'ADMIN', true, '2025-12-31 16:19:14.700', '2025-12-31 16:19:14.700');
INSERT INTO public.users VALUES (3, 'staff1', 'staff1@myshop.com', '$2a$10$rN7VcQ5TTR7/mIqwCpKU5OQVQr7T1QpOB3qzV6kIHnLLfi1yLRwXK', 'STAFF', true, '2025-12-31 16:19:14.720', '2025-12-31 16:19:14.720');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.categories VALUES (13, 'iPhone', 'Apple Smartphones', true, '2025-12-31 16:19:14.77', '2025-12-31 16:19:14.77');
INSERT INTO public.categories VALUES (14, 'iPad', 'Apple Tablets', true, '2025-12-31 16:19:14.784', '2025-12-31 16:19:14.784');
INSERT INTO public.categories VALUES (15, 'Laptop', 'Portable computers', true, '2025-12-31 16:19:14.791', '2025-12-31 16:19:14.791');
INSERT INTO public.categories VALUES (16, 'Tablet', 'Android and other tablets', true, '2025-12-31 16:19:14.797', '2025-12-31 16:19:14.797');
INSERT INTO public.categories VALUES (17, 'PC', 'Desktop computers', true, '2025-12-31 16:19:14.806', '2025-12-31 16:19:14.806');
INSERT INTO public.categories VALUES (18, 'TV', 'Smart Televisions', true, '2025-12-31 16:19:14.812', '2025-12-31 16:19:14.812');


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.commissions VALUES (1, 15, 103, 4696.00, 3.00, 140.88, false, '2025-11-23 08:12:46.86', '2025-11-23 08:12:46.86');
INSERT INTO public.commissions VALUES (2, 14, 105, 2179.00, 3.00, 65.37, false, NULL, '2025-06-18 13:10:44.035');
INSERT INTO public.commissions VALUES (3, 15, 106, 3225.00, 3.00, 96.75, false, '2024-09-29 14:15:41.981', '2024-09-29 14:15:41.981');
INSERT INTO public.commissions VALUES (4, 15, 107, 1500.00, 3.00, 45.00, true, NULL, '2024-02-03 19:39:20.823');
INSERT INTO public.commissions VALUES (5, 15, 108, 6096.00, 3.00, 182.88, true, NULL, '2024-09-30 17:20:50.396');
INSERT INTO public.commissions VALUES (6, 15, 109, 4295.00, 3.00, 128.85, false, '2025-10-26 04:57:08.787', '2025-10-26 04:57:08.787');
INSERT INTO public.commissions VALUES (7, 16, 113, 7548.00, 3.00, 226.44, true, NULL, '2025-10-14 19:40:47.285');
INSERT INTO public.commissions VALUES (8, 14, 114, 1799.00, 3.00, 53.97, false, NULL, '2025-07-12 06:51:55.655');
INSERT INTO public.commissions VALUES (9, 15, 115, 5196.00, 3.00, 155.88, false, '2024-11-26 20:30:45.193', '2024-11-26 20:30:45.193');
INSERT INTO public.commissions VALUES (10, 14, 116, 4645.00, 3.00, 139.35, false, '2024-06-06 07:50:49.33', '2024-06-06 07:50:49.33');
INSERT INTO public.commissions VALUES (11, 16, 120, 6395.00, 3.00, 191.85, false, NULL, '2025-02-12 14:17:01.211');
INSERT INTO public.commissions VALUES (12, 15, 121, 4796.00, 3.00, 143.88, true, '2025-11-01 06:17:35.176', '2025-11-01 06:17:35.176');
INSERT INTO public.commissions VALUES (13, 14, 123, 3499.00, 3.00, 104.97, true, NULL, '2025-11-07 17:34:24.132');
INSERT INTO public.commissions VALUES (14, 14, 126, 2698.00, 3.00, 80.94, false, NULL, '2024-06-07 10:53:51.917');
INSERT INTO public.commissions VALUES (15, 16, 127, 1099.00, 3.00, 32.97, true, '2025-03-19 02:39:51.964', '2025-03-19 02:39:51.964');
INSERT INTO public.commissions VALUES (16, 15, 129, 3198.00, 3.00, 95.94, true, '2024-07-09 17:49:46.42', '2024-07-09 17:49:46.42');
INSERT INTO public.commissions VALUES (17, 15, 130, 5097.00, 3.00, 152.91, true, '2025-06-26 00:24:51.79', '2025-06-26 00:24:51.79');
INSERT INTO public.commissions VALUES (18, 16, 131, 1699.00, 3.00, 50.97, false, NULL, '2024-09-20 20:18:11.206');
INSERT INTO public.commissions VALUES (19, 15, 133, 1000.00, 3.00, 30.00, true, NULL, '2025-10-13 23:11:14.349');
INSERT INTO public.commissions VALUES (20, 14, 134, 6946.00, 3.00, 208.38, true, '2025-01-10 17:47:42.797', '2025-01-10 17:47:42.797');
INSERT INTO public.commissions VALUES (21, 14, 135, 6196.00, 3.00, 185.88, true, NULL, '2025-06-10 05:09:13.423');
INSERT INTO public.commissions VALUES (22, 15, 136, 5584.00, 3.00, 167.52, false, '2025-04-09 15:12:33.321', '2025-04-09 15:12:33.321');
INSERT INTO public.commissions VALUES (23, 16, 138, 6046.00, 3.00, 181.38, false, '2024-12-20 09:21:48.562', '2024-12-20 09:21:48.562');
INSERT INTO public.commissions VALUES (24, 15, 140, 798.00, 3.00, 23.94, true, NULL, '2025-07-21 11:23:26.669');
INSERT INTO public.commissions VALUES (25, 15, 141, 2598.00, 3.00, 77.94, true, NULL, '2024-11-22 22:07:46.15');
INSERT INTO public.commissions VALUES (26, 16, 142, 3496.00, 3.00, 104.88, false, '2024-11-17 23:01:41.959', '2024-11-17 23:01:41.959');
INSERT INTO public.commissions VALUES (27, 15, 143, 2197.00, 3.00, 65.91, false, '2024-07-14 11:59:25.577', '2024-07-14 11:59:25.577');
INSERT INTO public.commissions VALUES (28, 15, 145, 5796.00, 3.00, 173.88, true, '2024-02-09 11:01:51.423', '2024-02-09 11:01:51.423');
INSERT INTO public.commissions VALUES (29, 16, 146, 3577.00, 3.00, 107.31, true, '2024-09-26 13:03:17.116', '2024-09-26 13:03:17.116');
INSERT INTO public.commissions VALUES (30, 16, 152, 189.00, 3.00, 5.67, true, NULL, '2025-11-22 11:08:44.258');
INSERT INTO public.commissions VALUES (31, 16, 153, 739.00, 3.00, 22.17, false, NULL, '2024-05-09 07:44:43.737');
INSERT INTO public.commissions VALUES (32, 15, 156, 4197.00, 3.00, 125.91, true, NULL, '2024-08-09 21:52:52.609');
INSERT INTO public.commissions VALUES (33, 15, 159, 1798.00, 3.00, 53.94, true, NULL, '2024-12-10 08:25:49.814');
INSERT INTO public.commissions VALUES (34, 16, 160, 4995.00, 3.00, 149.85, false, NULL, '2024-08-14 03:32:43.473');
INSERT INTO public.commissions VALUES (35, 15, 161, 4697.00, 3.00, 140.91, true, NULL, '2025-05-16 00:37:30.696');
INSERT INTO public.commissions VALUES (36, 16, 162, 5198.00, 3.00, 155.94, false, '2025-02-18 05:31:40.758', '2025-02-18 05:31:40.758');
INSERT INTO public.commissions VALUES (37, 16, 164, 449.00, 3.00, 13.47, true, '2024-09-09 09:20:55.778', '2024-09-09 09:20:55.778');
INSERT INTO public.commissions VALUES (38, 14, 165, 550.00, 3.00, 16.50, false, '2024-12-06 03:16:00.86', '2024-12-06 03:16:00.86');
INSERT INTO public.commissions VALUES (39, 16, 168, 5134.00, 3.00, 154.02, true, '2025-04-01 19:41:33.048', '2025-04-01 19:41:33.048');
INSERT INTO public.commissions VALUES (40, 15, 169, 699.00, 3.00, 20.97, false, '2025-02-24 20:29:02.167', '2025-02-24 20:29:02.167');
INSERT INTO public.commissions VALUES (41, 14, 171, 500.00, 3.00, 15.00, true, '2025-01-30 20:04:49.806', '2025-01-30 20:04:49.806');
INSERT INTO public.commissions VALUES (42, 14, 174, 1849.00, 3.00, 55.47, false, NULL, '2024-10-01 03:05:48.048');
INSERT INTO public.commissions VALUES (43, 14, 175, 3247.00, 3.00, 97.41, false, NULL, '2024-01-16 06:59:57.484');
INSERT INTO public.commissions VALUES (44, 15, 176, 4643.00, 3.00, 139.29, false, NULL, '2024-09-08 16:44:17.423');
INSERT INTO public.commissions VALUES (45, 14, 177, 6126.00, 3.00, 183.78, true, NULL, '2024-06-26 14:23:29.946');
INSERT INTO public.commissions VALUES (46, 14, 178, 599.00, 3.00, 17.97, false, '2025-10-09 20:12:18.006', '2025-10-09 20:12:18.006');
INSERT INTO public.commissions VALUES (47, 16, 180, 2825.00, 3.00, 84.75, false, '2024-12-03 08:35:15.091', '2024-12-03 08:35:15.091');
INSERT INTO public.commissions VALUES (48, 15, 182, 3395.00, 3.00, 101.85, false, '2025-07-30 13:12:18.642', '2025-07-30 13:12:18.642');
INSERT INTO public.commissions VALUES (49, 14, 183, 2196.00, 3.00, 65.88, false, NULL, '2024-12-07 12:54:00.415');
INSERT INTO public.commissions VALUES (50, 14, 184, 2898.00, 3.00, 86.94, true, NULL, '2024-07-28 05:29:51.097');
INSERT INTO public.commissions VALUES (51, 16, 185, 6296.00, 3.00, 188.88, false, NULL, '2024-06-19 05:01:11.583');
INSERT INTO public.commissions VALUES (52, 15, 186, 1598.00, 3.00, 47.94, true, '2025-01-25 00:29:56.005', '2025-01-25 00:29:56.005');
INSERT INTO public.commissions VALUES (53, 16, 187, 999.00, 3.00, 29.97, true, '2024-02-27 19:47:57.191', '2024-02-27 19:47:57.191');
INSERT INTO public.commissions VALUES (54, 15, 189, 6746.00, 3.00, 202.38, false, '2025-10-10 13:55:45.347', '2025-10-10 13:55:45.347');
INSERT INTO public.commissions VALUES (55, 15, 191, 4645.00, 3.00, 139.35, false, '2025-10-14 12:06:06.199', '2025-10-14 12:06:06.199');
INSERT INTO public.commissions VALUES (56, 16, 194, 7594.00, 3.00, 227.82, false, NULL, '2024-04-26 09:24:10.065');
INSERT INTO public.commissions VALUES (57, 15, 196, 3437.00, 3.00, 103.11, false, NULL, '2024-05-06 18:21:38.111');
INSERT INTO public.commissions VALUES (58, 14, 199, 2998.00, 3.00, 89.94, false, NULL, '2024-04-24 05:52:58.18');
INSERT INTO public.commissions VALUES (59, 14, 200, 2598.00, 3.00, 77.94, true, NULL, '2025-08-06 01:13:53.938');


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.customers VALUES (14, 'John Smith', 'john.smith@example.com', '0901234567', '123 Main St, New York, NY', true, '2024-01-01 00:00:00', 7195.00, NULL, '2025-12-31 16:19:17.207', '2025-12-31 16:19:19.132');
INSERT INTO public.customers VALUES (15, 'Emily Johnson', 'emily.j@example.com', '0902345678', '456 Market St, San Francisco, CA', false, NULL, 17125.00, NULL, '2025-12-31 16:19:17.221', '2025-12-31 16:19:19.143');
INSERT INTO public.customers VALUES (16, 'Michael Williams', 'mike.w@example.com', '0903456789', '789 Broadway, Los Angeles, CA', true, '2024-06-15 00:00:00', 13591.00, NULL, '2025-12-31 16:19:17.231', '2025-12-31 16:19:19.152');
INSERT INTO public.customers VALUES (17, 'Sarah Brown', 'sarah.b@example.com', '0904567890', '321 Elm St, Chicago, IL', false, NULL, 4977.00, NULL, '2025-12-31 16:19:17.236', '2025-12-31 16:19:19.162');
INSERT INTO public.customers VALUES (18, 'David Jones', 'david.j@example.com', '0905678901', '654 Pine St, Houston, TX', true, '2024-03-20 00:00:00', 13889.00, NULL, '2025-12-31 16:19:17.241', '2025-12-31 16:19:19.172');
INSERT INTO public.customers VALUES (19, 'Jennifer Garcia', 'jen.garcia@example.com', '0906789012', '987 Oak Ave, Miami, FL', true, '2024-02-10 00:00:00', 6285.00, NULL, '2025-12-31 16:19:17.246', '2025-12-31 16:19:19.179');
INSERT INTO public.customers VALUES (20, 'Robert Miller', 'rob.miller@example.com', '0907890123', '147 Maple Dr, Seattle, WA', false, NULL, 9894.00, NULL, '2025-12-31 16:19:17.252', '2025-12-31 16:19:19.187');
INSERT INTO public.customers VALUES (21, 'Jessica Davis', 'jess.davis@example.com', '0908901234', '258 Cedar Ln, Boston, MA', false, NULL, 9625.00, NULL, '2025-12-31 16:19:17.258', '2025-12-31 16:19:19.195');
INSERT INTO public.customers VALUES (22, 'William Rodriguez', 'will.rod@example.com', '0909012345', '369 Birch Rd, Denver, CO', true, '2024-05-01 00:00:00', 18151.00, NULL, '2025-12-31 16:19:17.262', '2025-12-31 16:19:19.204');
INSERT INTO public.customers VALUES (23, 'Elizabeth Martinez', 'liz.martinez@example.com', '0900123456', '741 Spruce Ct, Atlanta, GA', true, '2024-07-20 00:00:00', 0.00, NULL, '2025-12-31 16:19:17.268', '2025-12-31 16:19:19.211');
INSERT INTO public.customers VALUES (24, 'James Anderson', 'james.a@example.com', '0911234567', '852 Willow Way, Phoenix, AZ', false, NULL, 19785.00, NULL, '2025-12-31 16:19:17.274', '2025-12-31 16:19:19.219');
INSERT INTO public.customers VALUES (25, 'Linda Taylor', 'linda.t@example.com', '0912345678', '963 Aspen Pl, Portland, OR', false, NULL, 0.00, NULL, '2025-12-31 16:19:17.278', '2025-12-31 16:19:19.226');
INSERT INTO public.customers VALUES (26, 'Christopher Lee', 'chris.lee@example.com', '0913456789', '159 Valley Rd, Austin, TX', true, '2024-04-12 00:00:00', 9122.00, NULL, '2025-12-31 16:19:17.284', '2025-12-31 16:19:19.233');
INSERT INTO public.customers VALUES (27, 'Patricia White', 'pat.white@example.com', '0914567890', '753 Hill St, Nashville, TN', false, NULL, 11489.00, NULL, '2025-12-31 16:19:17.29', '2025-12-31 16:19:19.242');
INSERT INTO public.customers VALUES (28, 'Daniel Harris', 'dan.harris@example.com', '0915678901', '951 Lake Dr, Detroit, MI', true, '2024-08-05 00:00:00', 4697.00, NULL, '2025-12-31 16:19:17.296', '2025-12-31 16:19:19.251');
INSERT INTO public.customers VALUES (29, 'Nancy Clark', 'nancy.clark@example.com', '0916789012', '357 River Ln, Minneapolis, MN', false, NULL, 4036.00, NULL, '2025-12-31 16:19:17.302', '2025-12-31 16:19:19.259');
INSERT INTO public.customers VALUES (30, 'Matthew Lewis', 'matt.lewis@example.com', '0917890123', '486 Forest Ave, Tampa, FL', true, '2024-09-18 00:00:00', 2825.00, NULL, '2025-12-31 16:19:17.307', '2025-12-31 16:19:19.268');
INSERT INTO public.customers VALUES (31, 'Karen Walker', 'karen.w@example.com', '0918901234', '624 Mountain Rd, Cleveland, OH', false, NULL, 11289.00, NULL, '2025-12-31 16:19:17.313', '2025-12-31 16:19:19.275');
INSERT INTO public.customers VALUES (32, 'Thomas Hall', 'tom.hall@example.com', '0919012345', '792 Beach Blvd, San Diego, CA', true, '2024-01-25 00:00:00', 7794.00, NULL, '2025-12-31 16:19:17.319', '2025-12-31 16:19:19.284');
INSERT INTO public.customers VALUES (33, 'Betty Allen', 'betty.allen@example.com', '0920123456', '135 Park Ave, Philadelphia, PA', false, NULL, 4546.00, NULL, '2025-12-31 16:19:17.325', '2025-12-31 16:19:19.293');
INSERT INTO public.customers VALUES (34, 'Charles Young', 'charles.y@example.com', '0921234567', '246 Garden St, Charlotte, NC', true, '2024-06-30 00:00:00', 18184.00, NULL, '2025-12-31 16:19:17.331', '2025-12-31 16:19:19.301');
INSERT INTO public.customers VALUES (35, 'Sandra King', 'sandra.king@example.com', '0922345678', '864 Sunset Dr, Indianapolis, IN', true, '2024-03-08 00:00:00', 13229.00, NULL, '2025-12-31 16:19:17.338', '2025-12-31 16:19:19.307');


--
-- Data for Name: discounts; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.discounts VALUES (7, 'WELCOME2025', 'First Time User', 'Welcome gift for new users', 'FIXED_AMOUNT', 10.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, true, false, NULL, '2025-12-31 16:19:14.831', '2025-12-31 16:19:14.831');
INSERT INTO public.discounts VALUES (8, 'FREESHIP', 'Free Shipping', 'Free shipping on all orders', 'FIXED_AMOUNT', 5.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, true, false, NULL, '2025-12-31 16:19:14.843', '2025-12-31 16:19:14.843');
INSERT INTO public.discounts VALUES (9, 'MERRYXMAS', 'Merry Christmas', 'Holiday season special', 'PERCENTAGE', 20.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, true, false, NULL, '2025-12-31 16:19:14.852', '2025-12-31 16:19:14.852');
INSERT INTO public.discounts VALUES (10, 'FLASH50', 'Flash Sale', 'Limited time offer', 'PERCENTAGE', 50.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, false, false, NULL, '2025-12-31 16:19:14.86', '2025-12-31 16:19:14.86');
INSERT INTO public.discounts VALUES (11, 'VIPMEMBER', 'VIP Discount', 'Exclusive for members', 'PERCENTAGE', 15.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 0, true, false, NULL, '2025-12-31 16:19:14.87', '2025-12-31 16:19:14.87');


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.order_items VALUES (235, 101, 266, 2, 1799.00, 3598.00, 0.00, 3598.00);
INSERT INTO public.order_items VALUES (236, 101, 257, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items VALUES (237, 101, 166, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items VALUES (238, 101, 181, 1, 1199.00, 1199.00, 0.00, 1199.00);
INSERT INTO public.order_items VALUES (239, 102, 162, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (240, 102, 296, 1, 1499.00, 1499.00, 0.00, 1499.00);
INSERT INTO public.order_items VALUES (241, 102, 190, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items VALUES (242, 103, 202, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items VALUES (243, 103, 293, 1, 499.00, 499.00, 0.00, 499.00);
INSERT INTO public.order_items VALUES (244, 103, 261, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items VALUES (245, 103, 220, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (246, 104, 202, 1, 300.00, 300.00, 0.00, 300.00);
INSERT INTO public.order_items VALUES (247, 105, 208, 1, 180.00, 180.00, 0.00, 180.00);
INSERT INTO public.order_items VALUES (248, 105, 307, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items VALUES (249, 106, 173, 1, 429.00, 429.00, 0.00, 429.00);
INSERT INTO public.order_items VALUES (250, 106, 179, 2, 250.00, 500.00, 0.00, 500.00);
INSERT INTO public.order_items VALUES (251, 106, 243, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items VALUES (252, 106, 231, 2, 449.00, 898.00, 0.00, 898.00);
INSERT INTO public.order_items VALUES (253, 107, 202, 1, 300.00, 300.00, 0.00, 300.00);
INSERT INTO public.order_items VALUES (254, 107, 202, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items VALUES (255, 107, 202, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items VALUES (256, 108, 215, 2, 1899.00, 3798.00, 0.00, 3798.00);
INSERT INTO public.order_items VALUES (257, 108, 190, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (258, 108, 179, 2, 250.00, 500.00, 0.00, 500.00);
INSERT INTO public.order_items VALUES (259, 109, 163, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items VALUES (260, 109, 184, 2, 799.00, 1598.00, 0.00, 1598.00);
INSERT INTO public.order_items VALUES (261, 109, 243, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items VALUES (262, 110, 182, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (263, 110, 302, 2, 449.00, 898.00, 0.00, 898.00);
INSERT INTO public.order_items VALUES (264, 111, 202, 1, 300.00, 300.00, 0.00, 300.00);
INSERT INTO public.order_items VALUES (265, 111, 180, 2, 200.00, 400.00, 0.00, 400.00);
INSERT INTO public.order_items VALUES (266, 111, 283, 2, 1899.00, 3798.00, 0.00, 3798.00);
INSERT INTO public.order_items VALUES (267, 111, 233, 1, 1499.00, 1499.00, 0.00, 1499.00);
INSERT INTO public.order_items VALUES (268, 112, 242, 1, 479.00, 479.00, 0.00, 479.00);
INSERT INTO public.order_items VALUES (269, 112, 164, 1, 799.00, 799.00, 0.00, 799.00);
INSERT INTO public.order_items VALUES (270, 112, 224, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items VALUES (271, 112, 272, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items VALUES (272, 113, 289, 2, 3499.00, 6998.00, 0.00, 6998.00);
INSERT INTO public.order_items VALUES (273, 113, 179, 1, 250.00, 250.00, 0.00, 250.00);
INSERT INTO public.order_items VALUES (274, 113, 202, 1, 300.00, 300.00, 0.00, 300.00);
INSERT INTO public.order_items VALUES (275, 114, 216, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items VALUES (276, 115, 235, 2, 1599.00, 3198.00, 0.00, 3198.00);
INSERT INTO public.order_items VALUES (277, 115, 220, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items VALUES (278, 116, 292, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (279, 116, 282, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items VALUES (280, 116, 253, 1, 199.00, 199.00, 0.00, 199.00);
INSERT INTO public.order_items VALUES (281, 116, 231, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items VALUES (282, 117, 194, 2, 649.00, 1298.00, 0.00, 1298.00);
INSERT INTO public.order_items VALUES (283, 117, 161, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items VALUES (284, 117, 225, 2, 1399.00, 2798.00, 0.00, 2798.00);
INSERT INTO public.order_items VALUES (285, 118, 195, 2, 449.00, 898.00, 0.00, 898.00);
INSERT INTO public.order_items VALUES (286, 118, 246, 1, 219.00, 219.00, 0.00, 219.00);
INSERT INTO public.order_items VALUES (287, 118, 159, 2, 1599.00, 3198.00, 0.00, 3198.00);
INSERT INTO public.order_items VALUES (288, 118, 172, 1, 499.00, 499.00, 0.00, 499.00);
INSERT INTO public.order_items VALUES (289, 119, 220, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (290, 119, 264, 1, 1299.00, 1299.00, 0.00, 1299.00);
INSERT INTO public.order_items VALUES (291, 119, 241, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items VALUES (292, 120, 295, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items VALUES (293, 120, 280, 1, 2599.00, 2599.00, 0.00, 2599.00);
INSERT INTO public.order_items VALUES (294, 120, 169, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items VALUES (295, 121, 214, 2, 1399.00, 2798.00, 0.00, 2798.00);
INSERT INTO public.order_items VALUES (296, 121, 213, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items VALUES (297, 122, 299, 1, 799.00, 799.00, 0.00, 799.00);
INSERT INTO public.order_items VALUES (298, 122, 186, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items VALUES (299, 122, 226, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items VALUES (300, 123, 289, 1, 3499.00, 3499.00, 0.00, 3499.00);
INSERT INTO public.order_items VALUES (301, 124, 193, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items VALUES (302, 125, 278, 1, 2499.00, 2499.00, 0.00, 2499.00);
INSERT INTO public.order_items VALUES (303, 125, 289, 2, 3499.00, 6998.00, 0.00, 6998.00);
INSERT INTO public.order_items VALUES (304, 125, 191, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items VALUES (305, 125, 179, 2, 250.00, 500.00, 0.00, 500.00);
INSERT INTO public.order_items VALUES (306, 126, 288, 1, 1699.00, 1699.00, 0.00, 1699.00);
INSERT INTO public.order_items VALUES (307, 126, 250, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (308, 127, 193, 1, 499.00, 499.00, 0.00, 499.00);
INSERT INTO public.order_items VALUES (309, 127, 178, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items VALUES (310, 128, 234, 1, 1449.00, 1449.00, 0.00, 1449.00);
INSERT INTO public.order_items VALUES (311, 128, 165, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (312, 128, 191, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items VALUES (313, 129, 272, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items VALUES (314, 129, 157, 1, 1199.00, 1199.00, 0.00, 1199.00);
INSERT INTO public.order_items VALUES (315, 130, 262, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items VALUES (316, 130, 161, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items VALUES (317, 131, 221, 1, 1699.00, 1699.00, 0.00, 1699.00);
INSERT INTO public.order_items VALUES (318, 132, 282, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items VALUES (319, 132, 234, 1, 1449.00, 1449.00, 0.00, 1449.00);
INSERT INTO public.order_items VALUES (320, 133, 204, 2, 500.00, 1000.00, 0.00, 1000.00);
INSERT INTO public.order_items VALUES (321, 134, 224, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items VALUES (322, 134, 294, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items VALUES (323, 134, 177, 2, 650.00, 1300.00, 0.00, 1300.00);
INSERT INTO public.order_items VALUES (324, 134, 201, 1, 450.00, 450.00, 0.00, 450.00);
INSERT INTO public.order_items VALUES (325, 135, 224, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items VALUES (326, 135, 209, 2, 1099.00, 2198.00, 0.00, 2198.00);
INSERT INTO public.order_items VALUES (327, 136, 269, 1, 2899.00, 2899.00, 0.00, 2899.00);
INSERT INTO public.order_items VALUES (328, 136, 246, 2, 219.00, 438.00, 0.00, 438.00);
INSERT INTO public.order_items VALUES (329, 136, 213, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items VALUES (330, 136, 255, 1, 249.00, 249.00, 0.00, 249.00);
INSERT INTO public.order_items VALUES (331, 137, 279, 2, 1699.00, 3398.00, 0.00, 3398.00);
INSERT INTO public.order_items VALUES (332, 137, 293, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items VALUES (333, 137, 241, 1, 499.00, 499.00, 0.00, 499.00);
INSERT INTO public.order_items VALUES (334, 138, 226, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items VALUES (335, 138, 295, 1, 1199.00, 1199.00, 0.00, 1199.00);
INSERT INTO public.order_items VALUES (336, 138, 273, 2, 1399.00, 2798.00, 0.00, 2798.00);
INSERT INTO public.order_items VALUES (337, 138, 179, 1, 250.00, 250.00, 0.00, 250.00);
INSERT INTO public.order_items VALUES (338, 139, 260, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items VALUES (339, 139, 187, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items VALUES (340, 140, 301, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items VALUES (341, 141, 180, 2, 200.00, 400.00, 0.00, 400.00);
INSERT INTO public.order_items VALUES (342, 141, 177, 1, 650.00, 650.00, 0.00, 650.00);
INSERT INTO public.order_items VALUES (343, 141, 192, 1, 749.00, 749.00, 0.00, 749.00);
INSERT INTO public.order_items VALUES (344, 141, 164, 1, 799.00, 799.00, 0.00, 799.00);
INSERT INTO public.order_items VALUES (345, 142, 178, 2, 300.00, 600.00, 0.00, 600.00);
INSERT INTO public.order_items VALUES (346, 142, 244, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items VALUES (347, 142, 243, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items VALUES (348, 142, 273, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items VALUES (349, 143, 199, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (350, 143, 257, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items VALUES (351, 144, 247, 1, 189.00, 189.00, 0.00, 189.00);
INSERT INTO public.order_items VALUES (352, 145, 261, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items VALUES (353, 145, 271, 2, 1599.00, 3198.00, 0.00, 3198.00);
INSERT INTO public.order_items VALUES (354, 146, 186, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items VALUES (355, 146, 272, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items VALUES (356, 146, 174, 1, 479.00, 479.00, 0.00, 479.00);
INSERT INTO public.order_items VALUES (357, 147, 274, 1, 1499.00, 1499.00, 0.00, 1499.00);
INSERT INTO public.order_items VALUES (358, 147, 292, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items VALUES (359, 147, 233, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items VALUES (360, 148, 231, 2, 449.00, 898.00, 0.00, 898.00);
INSERT INTO public.order_items VALUES (361, 148, 163, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (362, 149, 226, 2, 1799.00, 3598.00, 0.00, 3598.00);
INSERT INTO public.order_items VALUES (363, 149, 180, 1, 200.00, 200.00, 0.00, 200.00);
INSERT INTO public.order_items VALUES (364, 150, 217, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items VALUES (365, 151, 161, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items VALUES (366, 152, 247, 1, 189.00, 189.00, 0.00, 189.00);
INSERT INTO public.order_items VALUES (367, 153, 176, 1, 550.00, 550.00, 0.00, 550.00);
INSERT INTO public.order_items VALUES (368, 153, 247, 1, 189.00, 189.00, 0.00, 189.00);
INSERT INTO public.order_items VALUES (369, 154, 165, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items VALUES (370, 154, 248, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (371, 154, 221, 1, 1699.00, 1699.00, 0.00, 1699.00);
INSERT INTO public.order_items VALUES (372, 155, 244, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items VALUES (373, 155, 176, 2, 550.00, 1100.00, 0.00, 1100.00);
INSERT INTO public.order_items VALUES (374, 156, 220, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items VALUES (375, 156, 219, 1, 2199.00, 2199.00, 0.00, 2199.00);
INSERT INTO public.order_items VALUES (376, 157, 227, 1, 1099.00, 1099.00, 0.00, 1099.00);
INSERT INTO public.order_items VALUES (377, 158, 195, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items VALUES (378, 158, 277, 1, 2999.00, 2999.00, 0.00, 2999.00);
INSERT INTO public.order_items VALUES (379, 158, 244, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items VALUES (380, 159, 238, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (381, 159, 184, 1, 799.00, 799.00, 0.00, 799.00);
INSERT INTO public.order_items VALUES (382, 160, 265, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items VALUES (383, 160, 172, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items VALUES (384, 160, 220, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (385, 161, 224, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items VALUES (386, 161, 248, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items VALUES (387, 161, 226, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items VALUES (388, 162, 280, 2, 2599.00, 5198.00, 0.00, 5198.00);
INSERT INTO public.order_items VALUES (389, 163, 229, 1, 649.00, 649.00, 0.00, 649.00);
INSERT INTO public.order_items VALUES (390, 164, 195, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items VALUES (391, 165, 176, 1, 550.00, 550.00, 0.00, 550.00);
INSERT INTO public.order_items VALUES (392, 166, 175, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items VALUES (393, 166, 295, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items VALUES (394, 167, 296, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items VALUES (395, 167, 218, 2, 1299.00, 2598.00, 0.00, 2598.00);
INSERT INTO public.order_items VALUES (396, 167, 307, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items VALUES (397, 167, 185, 1, 599.00, 599.00, 0.00, 599.00);
INSERT INTO public.order_items VALUES (398, 168, 244, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items VALUES (399, 168, 246, 2, 219.00, 438.00, 0.00, 438.00);
INSERT INTO public.order_items VALUES (400, 168, 215, 1, 1899.00, 1899.00, 0.00, 1899.00);
INSERT INTO public.order_items VALUES (401, 168, 237, 2, 1199.00, 2398.00, 0.00, 2398.00);
INSERT INTO public.order_items VALUES (402, 169, 243, 1, 699.00, 699.00, 0.00, 699.00);
INSERT INTO public.order_items VALUES (403, 170, 198, 1, 479.00, 479.00, 0.00, 479.00);
INSERT INTO public.order_items VALUES (404, 170, 168, 2, 799.00, 1598.00, 0.00, 1598.00);
INSERT INTO public.order_items VALUES (405, 171, 179, 2, 250.00, 500.00, 0.00, 500.00);
INSERT INTO public.order_items VALUES (406, 172, 253, 2, 199.00, 398.00, 0.00, 398.00);
INSERT INTO public.order_items VALUES (407, 172, 304, 1, 229.00, 229.00, 0.00, 229.00);
INSERT INTO public.order_items VALUES (408, 172, 221, 1, 1699.00, 1699.00, 0.00, 1699.00);
INSERT INTO public.order_items VALUES (409, 173, 170, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items VALUES (410, 174, 201, 1, 450.00, 450.00, 0.00, 450.00);
INSERT INTO public.order_items VALUES (411, 174, 273, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items VALUES (412, 175, 250, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (413, 175, 229, 1, 649.00, 649.00, 0.00, 649.00);
INSERT INTO public.order_items VALUES (414, 175, 232, 1, 1599.00, 1599.00, 0.00, 1599.00);
INSERT INTO public.order_items VALUES (415, 176, 200, 2, 699.00, 1398.00, 0.00, 1398.00);
INSERT INTO public.order_items VALUES (416, 176, 255, 1, 249.00, 249.00, 0.00, 249.00);
INSERT INTO public.order_items VALUES (417, 176, 199, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (418, 176, 228, 2, 599.00, 1198.00, 0.00, 1198.00);
INSERT INTO public.order_items VALUES (419, 177, 171, 2, 499.00, 998.00, 0.00, 998.00);
INSERT INTO public.order_items VALUES (420, 177, 197, 1, 329.00, 329.00, 0.00, 329.00);
INSERT INTO public.order_items VALUES (421, 177, 177, 2, 650.00, 1300.00, 0.00, 1300.00);
INSERT INTO public.order_items VALUES (422, 177, 289, 1, 3499.00, 3499.00, 0.00, 3499.00);
INSERT INTO public.order_items VALUES (423, 178, 294, 1, 599.00, 599.00, 0.00, 599.00);
INSERT INTO public.order_items VALUES (424, 179, 229, 2, 649.00, 1298.00, 0.00, 1298.00);
INSERT INTO public.order_items VALUES (425, 179, 215, 1, 1899.00, 1899.00, 0.00, 1899.00);
INSERT INTO public.order_items VALUES (426, 179, 225, 2, 1399.00, 2798.00, 0.00, 2798.00);
INSERT INTO public.order_items VALUES (427, 180, 251, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items VALUES (428, 180, 245, 1, 229.00, 229.00, 0.00, 229.00);
INSERT INTO public.order_items VALUES (429, 180, 199, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (430, 181, 303, 1, 249.00, 249.00, 0.00, 249.00);
INSERT INTO public.order_items VALUES (431, 182, 165, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items VALUES (432, 182, 256, 1, 299.00, 299.00, 0.00, 299.00);
INSERT INTO public.order_items VALUES (433, 182, 168, 2, 799.00, 1598.00, 0.00, 1598.00);
INSERT INTO public.order_items VALUES (434, 182, 185, 1, 599.00, 599.00, 0.00, 599.00);
INSERT INTO public.order_items VALUES (435, 183, 165, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items VALUES (436, 183, 213, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (437, 183, 252, 2, 149.00, 298.00, 0.00, 298.00);
INSERT INTO public.order_items VALUES (438, 184, 307, 1, 1999.00, 1999.00, 0.00, 1999.00);
INSERT INTO public.order_items VALUES (439, 184, 190, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items VALUES (440, 185, 178, 1, 300.00, 300.00, 0.00, 300.00);
INSERT INTO public.order_items VALUES (441, 185, 307, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items VALUES (442, 185, 258, 2, 999.00, 1998.00, 0.00, 1998.00);
INSERT INTO public.order_items VALUES (443, 186, 239, 2, 799.00, 1598.00, 0.00, 1598.00);
INSERT INTO public.order_items VALUES (444, 187, 238, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (445, 188, 190, 1, 899.00, 899.00, 0.00, 899.00);
INSERT INTO public.order_items VALUES (446, 189, 270, 2, 1899.00, 3798.00, 0.00, 3798.00);
INSERT INTO public.order_items VALUES (447, 189, 212, 1, 2499.00, 2499.00, 0.00, 2499.00);
INSERT INTO public.order_items VALUES (448, 189, 195, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items VALUES (449, 190, 190, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (450, 190, 216, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items VALUES (451, 190, 302, 1, 449.00, 449.00, 0.00, 449.00);
INSERT INTO public.order_items VALUES (452, 190, 242, 1, 479.00, 479.00, 0.00, 479.00);
INSERT INTO public.order_items VALUES (453, 191, 257, 2, 399.00, 798.00, 0.00, 798.00);
INSERT INTO public.order_items VALUES (454, 191, 234, 1, 1449.00, 1449.00, 0.00, 1449.00);
INSERT INTO public.order_items VALUES (455, 191, 187, 1, 1199.00, 1199.00, 0.00, 1199.00);
INSERT INTO public.order_items VALUES (456, 191, 157, 1, 1199.00, 1199.00, 0.00, 1199.00);
INSERT INTO public.order_items VALUES (457, 192, 297, 1, 1299.00, 1299.00, 0.00, 1299.00);
INSERT INTO public.order_items VALUES (458, 192, 289, 2, 3499.00, 6998.00, 0.00, 6998.00);
INSERT INTO public.order_items VALUES (459, 192, 173, 1, 429.00, 429.00, 0.00, 429.00);
INSERT INTO public.order_items VALUES (460, 192, 284, 2, 2799.00, 5598.00, 0.00, 5598.00);
INSERT INTO public.order_items VALUES (461, 193, 216, 1, 1799.00, 1799.00, 0.00, 1799.00);
INSERT INTO public.order_items VALUES (462, 193, 160, 1, 999.00, 999.00, 0.00, 999.00);
INSERT INTO public.order_items VALUES (463, 193, 303, 1, 249.00, 249.00, 0.00, 249.00);
INSERT INTO public.order_items VALUES (464, 194, 162, 2, 899.00, 1798.00, 0.00, 1798.00);
INSERT INTO public.order_items VALUES (465, 194, 214, 2, 1399.00, 2798.00, 0.00, 2798.00);
INSERT INTO public.order_items VALUES (466, 194, 296, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items VALUES (467, 195, 285, 1, 1599.00, 1599.00, 0.00, 1599.00);
INSERT INTO public.order_items VALUES (468, 196, 180, 2, 200.00, 400.00, 0.00, 400.00);
INSERT INTO public.order_items VALUES (469, 196, 246, 2, 219.00, 438.00, 0.00, 438.00);
INSERT INTO public.order_items VALUES (470, 196, 280, 1, 2599.00, 2599.00, 0.00, 2599.00);
INSERT INTO public.order_items VALUES (471, 197, 206, 2, 250.00, 500.00, 0.00, 500.00);
INSERT INTO public.order_items VALUES (472, 197, 305, 2, 1899.00, 3798.00, 0.00, 3798.00);
INSERT INTO public.order_items VALUES (473, 197, 244, 1, 399.00, 399.00, 0.00, 399.00);
INSERT INTO public.order_items VALUES (474, 197, 262, 2, 1999.00, 3998.00, 0.00, 3998.00);
INSERT INTO public.order_items VALUES (475, 198, 177, 1, 650.00, 650.00, 0.00, 650.00);
INSERT INTO public.order_items VALUES (476, 198, 188, 1, 1399.00, 1399.00, 0.00, 1399.00);
INSERT INTO public.order_items VALUES (477, 199, 282, 2, 1499.00, 2998.00, 0.00, 2998.00);
INSERT INTO public.order_items VALUES (478, 200, 297, 2, 1299.00, 2598.00, 0.00, 2598.00);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.orders VALUES (101, 'ORD-2024-001', 26, 15, 'CANCELLED', 7394.00, NULL, 0.00, 0.00, 7394.00, NULL, '2024-02-09 22:02:45.573', '2025-12-31 16:19:17.35', NULL);
INSERT INTO public.orders VALUES (102, 'ORD-2024-002', 32, 14, 'CANCELLED', 4196.00, NULL, 0.00, 0.00, 4196.00, NULL, '2025-05-02 21:28:17.005', '2025-12-31 16:19:17.377', NULL);
INSERT INTO public.orders VALUES (103, 'ORD-2024-003', 20, 15, 'COMPLETED', 4696.00, NULL, 0.00, 0.00, 4696.00, NULL, '2025-11-23 08:12:46.86', '2025-12-31 16:19:17.394', '2025-11-23 08:12:46.86');
INSERT INTO public.orders VALUES (104, 'ORD-2024-004', 27, 14, 'PENDING', 300.00, NULL, 0.00, 0.00, 300.00, NULL, '2025-01-07 22:16:49.314', '2025-12-31 16:19:17.42', NULL);
INSERT INTO public.orders VALUES (105, 'ORD-2024-005', 17, 14, 'COMPLETED', 2179.00, NULL, 0.00, 0.00, 2179.00, NULL, '2025-06-18 13:10:44.035', '2025-12-31 16:19:17.435', '2025-06-18 13:10:44.035');
INSERT INTO public.orders VALUES (106, 'ORD-2024-006', 22, 15, 'COMPLETED', 3225.00, NULL, 0.00, 0.00, 3225.00, NULL, '2024-09-29 14:15:41.981', '2025-12-31 16:19:17.455', '2024-09-29 14:15:41.981');
INSERT INTO public.orders VALUES (107, 'ORD-2024-007', 28, 15, 'COMPLETED', 1500.00, NULL, 0.00, 0.00, 1500.00, NULL, '2024-02-03 19:39:20.823', '2025-12-31 16:19:17.475', '2024-02-03 19:39:20.823');
INSERT INTO public.orders VALUES (108, 'ORD-2024-008', 19, 15, 'COMPLETED', 6096.00, NULL, 0.00, 0.00, 6096.00, NULL, '2024-09-30 17:20:50.396', '2025-12-31 16:19:17.497', '2024-09-30 17:20:50.396');
INSERT INTO public.orders VALUES (109, 'ORD-2024-009', 31, 15, 'COMPLETED', 4295.00, NULL, 0.00, 0.00, 4295.00, NULL, '2025-10-26 04:57:08.787', '2025-12-31 16:19:17.513', '2025-10-26 04:57:08.787');
INSERT INTO public.orders VALUES (110, 'ORD-2024-010', 17, 14, 'CANCELLED', 1897.00, NULL, 0.00, 0.00, 1897.00, NULL, '2025-02-26 17:55:32.048', '2025-12-31 16:19:17.533', NULL);
INSERT INTO public.orders VALUES (111, 'ORD-2024-011', 20, 16, 'PROCESSING', 5997.00, NULL, 0.00, 0.00, 5997.00, NULL, '2025-07-08 10:04:12.539', '2025-12-31 16:19:17.545', NULL);
INSERT INTO public.orders VALUES (112, 'ORD-2024-012', 18, 15, 'CANCELLED', 7275.00, NULL, 0.00, 0.00, 7275.00, NULL, '2024-03-24 23:26:17.423', '2025-12-31 16:19:17.56', NULL);
INSERT INTO public.orders VALUES (113, 'ORD-2024-013', 15, 16, 'COMPLETED', 7548.00, NULL, 0.00, 0.00, 7548.00, NULL, '2025-10-14 19:40:47.285', '2025-12-31 16:19:17.573', '2025-10-14 19:40:47.285');
INSERT INTO public.orders VALUES (114, 'ORD-2024-014', 24, 14, 'COMPLETED', 1799.00, NULL, 0.00, 0.00, 1799.00, NULL, '2025-07-12 06:51:55.655', '2025-12-31 16:19:17.59', '2025-07-12 06:51:55.655');
INSERT INTO public.orders VALUES (115, 'ORD-2024-015', 31, 15, 'COMPLETED', 5196.00, NULL, 0.00, 0.00, 5196.00, NULL, '2024-11-26 20:30:45.193', '2025-12-31 16:19:17.605', '2024-11-26 20:30:45.193');
INSERT INTO public.orders VALUES (116, 'ORD-2024-016', 15, 14, 'COMPLETED', 4645.00, NULL, 0.00, 0.00, 4645.00, NULL, '2024-06-06 07:50:49.33', '2025-12-31 16:19:17.621', '2024-06-06 07:50:49.33');
INSERT INTO public.orders VALUES (117, 'ORD-2024-017', 32, 14, 'PENDING', 6294.00, NULL, 0.00, 0.00, 6294.00, NULL, '2025-08-28 13:19:38.107', '2025-12-31 16:19:17.636', NULL);
INSERT INTO public.orders VALUES (118, 'ORD-2024-018', 26, 16, 'PENDING', 4814.00, NULL, 0.00, 0.00, 4814.00, NULL, '2024-11-27 03:09:37.766', '2025-12-31 16:19:17.647', NULL);
INSERT INTO public.orders VALUES (119, 'ORD-2024-019', 25, 16, 'PROCESSING', 3296.00, NULL, 0.00, 0.00, 3296.00, NULL, '2024-03-29 07:20:32.69', '2025-12-31 16:19:17.659', NULL);
INSERT INTO public.orders VALUES (120, 'ORD-2024-020', 24, 16, 'COMPLETED', 6395.00, NULL, 0.00, 0.00, 6395.00, NULL, '2025-02-12 14:17:01.211', '2025-12-31 16:19:17.673', '2025-02-12 14:17:01.211');
INSERT INTO public.orders VALUES (121, 'ORD-2024-021', 32, 15, 'COMPLETED', 4796.00, NULL, 0.00, 0.00, 4796.00, NULL, '2025-11-01 06:17:35.176', '2025-12-31 16:19:17.688', '2025-11-01 06:17:35.176');
INSERT INTO public.orders VALUES (122, 'ORD-2024-022', 32, 14, 'PROCESSING', 4796.00, NULL, 0.00, 0.00, 4796.00, NULL, '2025-10-13 13:16:48.572', '2025-12-31 16:19:17.704', NULL);
INSERT INTO public.orders VALUES (123, 'ORD-2024-023', 21, 14, 'COMPLETED', 3499.00, NULL, 0.00, 0.00, 3499.00, NULL, '2025-11-07 17:34:24.132', '2025-12-31 16:19:17.714', '2025-11-07 17:34:24.132');
INSERT INTO public.orders VALUES (124, 'ORD-2024-024', 25, 15, 'PROCESSING', 998.00, NULL, 0.00, 0.00, 998.00, NULL, '2025-06-09 08:59:38.267', '2025-12-31 16:19:17.729', NULL);
INSERT INTO public.orders VALUES (125, 'ORD-2024-025', 15, 15, 'CANCELLED', 11195.00, NULL, 0.00, 0.00, 11195.00, NULL, '2025-04-29 21:42:05.887', '2025-12-31 16:19:17.74', NULL);
INSERT INTO public.orders VALUES (126, 'ORD-2024-026', 16, 14, 'COMPLETED', 2698.00, NULL, 0.00, 0.00, 2698.00, NULL, '2024-06-07 10:53:51.917', '2025-12-31 16:19:17.752', '2024-06-07 10:53:51.917');
INSERT INTO public.orders VALUES (127, 'ORD-2024-027', 17, 16, 'COMPLETED', 1099.00, NULL, 0.00, 0.00, 1099.00, NULL, '2025-03-19 02:39:51.964', '2025-12-31 16:19:17.768', '2025-03-19 02:39:51.964');
INSERT INTO public.orders VALUES (128, 'ORD-2024-028', 26, 16, 'PROCESSING', 4445.00, NULL, 0.00, 0.00, 4445.00, NULL, '2024-09-09 06:37:38.647', '2025-12-31 16:19:17.784', NULL);
INSERT INTO public.orders VALUES (129, 'ORD-2024-029', 35, 15, 'COMPLETED', 3198.00, NULL, 0.00, 0.00, 3198.00, NULL, '2024-07-09 17:49:46.42', '2025-12-31 16:19:17.796', '2024-07-09 17:49:46.42');
INSERT INTO public.orders VALUES (130, 'ORD-2024-030', 16, 15, 'COMPLETED', 5097.00, NULL, 0.00, 0.00, 5097.00, NULL, '2025-06-26 00:24:51.79', '2025-12-31 16:19:17.815', '2025-06-26 00:24:51.79');
INSERT INTO public.orders VALUES (131, 'ORD-2024-031', 17, 16, 'COMPLETED', 1699.00, NULL, 0.00, 0.00, 1699.00, NULL, '2024-09-20 20:18:11.206', '2025-12-31 16:19:17.832', '2024-09-20 20:18:11.206');
INSERT INTO public.orders VALUES (132, 'ORD-2024-032', 17, 16, 'PENDING', 4447.00, NULL, 0.00, 0.00, 4447.00, NULL, '2024-01-23 07:25:25.202', '2025-12-31 16:19:17.849', NULL);
INSERT INTO public.orders VALUES (133, 'ORD-2024-033', 28, 15, 'COMPLETED', 1000.00, NULL, 0.00, 0.00, 1000.00, NULL, '2025-10-13 23:11:14.349', '2025-12-31 16:19:17.86', '2025-10-13 23:11:14.349');
INSERT INTO public.orders VALUES (134, 'ORD-2024-034', 24, 14, 'COMPLETED', 6946.00, NULL, 0.00, 0.00, 6946.00, NULL, '2025-01-10 17:47:42.797', '2025-12-31 16:19:17.878', '2025-01-10 17:47:42.797');
INSERT INTO public.orders VALUES (135, 'ORD-2024-035', 14, 14, 'COMPLETED', 6196.00, NULL, 0.00, 0.00, 6196.00, NULL, '2025-06-10 05:09:13.423', '2025-12-31 16:19:17.895', '2025-06-10 05:09:13.423');
INSERT INTO public.orders VALUES (136, 'ORD-2024-036', 35, 15, 'COMPLETED', 5584.00, NULL, 0.00, 0.00, 5584.00, NULL, '2025-04-09 15:12:33.321', '2025-12-31 16:19:17.911', '2025-04-09 15:12:33.321');
INSERT INTO public.orders VALUES (137, 'ORD-2024-037', 14, 16, 'PROCESSING', 4895.00, NULL, 0.00, 0.00, 4895.00, NULL, '2025-04-18 18:32:09.222', '2025-12-31 16:19:17.932', NULL);
INSERT INTO public.orders VALUES (138, 'ORD-2024-038', 27, 16, 'COMPLETED', 6046.00, NULL, 0.00, 0.00, 6046.00, NULL, '2024-12-20 09:21:48.562', '2025-12-31 16:19:17.945', '2024-12-20 09:21:48.562');
INSERT INTO public.orders VALUES (139, 'ORD-2024-039', 32, 14, 'CANCELLED', 3596.00, NULL, 0.00, 0.00, 3596.00, NULL, '2025-11-17 00:03:16.432', '2025-12-31 16:19:17.965', NULL);
INSERT INTO public.orders VALUES (140, 'ORD-2024-040', 15, 15, 'COMPLETED', 798.00, NULL, 0.00, 0.00, 798.00, NULL, '2025-07-21 11:23:26.669', '2025-12-31 16:19:17.978', '2025-07-21 11:23:26.669');
INSERT INTO public.orders VALUES (141, 'ORD-2024-041', 35, 15, 'COMPLETED', 2598.00, NULL, 0.00, 0.00, 2598.00, NULL, '2024-11-22 22:07:46.15', '2025-12-31 16:19:17.995', '2024-11-22 22:07:46.15');
INSERT INTO public.orders VALUES (142, 'ORD-2024-042', 22, 16, 'COMPLETED', 3496.00, NULL, 0.00, 0.00, 3496.00, NULL, '2024-11-17 23:01:41.959', '2025-12-31 16:19:18.017', '2024-11-17 23:01:41.959');
INSERT INTO public.orders VALUES (143, 'ORD-2024-043', 28, 15, 'COMPLETED', 2197.00, NULL, 0.00, 0.00, 2197.00, NULL, '2024-07-14 11:59:25.577', '2025-12-31 16:19:18.037', '2024-07-14 11:59:25.577');
INSERT INTO public.orders VALUES (144, 'ORD-2024-044', 16, 14, 'PROCESSING', 189.00, NULL, 0.00, 0.00, 189.00, NULL, '2025-02-02 15:18:24.285', '2025-12-31 16:19:18.057', NULL);
INSERT INTO public.orders VALUES (145, 'ORD-2024-045', 16, 15, 'COMPLETED', 5796.00, NULL, 0.00, 0.00, 5796.00, NULL, '2024-02-09 11:01:51.423', '2025-12-31 16:19:18.071', '2024-02-09 11:01:51.423');
INSERT INTO public.orders VALUES (146, 'ORD-2024-046', 26, 16, 'COMPLETED', 3577.00, NULL, 0.00, 0.00, 3577.00, NULL, '2024-09-26 13:03:17.116', '2025-12-31 16:19:18.091', '2024-09-26 13:03:17.116');
INSERT INTO public.orders VALUES (147, 'ORD-2024-047', 28, 15, 'CANCELLED', 6495.00, NULL, 0.00, 0.00, 6495.00, NULL, '2024-03-02 10:10:35.487', '2025-12-31 16:19:18.113', NULL);
INSERT INTO public.orders VALUES (148, 'ORD-2024-048', 22, 15, 'PROCESSING', 1897.00, NULL, 0.00, 0.00, 1897.00, NULL, '2024-10-13 13:42:07.608', '2025-12-31 16:19:18.132', NULL);
INSERT INTO public.orders VALUES (149, 'ORD-2024-049', 20, 16, 'PROCESSING', 3798.00, NULL, 0.00, 0.00, 3798.00, NULL, '2025-07-16 11:06:27.833', '2025-12-31 16:19:18.15', NULL);
INSERT INTO public.orders VALUES (150, 'ORD-2024-050', 33, 14, 'CANCELLED', 2998.00, NULL, 0.00, 0.00, 2998.00, NULL, '2025-04-20 11:33:40.632', '2025-12-31 16:19:18.169', NULL);
INSERT INTO public.orders VALUES (151, 'ORD-2024-051', 22, 15, 'PENDING', 1099.00, NULL, 0.00, 0.00, 1099.00, NULL, '2025-04-22 10:44:05.853', '2025-12-31 16:19:18.185', NULL);
INSERT INTO public.orders VALUES (152, 'ORD-2024-052', 19, 16, 'COMPLETED', 189.00, NULL, 0.00, 0.00, 189.00, NULL, '2025-11-22 11:08:44.258', '2025-12-31 16:19:18.2', '2025-11-22 11:08:44.258');
INSERT INTO public.orders VALUES (153, 'ORD-2024-053', 15, 16, 'COMPLETED', 739.00, NULL, 0.00, 0.00, 739.00, NULL, '2024-05-09 07:44:43.737', '2025-12-31 16:19:18.221', '2024-05-09 07:44:43.737');
INSERT INTO public.orders VALUES (154, 'ORD-2024-054', 26, 16, 'CANCELLED', 4396.00, NULL, 0.00, 0.00, 4396.00, NULL, '2024-07-04 10:56:56.469', '2025-12-31 16:19:18.254', NULL);
INSERT INTO public.orders VALUES (155, 'ORD-2024-055', 33, 16, 'PENDING', 1499.00, NULL, 0.00, 0.00, 1499.00, NULL, '2025-08-14 10:18:06.596', '2025-12-31 16:19:18.273', NULL);
INSERT INTO public.orders VALUES (156, 'ORD-2024-056', 34, 15, 'COMPLETED', 4197.00, NULL, 0.00, 0.00, 4197.00, NULL, '2024-08-09 21:52:52.609', '2025-12-31 16:19:18.291', '2024-08-09 21:52:52.609');
INSERT INTO public.orders VALUES (157, 'ORD-2024-057', 17, 15, 'PROCESSING', 1099.00, NULL, 0.00, 0.00, 1099.00, NULL, '2025-07-15 20:29:08.69', '2025-12-31 16:19:18.321', NULL);
INSERT INTO public.orders VALUES (158, 'ORD-2024-058', 17, 15, 'PROCESSING', 3847.00, NULL, 0.00, 0.00, 3847.00, NULL, '2024-12-29 11:09:32.72', '2025-12-31 16:19:18.345', NULL);
INSERT INTO public.orders VALUES (159, 'ORD-2024-059', 31, 15, 'COMPLETED', 1798.00, NULL, 0.00, 0.00, 1798.00, NULL, '2024-12-10 08:25:49.814', '2025-12-31 16:19:18.385', '2024-12-10 08:25:49.814');
INSERT INTO public.orders VALUES (160, 'ORD-2024-060', 26, 16, 'COMPLETED', 4995.00, NULL, 0.00, 0.00, 4995.00, NULL, '2024-08-14 03:32:43.473', '2025-12-31 16:19:18.426', '2024-08-14 03:32:43.473');
INSERT INTO public.orders VALUES (161, 'ORD-2024-061', 18, 15, 'COMPLETED', 4697.00, NULL, 0.00, 0.00, 4697.00, NULL, '2025-05-16 00:37:30.696', '2025-12-31 16:19:18.454', '2025-05-16 00:37:30.696');
INSERT INTO public.orders VALUES (162, 'ORD-2024-062', 20, 16, 'COMPLETED', 5198.00, NULL, 0.00, 0.00, 5198.00, NULL, '2025-02-18 05:31:40.758', '2025-12-31 16:19:18.479', '2025-02-18 05:31:40.758');
INSERT INTO public.orders VALUES (163, 'ORD-2024-063', 21, 15, 'CANCELLED', 649.00, NULL, 0.00, 0.00, 649.00, NULL, '2024-01-07 06:02:01.326', '2025-12-31 16:19:18.502', NULL);
INSERT INTO public.orders VALUES (164, 'ORD-2024-064', 33, 16, 'COMPLETED', 449.00, NULL, 0.00, 0.00, 449.00, NULL, '2024-09-09 09:20:55.778', '2025-12-31 16:19:18.516', '2024-09-09 09:20:55.778');
INSERT INTO public.orders VALUES (165, 'ORD-2024-065', 26, 14, 'COMPLETED', 550.00, NULL, 0.00, 0.00, 550.00, NULL, '2024-12-06 03:16:00.86', '2025-12-31 16:19:18.533', '2024-12-06 03:16:00.86');
INSERT INTO public.orders VALUES (166, 'ORD-2024-066', 33, 14, 'PROCESSING', 2797.00, NULL, 0.00, 0.00, 2797.00, NULL, '2024-01-09 14:58:38.094', '2025-12-31 16:19:18.55', NULL);
INSERT INTO public.orders VALUES (167, 'ORD-2024-067', 26, 14, 'PENDING', 10193.00, NULL, 0.00, 0.00, 10193.00, NULL, '2025-01-04 19:04:12.03', '2025-12-31 16:19:18.562', NULL);
INSERT INTO public.orders VALUES (168, 'ORD-2024-068', 22, 16, 'COMPLETED', 5134.00, NULL, 0.00, 0.00, 5134.00, NULL, '2025-04-01 19:41:33.048', '2025-12-31 16:19:18.575', '2025-04-01 19:41:33.048');
INSERT INTO public.orders VALUES (169, 'ORD-2024-069', 33, 15, 'COMPLETED', 699.00, NULL, 0.00, 0.00, 699.00, NULL, '2025-02-24 20:29:02.167', '2025-12-31 16:19:18.596', '2025-02-24 20:29:02.167');
INSERT INTO public.orders VALUES (170, 'ORD-2024-070', 23, 15, 'CANCELLED', 2077.00, NULL, 0.00, 0.00, 2077.00, NULL, '2024-05-24 21:55:36.763', '2025-12-31 16:19:18.612', NULL);
INSERT INTO public.orders VALUES (171, 'ORD-2024-071', 33, 14, 'COMPLETED', 500.00, NULL, 0.00, 0.00, 500.00, NULL, '2025-01-30 20:04:49.806', '2025-12-31 16:19:18.628', '2025-01-30 20:04:49.806');
INSERT INTO public.orders VALUES (172, 'ORD-2024-072', 22, 16, 'CANCELLED', 2326.00, NULL, 0.00, 0.00, 2326.00, NULL, '2024-11-08 03:34:38.723', '2025-12-31 16:19:18.646', NULL);
INSERT INTO public.orders VALUES (173, 'ORD-2024-073', 18, 16, 'PENDING', 1198.00, NULL, 0.00, 0.00, 1198.00, NULL, '2025-10-23 19:11:51.537', '2025-12-31 16:19:18.661', NULL);
INSERT INTO public.orders VALUES (174, 'ORD-2024-074', 35, 14, 'COMPLETED', 1849.00, NULL, 0.00, 0.00, 1849.00, NULL, '2024-10-01 03:05:48.048', '2025-12-31 16:19:18.674', '2024-10-01 03:05:48.048');
INSERT INTO public.orders VALUES (175, 'ORD-2024-075', 27, 14, 'COMPLETED', 3247.00, NULL, 0.00, 0.00, 3247.00, NULL, '2024-01-16 06:59:57.484', '2025-12-31 16:19:18.69', '2024-01-16 06:59:57.484');
INSERT INTO public.orders VALUES (176, 'ORD-2024-076', 34, 15, 'COMPLETED', 4643.00, NULL, 0.00, 0.00, 4643.00, NULL, '2024-09-08 16:44:17.423', '2025-12-31 16:19:18.708', '2024-09-08 16:44:17.423');
INSERT INTO public.orders VALUES (177, 'ORD-2024-077', 21, 14, 'COMPLETED', 6126.00, NULL, 0.00, 0.00, 6126.00, NULL, '2024-06-26 14:23:29.946', '2025-12-31 16:19:18.73', '2024-06-26 14:23:29.946');
INSERT INTO public.orders VALUES (178, 'ORD-2024-078', 29, 14, 'COMPLETED', 599.00, NULL, 0.00, 0.00, 599.00, NULL, '2025-10-09 20:12:18.006', '2025-12-31 16:19:18.748', '2025-10-09 20:12:18.006');
INSERT INTO public.orders VALUES (179, 'ORD-2024-079', 23, 15, 'PENDING', 5995.00, NULL, 0.00, 0.00, 5995.00, NULL, '2025-11-14 17:35:42.43', '2025-12-31 16:19:18.763', NULL);
INSERT INTO public.orders VALUES (180, 'ORD-2024-080', 30, 16, 'COMPLETED', 2825.00, NULL, 0.00, 0.00, 2825.00, NULL, '2024-12-03 08:35:15.091', '2025-12-31 16:19:18.776', '2024-12-03 08:35:15.091');
INSERT INTO public.orders VALUES (181, 'ORD-2024-081', 22, 16, 'PROCESSING', 249.00, NULL, 0.00, 0.00, 249.00, NULL, '2024-04-07 12:53:50.197', '2025-12-31 16:19:18.798', NULL);
INSERT INTO public.orders VALUES (182, 'ORD-2024-082', 15, 15, 'COMPLETED', 3395.00, NULL, 0.00, 0.00, 3395.00, NULL, '2025-07-30 13:12:18.642', '2025-12-31 16:19:18.81', '2025-07-30 13:12:18.642');
INSERT INTO public.orders VALUES (183, 'ORD-2024-083', 27, 14, 'COMPLETED', 2196.00, NULL, 0.00, 0.00, 2196.00, NULL, '2024-12-07 12:54:00.415', '2025-12-31 16:19:18.83', '2024-12-07 12:54:00.415');
INSERT INTO public.orders VALUES (184, 'ORD-2024-084', 33, 14, 'COMPLETED', 2898.00, NULL, 0.00, 0.00, 2898.00, NULL, '2024-07-28 05:29:51.097', '2025-12-31 16:19:18.848', '2024-07-28 05:29:51.097');
INSERT INTO public.orders VALUES (185, 'ORD-2024-085', 22, 16, 'COMPLETED', 6296.00, NULL, 0.00, 0.00, 6296.00, NULL, '2024-06-19 05:01:11.583', '2025-12-31 16:19:18.866', '2024-06-19 05:01:11.583');
INSERT INTO public.orders VALUES (186, 'ORD-2024-086', 18, 15, 'COMPLETED', 1598.00, NULL, 0.00, 0.00, 1598.00, NULL, '2025-01-25 00:29:56.005', '2025-12-31 16:19:18.886', '2025-01-25 00:29:56.005');
INSERT INTO public.orders VALUES (187, 'ORD-2024-087', 14, 16, 'COMPLETED', 999.00, NULL, 0.00, 0.00, 999.00, NULL, '2024-02-27 19:47:57.191', '2025-12-31 16:19:18.903', '2024-02-27 19:47:57.191');
INSERT INTO public.orders VALUES (188, 'ORD-2024-088', 32, 15, 'PROCESSING', 899.00, NULL, 0.00, 0.00, 899.00, NULL, '2025-10-18 15:40:35.461', '2025-12-31 16:19:18.921', NULL);
INSERT INTO public.orders VALUES (189, 'ORD-2024-089', 34, 15, 'COMPLETED', 6746.00, NULL, 0.00, 0.00, 6746.00, NULL, '2025-10-10 13:55:45.347', '2025-12-31 16:19:18.932', '2025-10-10 13:55:45.347');
INSERT INTO public.orders VALUES (190, 'ORD-2024-090', 31, 15, 'CANCELLED', 4525.00, NULL, 0.00, 0.00, 4525.00, NULL, '2024-08-16 05:29:58.225', '2025-12-31 16:19:18.95', NULL);
INSERT INTO public.orders VALUES (191, 'ORD-2024-091', 24, 15, 'COMPLETED', 4645.00, NULL, 0.00, 0.00, 4645.00, NULL, '2025-10-14 12:06:06.199', '2025-12-31 16:19:18.967', '2025-10-14 12:06:06.199');
INSERT INTO public.orders VALUES (192, 'ORD-2024-092', 35, 15, 'CANCELLED', 14324.00, NULL, 0.00, 0.00, 14324.00, NULL, '2024-11-22 15:04:34.504', '2025-12-31 16:19:18.989', NULL);
INSERT INTO public.orders VALUES (193, 'ORD-2024-093', 21, 16, 'CANCELLED', 3047.00, NULL, 0.00, 0.00, 3047.00, NULL, '2025-12-14 11:24:32.241', '2025-12-31 16:19:19.003', NULL);
INSERT INTO public.orders VALUES (194, 'ORD-2024-094', 18, 16, 'COMPLETED', 7594.00, NULL, 0.00, 0.00, 7594.00, NULL, '2024-04-26 09:24:10.065', '2025-12-31 16:19:19.015', '2024-04-26 09:24:10.065');
INSERT INTO public.orders VALUES (195, 'ORD-2024-095', 30, 15, 'PENDING', 1599.00, NULL, 0.00, 0.00, 1599.00, NULL, '2024-08-18 05:57:04.993', '2025-12-31 16:19:19.032', NULL);
INSERT INTO public.orders VALUES (196, 'ORD-2024-096', 29, 15, 'COMPLETED', 3437.00, NULL, 0.00, 0.00, 3437.00, NULL, '2024-05-06 18:21:38.111', '2025-12-31 16:19:19.043', '2024-05-06 18:21:38.111');
INSERT INTO public.orders VALUES (197, 'ORD-2024-097', 21, 14, 'PROCESSING', 8695.00, NULL, 0.00, 0.00, 8695.00, NULL, '2025-06-06 01:42:08.184', '2025-12-31 16:19:19.061', NULL);
INSERT INTO public.orders VALUES (198, 'ORD-2024-098', 33, 15, 'PENDING', 2049.00, NULL, 0.00, 0.00, 2049.00, NULL, '2024-07-19 00:58:56.155', '2025-12-31 16:19:19.074', NULL);
INSERT INTO public.orders VALUES (199, 'ORD-2024-099', 32, 14, 'COMPLETED', 2998.00, NULL, 0.00, 0.00, 2998.00, NULL, '2024-04-24 05:52:58.18', '2025-12-31 16:19:19.087', '2024-04-24 05:52:58.18');
INSERT INTO public.orders VALUES (200, 'ORD-2024-100', 34, 14, 'COMPLETED', 2598.00, NULL, 0.00, 0.00, 2598.00, NULL, '2025-08-06 01:13:53.938', '2025-12-31 16:19:19.103', '2025-08-06 01:13:53.938');


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.product_images VALUES (1, 157, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', 0, true, '2025-12-31 16:19:14.879');
INSERT INTO public.product_images VALUES (2, 157, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 1, false, '2025-12-31 16:19:14.879');
INSERT INTO public.product_images VALUES (3, 157, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 2, false, '2025-12-31 16:19:14.879');
INSERT INTO public.product_images VALUES (4, 158, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_5.png', 0, true, '2025-12-31 16:19:14.923');
INSERT INTO public.product_images VALUES (5, 158, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 1, false, '2025-12-31 16:19:14.923');
INSERT INTO public.product_images VALUES (6, 158, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 2, false, '2025-12-31 16:19:14.923');
INSERT INTO public.product_images VALUES (7, 159, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_2__5_2_1_1_1_1_2_1_1.jpg', 0, true, '2025-12-31 16:19:14.937');
INSERT INTO public.product_images VALUES (8, 159, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 1, false, '2025-12-31 16:19:14.937');
INSERT INTO public.product_images VALUES (9, 159, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 2, false, '2025-12-31 16:19:14.937');
INSERT INTO public.product_images VALUES (10, 160, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-plus_1_.png', 0, true, '2025-12-31 16:19:14.948');
INSERT INTO public.product_images VALUES (11, 160, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 1, false, '2025-12-31 16:19:14.948');
INSERT INTO public.product_images VALUES (12, 160, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 2, false, '2025-12-31 16:19:14.948');
INSERT INTO public.product_images VALUES (13, 161, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_2__5_2_1_1_1_1_2_1_1.jpg', 0, true, '2025-12-31 16:19:14.963');
INSERT INTO public.product_images VALUES (14, 161, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768368578332_2.jpg', 1, false, '2025-12-31 16:19:14.963');
INSERT INTO public.product_images VALUES (15, 161, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2024_4_16_638488768365442895_6.jpg', 2, false, '2025-12-31 16:19:14.963');
INSERT INTO public.product_images VALUES (16, 162, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2023_9_13_638302007249847040_iPhone_15_Plus_Blue_Pure_Back_iPhone_15_Plus_Blue_Pure_Front_2up_Screen__USEN.jpg', 0, true, '2025-12-31 16:19:14.978');
INSERT INTO public.product_images VALUES (17, 162, 'https://cdn.tgdd.vn/Products/Images/42/303891/iphone-15-plus-1-750x500.jpg', 1, false, '2025-12-31 16:19:14.978');
INSERT INTO public.product_images VALUES (18, 162, 'https://cdn.tgdd.vn/Products/Images/42/303891/s16/iphone-15-plus-vang-1-650x650.jpg', 2, false, '2025-12-31 16:19:14.978');
INSERT INTO public.product_images VALUES (19, 163, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/dien-thoai-iphone-15-plus-256gb-3.jpg', 0, true, '2025-12-31 16:19:14.996');
INSERT INTO public.product_images VALUES (20, 163, 'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-130923-014953.jpg', 1, false, '2025-12-31 16:19:14.996');
INSERT INTO public.product_images VALUES (21, 163, 'https://cdn.tgdd.vn/Products/Images/42/303823/iphone-15-plus-256gb-xanh-thumb-600x600.jpg', 2, false, '2025-12-31 16:19:14.996');
INSERT INTO public.product_images VALUES (22, 164, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/n/vn_iphone_15_yellow_pdp_image_position-1a_yellow_color_1_4_1_1.jpg', 0, true, '2025-12-31 16:19:15.012');
INSERT INTO public.product_images VALUES (23, 164, 'https://clickbuy.com.vn/uploads/pro/2_51654.jpg', 1, false, '2025-12-31 16:19:15.012');
INSERT INTO public.product_images VALUES (24, 164, 'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-1-3-750x500.jpg', 2, false, '2025-12-31 16:19:15.012');
INSERT INTO public.product_images VALUES (25, 165, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Phone/Apple/iphone_15/dien-thoai-iphone-15-256gb-8.jpg', 0, true, '2025-12-31 16:19:15.028');
INSERT INTO public.product_images VALUES (26, 165, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/n/vn_iphone_15_pink_pdp_image_position-9_accessory_1.jpg', 1, false, '2025-12-31 16:19:15.028');
INSERT INTO public.product_images VALUES (27, 165, 'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-1-3-750x500.jpg', 2, false, '2025-12-31 16:19:15.028');
INSERT INTO public.product_images VALUES (28, 166, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/_/t_m_18_1_3_2.png', 0, true, '2025-12-31 16:19:15.044');
INSERT INTO public.product_images VALUES (29, 166, 'https://bachlongstore.vn/vnt_upload/product/11_2023/5646.jpg', 1, false, '2025-12-31 16:19:15.044');
INSERT INTO public.product_images VALUES (30, 166, 'https://thangtaostore.com/watermark/product/540x540x2/upload/product/14prm-nen-6822.png', 2, false, '2025-12-31 16:19:15.044');
INSERT INTO public.product_images VALUES (31, 167, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/_/v_ng_12_1_2_1.png', 0, true, '2025-12-31 16:19:15.06');
INSERT INTO public.product_images VALUES (32, 167, 'https://bachlongstore.vn/vnt_upload/product/11_2023/5646.jpg', 1, false, '2025-12-31 16:19:15.06');
INSERT INTO public.product_images VALUES (33, 167, 'https://thangtaostore.com/watermark/product/540x540x2/upload/product/14prm-nen-6822.png', 2, false, '2025-12-31 16:19:15.06');
INSERT INTO public.product_images VALUES (34, 168, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/h/photo_2022-09-28_21-58-51_4_1_2_2.jpg', 0, true, '2025-12-31 16:19:15.079');
INSERT INTO public.product_images VALUES (35, 168, 'https://cdn2.fptshop.com.vn/unsafe/564x0/filters:quality(80)/Uploads/images/2015/Tin-Tuc/02/iPhone-14-Plus.jpg', 1, false, '2025-12-31 16:19:15.079');
INSERT INTO public.product_images VALUES (36, 168, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkM7pjbtU7CkTq6yJNNpS_VBvfYvEjRwH_JA&s', 2, false, '2025-12-31 16:19:15.079');
INSERT INTO public.product_images VALUES (37, 169, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/h/photo_2022-09-28_21-58-56_11_1.jpg', 0, true, '2025-12-31 16:19:15.095');
INSERT INTO public.product_images VALUES (38, 169, 'https://www.didongmy.com/vnt_upload/product/09_2022/thumbs/(600x600)_14xam_didongmy_600x600.png', 1, false, '2025-12-31 16:19:15.095');
INSERT INTO public.product_images VALUES (39, 169, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkM7pjbtU7CkTq6yJNNpS_VBvfYvEjRwH_JA&s', 2, false, '2025-12-31 16:19:15.095');
INSERT INTO public.product_images VALUES (40, 170, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-13_2_2.jpg', 0, true, '2025-12-31 16:19:15.112');
INSERT INTO public.product_images VALUES (41, 170, 'https://mac24h.vn/images/detailed/92/iPhone13-2021.png', 1, false, '2025-12-31 16:19:15.112');
INSERT INTO public.product_images VALUES (42, 170, 'https://trangthienlong.com.vn/wp-content/uploads/2024/11/iphone-13-thuong-vs-iphone-13-mini-128gb-256gb-512gb.jpg', 2, false, '2025-12-31 16:19:15.112');
INSERT INTO public.product_images VALUES (43, 171, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/4/14_1_9_2_6.jpg', 0, true, '2025-12-31 16:19:15.128');
INSERT INTO public.product_images VALUES (44, 171, 'https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111872_iphone13-mini-colors-480.png', 1, false, '2025-12-31 16:19:15.128');
INSERT INTO public.product_images VALUES (45, 171, 'https://cdn.tgdd.vn/Products/Images/42/236780/Kit/iphone-13-mini-n.jpg', 2, false, '2025-12-31 16:19:15.128');
INSERT INTO public.product_images VALUES (46, 172, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12.png', 0, true, '2025-12-31 16:19:15.143');
INSERT INTO public.product_images VALUES (47, 172, 'https://trangthienlong.com.vn/wp-content/uploads/2024/11/iphone-12-thuong-vs-iphone-12-mini-64gb-128gb-256gb.jpg', 1, false, '2025-12-31 16:19:15.143');
INSERT INTO public.product_images VALUES (48, 172, 'https://bvtmobile.com/uploads/source/iphone12-1/iphone-12-purple.jpg', 2, false, '2025-12-31 16:19:15.143');
INSERT INTO public.product_images VALUES (49, 173, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_359_1.png', 0, true, '2025-12-31 16:19:15.159');
INSERT INTO public.product_images VALUES (50, 173, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8NgCLku1R6mXVtCPnfcJ69eCVlKUTDw2F9A&s', 1, false, '2025-12-31 16:19:15.159');
INSERT INTO public.product_images VALUES (51, 173, 'https://cdn.tgdd.vn/Files/2022/01/18/1411437/265266695_455337209385670_598702_1280x1596-800-resize.jpg', 2, false, '2025-12-31 16:19:15.159');
INSERT INTO public.product_images VALUES (52, 174, 'https://cdn2.fptshop.com.vn/unsafe/828x0/filters:format(webp):quality(75)/2022_4_15_637856361035158510_iPhone%20SE%20(8).jpg', 0, true, '2025-12-31 16:19:15.173');
INSERT INTO public.product_images VALUES (53, 174, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8NgCLku1R6mXVtCPnfcJ69eCVlKUTDw2F9A&s', 1, false, '2025-12-31 16:19:15.173');
INSERT INTO public.product_images VALUES (54, 174, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG4irNnFC0x8E0XZWuOjNEhbuP4f3gEKF75g&s', 2, false, '2025-12-31 16:19:15.173');
INSERT INTO public.product_images VALUES (55, 175, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-11.png', 0, true, '2025-12-31 16:19:15.192');
INSERT INTO public.product_images VALUES (56, 175, 'https://product.hstatic.net/200000768357/product/_thuong__-_color_321d25895d074fcb834639ed7bd57c89.png', 1, false, '2025-12-31 16:19:15.192');
INSERT INTO public.product_images VALUES (57, 175, 'https://cdn.hstatic.net/products/1000359786/dsc04242_b7d12b5a18804611994a2973ddcc37da_master.jpg', 2, false, '2025-12-31 16:19:15.192');
INSERT INTO public.product_images VALUES (58, 176, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/d/o/download_4_2_2.png', 0, true, '2025-12-31 16:19:15.206');
INSERT INTO public.product_images VALUES (59, 176, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTORePfP_KQXTOlzpv1KwOIkGftpyXwe-kfw&s', 1, false, '2025-12-31 16:19:15.206');
INSERT INTO public.product_images VALUES (60, 176, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfGa9_vOfQFnIp4khLHO_CUX7J6kqOJQ3N_Q&s', 2, false, '2025-12-31 16:19:15.206');
INSERT INTO public.product_images VALUES (61, 177, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/d/o/download_2__1_27.png', 0, true, '2025-12-31 16:19:15.224');
INSERT INTO public.product_images VALUES (62, 177, 'https://qkm.vn/wp-content/uploads/2024/07/iphone-12-pro-128gb-256gb-512gb-cu-like-new-9-qkm-1.jpg', 1, false, '2025-12-31 16:19:15.224');
INSERT INTO public.product_images VALUES (63, 177, 'https://images.tokopedia.net/img/cache/700/VqbcmM/2024/3/26/15fe9df0-1b80-491f-8095-df4973d45416.jpg', 2, false, '2025-12-31 16:19:15.224');
INSERT INTO public.product_images VALUES (64, 178, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone_xs_max_512gb_1_1.jpg', 0, true, '2025-12-31 16:19:15.238');
INSERT INTO public.product_images VALUES (65, 178, 'https://bizweb.dktcdn.net/thumb/grande/100/372/421/products/apple-iphone-xs-black-92641fd4-2491-46ce-8443-6ec1a6b50b74.png?v=1741951045827', 1, false, '2025-12-31 16:19:15.238');
INSERT INTO public.product_images VALUES (66, 178, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9LyRziohMSb_26zq7VG6IxCg1Br0-tW-R8g&s', 2, false, '2025-12-31 16:19:15.238');
INSERT INTO public.product_images VALUES (67, 179, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone_xr_64gb_1.png', 0, true, '2025-12-31 16:19:15.252');
INSERT INTO public.product_images VALUES (68, 179, 'https://truonggiang.vn/wp-content/uploads/2022/05/iphone-xr-64gb-cu-1.jpg', 1, false, '2025-12-31 16:19:15.252');
INSERT INTO public.product_images VALUES (69, 179, 'https://cdn.tgdd.vn/Products/Images/42/230406/Kit/iphone-xr-64gb-hop-moi-note-1.jpg', 2, false, '2025-12-31 16:19:15.252');
INSERT INTO public.product_images VALUES (70, 180, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone8-plus-silver-select-2018_6_3.png', 0, true, '2025-12-31 16:19:15.267');
INSERT INTO public.product_images VALUES (71, 180, 'https://truonggiang.vn/wp-content/uploads/2021/02/iphone-8-plus-64gb-2.jpg', 1, false, '2025-12-31 16:19:15.267');
INSERT INTO public.product_images VALUES (72, 180, 'https://24hstore.vn/images/products/2025/05/30/large/iphone-8-plus-64gb-cu-98.jpg', 2, false, '2025-12-31 16:19:15.267');
INSERT INTO public.product_images VALUES (73, 181, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/p/h/photo_2024-10-02_13-59-00_1.jpg', 0, true, '2025-12-31 16:19:15.279');
INSERT INTO public.product_images VALUES (74, 181, 'https://rauvang.com/data/Product/iphone-16-pro-max-all.htm_1726020874.jpg', 1, false, '2025-12-31 16:19:15.279');
INSERT INTO public.product_images VALUES (75, 181, 'https://hdmobi.vn/wp-content/uploads/2024/11/iphone-16-pro-max-400x400.jpg', 2, false, '2025-12-31 16:19:15.279');
INSERT INTO public.product_images VALUES (76, 182, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro_1.png', 0, true, '2025-12-31 16:19:15.292');
INSERT INTO public.product_images VALUES (77, 182, 'https://rauvang.com/data/Product/iphone-16-pro-max-all.htm_1726020874.jpg', 1, false, '2025-12-31 16:19:15.292');
INSERT INTO public.product_images VALUES (78, 182, 'https://hdmobi.vn/wp-content/uploads/2024/11/iphone-16-pro-max-400x400.jpg', 2, false, '2025-12-31 16:19:15.292');
INSERT INTO public.product_images VALUES (79, 183, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-plus-1.png', 0, true, '2025-12-31 16:19:15.304');
INSERT INTO public.product_images VALUES (80, 183, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-plus-6.png', 1, false, '2025-12-31 16:19:15.304');
INSERT INTO public.product_images VALUES (81, 183, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/329138/iphone-16-plus-1-638639830699738117.jpg', 2, false, '2025-12-31 16:19:15.304');
INSERT INTO public.product_images VALUES (82, 184, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-1.png', 0, true, '2025-12-31 16:19:15.322');
INSERT INTO public.product_images VALUES (83, 184, 'https://bvtmobile.com/uploads/source/ip16/3ead4148a56b2b136ab7581af5df98af.jpg', 1, false, '2025-12-31 16:19:15.322');
INSERT INTO public.product_images VALUES (84, 184, 'https://www.didongmy.com/vnt_upload/product/09_2024/thumbs/(600x600)_iphone_16_mau_trang_didongmy_thumb_600x600.jpg', 2, false, '2025-12-31 16:19:15.322');
INSERT INTO public.product_images VALUES (85, 185, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16e-128gb.png', 0, true, '2025-12-31 16:19:15.336');
INSERT INTO public.product_images VALUES (86, 185, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV6a2rHtKofwe4LaZwa9tmLrKhAGQiczbBKQ&s', 1, false, '2025-12-31 16:19:15.336');
INSERT INTO public.product_images VALUES (87, 185, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIR0kuICiJMkpgh7VxokXayX3Jx9WBY5yneg&s', 2, false, '2025-12-31 16:19:15.336');
INSERT INTO public.product_images VALUES (88, 186, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-spacegray-202210-02_3_3_1_1_1_4.jpg', 0, true, '2025-12-31 16:19:15.348');
INSERT INTO public.product_images VALUES (89, 186, 'https://hoangsonstore.com/wp-content/uploads/2023/01/ipad-pro-m2-12-9-inch-2022-wifi-128gb-moi-100-4498-9.jpg', 1, false, '2025-12-31 16:19:15.348');
INSERT INTO public.product_images VALUES (90, 186, 'https://phucanhcdn.com/media/product/49294_wifi_128gbb.jpg', 2, false, '2025-12-31 16:19:15.348');
INSERT INTO public.product_images VALUES (91, 187, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-13-select-202210_3_1.png', 0, true, '2025-12-31 16:19:15.365');
INSERT INTO public.product_images VALUES (92, 187, 'https://cdn.tgdd.vn/Products/Images/522/295468/Slider/ipad-pro-m2-12.9-inch-wifi-cellular-256gb638030923425442302.jpg', 1, false, '2025-12-31 16:19:15.365');
INSERT INTO public.product_images VALUES (93, 187, 'https://product.hstatic.net/200000525189/product/ipad_pro_xam_1f32e1ae3df44c35b5b3b65cbbae9c94_1024x1024.png', 2, false, '2025-12-31 16:19:15.365');
INSERT INTO public.product_images VALUES (94, 188, 'https://cdn.tgdd.vn/Products/Images/522/295464/ipad-pro-m2-12.5-wifi-xam-thumb-600x600.jpg', 0, true, '2025-12-31 16:19:15.378');
INSERT INTO public.product_images VALUES (95, 188, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm81Tp_UUt-55DSUzXRuHPEqye7el7SxUsvQ&s', 1, false, '2025-12-31 16:19:15.378');
INSERT INTO public.product_images VALUES (96, 188, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRR4WRkax6esH-dLzqJX2NxCCOKUQ5nUEFswA&s', 2, false, '2025-12-31 16:19:15.378');
INSERT INTO public.product_images VALUES (97, 189, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01_4.jpg', 0, true, '2025-12-31 16:19:15.395');
INSERT INTO public.product_images VALUES (98, 189, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIWAz27a_a3nqmpNV0twAHy7e5zIM7whm0ww&s', 1, false, '2025-12-31 16:19:15.395');
INSERT INTO public.product_images VALUES (99, 189, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRR4WRkax6esH-dLzqJX2NxCCOKUQ5nUEFswA&s', 2, false, '2025-12-31 16:19:15.395');
INSERT INTO public.product_images VALUES (152, 207, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpVa9xWhpe-lggq2UlEEtghDF-OS1Qf3udKA&s', 1, false, '2025-12-31 16:19:15.771');
INSERT INTO public.product_images VALUES (100, 190, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-13-select-202210_1_1_1.png', 0, true, '2025-12-31 16:19:15.413');
INSERT INTO public.product_images VALUES (101, 190, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDst8InmVt2Cv-8_KE-jlbsch99V6JBWho0w&s', 1, false, '2025-12-31 16:19:15.413');
INSERT INTO public.product_images VALUES (102, 190, 'https://product.hstatic.net/1000329106/product/ipad-pro-m2-wifi-bac-4_c431a0f9999a4c1e84f87eb9efd385fa_master.jpg', 2, false, '2025-12-31 16:19:15.413');
INSERT INTO public.product_images VALUES (103, 191, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-air-5.png', 0, true, '2025-12-31 16:19:15.43');
INSERT INTO public.product_images VALUES (104, 191, 'https://bachlongstore.vn/vnt_upload/product/11_2023/thumbs/1000_43543.jpg', 1, false, '2025-12-31 16:19:15.43');
INSERT INTO public.product_images VALUES (105, 191, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe11ZOYkPc9x8kxEZXwptVw50MYraBpZ1kRA&s', 2, false, '2025-12-31 16:19:15.43');
INSERT INTO public.product_images VALUES (106, 192, 'https://cdn.tgdd.vn/Products/Images/522/274154/ipad-air-5-wifi-blue-thumb-1-600x600.jpg', 0, true, '2025-12-31 16:19:15.445');
INSERT INTO public.product_images VALUES (107, 192, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0iDUvTzRZcx7B5tD4_3WNsHpgAGMemqYKFw&s', 1, false, '2025-12-31 16:19:15.445');
INSERT INTO public.product_images VALUES (108, 192, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTbOsDPRvn7Cjx-7BxOQjqqspjyvdpAwwihA&s', 2, false, '2025-12-31 16:19:15.445');
INSERT INTO public.product_images VALUES (109, 193, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/_/t_i_xu_ng_2__1_8_1_1.png', 0, true, '2025-12-31 16:19:15.462');
INSERT INTO public.product_images VALUES (110, 193, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-mini-6-5.jpg', 1, false, '2025-12-31 16:19:15.462');
INSERT INTO public.product_images VALUES (111, 193, 'https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg', 2, false, '2025-12-31 16:19:15.462');
INSERT INTO public.product_images VALUES (112, 194, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-mini-6-5_1_1_1_1.jpg', 0, true, '2025-12-31 16:19:15.479');
INSERT INTO public.product_images VALUES (113, 194, 'https://minhdatstore.vn/public/uploads/ipad-mini-6-glr-1.jpg', 1, false, '2025-12-31 16:19:15.479');
INSERT INTO public.product_images VALUES (114, 194, 'https://laptop360.net/wp-content/uploads/2023/04/Apple-iPad-Mini-6-4.jpg', 2, false, '2025-12-31 16:19:15.479');
INSERT INTO public.product_images VALUES (115, 195, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-10-9-inch-2022.png', 0, true, '2025-12-31 16:19:15.497');
INSERT INTO public.product_images VALUES (116, 195, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/tablet/iPad/iPad-gen-10/ipad-10-9-inch-2022-7.jpg', 1, false, '2025-12-31 16:19:15.497');
INSERT INTO public.product_images VALUES (117, 195, 'https://mac24h.vn/images/detailed/92/IPAD_GEN_10_MAC24H.png', 2, false, '2025-12-31 16:19:15.497');
INSERT INTO public.product_images VALUES (118, 196, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-2022-hero-blue-wifi-select_1.png', 0, true, '2025-12-31 16:19:15.518');
INSERT INTO public.product_images VALUES (119, 196, 'https://mac24h.vn/images/detailed/92/IPAD_GEN_10_MAC24H.png', 1, false, '2025-12-31 16:19:15.518');
INSERT INTO public.product_images VALUES (120, 196, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzjN61i55zCHHpH35T7mOVY37YdkPQsSHkUA&s', 2, false, '2025-12-31 16:19:15.518');
INSERT INTO public.product_images VALUES (121, 197, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/c/2c_v.png', 0, true, '2025-12-31 16:19:15.533');
INSERT INTO public.product_images VALUES (122, 197, 'https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg', 1, false, '2025-12-31 16:19:15.533');
INSERT INTO public.product_images VALUES (123, 197, 'https://phucanhcdn.com/media/lib/09-10-2021/ipadgen9102bvh8.jpg', 2, false, '2025-12-31 16:19:15.533');
INSERT INTO public.product_images VALUES (124, 198, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/401/951/products/dacdiemnoibatad7358efe2ed47aa9-6fd11bbc-2a77-4216-b94b-08369a6a8e34.png?v=1749147182043', 0, true, '2025-12-31 16:19:15.555');
INSERT INTO public.product_images VALUES (125, 198, 'https://phucanhcdn.com/media/lib/09-10-2021/ipadgen9102bvh8.jpg', 1, false, '2025-12-31 16:19:15.555');
INSERT INTO public.product_images VALUES (126, 198, 'https://www.civip.com.vn/media/product/10281_10050587_ipad_gen_9_wifi_256gb_10_2_inch_mk2p3za_a_bac_2021_4.jpg', 2, false, '2025-12-31 16:19:15.555');
INSERT INTO public.product_images VALUES (127, 199, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-12-9-2021_1_1_2_1_1_2.jpg', 0, true, '2025-12-31 16:19:15.57');
INSERT INTO public.product_images VALUES (128, 199, 'https://dienthoaigiakho.vn/_next/image?url=https%3A%2F%2Fcdn.dienthoaigiakho.vn%2Fphotos%2F1678077654796-ipad-12.9-2021-128-1.jpg&w=3840&q=75', 1, false, '2025-12-31 16:19:15.57');
INSERT INTO public.product_images VALUES (129, 199, 'https://cdn.viettablet.com/images/companies/1/0-hinh-moi/tin-tuc/2021/thang-1/13-1/ipad-pro-2021.jpg?1610621599027', 2, false, '2025-12-31 16:19:15.57');
INSERT INTO public.product_images VALUES (130, 200, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-11-2021-2_1_1_1_1_1_1_1_1_1_1_1_1_1_1.jpg', 0, true, '2025-12-31 16:19:15.605');
INSERT INTO public.product_images VALUES (131, 200, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3vHN-tGsrVWq25QaavkiD9SDzHRK2gQyxfg&s', 1, false, '2025-12-31 16:19:15.605');
INSERT INTO public.product_images VALUES (132, 200, 'https://product.hstatic.net/200000373523/product/-tinh-bang-ipad-pro-m1-2021-11-inch-wifi-8gb-128gb-mhqr3za-a-xam-01_1__a02b1bc769cc4ccd85faee6a5820b984_grande.jpg', 2, false, '2025-12-31 16:19:15.605');
INSERT INTO public.product_images VALUES (133, 201, 'https://ttcenter.com.vn/uploads/product/zsr37jz9-364-ipad-air-4-10-9-inch-wifi-64gb-like-new.jpg', 0, true, '2025-12-31 16:19:15.628');
INSERT INTO public.product_images VALUES (134, 201, 'https://assets.kogan.com/images/brus-australia/BRS-APPLE-IPAD-AIR-4-64GB-W-ANY-G/1-90785cef98-apple_ipad_air_4_any_colour_new.jpg?auto=webp&bg-color=fff&canvas=1200%2C800&dpr=1&enable=upscale&fit=bounds&height=800&quality=90&width=1200', 1, false, '2025-12-31 16:19:15.628');
INSERT INTO public.product_images VALUES (135, 201, 'https://cdn.viettablet.com/images/companies/1/0-hinh-moi/tin-tuc/2020/17-9/ipad-air-4-mau-sac.jpg?1600340943574', 2, false, '2025-12-31 16:19:15.628');
INSERT INTO public.product_images VALUES (136, 202, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-mini-select-wifi-silver-201903_7_1.png', 0, true, '2025-12-31 16:19:15.655');
INSERT INTO public.product_images VALUES (137, 202, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-mini-5_3_1.jpg', 1, false, '2025-12-31 16:19:15.655');
INSERT INTO public.product_images VALUES (138, 202, 'https://macvn.com.vn/wp-content/uploads/2023/10/ipad-mini-gen-5-1.jpg', 2, false, '2025-12-31 16:19:15.655');
INSERT INTO public.product_images VALUES (139, 203, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-ipad-pro-11-2020-wifi-256-gb-2_2_1_1.jpg', 0, true, '2025-12-31 16:19:15.683');
INSERT INTO public.product_images VALUES (140, 203, 'https://2tmobile.com/wp-content/uploads/2022/07/ipad_pro_12_9_inch_2021_2tmobile.jpg', 1, false, '2025-12-31 16:19:15.683');
INSERT INTO public.product_images VALUES (141, 203, 'https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-8.jpg', 2, false, '2025-12-31 16:19:15.683');
INSERT INTO public.product_images VALUES (142, 204, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_bac_3_1_2.jpg', 0, true, '2025-12-31 16:19:15.704');
INSERT INTO public.product_images VALUES (143, 204, 'https://cdn.tgdd.vn/Products/Images/522/220163/Slider/ipad-pro-11-inch-2020-073220-033200-788.jpg', 1, false, '2025-12-31 16:19:15.704');
INSERT INTO public.product_images VALUES (144, 204, 'https://2tmobile.com/wp-content/uploads/2022/10/ipad-pro-11-inch-m2-series.jpg', 2, false, '2025-12-31 16:19:15.704');
INSERT INTO public.product_images VALUES (145, 205, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/9/19268_ipadgen8sliver_ok_3.jpg', 0, true, '2025-12-31 16:19:15.733');
INSERT INTO public.product_images VALUES (146, 205, 'https://bizweb.dktcdn.net/thumb/grande/100/401/951/products/ipad-gen-8-2.png?v=1730041219287', 1, false, '2025-12-31 16:19:15.733');
INSERT INTO public.product_images VALUES (147, 205, 'https://i.ebayimg.com/images/g/caIAAOSw5DpgOTCx/s-l400.jpg', 2, false, '2025-12-31 16:19:15.733');
INSERT INTO public.product_images VALUES (148, 206, 'https://hoangtrungmobile.vn/wp-content/uploads/2021/03/ipad-air-3-bac.jpg', 0, true, '2025-12-31 16:19:15.753');
INSERT INTO public.product_images VALUES (149, 206, 'https://hoangtrungmobile.vn/wp-content/uploads/2021/03/ipad-air-3-1.png', 1, false, '2025-12-31 16:19:15.753');
INSERT INTO public.product_images VALUES (150, 206, 'https://cellphones.com.vn/media/wysiwyg/tablet/apple/apple-ipad-air-105-wifi-64gb-chinh-hang-2.jpg', 2, false, '2025-12-31 16:19:15.753');
INSERT INTO public.product_images VALUES (151, 207, 'https://didongthongminh.vn/images/products/2025/09/19/original/2(4).jpg', 0, true, '2025-12-31 16:19:15.771');
INSERT INTO public.product_images VALUES (153, 207, 'https://2tmobile.com/wp-content/uploads/2022/10/ipad-pro-10-5-2017-rose-gold.jpg', 2, false, '2025-12-31 16:19:15.771');
INSERT INTO public.product_images VALUES (154, 208, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-9in-gold_3_1_2_1.jpg', 0, true, '2025-12-31 16:19:15.79');
INSERT INTO public.product_images VALUES (155, 208, 'https://24hstore.vn/images/products/2024/10/30/large/ipad-pro-9-7-2016-wifi-cellular-cu.jpg', 1, false, '2025-12-31 16:19:15.79');
INSERT INTO public.product_images VALUES (156, 208, 'https://shopdunk.com/images/thumbs/0016536_DSC06746-1-800x450_1600.jpeg', 2, false, '2025-12-31 16:19:15.79');
INSERT INTO public.product_images VALUES (157, 209, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/b/mba13-m3-midnight-gallery1-202402_3_1_2_1.jpg', 0, true, '2025-12-31 16:19:15.809');
INSERT INTO public.product_images VALUES (158, 209, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9ciFFwk8JAZzSj_HnhFmw7R9V0VFcUET99w&s', 1, false, '2025-12-31 16:19:15.809');
INSERT INTO public.product_images VALUES (159, 209, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzcw-AOkamn41r6w98MjF_GgPYGMBN2k7XiQ&s', 2, false, '2025-12-31 16:19:15.809');
INSERT INTO public.product_images VALUES (160, 210, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/laptop/macbook/Air/M3-2024/macbook-air-m3-15-inch-2024-1_1.jpg', 0, true, '2025-12-31 16:19:15.829');
INSERT INTO public.product_images VALUES (161, 210, 'https://cdn.tgdd.vn/News/1562806/1-1280x720.jpg', 1, false, '2025-12-31 16:19:15.829');
INSERT INTO public.product_images VALUES (162, 210, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfgklLIT3u0jp1zknXIoVcOYGWCfXck8Qk6A&s', 2, false, '2025-12-31 16:19:15.829');
INSERT INTO public.product_images VALUES (163, 211, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/laptop/macbook/macbook-pro-7.jpg', 0, true, '2025-12-31 16:19:15.845');
INSERT INTO public.product_images VALUES (164, 211, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0LaLe2Dxa6uVFmI1mmdTO4EkcbnYa1Jq7aQ&s', 1, false, '2025-12-31 16:19:15.845');
INSERT INTO public.product_images VALUES (165, 211, 'https://helios-i.mashable.com/imagery/reviews/04xYfyZ1mk1LcppkgmbOzG5/images-14.fill.size_2000x1125.v1701668675.jpg', 2, false, '2025-12-31 16:19:15.845');
INSERT INTO public.product_images VALUES (166, 212, 'https://bizweb.dktcdn.net/100/318/659/products/7-5581399e-3267-456a-8d4f-9259ac8f5dc0.jpg?v=1699430082770', 0, true, '2025-12-31 16:19:15.858');
INSERT INTO public.product_images VALUES (167, 212, 'https://macone.vn/wp-content/uploads/2023/12/apple-macbook-pro-2023-4.jpeg', 1, false, '2025-12-31 16:19:15.858');
INSERT INTO public.product_images VALUES (168, 212, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS28xgUz1fbA0-xerg3SyMgoIvava19dSAn9w&s', 2, false, '2025-12-31 16:19:15.858');
INSERT INTO public.product_images VALUES (169, 213, 'https://cdn2.fptshop.com.vn/unsafe/macbook_air_13_m2_midnight_1_35053fbcf9.png', 0, true, '2025-12-31 16:19:15.875');
INSERT INTO public.product_images VALUES (170, 213, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHPmPFYftfJXaQvAPdwjZDxLfusqCZpVJW9g&s', 1, false, '2025-12-31 16:19:15.875');
INSERT INTO public.product_images VALUES (171, 213, 'https://shopdunk.com/images/thumbs/0018828_so-sanh-macbook-air-m2-13-inch-va-15-inch_1600.jpeg', 2, false, '2025-12-31 16:19:15.875');
INSERT INTO public.product_images VALUES (172, 214, 'https://cellphones.com.vn/sforum/wp-content/uploads/2022/01/tren-tay-Dell-XPS-13-Plus-13.jpg', 0, true, '2025-12-31 16:19:15.893');
INSERT INTO public.product_images VALUES (173, 214, 'https://cellphones.com.vn/sforum/wp-content/uploads/2022/01/tren-tay-Dell-XPS-13-Plus-12.jpg', 1, false, '2025-12-31 16:19:15.893');
INSERT INTO public.product_images VALUES (174, 214, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_3__7_102.png', 2, false, '2025-12-31 16:19:15.893');
INSERT INTO public.product_images VALUES (175, 215, 'https://media.wired.com/photos/6169f03b58660fcbc5f4ec3b/master/w_1600%2Cc_limit/Gear-Dell-XPS-15-OLED-1.jpg', 0, true, '2025-12-31 16:19:15.909');
INSERT INTO public.product_images VALUES (176, 215, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSwRbnCnclo9IzxAzIdB1v2r2-jPIVF7DRSw&s', 1, false, '2025-12-31 16:19:15.909');
INSERT INTO public.product_images VALUES (177, 215, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5JJ7qgZP-lZq8X05QvJEObTdoWK7g6OrFaw&s', 2, false, '2025-12-31 16:19:15.909');
INSERT INTO public.product_images VALUES (178, 216, 'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2023/11/10-6.jpg', 0, true, '2025-12-31 16:19:15.923');
INSERT INTO public.product_images VALUES (179, 216, 'https://www.laptopvip.vn/images/companies/1/JVS/LENOVO/TP-X1C-G11/10006.jpg?1680061438462', 1, false, '2025-12-31 16:19:15.923');
INSERT INTO public.product_images VALUES (180, 216, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRltvy2CyXoprbFFNwIYQ22jFcoklCJaBdv1w&s', 2, false, '2025-12-31 16:19:15.923');
INSERT INTO public.product_images VALUES (181, 217, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/a/laptop-hp-spectre-x360-14-ea0023xd-cu-dep-3_1.jpg', 0, true, '2025-12-31 16:19:15.939');
INSERT INTO public.product_images VALUES (182, 217, 'https://khoaquan.vn/wp-content/uploads/2023/12/803M6EA-ABU_14_1750x1285.webp', 1, false, '2025-12-31 16:19:15.939');
INSERT INTO public.product_images VALUES (183, 217, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJsFo4sNurYpNvb2Xlkmm7E13Dc4GeHrHU3g&s', 2, false, '2025-12-31 16:19:15.939');
INSERT INTO public.product_images VALUES (184, 218, 'https://nguyencongpc.vn/media/product/20151-asus-zenbook-duo-14-ux482eg-ka166t-6.jpg', 0, true, '2025-12-31 16:19:15.955');
INSERT INTO public.product_images VALUES (185, 218, 'https://dlcdnwebimgs.asus.com/gain/e1c062dc-b3ad-4b84-b310-eda9f5984d2c/', 1, false, '2025-12-31 16:19:15.955');
INSERT INTO public.product_images VALUES (186, 218, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBsXHWAG648DddEZ-ShffoL3w3vx3FcB1uTQ&s', 2, false, '2025-12-31 16:19:15.955');
INSERT INTO public.product_images VALUES (187, 219, 'https://laptops.vn/wp-content/uploads/2024/06/razer-blade-14-2024-1710487813_1711595620-1.jpg', 0, true, '2025-12-31 16:19:15.967');
INSERT INTO public.product_images VALUES (188, 219, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHrfvgh-p4VzqO_ukL1RFy_dSL7VTITruJ3Q&s', 1, false, '2025-12-31 16:19:15.967');
INSERT INTO public.product_images VALUES (189, 219, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4IlJyBL2ICq8x16wOPdvtUxMrka3nMeBYpA&s', 2, false, '2025-12-31 16:19:15.967');
INSERT INTO public.product_images VALUES (190, 220, 'https://vhost53003.vhostcdn.com/wp-content/uploads/2022/10/microsoft-surface-laptop-5-2.jpg', 0, true, '2025-12-31 16:19:15.979');
INSERT INTO public.product_images VALUES (191, 220, 'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2022/11/Microsoft-Surface-Laptop-5-20.jpg', 1, false, '2025-12-31 16:19:15.979');
INSERT INTO public.product_images VALUES (192, 220, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7MkaUHUjsps5gFKJWbC8MuinVcQSPybyRbw&s', 2, false, '2025-12-31 16:19:15.979');
INSERT INTO public.product_images VALUES (193, 221, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_55__2_11.png', 0, true, '2025-12-31 16:19:16.001');
INSERT INTO public.product_images VALUES (194, 221, 'https://mac24h.vn/images/detailed/94/LG_GRAM_17.jpg', 1, false, '2025-12-31 16:19:16.001');
INSERT INTO public.product_images VALUES (195, 221, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr4OucSL4UoxtCNtv_h8eiJF8W28_cAS_DVw&s', 2, false, '2025-12-31 16:19:16.001');
INSERT INTO public.product_images VALUES (196, 222, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/6/360pro_1.png', 0, true, '2025-12-31 16:19:16.018');
INSERT INTO public.product_images VALUES (197, 222, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/g/b/gb3_pro-2-configurator-800x600_1_2.png', 1, false, '2025-12-31 16:19:16.018');
INSERT INTO public.product_images VALUES (198, 222, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScwPLewEHjR5BC8ANjydiYyMSEC3JMLrQLZA&s', 2, false, '2025-12-31 16:19:16.018');
INSERT INTO public.product_images VALUES (199, 223, 'https://cellphones.com.vn/sforum/wp-content/uploads/2020/06/Acer-Swift-5-SF514-55-Standard_01.png', 0, true, '2025-12-31 16:19:16.031');
INSERT INTO public.product_images VALUES (200, 223, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/a/laptop-acer-swift-5-sf514-55t-51nz-2.jpg', 1, false, '2025-12-31 16:19:16.031');
INSERT INTO public.product_images VALUES (201, 223, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYQ869QAlPAQX_FyX8HJfDNMUiKfvVrSmdog&s', 2, false, '2025-12-31 16:19:16.031');
INSERT INTO public.product_images VALUES (202, 224, 'https://product.hstatic.net/200000722513/product/057vn_9630c86ceec944c49425ef01bb5c879d_master.png', 0, true, '2025-12-31 16:19:16.044');
INSERT INTO public.product_images VALUES (203, 224, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_mR-FETn-GwuAM8dMT0RpjJLHkBORjMZcwg&s', 1, false, '2025-12-31 16:19:16.044');
INSERT INTO public.product_images VALUES (204, 224, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfqk2m7tRGH-ImM1uqXkrG4bkilwjxetbDdg&s', 2, false, '2025-12-31 16:19:16.044');
INSERT INTO public.product_images VALUES (205, 225, 'https://cdn-media.sforum.vn/storage/app/media/chidung/yoga-9i/danh-gia-yoga-9i-2024-14.jpg', 0, true, '2025-12-31 16:19:16.057');
INSERT INTO public.product_images VALUES (256, 242, 'https://cdn.viettablet.com/images/thumbnails/480/516/detailed/56/oneplus-pad-chinh-hang.jpg', 0, true, '2025-12-31 16:19:16.299');
INSERT INTO public.product_images VALUES (206, 225, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_19__4_11.png', 1, false, '2025-12-31 16:19:16.057');
INSERT INTO public.product_images VALUES (207, 225, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1qo2a1bop9KKSVMh8FIwH6HC4e-Mbu5HAaA&s', 2, false, '2025-12-31 16:19:16.057');
INSERT INTO public.product_images VALUES (208, 226, 'https://www.laptopvip.vn/images/ab__webp/detailed/32/notebook-alienware-x14-r2-gray-gallery-6-www.laptopvip.vn-1686985486.webp', 0, true, '2025-12-31 16:19:16.07');
INSERT INTO public.product_images VALUES (209, 226, 'https://laptop15.vn/wp-content/uploads/2023/08/Dell-Alienware-X14-R1-2.png', 1, false, '2025-12-31 16:19:16.07');
INSERT INTO public.product_images VALUES (210, 226, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/l/a/laptop-alienware-x14-r1-3.png', 2, false, '2025-12-31 16:19:16.07');
INSERT INTO public.product_images VALUES (211, 227, 'https://product.hstatic.net/200000768357/product/gray_fab6e9b0c7374bfd86b9189632447680.png', 0, true, '2025-12-31 16:19:16.083');
INSERT INTO public.product_images VALUES (212, 227, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAYJ8TYeoCN6rNc9ymhjhgw46k7_Aj3aDwqQ&s', 1, false, '2025-12-31 16:19:16.083');
INSERT INTO public.product_images VALUES (213, 227, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiVkQY_qplE2tLMlAPIfS3wTuy_rT2L-5xfA&s', 2, false, '2025-12-31 16:19:16.083');
INSERT INTO public.product_images VALUES (214, 228, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/44/330075/dell-inspiron-15-3520-i5-n3520-i5u085w11slu-1-638627942653445825-750x500.jpg', 0, true, '2025-12-31 16:19:16.095');
INSERT INTO public.product_images VALUES (215, 228, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYIV3NYrS7zeOBD7mGLu5305ky5Ss45qjlvg&s', 1, false, '2025-12-31 16:19:16.095');
INSERT INTO public.product_images VALUES (216, 228, 'https://www.laptopvip.vn/images/ab__webp/detailed/31/ava-x8q4-0b-www.laptopvip.vn-1678677543.webp', 2, false, '2025-12-31 16:19:16.095');
INSERT INTO public.product_images VALUES (217, 229, 'https://www.laptopvip.vn/images/companies/1/JVS/HP/HP-Pavilion-15T/71lc66S1jqL._AC_SL1500_.jpg?1666681642506', 0, true, '2025-12-31 16:19:16.111');
INSERT INTO public.product_images VALUES (218, 229, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdAuOwmtb2G1uy9U7DDpZk2IhAhisOZq-dvw&s', 1, false, '2025-12-31 16:19:16.111');
INSERT INTO public.product_images VALUES (219, 229, 'https://laptopbaoloc.vn/wp-content/uploads/2023/02/Laptop-HP-Pavilion-15-eg0507TU-3.jpg', 2, false, '2025-12-31 16:19:16.111');
INSERT INTO public.product_images VALUES (220, 230, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_1__5_16_1.png', 0, true, '2025-12-31 16:19:16.124');
INSERT INTO public.product_images VALUES (221, 230, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/329/122/products/laptop-asus-vivobook-15-x1504va-nj070w-4.jpg?v=1696089769407', 1, false, '2025-12-31 16:19:16.124');
INSERT INTO public.product_images VALUES (222, 230, 'https://vt.net.vn/wp-content/uploads/2020/10/asus-vivo15-a1505va-l1114w-1.jpg', 2, false, '2025-12-31 16:19:16.124');
INSERT INTO public.product_images VALUES (223, 231, 'https://p3-ofp.static.pub/fes/cms/2022/12/28/cbsimp9kdhc8w1tw2t7pytz6exsvvv545729.jpg', 0, true, '2025-12-31 16:19:16.14');
INSERT INTO public.product_images VALUES (224, 231, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDgTiw21igwZMsUXiUsbcZHdXNC-oDr1f0HA&s', 1, false, '2025-12-31 16:19:16.14');
INSERT INTO public.product_images VALUES (225, 231, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSL2uB2sPHgWesRdvJPxCnqB6JEdtLPEYfKaQ&s', 2, false, '2025-12-31 16:19:16.14');
INSERT INTO public.product_images VALUES (226, 232, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/laptop/macbook/macbook-pro-7.jpg', 0, true, '2025-12-31 16:19:16.158');
INSERT INTO public.product_images VALUES (227, 232, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/macbook_pro_14_inch_m4_chip_silver_pdp_image_position_2_vn_vi.jpg', 1, false, '2025-12-31 16:19:16.158');
INSERT INTO public.product_images VALUES (228, 232, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSObbZAo9rBWO4d3gnK7bE3eIrk-FoddFLkSg&s', 2, false, '2025-12-31 16:19:16.158');
INSERT INTO public.product_images VALUES (229, 233, 'https://hungphatlaptop.com/wp-content/uploads/2024/01/DELL-XPS-14-9440-2024-Platinum-H1-1.jpeg', 0, true, '2025-12-31 16:19:16.173');
INSERT INTO public.product_images VALUES (230, 233, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK253slDwNKaR1CF_P5Y07C2LOLhhAI8m8GA&s', 1, false, '2025-12-31 16:19:16.173');
INSERT INTO public.product_images VALUES (231, 233, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrx-QJYF4Rg8UE2-dviGO0MfhdAbq0gj7BlQ&s', 2, false, '2025-12-31 16:19:16.173');
INSERT INTO public.product_images VALUES (232, 234, 'https://cdn2.fptshop.com.vn/unsafe/800x0/hp_omnibook_ultra_flip_14_fh0040tu_b13vhpa_6_2a358fe388.jpg', 0, true, '2025-12-31 16:19:16.195');
INSERT INTO public.product_images VALUES (233, 234, 'https://2tmobile.com/wp-content/uploads/2025/05/hp-omnibook-ultra-flip-2024-2tmobile.webp', 1, false, '2025-12-31 16:19:16.195');
INSERT INTO public.product_images VALUES (234, 234, 'https://www.pcworld.com/wp-content/uploads/2025/04/HP-OmiBook-Ultra-Flip-14-tablet-mode.jpg?quality=50&strip=all&w=1024', 2, false, '2025-12-31 16:19:16.195');
INSERT INTO public.product_images VALUES (235, 235, 'https://dlcdnwebimgs.asus.com/gain/E90DE227-7002-48C1-A940-B6E952D0BCCC', 0, true, '2025-12-31 16:19:16.211');
INSERT INTO public.product_images VALUES (236, 235, 'https://lapvip.vn/upload/products/original/asus-gaming-rog-zephyrus-g14-windows-10-1597659277.jpg', 1, false, '2025-12-31 16:19:16.211');
INSERT INTO public.product_images VALUES (237, 235, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6WCnBRFZF-mVz8vdU7DUAbkcm52uPiyE4rw&s', 2, false, '2025-12-31 16:19:16.211');
INSERT INTO public.product_images VALUES (238, 236, 'https://surfaceviet.vn/wp-content/uploads/2024/05/Surface-Laptop-7-Black-15-inch.jpg', 0, true, '2025-12-31 16:19:16.226');
INSERT INTO public.product_images VALUES (239, 236, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm-PQBOqfnRaqtr0G46MBSI-lYIkLxQNK5xA&s', 1, false, '2025-12-31 16:19:16.226');
INSERT INTO public.product_images VALUES (240, 236, 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1724683162-1722447273-microsoft-surface-laptop-2024-001-66aa759807ea4.jpg?crop=0.712xw:0.949xh;0.106xw,0.0342xh&resize=980:*', 2, false, '2025-12-31 16:19:16.226');
INSERT INTO public.product_images VALUES (241, 237, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tab-s9-ultra-kem-2_1_1.png', 0, true, '2025-12-31 16:19:16.238');
INSERT INTO public.product_images VALUES (242, 237, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbLFI74_smEYhr-YQcuYCQWT-2CAGcqnqrCA&s', 1, false, '2025-12-31 16:19:16.238');
INSERT INTO public.product_images VALUES (243, 237, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG5-j-Zk08C5eKFICM-FhrAFJjsH0qtbip-w&s', 2, false, '2025-12-31 16:19:16.238');
INSERT INTO public.product_images VALUES (244, 238, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/e/p/eprice_1_b7620c148ab010a64546e96a356978b2_2_1.jpg', 0, true, '2025-12-31 16:19:16.25');
INSERT INTO public.product_images VALUES (245, 238, 'https://cdn.tgdd.vn/Products/Images/522/307178/Slider/samsung-galaxy-tab-s9-plus-thumb-yt-1020x570.jpg', 1, false, '2025-12-31 16:19:16.25');
INSERT INTO public.product_images VALUES (246, 238, 'https://cdn-v2.didongviet.vn/files/default/2024/11/17/0/1734426091261_2_samsung_galaxy_tab_s9_plus_256gb_didongviet.jpg', 2, false, '2025-12-31 16:19:16.25');
INSERT INTO public.product_images VALUES (247, 239, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/s/ss-tab-s9_1.png', 0, true, '2025-12-31 16:19:16.262');
INSERT INTO public.product_images VALUES (248, 239, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWIurcQN_FHag_Kc3f4tbLSflbL_LceBKxRg&s', 1, false, '2025-12-31 16:19:16.262');
INSERT INTO public.product_images VALUES (249, 239, 'https://bachlongstore.vn/vnt_upload/product/10_2023/thumbs/1000_732176.png', 2, false, '2025-12-31 16:19:16.262');
INSERT INTO public.product_images VALUES (250, 240, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/a/tab-s9-fe-xam_2_1_1.png', 0, true, '2025-12-31 16:19:16.275');
INSERT INTO public.product_images VALUES (251, 240, 'https://happyphone.vn/wp-content/uploads/2024/03/Samsung-Galaxy-Tab-S9-FE-Wifi-128GB-Xanh-mint.png', 1, false, '2025-12-31 16:19:16.275');
INSERT INTO public.product_images VALUES (252, 240, 'https://cdn.tgdd.vn/Products/Images/522/309819/Slider/samsung-galaxy-tab-s9-fe-plus-tongquan-1020x570.jpg', 2, false, '2025-12-31 16:19:16.275');
INSERT INTO public.product_images VALUES (253, 241, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/g/o/google_pixel_tablet.jpg', 0, true, '2025-12-31 16:19:16.288');
INSERT INTO public.product_images VALUES (254, 241, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/tablet/Google/google-pixel-tablet-4.jpg', 1, false, '2025-12-31 16:19:16.288');
INSERT INTO public.product_images VALUES (255, 241, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz6SEJwyMo1YdZ3nlSMHgojasS7pnR-LG3QQ&s', 2, false, '2025-12-31 16:19:16.288');
INSERT INTO public.product_images VALUES (257, 242, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSinNk73b8swO4DX16Le9UCXMx59RUXThZfSw&s', 1, false, '2025-12-31 16:19:16.299');
INSERT INTO public.product_images VALUES (258, 242, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWiCI9Q92F0PDblHbMwoKORXuRKgpQaUFj-Q&s', 2, false, '2025-12-31 16:19:16.299');
INSERT INTO public.product_images VALUES (259, 243, 'https://p4-ofp.static.pub/fes/cms/2023/03/28/7dch8vg9lz0tzeg74u3x9paoln4o8z319478.png', 0, true, '2025-12-31 16:19:16.313');
INSERT INTO public.product_images VALUES (260, 243, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/07/Lenovo-Tab-P12-3.jpeg', 1, false, '2025-12-31 16:19:16.313');
INSERT INTO public.product_images VALUES (261, 243, 'https://p2-ofp.static.pub/fes/cms/2023/03/28/8wauc5kf0e16qej7g7cmhrspz7e2ov405745.jpg', 2, false, '2025-12-31 16:19:16.313');
INSERT INTO public.product_images VALUES (262, 244, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/m/i/mi-pad-6-cps-doc-quyen-xanh_3_1_1.jpg', 0, true, '2025-12-31 16:19:16.327');
INSERT INTO public.product_images VALUES (263, 244, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_pad6_-_1.png', 1, false, '2025-12-31 16:19:16.327');
INSERT INTO public.product_images VALUES (264, 244, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBIB74sMizNbFsFBamVCKLmRUXZA8JdLiZ6A&s', 2, false, '2025-12-31 16:19:16.327');
INSERT INTO public.product_images VALUES (265, 245, 'https://product.hstatic.net/200000730863/product/51gj5oqxbnl._ac_sl1000__f75a5ec479ef4fc1ac2f78b17c6da98d_master.jpg', 0, true, '2025-12-31 16:19:16.342');
INSERT INTO public.product_images VALUES (266, 245, 'https://kindlehanoi.vn/wp-content/uploads/2023/08/Fire-Max-11-2023-2024-model.jpg', 1, false, '2025-12-31 16:19:16.342');
INSERT INTO public.product_images VALUES (267, 245, 'https://m.media-amazon.com/images/I/51-hmSQ2FsL._UF1000,1000_QL80_.jpg', 2, false, '2025-12-31 16:19:16.342');
INSERT INTO public.product_images VALUES (268, 246, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-galaxy-tab-a9_11__1.png', 0, true, '2025-12-31 16:19:16.354');
INSERT INTO public.product_images VALUES (269, 246, 'https://cdn.tgdd.vn/Products/Images/522/315590/Slider/samsung-galaxy-tab-a9-plus-thumb-1020x570.jpg', 1, false, '2025-12-31 16:19:16.354');
INSERT INTO public.product_images VALUES (270, 246, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUJm3ql3pJ6k2YlTw1nXXTTddlDg7O13hSeg&s', 2, false, '2025-12-31 16:19:16.354');
INSERT INTO public.product_images VALUES (271, 247, 'https://p2-ofp.static.pub/fes/cms/2023/03/29/8rz4mn5wzzx3s29zfcffctkb2xcwjj602719.png', 0, true, '2025-12-31 16:19:16.365');
INSERT INTO public.product_images VALUES (272, 247, 'https://cdn.tgdd.vn/Files/2021/03/19/1336509/lenovotabm10hd-2_800x450.jpg', 1, false, '2025-12-31 16:19:16.365');
INSERT INTO public.product_images VALUES (273, 247, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc1qdbZMQHw9FzagItRiCuGjKEzl2vB-U9og&s', 2, false, '2025-12-31 16:19:16.365');
INSERT INTO public.product_images VALUES (274, 248, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/h/t/https___bucketeer_e05bbc84_baa3_437e_9518_adb32be77984.s3.amazonaws.com_public_images_b08df22d_4b5e_46a8_87c5_fc303e133f8a_1500x1500_1_1_1_1.jpg', 0, true, '2025-12-31 16:19:16.376');
INSERT INTO public.product_images VALUES (275, 248, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR06MlEDQr-ItwYbVMhDASbC0FAs_IefMXuQA&s', 1, false, '2025-12-31 16:19:16.376');
INSERT INTO public.product_images VALUES (276, 248, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnhyMRMNvOEwWJPqlO-DWpVHGzV6FVbF2-sA&s', 2, false, '2025-12-31 16:19:16.376');
INSERT INTO public.product_images VALUES (277, 249, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/e/series_tab_s8001_1_2.jpg', 0, true, '2025-12-31 16:19:16.389');
INSERT INTO public.product_images VALUES (278, 249, 'https://files.refurbed.com/ii/samsung-galaxy-tab-s8-plus-1666339074.jpg?t=fitdesign&h=600&w=800', 1, false, '2025-12-31 16:19:16.389');
INSERT INTO public.product_images VALUES (279, 249, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrc9d2K5eYzLkn9H-xzFjZ2Pa4TJKGdweXCw&s', 2, false, '2025-12-31 16:19:16.389');
INSERT INTO public.product_images VALUES (280, 250, 'https://surfacecity.vn/wp-content/uploads/microsoft-surface-pro-9-5g.jpg', 0, true, '2025-12-31 16:19:16.401');
INSERT INTO public.product_images VALUES (281, 250, 'https://surfacestore.com.vn/wp-content/uploads/2022/10/microsoft-surface-pro-9-1.jpg', 1, false, '2025-12-31 16:19:16.401');
INSERT INTO public.product_images VALUES (282, 250, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGG1Do0cRbDI-6IAY7-bbaq7FeA_FmoJzCIg&s', 2, false, '2025-12-31 16:19:16.401');
INSERT INTO public.product_images VALUES (283, 251, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/5/6/5650372_surface_go_3_under_embargo_until_22.jpg', 0, true, '2025-12-31 16:19:16.413');
INSERT INTO public.product_images VALUES (284, 251, 'https://hanoilab.com/wp-content/uploads/2024/10/Surface-Laptop-Go-3-New-Open-Box-Ha-Noi-Lab-5.jpg', 1, false, '2025-12-31 16:19:16.413');
INSERT INTO public.product_images VALUES (285, 251, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJCJshmeKQ9OJMsAyClsHXuYV2ic-piYrhuQ&s', 2, false, '2025-12-31 16:19:16.413');
INSERT INTO public.product_images VALUES (286, 252, 'https://www.chuwi.com/public/upload/image/20221229/52bc2a3d58a50a2bb14171419cc30094.png', 0, true, '2025-12-31 16:19:16.427');
INSERT INTO public.product_images VALUES (287, 252, 'https://dt24h.com/wp-content/uploads/2023/09/CHUWI-HiPad-XPro-15.jpg', 1, false, '2025-12-31 16:19:16.427');
INSERT INTO public.product_images VALUES (288, 252, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxXrVcWEH0zMNdKDHucFk1c8nRWZCul9iczQ&s', 2, false, '2025-12-31 16:19:16.427');
INSERT INTO public.product_images VALUES (289, 253, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/m/a/may-tinh-bang-teclast-t50-plus_1_.png', 0, true, '2025-12-31 16:19:16.441');
INSERT INTO public.product_images VALUES (290, 253, 'https://cdn-media.sforum.vn/storage/app/media/ace%20chu%20tu/tren-tay-teclast-t50-plus/ava.jpg', 1, false, '2025-12-31 16:19:16.441');
INSERT INTO public.product_images VALUES (291, 253, 'https://en.teclast.com/cdn/shop/files/10_acd659ea-17cb-4b0f-9626-31788d36421b.jpg?v=1686395318&width=1000', 2, false, '2025-12-31 16:19:16.441');
INSERT INTO public.product_images VALUES (292, 254, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-t21_12_.png', 0, true, '2025-12-31 16:19:16.453');
INSERT INTO public.product_images VALUES (293, 254, 'https://cdn.tgdd.vn/Files/2022/09/01/1461522/nokia-t21_1280x720-800-resize.jpg', 1, false, '2025-12-31 16:19:16.453');
INSERT INTO public.product_images VALUES (294, 254, 'https://cdn.tgdd.vn/Files/2023/03/21/1519337/a2-210323-065518-800-resize.jpg', 2, false, '2025-12-31 16:19:16.453');
INSERT INTO public.product_images VALUES (295, 255, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/r/e/realme-pad-2.png', 0, true, '2025-12-31 16:19:16.466');
INSERT INTO public.product_images VALUES (296, 255, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqxAYc62sIRw4x-H53FnJVbOo3suSyy4p22w&s', 1, false, '2025-12-31 16:19:16.466');
INSERT INTO public.product_images VALUES (297, 255, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlPuADAMojDUV_RmBf3lBhZtraWG6z1NgXuA&s', 2, false, '2025-12-31 16:19:16.466');
INSERT INTO public.product_images VALUES (298, 256, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-pad-air-128gb.jpg', 0, true, '2025-12-31 16:19:16.477');
INSERT INTO public.product_images VALUES (299, 256, 'https://cdn.tgdd.vn/Products/Images/522/281821/Slider/oppo-pad-air-thumb-YT-1020x570.jpg', 1, false, '2025-12-31 16:19:16.477');
INSERT INTO public.product_images VALUES (300, 256, 'https://cdn.tgdd.vn/Products/Images/522/281821/oppo-pad-air-1-1-750x500.jpg', 2, false, '2025-12-31 16:19:16.477');
INSERT INTO public.product_images VALUES (301, 257, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/v/i/vivo-pad-2_2_.jpg', 0, true, '2025-12-31 16:19:16.49');
INSERT INTO public.product_images VALUES (302, 257, 'https://cdn.tgdd.vn//News/0//vivo-pad-2-ra-mat-lo-dien-3-730x408.jpg', 1, false, '2025-12-31 16:19:16.49');
INSERT INTO public.product_images VALUES (303, 257, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkgzolOndfQzUnYtzWEdLdKdX6llp48SSTyQ&s', 2, false, '2025-12-31 16:19:16.49');
INSERT INTO public.product_images VALUES (304, 258, 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/Huawei-Matepad-Pro-13.9-3.jpg', 0, true, '2025-12-31 16:19:16.503');
INSERT INTO public.product_images VALUES (305, 258, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_48_20.jpg', 1, false, '2025-12-31 16:19:16.503');
INSERT INTO public.product_images VALUES (306, 258, 'https://cdn.tgdd.vn/News/1558700/10-1280x720.jpg', 2, false, '2025-12-31 16:19:16.503');
INSERT INTO public.product_images VALUES (307, 259, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/may-tinh-bang-honor-pad-9-pro_3_.png', 0, true, '2025-12-31 16:19:16.517');
INSERT INTO public.product_images VALUES (308, 259, 'https://cdn.tgdd.vn/News/0/d-1280x720.jpg', 1, false, '2025-12-31 16:19:16.517');
INSERT INTO public.product_images VALUES (309, 259, 'https://www.notebookcheck.net/fileadmin/_processed_/a/a/csm_20240315_144254_5048161306.jpg', 2, false, '2025-12-31 16:19:16.517');
INSERT INTO public.product_images VALUES (310, 260, 'https://mac24h.vn/images/companies/1/12inch%20rose/Macbook%2012%20inch%20gold/macminipost.png?1598064081104', 0, true, '2025-12-31 16:19:16.528');
INSERT INTO public.product_images VALUES (311, 260, 'https://macone.vn/wp-content/uploads/2023/01/m2-mac-mini-copy.jpg', 1, false, '2025-12-31 16:19:16.528');
INSERT INTO public.product_images VALUES (312, 260, 'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2023/03/Mac-mini-2023-2.jpg', 2, false, '2025-12-31 16:19:16.528');
INSERT INTO public.product_images VALUES (313, 261, 'https://cdn2.cellphones.com.vn/200x/media/catalog/product/m/a/macbook_33_.png', 0, true, '2025-12-31 16:19:16.541');
INSERT INTO public.product_images VALUES (314, 261, 'https://macone.vn/wp-content/uploads/2023/02/mac-mini-m2-pro.png', 1, false, '2025-12-31 16:19:16.541');
INSERT INTO public.product_images VALUES (315, 261, 'https://cdn.tgdd.vn/Files/2023/01/20/1504319/macminitrolaimanhmehonkhiduoctrangbichipapplem2pro_1280x720-800-resize.jpg', 2, false, '2025-12-31 16:19:16.541');
INSERT INTO public.product_images VALUES (316, 262, 'https://product.hstatic.net/200000348419/product/mac_studio_m2_max_2023_chinh_hang_21aed22940d54b5f8c6bc1e92f721ab1_large.png', 0, true, '2025-12-31 16:19:16.557');
INSERT INTO public.product_images VALUES (317, 262, 'https://shopdunk.com/images/thumbs/0018104_mac-studio-m2-max.jpeg', 1, false, '2025-12-31 16:19:16.557');
INSERT INTO public.product_images VALUES (318, 262, 'https://laptop15.vn/wp-content/uploads/2023/08/Mac-Studio-M1-Max-1.png', 2, false, '2025-12-31 16:19:16.557');
INSERT INTO public.product_images VALUES (319, 263, 'https://macstores.vn/wp-content/uploads/2023/06/mac-studio-m2-4.jpg', 0, true, '2025-12-31 16:19:16.571');
INSERT INTO public.product_images VALUES (320, 263, 'https://macmall.vn/uploads/screen_shot_2024-06-05_at_16_1717580424.29.17.png', 1, false, '2025-12-31 16:19:16.571');
INSERT INTO public.product_images VALUES (321, 263, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHReyPkahn7iL_EZFqHxA9DqTBiow747DXHg&s', 2, false, '2025-12-31 16:19:16.571');
INSERT INTO public.product_images VALUES (322, 264, 'https://shopdunk.com/images/thumbs/0022756_imac-m3-2023-24-inch-8-core-gpu8gb256gb.jpeg', 0, true, '2025-12-31 16:19:16.583');
INSERT INTO public.product_images VALUES (323, 264, 'https://www.apple.com/newsroom/images/2023/10/apple-supercharges-24-inch-imac-with-new-m3-chip/article/Apple-iMac-M3-colors-231030_big.jpg.large.jpg', 1, false, '2025-12-31 16:19:16.583');
INSERT INTO public.product_images VALUES (324, 264, 'https://mac24h.vn/images/companies/1/phu%CC%A3%20kie%CC%A3%CC%82n/Hyperdrive/imac%2024%20inch/IMAC%2024%20INCH.jpg?1718860710656', 2, false, '2025-12-31 16:19:16.583');
INSERT INTO public.product_images VALUES (325, 265, 'https://www.laptopvip.vn/images/ab__webp/detailed/10/dell-xps-27.webp', 0, true, '2025-12-31 16:19:16.594');
INSERT INTO public.product_images VALUES (326, 265, 'https://khoavang.vn/resources/cache/800xx1/data/dell/DEll-G5-5090/Dell-XPS-8940--4-1633518499.webp', 1, false, '2025-12-31 16:19:16.594');
INSERT INTO public.product_images VALUES (327, 265, 'https://i.pcmag.com/imagery/reviews/061gj28ssJiSsCmgbTfUojq-6.fit_lim.size_1050x.jpg', 2, false, '2025-12-31 16:19:16.594');
INSERT INTO public.product_images VALUES (328, 266, 'https://images-na.ssl-images-amazon.com/images/I/71C+ewM2JjL.jpg', 0, true, '2025-12-31 16:19:16.607');
INSERT INTO public.product_images VALUES (329, 266, 'https://sm.pcmag.com/pcmag_me/photo/default/078fwui2ishfdtodnicyblr-6_353v.jpg', 1, false, '2025-12-31 16:19:16.607');
INSERT INTO public.product_images VALUES (330, 266, 'https://images-na.ssl-images-amazon.com/images/I/61rLBkZzFJL.jpg', 2, false, '2025-12-31 16:19:16.607');
INSERT INTO public.product_images VALUES (331, 267, 'https://kaas.hpcloud.hp.com/PROD/v2/renderbinary/7477130/5038347/con-win-dt-p-omen-45l-gt22-1009nf-product-specifications/articuno-desktop', 0, true, '2025-12-31 16:19:16.62');
INSERT INTO public.product_images VALUES (332, 267, 'https://www.tnc.com.vn/uploads/news/20220729/omen-45l-may-bo-hp-gaming-de-dang-nang-cap%202.png', 1, false, '2025-12-31 16:19:16.62');
INSERT INTO public.product_images VALUES (333, 267, 'https://cdn.mos.cms.futurecdn.net/G9H9NhYMwFL3pszTEJrctG.jpg', 2, false, '2025-12-31 16:19:16.62');
INSERT INTO public.product_images VALUES (334, 268, 'https://p2-ofp.static.pub//fes/cms/2024/11/27/em8bpvjffmescc7mck5snjp1g73otp127407.png', 0, true, '2025-12-31 16:19:16.633');
INSERT INTO public.product_images VALUES (335, 268, 'https://p4-ofp.static.pub//fes/cms/2024/02/29/pcuk3jaes0a1yst8mollyq0nt8fn2c820605.jpg', 1, false, '2025-12-31 16:19:16.633');
INSERT INTO public.product_images VALUES (336, 268, 'https://p4-ofp.static.pub//fes/cms/2025/03/28/fxl0ptkilucyo10w6zpmy4ev6cv32h744429.jpg', 2, false, '2025-12-31 16:19:16.633');
INSERT INTO public.product_images VALUES (337, 269, 'https://res.cloudinary.com/corsair-pwa/image/upload/v1684950787/products/Vengeance-PC/CS-9050047-NA/Gallery/common/Vengeance__i7400_01.webp', 0, true, '2025-12-31 16:19:16.643');
INSERT INTO public.product_images VALUES (338, 269, 'https://thegadgetflow.com/wp-content/uploads/2023/03/CORSAIR-Vengeance-i7400-Frost-Edition-Gaming-PC-01.jpg', 1, false, '2025-12-31 16:19:16.643');
INSERT INTO public.product_images VALUES (339, 269, 'https://assets.corsair.com/image/upload/c_pad,q_85,h_1100,w_1100,f_auto/products/Vengeance-PC/CS-9050062-NA/Vengeance_i7400_Frost_Edition_01.webp', 2, false, '2025-12-31 16:19:16.643');
INSERT INTO public.product_images VALUES (340, 270, 'https://asset.msi.com/resize/image/global/product/product_1669160633809914962a2cb40d02df74877b17555b.png62405b38c58fe0f07fcef2367d8a9ba1/1024.png', 0, true, '2025-12-31 16:19:16.655');
INSERT INTO public.product_images VALUES (341, 270, 'https://i.pcmag.com/imagery/reviews/032R5yzbNKqbXJAXNujVkBu-2..v1616773109.jpg', 1, false, '2025-12-31 16:19:16.655');
INSERT INTO public.product_images VALUES (342, 270, 'https://asset.msi.com/resize/image/global/product/product_164989404970502cdd1b0b28ad95c2afe110e916bf.png62405b38c58fe0f07fcef2367d8a9ba1/600.png', 2, false, '2025-12-31 16:19:16.655');
INSERT INTO public.product_images VALUES (343, 271, 'https://m.media-amazon.com/images/I/71gtoidr0kL._AC_UF894,1000_QL80_.jpg', 0, true, '2025-12-31 16:19:16.669');
INSERT INTO public.product_images VALUES (344, 271, 'https://i.ytimg.com/vi/KFxk20EoSpc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA_XaIvA9VnqC2qcK58EFAmdMrS1Q', 1, false, '2025-12-31 16:19:16.669');
INSERT INTO public.product_images VALUES (345, 271, 'https://i5.walmartimages.com/seo/Skytech-Azure-Gaming-PC-Desktop-AMD-Ryzen-7-7800X3D-NVIDIA-Geforce-RTX-5070-2TB-Gen4-NVMe-SSD-32GB-RAM-AIO-Liquid-Cooling-Windows-11_91f306ac-8b09-46f3-8570-feba113218e0.37f582a20f6174efbf56f4317992e1fe.jpeg', 2, false, '2025-12-31 16:19:16.669');
INSERT INTO public.product_images VALUES (346, 272, 'https://m.media-amazon.com/images/I/818SNa1ruZL.jpg', 0, true, '2025-12-31 16:19:16.683');
INSERT INTO public.product_images VALUES (347, 272, 'https://shopsimpletronics.com/cdn/shop/products/PhotoRoom_20220119_181729_1946x.png?v=1642637923', 1, false, '2025-12-31 16:19:16.683');
INSERT INTO public.product_images VALUES (348, 272, 'https://cdn.panacompu.com/cdn-img/pv/cyberpowerpc-gamer-supreme-v6-preview.jpg?width=550&height=400&fixedwidthheight=false', 2, false, '2025-12-31 16:19:16.683');
INSERT INTO public.product_images VALUES (349, 273, 'https://m.media-amazon.com/images/I/81xlNPKMrQL._AC_UF1000,1000_QL80_.jpg', 0, true, '2025-12-31 16:19:16.695');
INSERT INTO public.product_images VALUES (350, 273, 'https://cdn.mos.cms.futurecdn.net/JQjSid2RWWUuieqcRfCXPC.jpg', 1, false, '2025-12-31 16:19:16.695');
INSERT INTO public.product_images VALUES (351, 273, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhcE-zDY9Jo2ZkuWqohQxy1qJABibm1wrWpA&s', 2, false, '2025-12-31 16:19:16.695');
INSERT INTO public.product_images VALUES (352, 274, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/329/122/products/may-tinh-mini-pc-intel-nuc-13-extreme-kit-i7-13700k-rnuc13rngi70000-6.jpg?v=1680947667597', 0, true, '2025-12-31 16:19:16.711');
INSERT INTO public.product_images VALUES (353, 274, 'https://dlcdnwebimgs.asus.com/gain/da443026-2c2c-4101-b960-0753d97d5429/', 1, false, '2025-12-31 16:19:16.711');
INSERT INTO public.product_images VALUES (354, 274, 'https://sb.tinhte.vn/2022/11/6199989_intel-nuc-13-extreme-raptor-canyon-tinhte-2.jpg', 2, false, '2025-12-31 16:19:16.711');
INSERT INTO public.product_images VALUES (355, 275, 'https://images-na.ssl-images-amazon.com/images/I/71fOGgAce-L.jpg', 0, true, '2025-12-31 16:19:16.727');
INSERT INTO public.product_images VALUES (356, 275, 'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/HP_Envy_Desktop_Header.jpg', 1, false, '2025-12-31 16:19:16.727');
INSERT INTO public.product_images VALUES (357, 275, 'https://support.hp.com/wcc-assets/document/images/211/c05240709.jpg', 2, false, '2025-12-31 16:19:16.727');
INSERT INTO public.product_images VALUES (358, 276, 'https://cdn1615.cdn4s4.io.vn/media/products/may-tinh-de-ban/dell/inspiron/3020mt/inspiron-3020-desktop.webp', 0, true, '2025-12-31 16:19:16.743');
INSERT INTO public.product_images VALUES (359, 276, 'https://sm.pcmag.com/pcmag_au/review/d/dell-inspi/dell-inspiron-small-desktop-3471_kz9r.jpg', 1, false, '2025-12-31 16:19:16.743');
INSERT INTO public.product_images VALUES (360, 276, 'https://sieuviet.vn/hm_content/uploads/anh-san-pham/pc/dell/1_2.webp', 2, false, '2025-12-31 16:19:16.743');
INSERT INTO public.product_images VALUES (361, 277, 'https://cdn.assets.prezly.com/346d8126-820e-4ee0-8b60-a0077acee526/PREDATOR-ORION-7000-PO7-660-02.jpg', 0, true, '2025-12-31 16:19:16.758');
INSERT INTO public.product_images VALUES (362, 277, 'https://file.hstatic.net/200000722513/article/predator-orion-7000-po7-640-lifestyle-03-scaled_fa4d2f201ba4484096f0f5acbcc6fc3d.jpg', 1, false, '2025-12-31 16:19:16.758');
INSERT INTO public.product_images VALUES (363, 277, 'https://nghenhinvietnam.vn/uploads/global/quanghuy/2024/9/6/acer/nghenhin__acer-predator-orion-7000-1.jpg', 2, false, '2025-12-31 16:19:16.758');
INSERT INTO public.product_images VALUES (364, 278, 'https://nzxt.com/cdn/shop/files/Player-Three-Prime-ASUS-WW-10.14.25-HERO-WHITE-BADGE_cf7be002-234d-43e0-a2b8-c78f0a7b1844.png?v=1764659862', 0, true, '2025-12-31 16:19:16.771');
INSERT INTO public.product_images VALUES (365, 278, 'https://9to5toys.com/wp-content/uploads/sites/5/2023/03/nzxt-player-three-9.png?w=1200&h=600&crop=1', 1, false, '2025-12-31 16:19:16.771');
INSERT INTO public.product_images VALUES (366, 278, 'https://i.pcmag.com/imagery/reviews/01qbCBNLmuSqLiLmSdQY6Xk-3..v1681409799.jpg', 2, false, '2025-12-31 16:19:16.771');
INSERT INTO public.product_images VALUES (367, 279, 'https://cdn.mos.cms.futurecdn.net/HF5NFDnzAF8NDE8znsB5JJ.jpg', 0, true, '2025-12-31 16:19:16.783');
INSERT INTO public.product_images VALUES (368, 279, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR37aO6vYZv4QdS2NpI3Fu84JKk-NxP4Q9c3Q&s', 1, false, '2025-12-31 16:19:16.783');
INSERT INTO public.product_images VALUES (369, 279, 'https://petapixel.com/assets/uploads/2024/06/maingear-mg-1-angle-petapixel-front.jpg', 2, false, '2025-12-31 16:19:16.783');
INSERT INTO public.product_images VALUES (370, 280, 'https://www.originpc.com/blog/wp-content/uploads/2019/12/neuron-hero-red.jpg', 0, true, '2025-12-31 16:19:16.796');
INSERT INTO public.product_images VALUES (371, 280, 'https://cdn.originpc.com/img/pdp/gaming/desktops/neuron/neuron-3500x-uv-prints.jpg', 1, false, '2025-12-31 16:19:16.796');
INSERT INTO public.product_images VALUES (372, 280, 'https://cdn.mos.cms.futurecdn.net/Et8JN39PXwXws5SzXHpCDX.jpg', 2, false, '2025-12-31 16:19:16.796');
INSERT INTO public.product_images VALUES (373, 281, 'https://dlcdnwebimgs.asus.com/gain/95E413EB-A725-4131-82B8-FF76A880EE0D', 0, true, '2025-12-31 16:19:16.809');
INSERT INTO public.product_images VALUES (374, 281, 'https://microless.com/cdn/products/255b85a6527a4dc4fee9a1901124670b-hi.jpg', 1, false, '2025-12-31 16:19:16.809');
INSERT INTO public.product_images VALUES (375, 281, 'https://dlcdnwebimgs.asus.com/gain/F5A260D0-CB75-45E2-A632-521DDC5F28BE/w260/fwebp', 2, false, '2025-12-31 16:19:16.809');
INSERT INTO public.product_images VALUES (376, 282, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/7/1/71557.png', 0, true, '2025-12-31 16:19:16.823');
INSERT INTO public.product_images VALUES (377, 282, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/mtsp/dien-tu/smart-tivi-lg-oled-4k-55-inch-oled55c3psa.jpg', 1, false, '2025-12-31 16:19:16.823');
INSERT INTO public.product_images VALUES (378, 282, 'https://img.websosanh.vn/v2/users/root_product/images/oled-tivi-lg-4k-55-inch-55c3ps/219d335ca6184.jpg', 2, false, '2025-12-31 16:19:16.823');
INSERT INTO public.product_images VALUES (379, 283, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWKs4_XrvUIeDRFuognIRCTV-7JIUCPgwRWw&s', 0, true, '2025-12-31 16:19:16.833');
INSERT INTO public.product_images VALUES (380, 283, 'https://www.cnet.com/a/img/resize/ded6920d086391e7e24b8e8a77a64e4031a0002f/hub/2023/06/09/b3b35284-1d0c-4c27-8676-954abc2fad8a/lg-c3-oled-tv-2023-07.jpg?auto=webp&fit=crop&height=1200&width=1200', 1, false, '2025-12-31 16:19:16.833');
INSERT INTO public.product_images VALUES (381, 283, 'https://i5.walmartimages.com/asr/0680c9f0-304d-4b92-85ca-51cae212f046.5b1fc8050441bf9820a3c5922feffd9b.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF', 2, false, '2025-12-31 16:19:16.833');
INSERT INTO public.product_images VALUES (382, 284, 'https://cdn.tgdd.vn/Products/Images/1942/306581/smart-tivi-oled-lg-4k-65-inch-65g3psa-1-700x467.jpg', 0, true, '2025-12-31 16:19:16.844');
INSERT INTO public.product_images VALUES (383, 284, 'https://www.lg.com/content/dam/channel/wcms/vn/images/tivi/oled65g3psa_atv_eavh_vn_c/gallery/D-02.jpg', 1, false, '2025-12-31 16:19:16.844');
INSERT INTO public.product_images VALUES (384, 284, 'https://www.cnet.com/a/img/resize/29626605caa770187edbdec3f678249ccd8c47ff/hub/2023/08/11/e2255be8-d8c3-4d3b-ada4-07454ab16b77/lg-g3-oled-tv-2023-02.jpg?auto=webp&width=1200', 2, false, '2025-12-31 16:19:16.844');
INSERT INTO public.product_images VALUES (385, 285, 'https://images.samsung.com/is/image/samsung/p6pim/ph/qa55s90cagxxp/gallery/ph-oled-s90c-qa55s90cagxxp-536185455', 0, true, '2025-12-31 16:19:16.858');
INSERT INTO public.product_images VALUES (386, 285, 'https://nghenhinvietnam.vn/uploads/global/quanghuy/2023/21/samsung/nghenhinvietnam_tv_samsung_s90c_3.jpg', 1, false, '2025-12-31 16:19:16.858');
INSERT INTO public.product_images VALUES (387, 285, 'https://nghenhinvietnam.vn/uploads/global/quanghuy/2023/21/samsung/nghenhinvietnam_tv_samsung_s90c_1.jpg', 2, false, '2025-12-31 16:19:16.858');
INSERT INTO public.product_images VALUES (388, 286, 'https://images.samsung.com/is/image/samsung/p6pim/ae/qa65s90cauxzn/gallery/ae-oled-tv-qa65s90cauxzn-front-black-titanium-536504295', 0, true, '2025-12-31 16:19:16.87');
INSERT INTO public.product_images VALUES (389, 286, 'https://dienmay247.com.vn/wp-content/uploads/2024/01/s90c-b1-600x400-1.jpg', 1, false, '2025-12-31 16:19:16.87');
INSERT INTO public.product_images VALUES (390, 286, 'https://i.insider.com/652e8e998bed706e837e201b?width=700', 2, false, '2025-12-31 16:19:16.87');
INSERT INTO public.product_images VALUES (391, 287, 'https://images.samsung.com/is/image/samsung/p6pim/ae/qa65s90cauxzn/gallery/ae-oled-tv-qa65s90cauxzn-front-black-titanium-536504295', 0, true, '2025-12-31 16:19:16.883');
INSERT INTO public.product_images VALUES (392, 287, 'https://image.anhducdigital.vn/hightech/tivi/qn90c-2023/qn90c-5.png', 1, false, '2025-12-31 16:19:16.883');
INSERT INTO public.product_images VALUES (393, 287, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/439/998/products/qn95d-fbb22d2c-bb9b-476e-a476-dbd09e24ab69.png?v=1713174876603', 2, false, '2025-12-31 16:19:16.883');
INSERT INTO public.product_images VALUES (394, 288, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/425/687/products/1-a6f4dd7b-9abb-4656-bf44-d498e101dca2.jpg?v=1764054897643', 0, true, '2025-12-31 16:19:16.898');
INSERT INTO public.product_images VALUES (395, 288, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/g/o/google-tivi-oled-sony-xr-55a80l-4k-55-inch_8_.png', 1, false, '2025-12-31 16:19:16.898');
INSERT INTO public.product_images VALUES (396, 288, 'https://sony.scene7.com/is/image/sonyglobalsolutions/TVFY23_A80L_65_WW_0_insitu_M?$productIntroPlatemobile$&fmt=png-alpha', 2, false, '2025-12-31 16:19:16.898');
INSERT INTO public.product_images VALUES (397, 289, 'https://logico.com.vn/images/products/2023/03/23/original/a95l-2_1679544846.png', 0, true, '2025-12-31 16:19:16.913');
INSERT INTO public.product_images VALUES (398, 289, 'https://cdn.mos.cms.futurecdn.net/Lk6dCXJhznwxULbqQj8U4P.jpg', 1, false, '2025-12-31 16:19:16.913');
INSERT INTO public.product_images VALUES (399, 289, 'https://cdn.tgdd.vn/Products/Images/1942/308548/x95l-700x467.jpg', 2, false, '2025-12-31 16:19:16.913');
INSERT INTO public.product_images VALUES (400, 290, 'https://i.rtings.com/assets/products/ygyrdRw8/tcl-qm8-qm850g-qled/design-medium.jpg?format=auto', 0, true, '2025-12-31 16:19:16.932');
INSERT INTO public.product_images VALUES (401, 290, 'https://m.media-amazon.com/images/I/91WXzWVVGsL._AC_UF894,1000_QL80_.jpg', 1, false, '2025-12-31 16:19:16.932');
INSERT INTO public.product_images VALUES (402, 290, 'https://i.rtings.com/assets/products/FxuLZKva/tcl-qm8-qm851g-qled/design-medium.jpg?format=auto', 2, false, '2025-12-31 16:19:16.932');
INSERT INTO public.product_images VALUES (403, 291, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv6ocmGcD3vR2p-W45Dt85ucV7DBxbalIrJw&s', 0, true, '2025-12-31 16:19:16.944');
INSERT INTO public.product_images VALUES (404, 291, 'https://m.media-amazon.com/images/I/714LAhAd8RL._AC_UF894,1000_QL80_.jpg', 1, false, '2025-12-31 16:19:16.944');
INSERT INTO public.product_images VALUES (405, 291, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVwQCb0tg9JZAMBa5StcbMndc4rdLm2Y_Rzg&s', 2, false, '2025-12-31 16:19:16.944');
INSERT INTO public.product_images VALUES (406, 292, 'https://www.vizio.com/content/dam/vizio/us/en/images/product/2020/tvs/p-series/p65q9-h1/gallery/2020_P-Series_P65Q9-H1_Front_OS_Newsweek-Best-Holiday-Gifts-2020.jpg/_jcr_content/renditions/cq5dam.web.640.480.png', 0, true, '2025-12-31 16:19:16.96');
INSERT INTO public.product_images VALUES (407, 292, 'https://www.vizio.com/content/dam/vizio/us/en/images/product/2021/tv/p-series/p65q9-j01/gallery/2022_PQ9-Series_Carton.jpg/_jcr_content/renditions/cq5dam.web.640.480.png', 1, false, '2025-12-31 16:19:16.96');
INSERT INTO public.product_images VALUES (408, 292, 'https://www.bhphotovideo.com/images/fb/vizio_pq65_f1_p_series_quantum_65_class_1439029.jpg', 2, false, '2025-12-31 16:19:16.96');
INSERT INTO public.product_images VALUES (409, 293, 'https://image.roku.com/w/rapid/images/meta-image/51c68c6e-4f37-4204-8bfb-6c9357793922.jpg', 0, true, '2025-12-31 16:19:16.977');
INSERT INTO public.product_images VALUES (410, 293, 'https://www.cnet.com/a/img/resize/c7d369847505bec9468fc04f16d71a96658cbe6e/hub/2023/04/06/cb4769b9-48d9-4b08-93bd-ff961575aaa4/roku-tv-23-02.jpg?auto=webp&width=1200', 1, false, '2025-12-31 16:19:16.977');
INSERT INTO public.product_images VALUES (411, 293, 'https://m.media-amazon.com/images/I/711mObDMN1L._AC_UF894,1000_QL80_.jpg', 2, false, '2025-12-31 16:19:16.977');
INSERT INTO public.product_images VALUES (412, 294, 'https://m.media-amazon.com/images/I/61wsF9lZJmL._AC_UF1000,1000_QL80_.jpg', 0, true, '2025-12-31 16:19:16.991');
INSERT INTO public.product_images VALUES (413, 294, 'https://m.media-amazon.com/images/I/81JIfxZb14L._AC_UF1000,1000_QL80_.jpg', 1, false, '2025-12-31 16:19:16.991');
INSERT INTO public.product_images VALUES (414, 294, 'https://m.media-amazon.com/images/G/01/kindle/journeys/RLLnvZrYJrpztidamPzsM2FUe2FYBetwtpWHnjNYR6l9g3D/Mzc4NDUwYjct._CB608418078_.jpg', 2, false, '2025-12-31 16:19:16.991');
INSERT INTO public.product_images VALUES (415, 295, 'https://www.lg.com/content/dam/channel/wcms/th/oled-tv/2023/b3-pdp-update/gallery/55-b3-a/TV-OLED-55-B3-A-Gallery-01.jpg/jcr:content/renditions/thum-1600x1062.jpeg', 0, true, '2025-12-31 16:19:17.01');
INSERT INTO public.product_images VALUES (416, 295, 'https://www.lg.com/content/dam/channel/wcms/sg/images/tv/features/oled2023/TV-OLED-B3-02-Intro-Visual-Mobile.jpg', 1, false, '2025-12-31 16:19:17.01');
INSERT INTO public.product_images VALUES (417, 295, 'https://cdn.nguyenkimmall.com/images/detailed/874/10055510-smart-tivi-oled-lg-4k-55-inch-oled55g3psa-2.jpg', 2, false, '2025-12-31 16:19:17.01');
INSERT INTO public.product_images VALUES (418, 296, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/322680/tivi-qled-khung-tranh-samsung-4k-55-inch-qa55ls03d-1-638691037685437659-700x467.jpg', 0, true, '2025-12-31 16:19:17.023');
INSERT INTO public.product_images VALUES (419, 296, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/h/thi_t_k_ch_a_c_t_n_6__1.png', 1, false, '2025-12-31 16:19:17.023');
INSERT INTO public.product_images VALUES (420, 296, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/k/q/kq75lsb03afxkr_009_l-perspective1_black_2_1_2.png', 2, false, '2025-12-31 16:19:17.023');
INSERT INTO public.product_images VALUES (421, 297, 'https://sony.scene7.com/is/image/sonyglobalsolutions/TVFY23_X90L_65_12_Beauty_I_M-1?$productIntroPlatemobile$&fmt=png-alpha', 0, true, '2025-12-31 16:19:17.041');
INSERT INTO public.product_images VALUES (422, 297, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/mtsp/dien-tu/chan-de-tivi-sony-xr65x90l.jpg', 1, false, '2025-12-31 16:19:17.041');
INSERT INTO public.product_images VALUES (423, 297, 'https://sonyimages.blob.core.windows.net/productr/large/XR65X90LU_0.png', 2, false, '2025-12-31 16:19:17.041');
INSERT INTO public.product_images VALUES (424, 298, 'https://m.media-amazon.com/images/I/91ESqVq-i3L.jpg', 0, true, '2025-12-31 16:19:17.059');
INSERT INTO public.product_images VALUES (425, 298, 'https://www.skyit-tt.com/wp-content/uploads/2022/11/91Zihsc0coL._AC_SL1500_.jpg', 1, false, '2025-12-31 16:19:17.059');
INSERT INTO public.product_images VALUES (426, 298, 'https://www.cnet.com/a/img/resize/5b1159c61c0eaa5d3a38cba6a09b74f30de67c69/hub/2020/09/10/e78939f6-20b4-4f42-b9ef-03c1c618cca8/04-tcl-6-series-2020-65r635.jpg?auto=webp&width=768', 2, false, '2025-12-31 16:19:17.059');
INSERT INTO public.product_images VALUES (427, 299, 'https://cdn.nguyenkimmall.com/images/detailed/898/10056785-google-tivi-mini-uled-hisense-4k-55inch-55u7k-1_o1mh-t9.jpg', 0, true, '2025-12-31 16:19:17.072');
INSERT INTO public.product_images VALUES (428, 299, 'https://cdn.tgdd.vn/Products/Images/1942/321449/tivi-uled-4k-hisense-55u7k-700x467.jpg', 1, false, '2025-12-31 16:19:17.072');
INSERT INTO public.product_images VALUES (429, 299, 'https://vcdn1-sohoa.vnecdn.net/2023/10/27/DSC06576-1698420432.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=sKQ-0Utr5YPRwFAyh-COhA', 2, false, '2025-12-31 16:19:17.072');
INSERT INTO public.product_images VALUES (430, 300, 'https://images.samsung.com/is/image/samsung/p6pim/africa_en/ua43cu7000uxly/gallery/africa-en-crystal-uhd-cu7000-ua43cu7000uxly-536771150?$Q90_1248_936_F_PNG$', 0, true, '2025-12-31 16:19:17.085');
INSERT INTO public.product_images VALUES (431, 300, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/Tivi/Samsung/43-inch/smart-tivi-samsung-uhd-43du7000-4k-43-inch-2024-1.jpg', 1, false, '2025-12-31 16:19:17.085');
INSERT INTO public.product_images VALUES (432, 300, 'https://cdn.nguyenkimmall.com/images/thumbnails/290/235/detailed/1163/10057637-Smart_Tivi_Samsung_4K_43_inch_UA43DU7000KXXV__1_.jpg', 2, false, '2025-12-31 16:19:17.085');
INSERT INTO public.product_images VALUES (433, 301, 'https://m.media-amazon.com/images/I/91MAjR2HydL._AC_UF894,1000_QL80_.jpg', 0, true, '2025-12-31 16:19:17.098');
INSERT INTO public.product_images VALUES (434, 301, 'https://m.media-amazon.com/images/I/519kS8lWBeL._AC_UF894,1000_QL80_.jpg', 1, false, '2025-12-31 16:19:17.098');
INSERT INTO public.product_images VALUES (435, 301, 'https://cdn.mos.cms.futurecdn.net/kWbKLdF6AktQ8JkHqUBpRQ.jpg', 2, false, '2025-12-31 16:19:17.098');
INSERT INTO public.product_images VALUES (436, 302, 'https://cdn.tgdd.vn/Products/Images/1942/274763/android-sony-4k-43-inch-kd-43x80k-180322-024040-550x340.png', 0, true, '2025-12-31 16:19:17.11');
INSERT INTO public.product_images VALUES (437, 302, 'https://cdn.tgdd.vn/Products/Images/1942/274763/android-sony-4k-43-inch-kd-43x80k-240322-025758.jpg', 1, false, '2025-12-31 16:19:17.11');
INSERT INTO public.product_images VALUES (438, 302, 'https://bizweb.dktcdn.net/thumb/grande/100/475/305/products/thumbnails-large-asset-plus-hierarchy-consumer-plus-assets-television-plus-assets-braviaa-plus-lcd-plus-hdtv-fy-plus-22-x80k-ecomm-plus-images-43-50-7-plus-frame-png-d40b5cae-a437-4294-a0b6-45b42d8d346f.png?v=1672991042467', 2, false, '2025-12-31 16:19:17.11');
INSERT INTO public.product_images VALUES (439, 303, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROQ3i7h3R7eF4Sa0DPzsRNbrnLnJ0CMH0mCQ&s', 0, true, '2025-12-31 16:19:17.123');
INSERT INTO public.product_images VALUES (440, 303, 'https://images-na.ssl-images-amazon.com/images/I/91uarXXZ7LL.jpg', 1, false, '2025-12-31 16:19:17.123');
INSERT INTO public.product_images VALUES (441, 303, 'https://images.techeblog.com/wp-content/uploads/2023/06/24131916/insignia-50-inch-class-f30-series-led-4k-smart-fire-tv-2023.jpg', 2, false, '2025-12-31 16:19:17.123');
INSERT INTO public.product_images VALUES (442, 304, 'https://cdn.tgdd.vn/Products/Images/1942/297318/google-tivi-toshiba-4k-43-inch-43c350lp-10-550x340.jpg', 0, true, '2025-12-31 16:19:17.134');
INSERT INTO public.product_images VALUES (443, 304, 'https://cdn.tgdd.vn/Products/Images/1942/341417/Slider/smart-tivi-toshiba-ai-4k-43-inch-43c350rp638978437940164200.jpg', 1, false, '2025-12-31 16:19:17.134');
INSERT INTO public.product_images VALUES (444, 304, 'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/5db66e97-e393-4016-bdd1-f92f2c655af2.png;maxHeight=1920;maxWidth=900?format=webp', 2, false, '2025-12-31 16:19:17.134');
INSERT INTO public.product_images VALUES (445, 305, 'https://thegioithietbiso.com/data/product/rvo1714620647.jpg', 0, true, '2025-12-31 16:19:17.15');
INSERT INTO public.product_images VALUES (446, 305, 'https://www.lg.com/content/dam/channel/wcms/uk/images/tvs-soundbars/oled-evo/oled2024/c4/features/oled-c4-16-ultra-slim-design-m.jpg', 1, false, '2025-12-31 16:19:17.15');
INSERT INTO public.product_images VALUES (447, 305, 'https://i5.walmartimages.com/asr/7e1c6b5a-39b4-467a-bbac-fd344d24dd92.54897e0cb4b954bb57b10b349fc57d7f.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF', 2, false, '2025-12-31 16:19:17.15');
INSERT INTO public.product_images VALUES (448, 306, 'https://images.samsung.com/is/image/samsung/p6pim/vn/qa65s95dakxxv/gallery/vn-oled-s95d-qa65s95dakxxv-thumb-540978937', 0, true, '2025-12-31 16:19:17.163');
INSERT INTO public.product_images VALUES (449, 306, 'https://vcdn1-sohoa.vnecdn.net/2024/08/06/DSC00528-1722936628.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=oyFyac-HLq1Qk6AcQldsKA', 1, false, '2025-12-31 16:19:17.163');
INSERT INTO public.product_images VALUES (450, 306, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture/News/News_expe_10229/10229.png?version=220712', 2, false, '2025-12-31 16:19:17.163');
INSERT INTO public.product_images VALUES (451, 307, 'https://sony.scene7.com/is/image/sonyglobalsolutions/TVFY24_UP_1_FrontWithStand_M?$productIntroPlatemobile$&fmt=png-alpha', 0, true, '2025-12-31 16:19:17.175');
INSERT INTO public.product_images VALUES (452, 307, 'https://m.media-amazon.com/images/I/81i2PtSHrwL._AC_UF1000,1000_QL80_.jpg', 1, false, '2025-12-31 16:19:17.175');
INSERT INTO public.product_images VALUES (453, 307, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8oOMmm770XjCFbyNSMPnSoTnZcGFKDUqvCQ&s', 2, false, '2025-12-31 16:19:17.175');
INSERT INTO public.product_images VALUES (454, 308, 'https://sm.pcmag.com/t/pcmag_au/review/t/tcl-qm8-cl/tcl-qm8-class-75-inch-tv-75qm851g_m1j9.1920.jpg', 0, true, '2025-12-31 16:19:17.187');
INSERT INTO public.product_images VALUES (455, 308, 'https://cdn-fastly.ce-sphere.com/media/2024/07/09/12261/post.jpg?size=720x845&nocrop=1', 1, false, '2025-12-31 16:19:17.187');
INSERT INTO public.product_images VALUES (456, 308, 'https://www.flatpanelshd.com/pictures/tcl_qm851g_tvd.jpg', 2, false, '2025-12-31 16:19:17.187');


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.products VALUES (229, 'HP Pavilion 15', 'Reliable daily driver, Bang & Olufsen audio.', 'HP-PAV-15', '35937177995', 649.00, 500.00, 18, 5, 15, true, 1, '2025-12-31 16:19:16.111', '2026-01-07 02:18:52.951');
INSERT INTO public.products VALUES (197, 'iPad (9th Gen) 64GB', 'A13 Bionic, 10.2-inch Retina display, Touch ID.', 'IPD-9-64', '911340144642', 329.00, 250.00, 38, 5, 14, true, 1, '2025-12-31 16:19:15.533', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (289, 'Sony Bravia XR A95L 65"', 'QD-OLED flagship, XR Triluminos Max.', 'SONY-A95L-65', '429001349475', 3499.00, 2800.00, 54, 5, 18, true, 4, '2025-12-31 16:19:16.913', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (282, 'LG C3 OLED 55"', 'OLED evo, Alpha 9 Gen 6 Processor, Dolby Vision.', 'LG-C3-55', '532617722428', 1499.00, 1100.00, 52, 5, 18, true, 4, '2025-12-31 16:19:16.823', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (261, 'Mac Mini M2 Pro', 'M2 Pro chip, 4x Thunderbolt 4 ports.', 'MAC-MINI-M2P', '792876508432', 1299.00, 1000.00, 6, 5, 17, true, 4, '2025-12-31 16:19:16.541', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (200, 'iPad Pro 11 M1 128GB Refurb', 'Refurbished M1 performance, ProMotion.', 'IPD-PRO11-M1-REF', '447839380867', 699.00, 550.00, 20, 5, 14, true, 2, '2025-12-31 16:19:15.605', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (231, 'Lenovo IdeaPad 3', 'Entry level, 15.6-inch FHD, privacy shutter.', 'LEN-IDEA-3', '243340944131', 449.00, 350.00, 27, 5, 15, true, 3, '2025-12-31 16:19:16.14', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (195, 'iPad (10th Gen) 64GB', 'All-screen design, 10.9-inch display, A14 Bionic.', 'IPD-10-64', '581894021442', 449.00, 350.00, 21, 5, 14, true, 2, '2025-12-31 16:19:15.497', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (224, 'MSI Stealth 16 Studio', 'Gaming and Creator laptop, RTX 4060, 240Hz.', 'MSI-ST-16', '191515903691', 1999.00, 1600.00, 49, 5, 15, true, 5, '2025-12-31 16:19:16.044', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (157, 'iPhone 15 Pro Max 256GB', 'Titanium design, A17 Pro chip, 48MP Main camera.', 'IPH-15PM-256', '571058535733', 1199.00, 900.00, 16, 5, 13, true, 2, '2025-12-31 16:19:14.879', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (243, 'Lenovo Tab P12 Pro', '12.6-inch AMOLED 120Hz, Snapdragon 870.', 'LEN-P12-PRO', '64056073248', 699.00, 500.00, 11, 5, 16, true, 5, '2025-12-31 16:19:16.313', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (247, 'Lenovo Tab M10 Plus', '10.6-inch 2K IPS, Reading mode.', 'LEN-M10-PLS', '200001752068', 189.00, 130.00, 14, 5, 16, true, 2, '2025-12-31 16:19:16.365', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (196, 'iPad (10th Gen) 256GB', 'Colorful design, Landscape Ultra Wide front camera.', 'IPD-10-256', '821747787561', 599.00, 480.00, 5, 5, 14, true, 0, '2025-12-31 16:19:15.518', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (198, 'iPad (9th Gen) 256GB', 'Essential iPad experience with extra storage.', 'IPD-9-256', '145958233458', 479.00, 380.00, 40, 5, 14, true, 0, '2025-12-31 16:19:15.555', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (218, 'Asus ZenBook Duo 14', 'Dual screen laptop for productivity.', 'ASUS-ZEN-14', '495986586160', 1299.00, 950.00, 19, 5, 15, true, 0, '2025-12-31 16:19:15.955', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (203, 'iPad Pro 12.9 (2020) Used', 'Used condition, A12Z Bionic, LiDAR Scanner.', 'IPD-PRO12-2020', '921306313205', 600.00, 450.00, 37, 5, 14, true, 0, '2025-12-31 16:19:15.683', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (240, 'Samsung Galaxy Tab S9 FE', 'Fan Edition, 10.9-inch LCD, 90Hz.', 'SAM-S9-FE', '78098238989', 449.00, 340.00, 9, 5, 16, true, 0, '2025-12-31 16:19:16.275', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (241, 'Google Pixel Tablet', 'Includes Charging Speaker Dock, Tensor G2.', 'GOO-PIX-TAB', '5232337604', 499.00, 380.00, 35, 5, 16, true, 0, '2025-12-31 16:19:16.288', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (242, 'OnePlus Pad', '11.61-inch 144Hz display, 67W fast charging.', 'ONE-PAD', '80227081081', 479.00, 360.00, 20, 5, 16, true, 0, '2025-12-31 16:19:16.299', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (263, 'Mac Studio M2 Ultra', 'The most powerful Mac silicon ever.', 'MAC-STUDIO-ULT', '5518576462', 3999.00, 3200.00, 51, 5, 17, true, 0, '2025-12-31 16:19:16.571', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (264, 'iMac 24" M3', 'All-in-one, 4.5K Retina display, Color-matched accessories.', 'IMAC-24-M3', '936556816520', 1299.00, 1000.00, 22, 5, 17, true, 0, '2025-12-31 16:19:16.583', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (249, 'Samsung Galaxy Tab S8+ Refurb', 'Refurbished Super AMOLED display.', 'SAM-S8-PLS-REF', '881520355742', 699.00, 500.00, 50, 5, 16, true, 0, '2025-12-31 16:19:16.389', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (254, 'Nokia T21', 'Tough built, 10.4-inch 2K display, 3 days battery.', 'NOK-T21', '848961820002', 239.00, 170.00, 28, 5, 16, true, 0, '2025-12-31 16:19:16.453', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (259, 'Honor Pad 9', '12.1-inch Paper-like display protection.', 'HON-PAD-9', '159930447789', 349.00, 250.00, 26, 5, 16, true, 0, '2025-12-31 16:19:16.517', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (260, 'Mac Mini M2', 'M2 chip, 8-core CPU, 10-core GPU.', 'MAC-MINI-M2', '676442373795', 599.00, 450.00, 23, 5, 17, true, 0, '2025-12-31 16:19:16.528', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (268, 'Lenovo Legion Tower 7i', 'Coldfront 4.0 cooling, Core i9 K-series.', 'LEN-LEG-T7', '872328112314', 2299.00, 1800.00, 11, 5, 17, true, 0, '2025-12-31 16:19:16.633', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (274, 'Intel NUC 13 Extreme', 'Tiny footprint, Supports full-size GPU.', 'INT-NUC-13', '533327444805', 1499.00, 1150.00, 5, 5, 17, true, 0, '2025-12-31 16:19:16.711', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (213, 'MacBook Air M2 13"', 'M2 chip, Redesigned chassis, MagSafe charging.', 'MAC-AIR-M2-13', '35427250127', 999.00, 750.00, 41, 5, 15, true, 5, '2025-12-31 16:19:15.875', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (234, 'HP OmniBook Ultra Flip', 'AI-ready 2-in-1, 3K OLED, haptic touchpad.', 'HP-OMNI-FLIP', '203186702212', 1449.00, 1150.00, 42, 5, 15, true, 1, '2025-12-31 16:19:16.195', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (293, 'Roku Plus Series TV 55"', 'Built-in Roku OS, QLED, Voice Remote Pro.', 'ROKU-PLS-55', '806911294620', 499.00, 380.00, 25, 5, 18, true, 1, '2025-12-31 16:19:16.977', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (248, 'Samsung Galaxy Tab S8 Ultra Refurb', 'Refurbished 14.6-inch giant tablet.', 'SAM-S8-ULT-REF', '956221569952', 899.00, 650.00, 36, 5, 16, true, 1, '2025-12-31 16:19:16.376', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (301, 'LG UR9000 50"', '4K UHD, HDR10 Pro, Magic Remote.', 'LG-UR9-50', '615429246411', 399.00, 300.00, 38, 5, 18, true, 2, '2025-12-31 16:19:17.098', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (256, 'Oppo Pad Air', 'Ultra thin 6.9mm, Snapdragon 680.', 'OPP-PAD-A', '274677875234', 299.00, 220.00, 31, 5, 16, true, 1, '2025-12-31 16:19:16.477', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (186, 'iPad Pro 12.9 M2 128GB', 'M2 chip, Liquid Retina XDR mini-LED display.', 'IPD-PRO12-M2-128', '492527188370', 1099.00, 850.00, 15, 5, 14, true, 1, '2025-12-31 16:19:15.348', '2026-01-07 02:18:52.958');
INSERT INTO public.products VALUES (199, 'iPad Pro 12.9 M1 128GB Refurb', 'Refurbished M1 Powerhouse, XDR display.', 'IPD-PRO12-M1-REF', '347104404467', 899.00, 700.00, 13, 5, 14, true, 6, '2025-12-31 16:19:15.57', '2026-01-07 02:18:52.958');
INSERT INTO public.products VALUES (237, 'Samsung Galaxy Tab S9 Ultra', '14.6-inch Dynamic AMOLED 2X, S Pen included.', 'SAM-S9-ULT', '36668459993', 1199.00, 900.00, 9, 5, 16, true, 2, '2025-12-31 16:19:16.238', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (163, 'iPhone 15 Plus 256GB', 'Large 6.7-inch display with extra storage capacity.', 'IPH-15PL-256', '854738333798', 999.00, 800.00, 41, 5, 13, true, 2, '2025-12-31 16:19:14.996', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (205, 'iPad (8th Gen) 32GB Used', 'Used condition, A12 Bionic, Apple Pencil 1 support.', 'IPD-8-USED', '332897182730', 200.00, 150.00, 10, 5, 14, true, 0, '2025-12-31 16:19:15.733', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (206, 'iPad Air 3 64GB Used', 'Used condition, A12 Bionic, Laminated display.', 'IPD-AIR3-USED', '374562154994', 250.00, 180.00, 11, 5, 14, true, 0, '2025-12-31 16:19:15.753', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (207, 'iPad Pro 10.5 Used', 'Used condition, A10X Fusion, ProMotion.', 'IPD-PRO105-USED', '622015938229', 220.00, 150.00, 25, 5, 14, true, 0, '2025-12-31 16:19:15.771', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (210, 'MacBook Air M3 15"', 'M3 chip, 15.3-inch Liquid Retina, Super thin.', 'MAC-AIR-M3-15', '602762064460', 1299.00, 1000.00, 23, 5, 15, true, 0, '2025-12-31 16:19:15.829', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (211, 'MacBook Pro 14 M3', 'M3 chip, 14-inch XDR display, Space Gray.', 'MAC-PRO-14-M3', '723993597684', 1599.00, 1250.00, 9, 5, 15, true, 0, '2025-12-31 16:19:15.845', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (217, 'HP Spectre x360 14', '2-in-1 Convertible, OLED display, 9MP camera.', 'HP-SPEC-14', '930205479800', 1499.00, 1150.00, 35, 5, 15, true, 0, '2025-12-31 16:19:15.939', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (287, 'Samsung QN90C Neo QLED 65"', 'Mini LED, Anti-Glare, Ultra Viewing Angle.', 'SAM-QN90C-65', '593606413080', 2199.00, 1700.00, 34, 5, 18, true, 0, '2025-12-31 16:19:16.883', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (290, 'TCL QM8 Mini-LED 65"', '2000+ local dimming zones, 2000 nits peak brightness.', 'TCL-QM8-65', '884893351084', 1199.00, 900.00, 23, 5, 18, true, 0, '2025-12-31 16:19:16.932', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (306, 'Samsung S95D OLED 65"', 'Glare-free OLED technology, NQ4 AI Gen2 Processor, up to 144Hz refresh rate.', 'SAM-S95D-65', '976986963214', 2399.00, 1850.00, 31, 5, 18, true, 0, '2025-12-31 16:19:17.163', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (308, 'TCL QM851G Mini-LED 75"', 'High-end Mini-LED with 5000+ nits peak brightness and 144Hz VRR.', 'TCL-QM851-75', '987714938832', 1499.00, 1100.00, 45, 5, 18, true, 0, '2025-12-31 16:19:17.187', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (189, 'iPad Pro 11 M2 128GB', 'M2 chip, 11-inch Liquid Retina display.', 'IPD-PRO11-M2-128', '666984651558', 799.00, 600.00, 5, 5, 14, true, 0, '2025-12-31 16:19:15.395', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (191, 'iPad Air 5 M1 64GB', 'M1 chip, 10.9-inch Liquid Retina, 5G capable.', 'IPD-AIR5-64', '36017640767', 599.00, 450.00, 34, 5, 14, true, 0, '2025-12-31 16:19:15.43', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (158, 'iPhone 15 Pro Max 512GB', 'Titanium design, A17 Pro chip, massive 512GB storage.', 'IPH-15PM-512', '541081801970', 1399.00, 1000.00, 12, 5, 13, true, 0, '2025-12-31 16:19:14.923', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (159, 'iPhone 15 Pro Max 1TB', 'Titanium design, A17 Pro chip, ultimate 1TB storage.', 'IPH-15PM-1TB', '498639203645', 1599.00, 1200.00, 26, 5, 13, true, 0, '2025-12-31 16:19:14.937', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (160, 'iPhone 15 Pro 128GB', '6.1-inch Super Retina XDR display, ProMotion technology.', 'IPH-15P-128', '978029603990', 999.00, 750.00, 32, 5, 13, true, 0, '2025-12-31 16:19:14.948', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (166, 'iPhone 14 Pro Max 128GB', 'Always-On display, Dynamic Island, 48MP Main camera.', 'IPH-14PM-128', '868207111002', 1099.00, 850.00, 28, 5, 13, true, 0, '2025-12-31 16:19:15.044', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (167, 'iPhone 14 Pro 128GB', '6.1-inch display, A16 Bionic, Crash Detection.', 'IPH-14P-128', '411455959608', 999.00, 750.00, 44, 5, 13, true, 0, '2025-12-31 16:19:15.06', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (184, 'iPhone 16 128GB', '6.1-inch display, A18 chip, Action button, dual-camera system.', 'IPH-16-128', '775903487662', 799.00, 620.00, 30, 5, 13, true, 3, '2025-12-31 16:19:15.322', '2026-01-07 02:18:52.95');
INSERT INTO public.products VALUES (292, 'Vizio P-Series Quantum 65"', 'QLED color, Active Full Array backlight.', 'VIZ-PQ-65', '883546932657', 999.00, 750.00, 37, 5, 18, true, 1, '2025-12-31 16:19:16.96', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (271, 'Skytech Azure Gaming PC', 'RTX 4070, 1TB NVMe, Mesh front panel.', 'SKY-AZU-GM', '940922511319', 1599.00, 1200.00, 28, 5, 17, true, 2, '2025-12-31 16:19:16.669', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (273, 'iBuyPower SlateMesh', 'High airflow mesh, RTX 4060 Ti.', 'IBP-SLA-MSH', '120630221493', 1399.00, 1000.00, 19, 5, 17, true, 4, '2025-12-31 16:19:16.695', '2026-01-07 02:18:52.951');
INSERT INTO public.products VALUES (269, 'Corsair Vengeance i7400', 'High-airflow case, iCUE RGB lighting.', 'COR-VEN-I7', '950950747732', 2899.00, 2300.00, 14, 5, 17, true, 1, '2025-12-31 16:19:16.643', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (280, 'Origin PC Neuron', 'Custom boutique build, UV printed glass option.', 'ORG-NEURON', '461496495286', 2599.00, 2100.00, 10, 5, 17, true, 4, '2025-12-31 16:19:16.796', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (235, 'ASUS ROG Zephyrus G14', 'OLED Nebula Display, RTX 4060, ultra-portable gaming.', 'ASUS-ROG-G14-24', '132824640447', 1599.00, 1300.00, 29, 5, 15, true, 2, '2025-12-31 16:19:16.211', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (161, 'iPhone 15 Pro 256GB', '6.1-inch display, A17 Pro chip, USB-C connector.', 'IPH-15P-256', '969510976476', 1099.00, 850.00, 48, 5, 13, true, 1, '2025-12-31 16:19:14.963', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (164, 'iPhone 15 128GB', 'Dynamic Island, 48MP Main camera, USB-C.', 'IPH-15-128', '254822030941', 799.00, 600.00, 24, 5, 13, true, 1, '2025-12-31 16:19:15.012', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (185, 'iPhone 16e 128GB', '2025 budget model, A18 chip, single "2-in-1" camera, Apple Intelligence support.', 'IPH-16E-128', '562685945480', 599.00, 450.00, 26, 5, 13, true, 1, '2025-12-31 16:19:15.336', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (215, 'Dell XPS 15 OLED', '3.5K OLED, RTX 4050, Intel Core i9.', 'DELL-XPS-15', '158991607323', 1899.00, 1500.00, 30, 5, 15, true, 3, '2025-12-31 16:19:15.909', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (178, 'iPhone XS Max 64GB Used', 'Pre-owned, Super Retina OLED display.', 'IPH-XSM-USED', '445166937726', 300.00, 200.00, 49, 5, 13, true, 5, '2025-12-31 16:19:15.238', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (228, 'Dell Inspiron 15', 'Budget friendly, AMD Ryzen 5, 15.6-inch.', 'DELL-INS-15', '836577374700', 599.00, 450.00, 16, 5, 15, true, 2, '2025-12-31 16:19:16.095', '2026-01-07 02:18:52.958');
INSERT INTO public.products VALUES (177, 'iPhone 12 Pro Max 128GB Refurb', 'Certified Refurbished, Largest display.', 'IPH-12PM-REF', '294296336755', 650.00, 500.00, 46, 5, 13, true, 5, '2025-12-31 16:19:15.224', '2026-01-07 02:18:52.958');
INSERT INTO public.products VALUES (270, 'MSI Aegis RS', 'Esports ready, Standard components for upgradability.', 'MSI-AEGIS', '830148820373', 1899.00, 1500.00, 17, 5, 17, true, 2, '2025-12-31 16:19:16.655', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (250, 'Microsoft Surface Pro 9', '2-in-1, Intel Core i5, 13-inch PixelSense.', 'MS-SURF-P9', '306937250049', 999.00, 750.00, 38, 5, 16, true, 2, '2025-12-31 16:19:16.401', '2026-01-07 02:18:52.958');
INSERT INTO public.products VALUES (162, 'iPhone 15 Plus 128GB', '6.7-inch display, Dynamic Island, A16 Bionic chip.', 'IPH-15PL-128', '886291954522', 899.00, 700.00, 50, 5, 13, true, 2, '2025-12-31 16:19:14.978', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (239, 'Samsung Galaxy Tab S9', '11-inch AMOLED, IP68 water resistance.', 'SAM-S9', '790809855692', 799.00, 600.00, 22, 5, 16, true, 2, '2025-12-31 16:19:16.262', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (214, 'Dell XPS 13 Plus', 'Intel Core i7, OLED touch, invisible touchpad.', 'DELL-XPS-13P', '992868816418', 1399.00, 1100.00, 33, 5, 15, true, 4, '2025-12-31 16:19:15.893', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (291, 'Hisense U8K Mini-LED 65"', '144Hz native refresh, Wi-Fi 6E.', 'HIS-U8K-65', '983952792557', 1099.00, 850.00, 44, 5, 18, true, 0, '2025-12-31 16:19:16.944', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (226, 'Alienware x14', 'Thinnest Alienware, RTX 4060, 165Hz display.', 'ALN-X14', '490061603456', 1799.00, 1400.00, 33, 5, 15, true, 2, '2025-12-31 16:19:16.07', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (251, 'Microsoft Surface Go 3', 'Portable 10.5-inch touchscreen 2-in-1.', 'MS-SURF-G3', '389977515119', 399.00, 300.00, 36, 5, 16, true, 2, '2025-12-31 16:19:16.413', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (296, 'Samsung The Frame 55"', 'Art Mode, Matte Display, Slim Fit Wall Mount.', 'SAM-FRAME-55', '927606806890', 1499.00, 1100.00, 17, 5, 18, true, 2, '2025-12-31 16:19:17.023', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (297, 'Sony X90L Full Array 65"', 'Full Array LED, Perfect for PS5.', 'SONY-X90L-65', '147106830241', 1299.00, 1000.00, 54, 5, 18, true, 2, '2025-12-31 16:19:17.041', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (201, 'iPad Air 4 64GB Refurb', 'Refurbished A14 Bionic, All-screen design.', 'IPD-AIR4-REF', '514366820508', 450.00, 350.00, 12, 5, 14, true, 2, '2025-12-31 16:19:15.628', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (245, 'Amazon Fire Max 11', '11-inch 2K display, 14 hour battery life.', 'AMZ-FIRE-11', '672938604059', 229.00, 150.00, 8, 5, 16, true, 1, '2025-12-31 16:19:16.342', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (288, 'Sony Bravia XR A80L 55"', 'Cognitive Processor XR, Acoustic Surface Audio.', 'SONY-A80L-55', '359660306635', 1699.00, 1300.00, 9, 5, 18, true, 1, '2025-12-31 16:19:16.898', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (253, 'Teclast T50', '2K display, Unibody aluminum design.', 'TEC-T50', '220301670314', 199.00, 140.00, 7, 5, 16, true, 1, '2025-12-31 16:19:16.441', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (298, 'TCL 6-Series 55"', 'Mini-LED technology, Roku TV built-in.', 'TCL-6S-55', '879829791089', 699.00, 500.00, 16, 5, 18, true, 0, '2025-12-31 16:19:17.059', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (299, 'Hisense U7K 55"', 'Gaming TV, 144Hz, Game Bar.', 'HIS-U7K-55', '178873531525', 799.00, 600.00, 18, 5, 18, true, 0, '2025-12-31 16:19:17.072', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (300, 'Samsung CU7000 43"', 'Crystal UHD 4K, Smart Tizen OS.', 'SAM-CU7-43', '129660998263', 299.00, 220.00, 8, 5, 18, true, 0, '2025-12-31 16:19:17.085', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (302, 'Sony X80K 43"', '4K HDR Processor X1, Triluminos Pro.', 'SONY-X80K-43', '911463363982', 449.00, 340.00, 24, 5, 18, true, 0, '2025-12-31 16:19:17.11', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (303, 'Insignia F30 Fire TV 50"', 'DTS Studio Sound, Voice Remote.', 'INS-F30-50', '904977611787', 249.00, 180.00, 48, 5, 18, true, 0, '2025-12-31 16:19:17.123', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (304, 'Toshiba C350 43"', 'Regza Engine 4K, Bezel-less design.', 'TOSH-C35-43', '489638838326', 229.00, 170.00, 43, 5, 18, true, 0, '2025-12-31 16:19:17.134', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (305, 'LG C4 OLED 55"', 'α9 AI Processor Gen7, 144Hz refresh rate, Filmmaker Mode for Dolby Vision.', 'LG-C4-55', '940685544830', 1899.00, 1450.00, 38, 5, 18, true, 0, '2025-12-31 16:19:17.15', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (222, 'Samsung Galaxy Book3 Pro', 'AMOLED 3K display, Intel 13th Gen, thin design.', 'SAM-BOOK3-PRO', '872215403289', 1449.00, 1100.00, 47, 5, 15, true, 0, '2025-12-31 16:19:16.018', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (223, 'Acer Swift 5', 'Antimicrobial coating, Aerospace-grade aluminum.', 'ACER-SWF-5', '72460544633', 1099.00, 800.00, 52, 5, 15, true, 0, '2025-12-31 16:19:16.031', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (225, 'Lenovo Yoga 9i', 'Rotating soundbar, 4K OLED, 2-in-1 design.', 'LEN-YOGA-9I', '445703462410', 1399.00, 1100.00, 36, 5, 15, true, 0, '2025-12-31 16:19:16.057', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (227, 'MacBook Pro 13 M2 Refurb', 'Refurbished M2, Touch Bar, active cooling.', 'MAC-PRO13-M2-REF', '649546781898', 1099.00, 850.00, 47, 5, 15, true, 0, '2025-12-31 16:19:16.083', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (176, 'iPhone 12 Pro 128GB Refurb', 'Certified Refurbished, Stainless steel design.', 'IPH-12P-REF', '889033705856', 550.00, 400.00, 14, 5, 13, true, 2, '2025-12-31 16:19:15.206', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (180, 'iPhone 8 Plus 64GB Used', 'Pre-owned, Dual cameras with Portrait mode.', 'IPH-8P-USED', '424374864721', 200.00, 120.00, 25, 5, 13, true, 4, '2025-12-31 16:19:15.267', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (173, 'iPhone SE (3rd Gen) 64GB', 'Classic design, A15 Bionic chip, 5G connectivity.', 'IPH-SE3-64', '54843204487', 429.00, 300.00, 18, 5, 13, true, 1, '2025-12-31 16:19:15.159', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (187, 'iPad Pro 12.9 M2 256GB', 'Extreme performance, Apple Pencil hover.', 'IPD-PRO12-M2-256', '912897781505', 1199.00, 950.00, 19, 5, 14, true, 1, '2025-12-31 16:19:15.365', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (171, 'iPhone 13 Mini 128GB', 'Pocket-sized power, 5.4-inch display, A15 Bionic.', 'IPH-13M-128', '606443861037', 499.00, 350.00, 38, 5, 13, true, 2, '2025-12-31 16:19:15.128', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (192, 'iPad Air 5 M1 256GB', 'M1 power, Center Stage camera, 256GB.', 'IPD-AIR5-256', '317988730110', 749.00, 600.00, 49, 5, 14, true, 1, '2025-12-31 16:19:15.445', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (216, 'ThinkPad X1 Carbon Gen 11', 'Ultralight business flagship, Carbon fiber chassis.', 'LEN-X1-G11', '571141627396', 1799.00, 1400.00, 23, 5, 15, true, 1, '2025-12-31 16:19:15.923', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (252, 'Chuwi HiPad XPro', 'Budget Android 12, 10.5-inch FHD.', 'CHU-HIPAD', '627339289934', 149.00, 100.00, 43, 5, 16, true, 2, '2025-12-31 16:19:16.427', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (220, 'Microsoft Surface Laptop 5', '13.5-inch Alcantara keyboard, Intel Evo.', 'MS-SURF-L5', '310939921779', 999.00, 750.00, 51, 5, 15, true, 6, '2025-12-31 16:19:15.979', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (170, 'iPhone 13 128GB', 'Dual-camera system, A15 Bionic chip, durable design.', 'IPH-13-128', '430326350134', 599.00, 450.00, 12, 5, 13, true, 0, '2025-12-31 16:19:15.112', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (175, 'iPhone 11 64GB', 'Dual-camera system, Night mode, all-day battery.', 'IPH-11-64', '481666226725', 399.00, 280.00, 47, 5, 13, true, 0, '2025-12-31 16:19:15.192', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (181, 'iPhone 16 Pro Max 256GB', '6.9-inch display, A18 Pro chip, 48MP Ultra-Wide camera, Camera Control button.', 'IPH-16PM-256', '400592134985', 1199.00, 950.00, 7, 5, 13, true, 0, '2025-12-31 16:19:15.279', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (182, 'iPhone 16 Pro 128GB', '6.3-inch display, A18 Pro chip, 5x Telephoto zoom, Grade 5 Titanium design.', 'IPH-16P-128', '26499320798', 999.00, 800.00, 16, 5, 13, true, 0, '2025-12-31 16:19:15.292', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (183, 'iPhone 16 Plus 128GB', '6.7-inch display, A18 chip, Camera Control, Apple Intelligence ready.', 'IPH-16PL-128', '447056327084', 899.00, 700.00, 30, 5, 13, true, 0, '2025-12-31 16:19:15.304', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (188, 'iPad Pro 12.9 M2 512GB', 'Pro workflows, 512GB storage for creators.', 'IPD-PRO12-M2-512', '624175815106', 1399.00, 1100.00, 45, 5, 14, true, 0, '2025-12-31 16:19:15.378', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (194, 'iPad Mini 6 256GB', 'Small size, huge power, Apple Pencil 2 support.', 'IPD-MINI6-256', '632955035916', 649.00, 500.00, 48, 5, 14, true, 0, '2025-12-31 16:19:15.479', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (230, 'Asus Vivobook 15', 'Thin and light, Intel Core i3, NanoEdge display.', 'ASUS-VIVO-15', '282029035657', 499.00, 380.00, 41, 5, 15, true, 0, '2025-12-31 16:19:16.124', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (233, 'Dell XPS 14 (2024)', 'Intel Core Ultra 7, CNC Aluminum, Gorilla Glass 3.', 'DELL-XPS-14-9440', '245373646243', 1499.00, 1200.00, 33, 5, 15, true, 0, '2025-12-31 16:19:16.173', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (236, 'Surface Laptop 7th Ed', 'Snapdragon X Elite, Copilot+ PC, 20-hour battery.', 'MS-SURF-L7', '729751933111', 999.00, 780.00, 49, 5, 15, true, 0, '2025-12-31 16:19:16.226', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (202, 'iPad Mini 5 64GB Used', 'Used condition, A12 Bionic, 7.9-inch display.', 'IPD-MINI5-USED', '800819446769', 300.00, 200.00, 37, 5, 14, true, 8, '2025-12-31 16:19:15.655', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (212, 'MacBook Pro 16 M3 Pro', 'M3 Pro chip, 16-inch XDR, 18GB RAM.', 'MAC-PRO-16-M3P', '105067576979', 2499.00, 2000.00, 18, 5, 15, true, 1, '2025-12-31 16:19:15.858', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (172, 'iPhone 12 64GB', 'A14 Bionic, 5G capable, Ceramic Shield front.', 'IPH-12-64', '732677047744', 499.00, 350.00, 33, 5, 13, true, 2, '2025-12-31 16:19:15.143', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (204, 'iPad Pro 11 (2020) Used', 'Used condition, Face ID, ProMotion.', 'IPD-PRO11-2020', '209095654719', 500.00, 380.00, 34, 5, 14, true, 2, '2025-12-31 16:19:15.704', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (209, 'MacBook Air M3 13"', 'M3 chip, 13.6-inch Liquid Retina, Midnight finish.', 'MAC-AIR-M3-13', '368963299097', 1099.00, 850.00, 25, 5, 15, true, 2, '2025-12-31 16:19:15.809', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (266, 'Alienware Aurora R16', 'Optimized airflow, Legend 3 design, Core i7.', 'ALN-AUR-R16', '317261639017', 1799.00, 1400.00, 47, 5, 17, true, 0, '2025-12-31 16:19:16.607', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (179, 'iPhone XR 64GB Used', 'Pre-owned, Liquid Retina HD display.', 'IPH-XR-USED', '796032231955', 250.00, 150.00, 43, 5, 13, true, 8, '2025-12-31 16:19:15.252', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (267, 'HP Omen 45L', 'Cryo Chamber cooling, RTX 4080, Glass side panel.', 'HP-OMEN-45', '611813674930', 2499.00, 2000.00, 47, 5, 17, true, 0, '2025-12-31 16:19:16.62', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (219, 'Razer Blade 14', 'AMD Ryzen 9, RTX 4070, 14-inch gaming powerhouse.', 'RAZ-BLD-14', '477264557350', 2199.00, 1800.00, 12, 5, 15, true, 1, '2025-12-31 16:19:15.967', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (294, 'Amazon Fire TV Omni 65"', 'Hands-free Alexa, QLED, Local Dimming.', 'AMZ-OMNI-65', '141480511774', 599.00, 450.00, 14, 5, 18, true, 3, '2025-12-31 16:19:16.991', '2026-01-07 02:18:52.95');
INSERT INTO public.products VALUES (262, 'Mac Studio M2 Max', 'Compact powerhouse for creative pros.', 'MAC-STUDIO-M2', '227661605925', 1999.00, 1600.00, 9, 5, 17, true, 2, '2025-12-31 16:19:16.557', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (169, 'iPhone 14 128GB', 'Vibrant Super Retina XDR display, A15 Bionic.', 'IPH-14-128', '745620674248', 699.00, 500.00, 42, 5, 13, true, 2, '2025-12-31 16:19:15.095', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (190, 'iPad Pro 11 M2 256GB', 'Portable pro performance, Face ID.', 'IPD-PRO11-M2-256', '382468674504', 899.00, 700.00, 40, 5, 14, true, 3, '2025-12-31 16:19:15.413', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (244, 'Xiaomi Pad 6', '11-inch WQHD+ 144Hz, Snapdragon 870.', 'XIA-PAD-6', '105464707022', 399.00, 280.00, 36, 5, 16, true, 3, '2025-12-31 16:19:16.327', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (278, 'NZXT Player Three', 'H9 Flow case, Kraken Elite cooler, RTX 4080.', 'NZXT-PL3', '403659013057', 2499.00, 2000.00, 12, 5, 17, true, 0, '2025-12-31 16:19:16.771', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (279, 'Maingear MG-1', 'Compact chassis, Customizable magnetic front panel.', 'MAIN-MG1', '565958598753', 1699.00, 1300.00, 47, 5, 17, true, 0, '2025-12-31 16:19:16.783', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (281, 'Asus ROG Strix G16CH', 'Headphone holder, Carry handle, Airflow focused.', 'ASUS-ROG-DT', '796057538764', 1799.00, 1400.00, 6, 5, 17, true, 0, '2025-12-31 16:19:16.809', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (283, 'LG C3 OLED 65"', 'Perfect black, 120Hz refresh rate for gaming.', 'LG-C3-65', '780885783379', 1899.00, 1400.00, 5, 5, 18, true, 0, '2025-12-31 16:19:16.833', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (284, 'LG G3 OLED 65"', 'Brightness Booster Max, One Wall Design.', 'LG-G3-65', '636125490738', 2799.00, 2100.00, 33, 5, 18, true, 0, '2025-12-31 16:19:16.844', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (285, 'Samsung S90C OLED 55"', 'QD-OLED technology, LaserSlim design.', 'SAM-S90C-55', '312274799095', 1599.00, 1200.00, 48, 5, 18, true, 0, '2025-12-31 16:19:16.858', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (286, 'Samsung S90C OLED 65"', 'Pantone Validated colors, Motion Xcelerator.', 'SAM-S90C-65', '967177677312', 1999.00, 1500.00, 48, 5, 18, true, 0, '2025-12-31 16:19:16.87', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (275, 'HP Envy Desktop', 'Content creator focused, plenty of ports.', 'HP-ENVY-DT', '924800801033', 899.00, 650.00, 42, 5, 17, true, 0, '2025-12-31 16:19:16.727', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (276, 'Dell Inspiron Desktop', 'Compact home office PC, Intel Core i5.', 'DELL-INS-DT', '232098470512', 699.00, 500.00, 42, 5, 17, true, 0, '2025-12-31 16:19:16.743', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (277, 'Acer Predator Orion 7000', 'FrostBlade fans, ARGB, RTX 4090 beast.', 'ACER-PRE-7K', '704739235607', 2999.00, 2400.00, 50, 5, 17, true, 0, '2025-12-31 16:19:16.758', '2026-01-07 02:18:52.775');
INSERT INTO public.products VALUES (238, 'Samsung Galaxy Tab S9+', '12.4-inch AMOLED, Snapdragon 8 Gen 2.', 'SAM-S9-PLS', '133123903834', 999.00, 750.00, 6, 5, 16, true, 2, '2025-12-31 16:19:16.25', '2026-01-07 02:18:52.954');
INSERT INTO public.products VALUES (272, 'CyberPowerPC Gamer Supreme', 'Liquid Cooled, 32GB DDR5, Custom RGB.', 'CYB-GAM-SUP', '59646430193', 1999.00, 1600.00, 40, 5, 17, true, 2, '2025-12-31 16:19:16.683', '2026-01-07 02:18:52.952');
INSERT INTO public.products VALUES (165, 'iPhone 15 256GB', 'Advanced dual-camera system, A16 Bionic chip.', 'IPH-15-256', '672465269307', 899.00, 700.00, 26, 5, 13, true, 2, '2025-12-31 16:19:15.028', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (168, 'iPhone 14 Plus 128GB', 'Longest battery life ever, 6.7-inch display.', 'IPH-14PL-128', '815256529643', 799.00, 600.00, 49, 5, 13, true, 2, '2025-12-31 16:19:15.079', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (265, 'Dell XPS Desktop', 'Minimalist design, Liquid cooling, RTX 4070.', 'DELL-XPS-DT', '577312606727', 1499.00, 1100.00, 18, 5, 17, true, 2, '2025-12-31 16:19:16.594', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (246, 'Samsung Galaxy Tab A9+', '11-inch 90Hz display, Quad speakers.', 'SAM-A9-PLS', '455317239817', 219.00, 160.00, 7, 5, 16, true, 6, '2025-12-31 16:19:16.354', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (208, 'iPad Pro 9.7 Used', 'Used condition, 9.7-inch display, A9X.', 'IPD-PRO97-USED', '641533294357', 180.00, 120.00, 30, 5, 14, true, 1, '2025-12-31 16:19:15.79', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (257, 'Vivo Pad 2', '12.1-inch 144Hz display, Dimensity 9000.', 'VIV-PAD-2', '26112410488', 399.00, 300.00, 48, 5, 16, true, 3, '2025-12-31 16:19:16.49', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (258, 'Huawei MatePad Pro 13.2', 'Flexible OLED, Near-Link M-Pencil.', 'HUA-MATE-13', '979314462309', 999.00, 750.00, 6, 5, 16, true, 2, '2025-12-31 16:19:16.503', '2026-01-07 02:18:52.953');
INSERT INTO public.products VALUES (255, 'Realme Pad 2', '11.5-inch 120Hz 2K display, 33W charge.', 'REA-PAD-2', '547497407842', 249.00, 180.00, 45, 5, 16, true, 2, '2025-12-31 16:19:16.466', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (193, 'iPad Mini 6 64GB', '8.3-inch Liquid Retina, A15 Bionic, USB-C.', 'IPD-MINI6-64', '65227228063', 499.00, 380.00, 11, 5, 14, true, 1, '2025-12-31 16:19:15.462', '2026-01-07 02:18:52.957');
INSERT INTO public.products VALUES (232, 'MacBook Pro 14 M4', 'Latest M4 chip, Nano-texture display option, Space Black.', 'MAC-PRO-14-M4', '317925704502', 1599.00, 1280.00, 16, 5, 15, true, 1, '2025-12-31 16:19:16.158', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (307, 'Sony Bravia 9 Mini-LED 65"', 'Sony’s brightest 4K TV, XR Backlight Master Drive, High Peak Brightness QLED.', 'SONY-B9-65', '499683625887', 1999.00, 1550.00, 52, 5, 18, true, 4, '2025-12-31 16:19:17.175', '2026-01-07 02:18:52.955');
INSERT INTO public.products VALUES (174, 'iPhone SE (3rd Gen) 128GB', 'Touch ID, powerful chip, ample storage.', 'IPH-SE3-128', '884186945472', 479.00, 340.00, 39, 5, 13, true, 1, '2025-12-31 16:19:15.173', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (295, 'LG B3 OLED 55"', 'Entry-level OLED, 120Hz, G-Sync compatible.', 'LG-B3-55', '803783757056', 1199.00, 900.00, 42, 5, 18, true, 3, '2025-12-31 16:19:17.01', '2026-01-07 02:18:52.956');
INSERT INTO public.products VALUES (221, 'LG Gram 17', 'Ultra-lightweight 17-inch laptop, long battery.', 'LG-GRAM-17', '356358815315', 1699.00, 1300.00, 34, 5, 15, true, 1, '2025-12-31 16:19:16.001', '2026-01-07 02:18:52.956');


--
-- Data for Name: sales_targets; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.users VALUES (16, 'staff1', 'staff1@myshop.com', '$2a$10$65OtutPF/d6hATzTi2q8h.GArMZ7X9ANCLp5HdcDhRnaV.PuGVX0a', 'STAFF', true, '2025-12-31 16:19:14.724', '2025-12-31 16:19:14.724');
INSERT INTO public.users VALUES (15, 'admin', 'admin@myshop.com', '$2a$10$m8PuNSWIXvk5VNoohCl/wuDIOIkrZQCYZGYKtHTOUlai69.VOJeFe', 'ADMIN', true, '2025-12-31 16:19:14.724', '2025-12-31 16:19:14.724');
INSERT INTO public.users VALUES (14, 'manager1', 'manager@myshop.com', '$2a$10$65OtutPF/d6hATzTi2q8h.GArMZ7X9ANCLp5HdcDhRnaV.PuGVX0a', 'MANAGER', true, '2025-12-31 16:19:14.724', '2025-12-31 16:19:14.724');


--
-- Name: app_licenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.app_licenses_id_seq', 3, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.categories_id_seq', 18, true);


--
-- Name: commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.commissions_id_seq', 59, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.customers_id_seq', 35, true);


--
-- Name: discounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.discounts_id_seq', 11, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.order_items_id_seq', 478, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orders_id_seq', 200, true);


--
-- Name: product_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.product_images_id_seq', 456, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_id_seq', 308, true);


--
-- Name: sales_targets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sales_targets_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


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

\unrestrict AmNOWEcSWmDz2yu5svhA0nZhRs7pVJKhDe8YIfNXfSfxI21c4B7u3rtGwt5kb5c

