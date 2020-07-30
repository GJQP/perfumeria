--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

-- Started on 2020-07-29 20:49:59

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 204 (class 1259 OID 89704)
-- Name: rig_asociaciones_nacionales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_asociaciones_nacionales (
    id smallint NOT NULL,
    nombre character varying(100) NOT NULL,
    region character varying(20) NOT NULL,
    id_ubic smallint NOT NULL,
    CONSTRAINT rig_asociacion_nacional_ck CHECK (((region)::text = ANY ((ARRAY['ASIA-PACÍFICO'::character varying, 'EUROPA'::character varying, 'AMÉRICA DEL NORTE'::character varying, 'LATINOAMERICA'::character varying])::text[])))
);


ALTER TABLE public.rig_asociaciones_nacionales OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 89711)
-- Name: rig_asociaciones_nacionales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_asociaciones_nacionales_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 300
    CACHE 1;


ALTER TABLE public.rig_asociaciones_nacionales_id_seq OWNER TO postgres;

--
-- TOC entry 3297 (class 0 OID 0)
-- Dependencies: 205
-- Name: rig_asociaciones_nacionales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_asociaciones_nacionales_id_seq OWNED BY public.rig_asociaciones_nacionales.id;


--
-- TOC entry 250 (class 1259 OID 90160)
-- Name: rig_componentes_funcionales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_componentes_funcionales (
    cas_otr_ing integer NOT NULL,
    id_perf integer NOT NULL
);


ALTER TABLE public.rig_componentes_funcionales OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 90222)
-- Name: rig_condiciones_contratos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_condiciones_contratos (
    id_prod smallint NOT NULL,
    id_prov smallint NOT NULL,
    id_ctra integer NOT NULL,
    id smallint NOT NULL,
    id_prov_ce smallint,
    id_ubic smallint,
    id_prov_cp smallint,
    id_condpgo integer
);


ALTER TABLE public.rig_condiciones_contratos OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 89805)
-- Name: rig_condiciones_de_envio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_condiciones_de_envio (
    id_prov smallint NOT NULL,
    id_ubic smallint NOT NULL,
    nombre character varying(30) NOT NULL,
    porce_serv numeric(3,2) NOT NULL,
    medio character varying(15) NOT NULL,
    CONSTRAINT rig_condiciones_de_envio_ck CHECK (((medio)::text = ANY ((ARRAY['AEREO'::character varying, 'TERRESTRE'::character varying, 'MARITIMO'::character varying])::text[])))
);


ALTER TABLE public.rig_condiciones_de_envio OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 89791)
-- Name: rig_condiciones_de_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_condiciones_de_pago (
    id_prov smallint NOT NULL,
    id integer NOT NULL,
    tipo character varying(15) NOT NULL,
    coutas smallint,
    porcen_cuo numeric(5,2),
    cant_meses smallint,
    CONSTRAINT rig_condiciones_de_pago_ck CHECK (((tipo)::text = ANY ((ARRAY['CONTADO'::character varying, 'PARCIAL'::character varying])::text[])))
);


ALTER TABLE public.rig_condiciones_de_pago OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 89796)
-- Name: rig_condiciones_de_pago_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_condiciones_de_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_condiciones_de_pago_id_seq OWNER TO postgres;

--
-- TOC entry 3298 (class 0 OID 0)
-- Dependencies: 213
-- Name: rig_condiciones_de_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_condiciones_de_pago_id_seq OWNED BY public.rig_condiciones_de_pago.id;


--
-- TOC entry 252 (class 1259 OID 90190)
-- Name: rig_contratos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_contratos (
    id_prod smallint NOT NULL,
    id_prov smallint NOT NULL,
    id integer NOT NULL,
    fcha_reg date NOT NULL,
    exc character varying(2) NOT NULL,
    cancelante character varying(50),
    fcha_fin date,
    mot_fin character varying(50),
    CONSTRAINT rig_contrato_ck CHECK (((exc)::text = ANY ((ARRAY['SI'::character varying, 'NO'::character varying])::text[])))
);


ALTER TABLE public.rig_contratos OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 90195)
-- Name: rig_contrato_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_contrato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_contrato_id_seq OWNER TO postgres;

--
-- TOC entry 3299 (class 0 OID 0)
-- Dependencies: 253
-- Name: rig_contrato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_contrato_id_seq OWNED BY public.rig_contratos.id;


--
-- TOC entry 261 (class 1259 OID 90287)
-- Name: rig_detalles_pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_detalles_pedidos (
    id_ped bigint NOT NULL,
    renglon smallint NOT NULL,
    cantidad integer NOT NULL,
    id_prov_ing bigint,
    id_ing bigint,
    cod_pre_ing bigint,
    cas_otr_ing bigint,
    cod_pre_otr bigint,
    CONSTRAINT rig_detalles_pedidos_ck CHECK ((cantidad > 0))
);


ALTER TABLE public.rig_detalles_pedidos OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 89821)
-- Name: rig_escalas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_escalas (
    id_prod smallint NOT NULL,
    fcha_reg timestamp without time zone NOT NULL,
    rgo_ini smallint NOT NULL,
    rgo_fin smallint NOT NULL,
    fcha_fin date
);


ALTER TABLE public.rig_escalas OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 90145)
-- Name: rig_esencias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_esencias (
    id_fao smallint NOT NULL,
    id_esenp bigint NOT NULL
);


ALTER TABLE public.rig_esencias OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 90091)
-- Name: rig_esencias_perfumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_esencias_perfumes (
    cas bigint NOT NULL,
    nombre character varying(20) NOT NULL,
    tipo character varying(10),
    CONSTRAINT rig_esencias_perfumes_ck CHECK (((tipo)::text = ANY ((ARRAY['NATURAL'::character varying, 'SINTETICO'::character varying])::text[])))
);


ALTER TABLE public.rig_esencias_perfumes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 89857)
-- Name: rig_evaluaciones_criterios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_evaluaciones_criterios (
    id_prod smallint NOT NULL,
    id_var smallint NOT NULL,
    fcha_reg timestamp without time zone NOT NULL,
    tipo_eval character varying(15) NOT NULL,
    peso numeric(5,2) NOT NULL,
    fcha_fin date,
    CONSTRAINT rig_evaluaciones_criterios_ck CHECK (((tipo_eval)::text = ANY ((ARRAY['INICIAL'::character varying, 'RENOVACION'::character varying])::text[])))
);


ALTER TABLE public.rig_evaluaciones_criterios OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 90262)
-- Name: rig_pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_pedidos (
    id bigint NOT NULL,
    fcha_reg date NOT NULL,
    estatus character varying(10) DEFAULT 'NO ENVIADO'::character varying NOT NULL,
    factura integer,
    total numeric(20,2),
    id_prod_conp smallint,
    id_prov_conp smallint,
    id_ctra_conp bigint,
    id_conp bigint,
    id_prod_cone smallint,
    id_prov_cone smallint,
    id_ctra_cone bigint,
    id_cone bigint,
    CONSTRAINT rig_pedido_ck CHECK (((estatus)::text = ANY ((ARRAY['ENVIADO'::character varying, 'NO ENVIADO'::character varying, 'RECHAZADO'::character varying])::text[])))
);


ALTER TABLE public.rig_pedidos OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 90272)
-- Name: rig_factura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_factura_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_factura_id_seq OWNER TO postgres;

--
-- TOC entry 3300 (class 0 OID 0)
-- Dependencies: 260
-- Name: rig_factura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_factura_id_seq OWNED BY public.rig_pedidos.factura;


--
-- TOC entry 241 (class 1259 OID 90051)
-- Name: rig_familias_olfativas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_familias_olfativas (
    id smallint NOT NULL,
    nombre character varying(20)
);


ALTER TABLE public.rig_familias_olfativas OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 90058)
-- Name: rig_familias_olfativas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_familias_olfativas_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 15
    CACHE 1;


ALTER TABLE public.rig_familias_olfativas_id_seq OWNER TO postgres;

--
-- TOC entry 3301 (class 0 OID 0)
-- Dependencies: 242
-- Name: rig_familias_olfativas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_familias_olfativas_id_seq OWNED BY public.rig_familias_olfativas.id;


--
-- TOC entry 244 (class 1259 OID 90076)
-- Name: rig_familias_perfumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_familias_perfumes (
    id_perf integer NOT NULL,
    id_fao smallint NOT NULL
);


ALTER TABLE public.rig_familias_perfumes OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 89873)
-- Name: rig_ingredientes_esencias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_ingredientes_esencias (
    id_prov smallint NOT NULL,
    id integer NOT NULL,
    cas bigint NOT NULL,
    nombre character varying(50) NOT NULL,
    tipo character varying(15) NOT NULL,
    des character varying(500) NOT NULL,
    solubilidad character varying(100),
    peligrosidad character varying(15),
    vida_alm smallint,
    ctrl character varying(15),
    CONSTRAINT rig_ingrediente_esencia_ck CHECK ((((tipo)::text = ANY ((ARRAY['NATURAL'::character varying, 'SINTETICO'::character varying])::text[])) AND ((peligrosidad)::text = ANY ((ARRAY['ALTA'::character varying, 'MEDIA'::character varying, 'BAJA'::character varying, 'NINGUNA'::character varying])::text[])) AND ((ctrl)::text = ANY ((ARRAY['SI'::character varying, 'NO'::character varying])::text[]))))
);


ALTER TABLE public.rig_ingredientes_esencias OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 89881)
-- Name: rig_ingredientes_esencias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_ingredientes_esencias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_ingredientes_esencias_id_seq OWNER TO postgres;

--
-- TOC entry 3302 (class 0 OID 0)
-- Dependencies: 221
-- Name: rig_ingredientes_esencias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_ingredientes_esencias_id_seq OWNED BY public.rig_ingredientes_esencias.id;


--
-- TOC entry 229 (class 1259 OID 89948)
-- Name: rig_ingredientes_extras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_ingredientes_extras (
    id_prov_ing smallint NOT NULL,
    id_ing bigint NOT NULL,
    cas_otr_ing bigint NOT NULL
);


ALTER TABLE public.rig_ingredientes_extras OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 90099)
-- Name: rig_ingredientes_familias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_ingredientes_familias (
    id_prov smallint NOT NULL,
    id_ing integer NOT NULL,
    id_fao smallint NOT NULL
);


ALTER TABLE public.rig_ingredientes_familias OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 90014)
-- Name: rig_intensidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_intensidades (
    id_perf integer NOT NULL,
    id integer NOT NULL,
    tipo character varying(3) NOT NULL,
    porcen numeric(5,2),
    des character varying(50),
    CONSTRAINT rig_intensidades_ck CHECK (((tipo)::text = ANY ((ARRAY['P'::character varying, 'EdP'::character varying, 'EdT'::character varying, 'EdC'::character varying, 'EdS'::character varying])::text[])))
);


ALTER TABLE public.rig_intensidades OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 90019)
-- Name: rig_intensidades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_intensidades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_intensidades_id_seq OWNER TO postgres;

--
-- TOC entry 3303 (class 0 OID 0)
-- Dependencies: 236
-- Name: rig_intensidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_intensidades_id_seq OWNED BY public.rig_intensidades.id;


--
-- TOC entry 210 (class 1259 OID 89769)
-- Name: rig_membresias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_membresias (
    fcha_reg timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    tipo_m character varying(15) NOT NULL,
    fcha_fin date,
    id_prod smallint,
    id_prov smallint,
    CONSTRAINT rig_proveedores_ck CHECK ((((tipo_m)::text = ANY ((ARRAY['PRINCIPAL'::character varying, 'SECUNDARIO'::character varying, 'REGIONAL'::character varying])::text[])) AND ((id_prod IS NULL) <> (id_prov IS NULL))))
);


ALTER TABLE public.rig_membresias OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 90130)
-- Name: rig_monoliticos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_monoliticos (
    id_perf integer NOT NULL,
    id_esenp bigint NOT NULL
);


ALTER TABLE public.rig_monoliticos OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 90114)
-- Name: rig_notas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_notas (
    id_perf integer NOT NULL,
    id_esenp bigint NOT NULL,
    tipo character varying(10),
    CONSTRAINT rig_notas_ck CHECK (((tipo)::text = ANY ((ARRAY['SALIDA'::character varying, 'CORAZON'::character varying, 'FONDO'::character varying])::text[])))
);


ALTER TABLE public.rig_notas OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 90175)
-- Name: rig_origenes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_origenes (
    id_fao smallint NOT NULL,
    id_esenp integer NOT NULL
);


ALTER TABLE public.rig_origenes OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 89890)
-- Name: rig_origenes_ingredientes_esencias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_origenes_ingredientes_esencias (
    id_prov smallint NOT NULL,
    id_ing integer NOT NULL,
    id_ubic smallint NOT NULL
);


ALTER TABLE public.rig_origenes_ingredientes_esencias OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 89924)
-- Name: rig_otros_ingredientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_otros_ingredientes (
    id_prov smallint,
    cas bigint NOT NULL,
    nombre character varying(20) NOT NULL,
    des character varying(150) NOT NULL
);


ALTER TABLE public.rig_otros_ingredientes OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 90308)
-- Name: rig_pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_pagos (
    id_ped integer NOT NULL,
    id_ord smallint NOT NULL,
    fcha_reg date NOT NULL,
    total numeric(20,2) NOT NULL
);


ALTER TABLE public.rig_pagos OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 89694)
-- Name: rig_paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_paises (
    id smallint NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE public.rig_paises OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 89701)
-- Name: rig_paises_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_paises_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 300
    CACHE 1;


ALTER TABLE public.rig_paises_id_seq OWNER TO postgres;

--
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 203
-- Name: rig_paises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_paises_id_seq OWNED BY public.rig_paises.id;


--
-- TOC entry 239 (class 1259 OID 90041)
-- Name: rig_palabras_claves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_palabras_claves (
    id smallint NOT NULL,
    palabra character varying(20) NOT NULL
);


ALTER TABLE public.rig_palabras_claves OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 90048)
-- Name: rig_palabras_claves_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_palabras_claves_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 100
    CACHE 1;


ALTER TABLE public.rig_palabras_claves_id_seq OWNER TO postgres;

--
-- TOC entry 3305 (class 0 OID 0)
-- Dependencies: 240
-- Name: rig_palabras_claves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_palabras_claves_id_seq OWNED BY public.rig_palabras_claves.id;


--
-- TOC entry 243 (class 1259 OID 90061)
-- Name: rig_palabras_familias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_palabras_familias (
    id_pal smallint NOT NULL,
    id_fao smallint NOT NULL
);


ALTER TABLE public.rig_palabras_familias OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 90270)
-- Name: rig_pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_pedidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_pedidos_id_seq OWNER TO postgres;

--
-- TOC entry 3306 (class 0 OID 0)
-- Dependencies: 259
-- Name: rig_pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_pedidos_id_seq OWNED BY public.rig_pedidos.id;


--
-- TOC entry 230 (class 1259 OID 89963)
-- Name: rig_perfumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_perfumes (
    id integer NOT NULL,
    id_prod smallint,
    nombre character varying(100) NOT NULL,
    genero character varying NOT NULL,
    tipo character varying(5) NOT NULL,
    edad character varying(15) NOT NULL,
    fcha_crea smallint,
    des text,
    CONSTRAINT rig_perfumes_ck CHECK ((((genero)::text = ANY ((ARRAY['F'::character varying, 'M'::character varying, 'U'::character varying])::text[])) AND ((tipo)::text = ANY ((ARRAY['MONO'::character varying, 'FASES'::character varying])::text[])) AND ((edad)::text = ANY ((ARRAY['JOVEN'::character varying, 'ADULTO'::character varying, 'MAYOR'::character varying, 'ATEMPORAL'::character varying])::text[]))))
);


ALTER TABLE public.rig_perfumes OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 89971)
-- Name: rig_perfumes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_perfumes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_perfumes_id_seq OWNER TO postgres;

--
-- TOC entry 3307 (class 0 OID 0)
-- Dependencies: 231
-- Name: rig_perfumes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_perfumes_id_seq OWNED BY public.rig_perfumes.id;


--
-- TOC entry 234 (class 1259 OID 89999)
-- Name: rig_perfumes_perfumistas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_perfumes_perfumistas (
    id_perf integer NOT NULL,
    id_prefta integer NOT NULL
);


ALTER TABLE public.rig_perfumes_perfumistas OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 89980)
-- Name: rig_perfumistas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_perfumistas (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    genero character varying NOT NULL,
    fcha_nac date,
    id_ubic smallint,
    CONSTRAINT rig_perfumistas_ck CHECK (((genero)::text = ANY ((ARRAY['F'::character varying, 'M'::character varying])::text[])))
);


ALTER TABLE public.rig_perfumistas OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 89990)
-- Name: rig_perfumistas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_perfumistas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_perfumistas_id_seq OWNER TO postgres;

--
-- TOC entry 3308 (class 0 OID 0)
-- Dependencies: 233
-- Name: rig_perfumistas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_perfumistas_id_seq OWNED BY public.rig_perfumistas.id;


--
-- TOC entry 224 (class 1259 OID 89911)
-- Name: rig_presentaciones_ingredientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_presentaciones_ingredientes (
    id_prov smallint NOT NULL,
    id_ing integer NOT NULL,
    cod_present integer NOT NULL,
    medida numeric(10,2) NOT NULL,
    unidad character varying(3) NOT NULL,
    precio numeric(10,2) NOT NULL
);


ALTER TABLE public.rig_presentaciones_ingredientes OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 89916)
-- Name: rig_presentaciones_ingredientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_presentaciones_ingredientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_presentaciones_ingredientes_id_seq OWNER TO postgres;

--
-- TOC entry 3309 (class 0 OID 0)
-- Dependencies: 225
-- Name: rig_presentaciones_ingredientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_presentaciones_ingredientes_id_seq OWNED BY public.rig_presentaciones_ingredientes.cod_present;


--
-- TOC entry 227 (class 1259 OID 89934)
-- Name: rig_presentaciones_otros_ingredientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_presentaciones_otros_ingredientes (
    cas_otr_ing bigint NOT NULL,
    cod_present integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    volumen numeric(10,2),
    unidad character varying(3),
    otra_pre character varying(15),
    des character varying(150),
    CONSTRAINT rig_presentaciones_ingredientes_ck CHECK (((otra_pre)::text = ANY ((ARRAY['RESTRINGIDO'::character varying, 'PROHIBIDO'::character varying])::text[])))
);


ALTER TABLE public.rig_presentaciones_otros_ingredientes OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 89939)
-- Name: rig_presentaciones_otros_ingredientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_presentaciones_otros_ingredientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_presentaciones_otros_ingredientes_id_seq OWNER TO postgres;

--
-- TOC entry 3310 (class 0 OID 0)
-- Dependencies: 228
-- Name: rig_presentaciones_otros_ingredientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_presentaciones_otros_ingredientes_id_seq OWNED BY public.rig_presentaciones_otros_ingredientes.cod_present;


--
-- TOC entry 237 (class 1259 OID 90028)
-- Name: rig_presentaciones_perfumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_presentaciones_perfumes (
    id_perf integer NOT NULL,
    id_int integer NOT NULL,
    id integer NOT NULL,
    vol numeric(10,2),
    unidad character varying(3)
);


ALTER TABLE public.rig_presentaciones_perfumes OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 90033)
-- Name: rig_presentaciones_perfumes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_presentaciones_perfumes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_presentaciones_perfumes_id_seq OWNER TO postgres;

--
-- TOC entry 3311 (class 0 OID 0)
-- Dependencies: 238
-- Name: rig_presentaciones_perfumes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_presentaciones_perfumes_id_seq OWNED BY public.rig_presentaciones_perfumes.id;


--
-- TOC entry 206 (class 1259 OID 89720)
-- Name: rig_productores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_productores (
    id smallint NOT NULL,
    nombre character varying(50) NOT NULL,
    pag character varying(50) NOT NULL,
    info_cto character varying(150) NOT NULL,
    email character varying(30) NOT NULL,
    telf character varying(20) NOT NULL,
    id_aso_nac smallint
);


ALTER TABLE public.rig_productores OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 89733)
-- Name: rig_productores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_productores_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.rig_productores_id_seq OWNER TO postgres;

--
-- TOC entry 3312 (class 0 OID 0)
-- Dependencies: 207
-- Name: rig_productores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_productores_id_seq OWNED BY public.rig_productores.id;


--
-- TOC entry 257 (class 1259 OID 90242)
-- Name: rig_productos_contratados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_productos_contratados (
    id_prod smallint NOT NULL,
    id_prov smallint NOT NULL,
    id_ctra integer NOT NULL,
    id smallint NOT NULL,
    id_prov_ing smallint,
    id_ing integer,
    cas_otr_ing bigint
);


ALTER TABLE public.rig_productos_contratados OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 89905)
-- Name: rig_prohibidas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_prohibidas (
    cas bigint NOT NULL,
    nombre character varying(80),
    tipo character varying(3),
    CONSTRAINT rig_prohibidas_ck CHECK (((tipo)::text = ANY ((ARRAY['P'::character varying, 'R'::character varying, 'S'::character varying, 'R-S'::character varying, 'R-P'::character varying, 'P-S'::character varying, 'P-R-S'::character varying])::text[])))
);


ALTER TABLE public.rig_prohibidas OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 89741)
-- Name: rig_proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_proveedores (
    id smallint NOT NULL,
    nombre character varying(50) NOT NULL,
    pag character varying(50) NOT NULL,
    info_cto character varying(150) NOT NULL,
    email character varying(30) NOT NULL,
    telf character varying(20) NOT NULL,
    id_ubic smallint NOT NULL,
    id_aso_nac smallint
);


ALTER TABLE public.rig_proveedores OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 89756)
-- Name: rig_proveedores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_proveedores_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.rig_proveedores_id_seq OWNER TO postgres;

--
-- TOC entry 3313 (class 0 OID 0)
-- Dependencies: 209
-- Name: rig_proveedores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_proveedores_id_seq OWNED BY public.rig_proveedores.id;


--
-- TOC entry 254 (class 1259 OID 90209)
-- Name: rig_renovaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_renovaciones (
    id_prod smallint NOT NULL,
    id_prov smallint NOT NULL,
    id_ctra integer NOT NULL,
    id integer NOT NULL,
    fcha_reg date
);


ALTER TABLE public.rig_renovaciones OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 90214)
-- Name: rig_renovaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_renovaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rig_renovaciones_id_seq OWNER TO postgres;

--
-- TOC entry 3314 (class 0 OID 0)
-- Dependencies: 255
-- Name: rig_renovaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_renovaciones_id_seq OWNED BY public.rig_renovaciones.id;


--
-- TOC entry 216 (class 1259 OID 89831)
-- Name: rig_resultados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_resultados (
    id_prod smallint NOT NULL,
    id_prov smallint NOT NULL,
    fcha_reg timestamp without time zone NOT NULL,
    tipo_eval character varying(15) NOT NULL,
    res numeric(5,2) NOT NULL,
    CONSTRAINT rig_resultados_ck CHECK (((tipo_eval)::text = ANY ((ARRAY['INICIAL'::character varying, 'RENOVACION'::character varying])::text[])))
);


ALTER TABLE public.rig_resultados OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 89776)
-- Name: rig_sucursales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_sucursales (
    id_ubic smallint NOT NULL,
    id_prod smallint NOT NULL
);


ALTER TABLE public.rig_sucursales OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 89847)
-- Name: rig_variables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rig_variables (
    id smallint NOT NULL,
    nombre character varying(25) NOT NULL,
    des character varying(80) NOT NULL
);


ALTER TABLE public.rig_variables OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 89854)
-- Name: rig_variables_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rig_variables_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 10
    CACHE 1;


ALTER TABLE public.rig_variables_id_seq OWNER TO postgres;

--
-- TOC entry 3315 (class 0 OID 0)
-- Dependencies: 218
-- Name: rig_variables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rig_variables_id_seq OWNED BY public.rig_variables.id;


--
-- TOC entry 2891 (class 2604 OID 89713)
-- Name: rig_asociaciones_nacionales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_asociaciones_nacionales ALTER COLUMN id SET DEFAULT nextval('public.rig_asociaciones_nacionales_id_seq'::regclass);


--
-- TOC entry 2897 (class 2604 OID 89798)
-- Name: rig_condiciones_de_pago id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_de_pago ALTER COLUMN id SET DEFAULT nextval('public.rig_condiciones_de_pago_id_seq'::regclass);


--
-- TOC entry 2920 (class 2604 OID 90197)
-- Name: rig_contratos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_contratos ALTER COLUMN id SET DEFAULT nextval('public.rig_contrato_id_seq'::regclass);


--
-- TOC entry 2917 (class 2604 OID 90060)
-- Name: rig_familias_olfativas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_familias_olfativas ALTER COLUMN id SET DEFAULT nextval('public.rig_familias_olfativas_id_seq'::regclass);


--
-- TOC entry 2903 (class 2604 OID 89883)
-- Name: rig_ingredientes_esencias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_esencias ALTER COLUMN id SET DEFAULT nextval('public.rig_ingredientes_esencias_id_seq'::regclass);


--
-- TOC entry 2913 (class 2604 OID 90021)
-- Name: rig_intensidades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_intensidades ALTER COLUMN id SET DEFAULT nextval('public.rig_intensidades_id_seq'::regclass);


--
-- TOC entry 2890 (class 2604 OID 89703)
-- Name: rig_paises id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_paises ALTER COLUMN id SET DEFAULT nextval('public.rig_paises_id_seq'::regclass);


--
-- TOC entry 2916 (class 2604 OID 90050)
-- Name: rig_palabras_claves id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_palabras_claves ALTER COLUMN id SET DEFAULT nextval('public.rig_palabras_claves_id_seq'::regclass);


--
-- TOC entry 2924 (class 2604 OID 90274)
-- Name: rig_pedidos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_pedidos ALTER COLUMN id SET DEFAULT nextval('public.rig_pedidos_id_seq'::regclass);


--
-- TOC entry 2925 (class 2604 OID 90275)
-- Name: rig_pedidos factura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_pedidos ALTER COLUMN factura SET DEFAULT nextval('public.rig_factura_id_seq'::regclass);


--
-- TOC entry 2909 (class 2604 OID 89973)
-- Name: rig_perfumes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumes ALTER COLUMN id SET DEFAULT nextval('public.rig_perfumes_id_seq'::regclass);


--
-- TOC entry 2911 (class 2604 OID 89992)
-- Name: rig_perfumistas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumistas ALTER COLUMN id SET DEFAULT nextval('public.rig_perfumistas_id_seq'::regclass);


--
-- TOC entry 2906 (class 2604 OID 89918)
-- Name: rig_presentaciones_ingredientes cod_present; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_ingredientes ALTER COLUMN cod_present SET DEFAULT nextval('public.rig_presentaciones_ingredientes_id_seq'::regclass);


--
-- TOC entry 2907 (class 2604 OID 89941)
-- Name: rig_presentaciones_otros_ingredientes cod_present; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_otros_ingredientes ALTER COLUMN cod_present SET DEFAULT nextval('public.rig_presentaciones_otros_ingredientes_id_seq'::regclass);


--
-- TOC entry 2915 (class 2604 OID 90035)
-- Name: rig_presentaciones_perfumes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_perfumes ALTER COLUMN id SET DEFAULT nextval('public.rig_presentaciones_perfumes_id_seq'::regclass);


--
-- TOC entry 2893 (class 2604 OID 89735)
-- Name: rig_productores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productores ALTER COLUMN id SET DEFAULT nextval('public.rig_productores_id_seq'::regclass);


--
-- TOC entry 2894 (class 2604 OID 89758)
-- Name: rig_proveedores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores ALTER COLUMN id SET DEFAULT nextval('public.rig_proveedores_id_seq'::regclass);


--
-- TOC entry 2922 (class 2604 OID 90216)
-- Name: rig_renovaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_renovaciones ALTER COLUMN id SET DEFAULT nextval('public.rig_renovaciones_id_seq'::regclass);


--
-- TOC entry 2901 (class 2604 OID 89856)
-- Name: rig_variables id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_variables ALTER COLUMN id SET DEFAULT nextval('public.rig_variables_id_seq'::regclass);


--
-- TOC entry 3233 (class 0 OID 89704)
-- Dependencies: 204
-- Data for Name: rig_asociaciones_nacionales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_asociaciones_nacionales (id, nombre, region, id_ubic) FROM stdin;
1	FFAANZ - Flavour & Fragrance Association of Australia & New Zealand	ASIA-PACÍFICO	45
2	CAFFCI - China Association of Flavor, Fragrance & Cosmetic Industries	ASIA-PACÍFICO	35
3	AFFI - Asosiasi Flavor dan Fragran Indonesia	ASIA-PACÍFICO	74
4	JFFMA - Japan Flavor & Fragrance Materials Association 	ASIA-PACÍFICO	70
5	KFFA - Korea Flavor & Fragrance Association	ASIA-PACÍFICO	84
6	FFAS - Flavor & Fragrance Association Singapore 	ASIA-PACÍFICO	77
7	Prodarom	EUROPA	64
8	DVRH - Deustcher Verband der Riechstoff-Hersteller E.V.	EUROPA	18
9	AISPEC - Federchimica Assospecifici	EUROPA	29
10	NEA	EUROPA	19
11	SAAFFI - South African Association of the Flavour & Fragrance Industry	EUROPA	139
12	AEFAA - Asociación Española de Fragancias y Aromas Alimentarios	EUROPA	28
13	SFFIA - Swiss Flavour and Fragrance Industry Association	EUROPA	66
14	AREP	EUROPA	59
15	IFRA UK	EUROPA	13
16	CAFEPA - Cámara Argentina de Fabricantes de Productos Aromaticos	LATINOAMERICA	5
17	ABIFRA - Associaçao Brasileira das Industrias de Oleos Essenciais, Fragrancias, Aromas	LATINOAMERICA	12
18	ACHISAF - Asociación Chilena de Sabores y Fragancias Asociación	LATINOAMERICA	81
19	CISF - Cámara de la Industria de Sabores y Fragrancias	LATINOAMERICA	82
20	ANFPA - Asociación Nacional de Fabricantes de Productos Aromáticos 	LATINOAMERICA	42
21	Fragrance Creators Association	AMÉRICA DEL NORTE	55
\.


--
-- TOC entry 3279 (class 0 OID 90160)
-- Dependencies: 250
-- Data for Name: rig_componentes_funcionales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_componentes_funcionales (cas_otr_ing, id_perf) FROM stdin;
14314422	1
14314422	2
14314422	3
14314422	4
14314422	5
14314422	6
14314422	7
14314422	8
14314422	9
120514	1
120514	2
120514	3
120514	5
120514	6
120514	7
1934210	1
1934210	2
1934210	3
4548532	4
4430186	7
61734	7
97530	8
4430186	9
61734	9
\.


--
-- TOC entry 3285 (class 0 OID 90222)
-- Dependencies: 256
-- Data for Name: rig_condiciones_contratos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_condiciones_contratos (id_prod, id_prov, id_ctra, id, id_prov_ce, id_ubic, id_prov_cp, id_condpgo) FROM stdin;
\.


--
-- TOC entry 3243 (class 0 OID 89805)
-- Dependencies: 214
-- Data for Name: rig_condiciones_de_envio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_condiciones_de_envio (id_prov, id_ubic, nombre, porce_serv, medio) FROM stdin;
1	66	Envio simple	0.50	MARITIMO
1	2	Envio simple	0.50	MARITIMO
1	9	Envio simple	0.54	MARITIMO
1	22	Envio simple	0.56	MARITIMO
1	64	Envio express	0.10	TERRESTRE
1	18	Envio simple	0.55	MARITIMO
1	29	Envio simple	0.31	MARITIMO
1	15	Envio simple	0.51	MARITIMO
1	115	Envio simple	0.70	MARITIMO
1	46	Envio simple	0.50	MARITIMO
1	47	Envio simple	0.30	MARITIMO
1	50	Envio simple	0.52	MARITIMO
1	139	Envio simple con refrigeracion	0.60	AEREO
1	28	Envio simple	0.50	MARITIMO
1	136	Envio simple	0.50	MARITIMO
1	1	Envio con proteciones	0.80	TERRESTRE
1	25	Envios de gran volumen	0.50	MARITIMO
1	74	Envio simple	0.50	MARITIMO
1	69	Envio simple	0.50	MARITIMO
1	77	Envido con proteciones	0.70	MARITIMO
1	78	Envio simple	0.51	MARITIMO
1	92	Envio simple	0.90	MARITIMO
1	55	Envio simple	0.50	MARITIMO
1	5	Envio express	0.84	TERRESTRE
1	82	Envio simple	0.53	MARITIMO
1	42	Envio simple	0.54	MARITIMO
1	13	Envio simple	0.50	MARITIMO
1	104	Envio simple	0.70	AEREO
1	188	Envio simple	0.70	AEREO
1	59	Envio simple	0.70	AEREO
1	97	Envio simple	0.70	TERRESTRE
2	2	Envio simple	0.60	MARITIMO
2	9	Envio simple	0.50	MARITIMO
2	22	Envio simple	0.22	TERRESTRE
2	62	Envio express	0.10	TERRESTRE
2	18	Envio simple	0.50	MARITIMO
2	21	Envio simple	0.30	MARITIMO
2	15	Envio simple	0.50	MARITIMO
2	114	Envio simple	0.60	TERRESTRE
2	46	Envio simple	0.50	MARITIMO
2	47	Envio sin embalaje	0.30	MARITIMO
2	50	Envio simple	0.50	MARITIMO
2	139	Envio simple con refrigeracion	0.60	AEREO
2	28	Envio simple	0.50	MARITIMO
2	13	Envio simple	0.50	MARITIMO
2	1	Envio sin proteciones	0.20	TERRESTRE
2	25	Envios de gran volumen	0.50	MARITIMO
2	74	Envio simple	0.50	MARITIMO
2	69	Envio express	0.40	TERRESTRE
2	71	Envido con proteciones	0.70	MARITIMO
2	78	Envio simple	0.50	MARITIMO
2	92	Envio simple	0.90	MARITIMO
2	5	Envio simple	0.50	MARITIMO
2	54	Envio express	0.80	TERRESTRE
2	82	Envio simple	0.40	MARITIMO
2	42	Envio en container común	0.30	MARITIMO
2	77	Envio simple	0.41	MARITIMO
2	104	Envio simple	0.70	AEREO
2	140	Envio simple	0.70	AEREO
2	59	Envio simple	0.70	AEREO
2	97	Envio simple	0.70	TERRESTRE
3	2	Envio simple	0.30	MARITIMO
3	9	Envio simple	0.40	MARITIMO
3	22	Envio simple	0.50	MARITIMO
3	64	Envio express	0.10	TERRESTRE
3	18	Envio simple	0.50	MARITIMO
3	29	Envio simple	0.30	MARITIMO
3	15	Envio express con proteccion	0.90	MARITIMO
3	115	Envio simple	0.70	MARITIMO
3	46	Envio simple	0.50	MARITIMO
3	47	Envio express	0.40	MARITIMO
3	50	Envio simple	0.50	MARITIMO
3	139	Envio simple con refrigeracion	0.60	AEREO
3	28	Envio express	0.90	AEREO
3	68	Envio simple	0.50	MARITIMO
3	1	Envio con proteciones	0.80	TERRESTRE
3	25	Envios de gran volumen	0.50	MARITIMO
3	74	Envio simple	0.50	MARITIMO
3	69	Envio simple	0.50	MARITIMO
3	77	Envido con proteciones	0.70	MARITIMO
3	78	Envio simple	0.50	MARITIMO
3	92	Envio simple	0.90	MARITIMO
3	55	Envio express	0.70	AEREO
3	42	Envio simple	0.55	MARITIMO
3	13	Envio simple	0.50	MARITIMO
3	104	Envio simple	0.70	AEREO
3	188	Envio express	0.50	TERRESTRE
3	59	Envio simple	0.70	AEREO
3	97	Envio simple	0.70	TERRESTRE
4	2	Envio simple	0.50	MARITIMO
4	9	Envio simple	0.53	MARITIMO
4	22	Envio simple	0.50	MARITIMO
4	64	Envio express	0.10	TERRESTRE
4	18	Envio simple	0.50	MARITIMO
4	29	Envio simple	0.30	MARITIMO
4	15	Envio simple	0.50	MARITIMO
4	115	Envio simple	0.71	MARITIMO
4	46	Envio simple	0.25	MARITIMO
4	47	Envio simple	0.34	MARITIMO
4	50	Envio simple	0.50	MARITIMO
4	139	Envio simple con refrigeracion	0.60	AEREO
4	28	Envio simple	0.50	MARITIMO
4	13	Envio simple	0.50	MARITIMO
4	1	Envio con proteciones	0.81	TERRESTRE
4	25	Envios de gran volumen	0.50	MARITIMO
4	92	Envio simple	0.90	MARITIMO
4	55	Envio simple	0.45	MARITIMO
4	5	Envio express	0.80	TERRESTRE
4	82	Envio simple	0.50	MARITIMO
4	42	Envio simple	0.50	MARITIMO
4	74	Envio simple	0.54	MARITIMO
4	104	Envio simple	0.70	AEREO
4	188	Envio simple	0.22	AEREO
4	59	Envio simple	0.84	AEREO
4	97	Envio simple	0.69	TERRESTRE
5	2	Envio simple	0.51	MARITIMO
5	9	Envio simple	0.50	MARITIMO
5	22	Envio simple	0.25	MARITIMO
5	64	Envio express	0.10	TERRESTRE
5	18	Envio simple	0.54	MARITIMO
5	29	Envio simple	0.30	TERRESTRE
5	15	Envio simple	0.35	MARITIMO
5	46	Envio simple	0.85	AEREO
5	47	Envio simple	0.30	MARITIMO
5	50	Envio simple	0.25	MARITIMO
5	28	Envio simple	0.15	MARITIMO
5	121	Envio simple	0.53	MARITIMO
5	1	Envio con proteciones	0.80	TERRESTRE
5	25	Envios de gran volumen	0.50	MARITIMO
5	74	Envio simple	0.53	MARITIMO
5	69	Envio simple	0.50	MARITIMO
5	77	Envido con proteciones	0.70	MARITIMO
5	78	Envio simple	0.50	MARITIMO
5	55	Envio simple	0.50	MARITIMO
5	5	Envio express	1.00	AEREO
5	82	Envio simple	0.50	MARITIMO
5	42	Envio simple	0.50	MARITIMO
5	13	Envio simple	0.50	MARITIMO
5	104	Envio simple	0.70	AEREO
5	188	Envio simple	0.70	AEREO
6	2	Envio con refrigeracion	0.50	MARITIMO
6	9	Envio simple	0.50	MARITIMO
6	22	Envio simple	0.50	MARITIMO
6	64	Envio express	0.10	TERRESTRE
6	18	Envio simple	0.53	MARITIMO
6	29	Envio simple	0.32	MARITIMO
6	15	Envio simple	0.50	MARITIMO
6	115	Envio simple	0.70	MARITIMO
6	46	Envio con refrigeracion	0.50	MARITIMO
6	47	Envio simple	0.30	MARITIMO
6	50	Envio con refrigeracion	0.50	MARITIMO
6	139	Envio simple con refrigeracion	0.60	AEREO
6	28	Envio simple	0.52	MARITIMO
6	73	Envio simple	0.10	MARITIMO
6	1	Envio con proteciones	0.80	TERRESTRE
6	25	Envios de gran volumen	0.50	MARITIMO
6	74	Envio simple	0.50	MARITIMO
6	69	Envio simple	0.50	MARITIMO
6	77	Envido con proteciones	0.70	MARITIMO
6	78	Envio simple	0.50	MARITIMO
6	92	Envio con proteciones	0.90	MARITIMO
6	55	Envio simple	0.55	MARITIMO
6	5	Envio express	0.80	TERRESTRE
6	82	Envio simple	0.55	MARITIMO
6	42	Envio simple	0.55	MARITIMO
6	13	Envio simple	0.50	MARITIMO
6	104	Envio simple	0.70	AEREO
6	188	Envio simple	0.70	AEREO
6	59	Envio simple	0.70	AEREO
6	97	Envio simple	0.70	TERRESTRE
\.


--
-- TOC entry 3241 (class 0 OID 89791)
-- Dependencies: 212
-- Data for Name: rig_condiciones_de_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_condiciones_de_pago (id_prov, id, tipo, coutas, porcen_cuo, cant_meses) FROM stdin;
1	1	CONTADO	1	100.00	6
1	2	PARCIAL	4	25.00	6
1	3	PARCIAL	10	10.00	8
2	4	PARCIAL	5	20.00	4
3	5	PARCIAL	2	50.00	10
3	6	CONTADO	1	100.00	3
4	7	CONTADO	1	100.00	4
4	8	PARCIAL	4	25.00	4
5	9	CONTADO	1	100.00	5
5	10	PARCIAL	3	33.00	5
5	11	PARCIAL	2	50.00	6
6	12	PARCIAL	2	50.00	6
\.


--
-- TOC entry 3281 (class 0 OID 90190)
-- Dependencies: 252
-- Data for Name: rig_contratos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_contratos (id_prod, id_prov, id, fcha_reg, exc, cancelante, fcha_fin, mot_fin) FROM stdin;
\.


--
-- TOC entry 3290 (class 0 OID 90287)
-- Dependencies: 261
-- Data for Name: rig_detalles_pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_detalles_pedidos (id_ped, renglon, cantidad, id_prov_ing, id_ing, cod_pre_ing, cas_otr_ing, cod_pre_otr) FROM stdin;
\.


--
-- TOC entry 3244 (class 0 OID 89821)
-- Dependencies: 215
-- Data for Name: rig_escalas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_escalas (id_prod, fcha_reg, rgo_ini, rgo_fin, fcha_fin) FROM stdin;
1	2020-07-29 20:47:15.060359	0	20	2020-07-29
1	2020-07-29 20:47:26.790397	3	12	\N
2	2020-07-29 20:48:41.980786	0	8	\N
3	2020-07-29 20:48:52.066072	0	8	\N
\.


--
-- TOC entry 3278 (class 0 OID 90145)
-- Dependencies: 249
-- Data for Name: rig_esencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_esencias (id_fao, id_esenp) FROM stdin;
2	8007758
5	8007758
2	8008319
5	8000280
6	8000280
5	8000257
5	8014093
9	81152
2	84929317
4	2408200
9	977000660
8	117933898
8	929625081
8	68916018
9	93914
8	93914
3	84649810
3	89958292
3	55066494
8	55066494
8	91771334
9	91771334
4	102227
5	102227
10	84649990
8	15679126
10	15679126
3	8053336
3	133186
4	133186
10	91612
9	531599
9	977051629
4	59558235
4	52789738
3	84650602
\.


--
-- TOC entry 3274 (class 0 OID 90091)
-- Dependencies: 245
-- Data for Name: rig_esencias_perfumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_esencias_perfumes (cas, nombre, tipo) FROM stdin;
8007758	Bergamota	NATURAL
8008319	Mandarina	NATURAL
8000257	Romero	NATURAL
8014093	Patchouli	NATURAL
81152	Musk	SINTETICO
84929317	Limón	NATURAL
2408200	Manzana	NATURAL
977000660	Canela	NATURAL
117933898	Caoba	NATURAL
929625081	Cedro	NATURAL
68916018	Sándalo	NATURAL
93914	Vainilla	NATURAL
84649810	Rosa	NATURAL
89958292	Clavel	NATURAL
55066494	Lirio	NATURAL
91771334	Bamboo	NATURAL
8000280	Lavanda	NATURAL
102227	Geranio	NATURAL
84649990	Lacteos	NATURAL
15679126	Pistacho	NATURAL
8053336	Violeta	NATURAL
133186	Iris	NATURAL
91612	Cuero	SINTETICO
531599	Semillas de tonka	NATURAL
977051629	Pimienta negra	NATURAL
59558235	Ylang	NATURAL
52789738	Higo	NATURAL
84650602	Te negro	NATURAL
\.


--
-- TOC entry 3248 (class 0 OID 89857)
-- Dependencies: 219
-- Data for Name: rig_evaluaciones_criterios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_evaluaciones_criterios (id_prod, id_var, fcha_reg, tipo_eval, peso, fcha_fin) FROM stdin;
\.


--
-- TOC entry 3270 (class 0 OID 90051)
-- Dependencies: 241
-- Data for Name: rig_familias_olfativas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_familias_olfativas (id, nombre) FROM stdin;
1	Verde
2	Citrico
3	Flores
4	Frutas
5	Aromáticos
6	Helechos
7	Chipre
8	Maderas
9	Orientales
10	Otros
\.


--
-- TOC entry 3273 (class 0 OID 90076)
-- Dependencies: 244
-- Data for Name: rig_familias_perfumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_familias_perfumes (id_perf, id_fao) FROM stdin;
1	2
1	5
1	7
1	9
2	2
2	8
3	3
3	8
3	2
4	5
4	9
4	2
5	8
5	9
5	10
6	3
6	10
7	5
7	9
8	5
8	8
8	9
9	5
9	8
9	9
\.


--
-- TOC entry 3249 (class 0 OID 89873)
-- Dependencies: 220
-- Data for Name: rig_ingredientes_esencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_ingredientes_esencias (id_prov, id, cas, nombre, tipo, des, solubilidad, peligrosidad, vida_alm, ctrl) FROM stdin;
3	1	5392405	Citral	NATURAL	Citral tiene un fuerte olor a limón (cítrico). El olor a limón de Neral es menos intenso, pero más dulce. Por lo tanto, Citral es un compuesto aromático utilizado en perfumería por su efecto cítrico. Citral también se usa como sabor y para fortificar el aceite de limón. También tiene fuertes cualidades antimicrobianas y efectos feromonales en ácaros e insectos. Citral se usa en la síntesis de vitamina A, licopeno, ionona y metilionona, para enmascarar el olor a humo.	Soluble en alcohol, aceite de parafina y agua de 1340 mg/L a 25°C	BAJA	720	\N
3	2	106241	Geraniol	NATURAL	El geraniol es un monoterpenoide y un alcohol. Es el componente principal del aceite de rosa, el aceite de palmarosa y el aceite de citronela. Es un aceite incoloro, aunque las muestras comerciales pueden aparecer amarillas. El grupo funcional derivado del geraniol (en esencia, geraniol que carece del terminal -OH) se llama geranilo.	Soluble en alcohol, aceite de parafina, kerosene y agua de 25.16 mg/L a 25°C	BAJA	720	\N
3	3	79776	Beta-ionone	NATURAL	La beta-ionona es un líquido incoloro a amarillo claro con olor a madera de cedro. En una solución alcohólica muy diluida, el olor se asemeja al olor a violetas. La beta-ionona se encuentra en la zanahoria y en muchos aceites esenciales, incluido el aceite de boronia megastigma (boronia marrón) y la ionona comercial. También es un agente saborizante.	Soluble en alcohol y agua de 1340 mg/L a 25°C	MEDIA	720	\N
1	4	70788306	Propanol de madera	SINTETICO	Es un isómero muy común en la industria del perfume. Se caracteriza por su olor fuerte a madera y almizcle. Su fórmula química es 1-(2,2,6-trimethylcyclohexyl)hexan-3-ol	Soluble en alcohol y agua de 1.149 mg/L a 25°C	BAJA	720	\N
1	5	98555	Terpineol alpha	NATURAL	Terpineol con fórmula química C10H18O, es una forma natural de monoterpeno de alcohol que se ha aislado a partir de una variedad de fuentes tales como el aceite de cajeput, aceite de pino, y aceite petitgrain. Hay cuatro isómeros , alfa -, beta -, gamma -terpineol, y terpinen-4-ol. beta - y gamma -terpineol difieren sólo por la ubicación del doble enlace. Terpineol es por lo general una mezcla de estos isómeros con alfa -terpineol como componente principal.	Soluble en alcohol, aceite de parafina, kerosene y agua de 710 mg/L a 25°C	BAJA	720	\N
1	6	88415	Otcbha	NATURAL	Compuesto de incoloro o amarillo pálido que tiene un fuerte y duradero olor a manzana. Este compuesto es usado generalmente como solvente o como componente de fragancias	Solubilidad en alcohol, aceite de parafina y agua de 7.462 mg/L a 25	MEDIA	720	\N
2	7	93925	Aceite de styrallyl	NATURAL	Compuesto de color amarillo pálido con un dulce olor frutal y herbaceo. Este compuesto es usado generalmente para otorgar un olor a gardenia	Solubilidad en alcohol, aceite de parafina y agua de 481.1 mg/L a 25	MEDIA	720	\N
2	8	60128	Alcohol fenetílico	NATURAL	El alcohol fenetílico, o 2-feniletanol, es el compuesto orgánico que consiste en un grupo de grupo fenetilo (C6H5CH2CH2) unido a OH. Es un líquido incoloro se encuentra presente ampliamente en la naturaleza, se encuentra en una variedad de aceites esenciales. Tiene un agradable olor floral.	Soluble en alcohol, aceite de parafina, kerosene y agua de 2.199e+004 mg/L a 25°C	BAJA	720	\N
2	9	103957	Aldehído de ciclamen	SINTETICO	El aldehído de ciclamen es una molécula de fragancia que se ha utilizado en jabones, detergentes, lociones y perfumes desde la década de 1920. Adicionalmete es empleado en aditivos para alimentos de forma directa	Soluble en alcohol, aceite de parafina y agua de 22.59 mg/L a 25°C	BAJA	720	\N
4	10	125122	Acetato de bornilo	SINTETICO	Acetato de Bornilo es una molécula sintética altamente utilizada en la industria del perfume y en la elaboración de fragancias	Soluble en alcohol, aceite de parafina, kerosene y agua de 9.721 mg/L a 25°C	BAJA	720	\N
4	11	141128	Acetato de nerilo	SINTETICO	Acetato de nerilo es un compuesto químico que se encuentra en los aceites de cítricos. Químicamente, es el acetato de éster de nerol. Se utiliza en sabores y en perfumería para impartir aromas florales y frutales.	Soluble en alcohol, aceite de parafina y agua de 18.24 mg/L a 25°C	BAJA	720	\N
4	12	7785333	(+)-α-Terpineol	NATURAL	Es un compuesto orgánico de la clase terpeno, uno de los dos isómeros del pineno que está presente en algunos aceites, tales como el aceite de eucalipto y aceite de cáscara de naranja	Soluble en alcohol y agua de 0.3194 mg/L a 25°C	BAJA	720	\N
5	13	100061	Acetanisola	SINTETICO	El acetanisol es un compuesto químico aromático con un aroma descrito como dulce, afrutado, a nuez y similar a la vainilla. Además, el acetanisol a veces puede oler a mantequilla o caramelo. El acetanisol se encuentra naturalmente en el castoreum, la secreción glandular del castor.	Soluble en alcohol y agua de 2474 mg/L a 25°C	BAJA	720	\N
5	14	52474609	Aldemone	SINTETICO	Es un compuesto químico de olor marino/ozono muy difuso. Su fórmula es 1-(4-methoxyphenyl)ethanone y usualmente se encuentra como cristales bláncos o amarillos muy pálidos	Soluble en alcohol y agua de 1.512 mg/L a 25°C	BAJA	720	\N
5	15	2051787	Octanoato de allil	SINTETICO	Es un compuesto químico incoloro y cristalino, de olor a piña/frutal de duración media. También es conocido bajo el nombre de prop-2-enyl butanoate	Soluble en alcohol y agua de 1233 mg/L a 25°C	MEDIA	720	\N
6	16	8015734	Aceite de albahaca dulce	NATURAL	La albahaca es una hierba aromática original de Irán, India, Pakistán y otras regiones tropicales de Asia. El aceite esencial de albahaca es rico en estragol	Soluble en alcohol, aceite de parafina y agua de 332.1 mg/L a 25°C	BAJA	720	\N
6	17	8006824	Aceite de pimienta negra	NATURAL	Proviene de un fruto de aproximadamente 5 mm que se puede usar entero o en polvo para la elaboración de fragancias picantes o como aditivo alimenticio	Soluble en alcohol	BAJA	180	\N
6	18	8015881	Aceite de semillas de zanahoria	NATURAL	El aceite esencial de zanahoria se extrae de las semillas secas de zanahoria mediante la destilación por vapor, la cual preserva perfectamente los nutrientes valiosos. Las semillas de zanahoria producen el aceite esencial pero también pueden utilizarse otras partes de la planta	Soluble en alcohol, aceite de parafina y agua de 8.507 mg/L a 25°C	BAJA	720	\N
\.


--
-- TOC entry 3258 (class 0 OID 89948)
-- Dependencies: 229
-- Data for Name: rig_ingredientes_extras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_ingredientes_extras (id_prov_ing, id_ing, cas_otr_ing) FROM stdin;
3	2	14314422
3	1	14314422
6	16	14314422
6	17	14314422
6	18	14314422
2	8	14314422
1	4	100516
5	15	100516
3	3	100516
\.


--
-- TOC entry 3275 (class 0 OID 90099)
-- Dependencies: 246
-- Data for Name: rig_ingredientes_familias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_ingredientes_familias (id_prov, id_ing, id_fao) FROM stdin;
3	1	2
3	2	3
3	3	8
3	3	3
1	4	8
1	5	8
1	5	2
1	6	2
2	7	2
2	8	4
2	9	3
4	10	3
4	11	2
4	12	1
5	13	5
5	14	5
5	14	1
5	15	4
6	16	5
6	16	6
6	17	8
6	18	8
\.


--
-- TOC entry 3264 (class 0 OID 90014)
-- Dependencies: 235
-- Data for Name: rig_intensidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_intensidades (id_perf, id, tipo, porcen, des) FROM stdin;
1	1	EdT	\N	\N
2	2	EdP	\N	\N
3	3	EdT	\N	\N
4	4	EdP	\N	\N
5	5	EdP	\N	\N
6	6	EdP	\N	\N
7	7	EdT	\N	\N
8	8	EdT	\N	\N
9	9	EdP	\N	\N
\.


--
-- TOC entry 3239 (class 0 OID 89769)
-- Dependencies: 210
-- Data for Name: rig_membresias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_membresias (fcha_reg, tipo_m, fcha_fin, id_prod, id_prov) FROM stdin;
2020-07-29 20:45:25.691572	PRINCIPAL	\N	1	\N
2020-07-29 20:45:26.691572	REGIONAL	\N	2	\N
2020-07-29 20:45:27.691572	REGIONAL	\N	3	\N
2020-07-29 20:45:24.691572	SECUNDARIO	\N	\N	1
2020-07-29 20:45:28.691572	SECUNDARIO	\N	\N	2
2020-07-29 20:45:29.691572	PRINCIPAL	\N	\N	3
2020-07-29 20:45:30.691572	REGIONAL	\N	\N	4
2020-07-29 20:45:31.691572	REGIONAL	\N	\N	5
2020-07-29 20:45:32.691572	REGIONAL	\N	\N	6
\.


--
-- TOC entry 3277 (class 0 OID 90130)
-- Dependencies: 248
-- Data for Name: rig_monoliticos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_monoliticos (id_perf, id_esenp) FROM stdin;
5	84649990
5	15679126
5	93914
7	81152
7	531599
\.


--
-- TOC entry 3276 (class 0 OID 90114)
-- Dependencies: 247
-- Data for Name: rig_notas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_notas (id_perf, id_esenp, tipo) FROM stdin;
1	8007758	SALIDA
1	8008319	SALIDA
1	8000280	CORAZON
1	8000257	CORAZON
1	8014093	FONDO
1	81152	FONDO
2	84929317	SALIDA
2	2408200	SALIDA
2	977000660	CORAZON
2	117933898	CORAZON
2	89958292	CORAZON
2	929625081	FONDO
2	68916018	FONDO
2	93914	FONDO
3	84929317	SALIDA
3	84649810	SALIDA
3	89958292	CORAZON
3	55066494	CORAZON
3	81152	FONDO
3	8014093	FONDO
4	84929317	SALIDA
4	91771334	SALIDA
4	8000280	CORAZON
4	102227	CORAZON
4	117933898	FONDO
4	929625081	FONDO
6	8053336	SALIDA
6	133186	CORAZON
6	91612	FONDO
8	8008319	SALIDA
8	977051629	SALIDA
8	59558235	SALIDA
8	102227	CORAZON
8	93914	FONDO
8	8014093	FONDO
9	52789738	SALIDA
9	84650602	SALIDA
9	133186	CORAZON
9	68916018	FONDO
9	531599	FONDO
\.


--
-- TOC entry 3280 (class 0 OID 90175)
-- Dependencies: 251
-- Data for Name: rig_origenes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_origenes (id_fao, id_esenp) FROM stdin;
\.


--
-- TOC entry 3251 (class 0 OID 89890)
-- Dependencies: 222
-- Data for Name: rig_origenes_ingredientes_esencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_origenes_ingredientes_esencias (id_prov, id_ing, id_ubic) FROM stdin;
3	1	18
3	2	24
3	3	18
1	4	37
1	5	18
1	6	24
2	7	25
2	8	25
2	9	25
4	10	25
4	11	25
4	12	25
5	13	28
5	14	28
5	15	28
6	16	64
6	17	64
6	18	64
\.


--
-- TOC entry 3255 (class 0 OID 89924)
-- Dependencies: 226
-- Data for Name: rig_otros_ingredientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_otros_ingredientes (id_prov, cas, nombre, des) FROM stdin;
1	14314422	Agua	Agua, solvente universal e indispensable para la vida
1	120514	Benzoato de bencilo	El benzoato de bencilo es el éster bencílico del ácido benzoico. Es un compuesto orgánico de fórmula C6H5CH2O2CC6H5
2	100516	Alcohol bencílico	El alcohol bencílico es un compuesto orgánico cuya fórmula es C6H5CH2OH
\N	97530	Eugenol	Eugenol (C10H12O2) es guaiacol con una cadena alil sustituda
\N	4548532	Rojo 4	FD&C red No. 4 es un colorante artificial ampliamente utilizado
3	4430186	Violeta 2	Violeta 2 es un colorante artificial ampliamente utilizado
3	1934210	Amarillo 5	El amarillo 5 es conocido también como tartracina ó E102
\N	61734	Azul de metileno	El azul de metileno, también llamado cloruro de metiltionina, es un colorante orgánico
\N	60177391	Amberita	Es una resina incolora o amarillenta
\.


--
-- TOC entry 3291 (class 0 OID 90308)
-- Dependencies: 262
-- Data for Name: rig_pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_pagos (id_ped, id_ord, fcha_reg, total) FROM stdin;
\.


--
-- TOC entry 3231 (class 0 OID 89694)
-- Dependencies: 202
-- Data for Name: rig_paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_paises (id, nombre) FROM stdin;
1	Australia
2	Austria
3	Azerbaiyán
4	Anguilla
5	Argentina
6	Armenia
7	Bielorrusia
8	Belice
9	Bélgica
10	Bermudas
11	Bulgaria
12	Brasil
13	Reino Unido
14	Hungría
15	Vietnam
16	Haiti
17	Guadalupe
18	Alemania
19	Países Bajos - Holanda
20	Grecia
21	Georgia
22	Dinamarca
23	Egipto
24	Israel
25	India
26	Irán
27	Irlanda
28	España
29	Italia
30	Kazajstán
31	Camerún
32	Canadá
33	Chipre
34	Kirguistán
35	China
36	Costa Rica
37	Kuwait
38	Letonia
39	Libia
40	Lituania
41	Luxemburgo
42	México
43	Moldavia
44	Mónaco
45	Nueva Zelanda
46	Noruega
47	Polonia
48	Portugal
49	Reunión
50	Rusia
51	El Salvador
52	Eslovaquia
53	Eslovenia
54	Surinam
55	Estados Unidos
56	Tadjikistan
57	Turkmenistan
58	Islas Turcas y Caicos
59	Turquía
60	Uganda
61	Uzbekistán
62	Ucrania
63	Finlandia
64	Francia
65	República Checa
66	Suiza
67	Suecia
68	Estonia
69	Corea del Sur
70	Japón
71	Croacia
72	Rumanía
73	Hong Kong
74	Indonesia
75	Jordania
76	Malasia
77	Singapur
78	Taiwan
79	Bosnia y Herzegovina
80	Bahamas
81	Chile
82	Colombia
83	Islandia
84	Corea del Norte
85	Macedonia
86	Malta
87	Pakistán
88	Papúa-Nueva Guinea
89	Perú
90	Filipinas
91	Arabia Saudita
92	Tailandia
93	Emiratos árabes Unidos
94	Groenlandia
95	Venezuela
96	Zimbabwe
97	Kenia
98	Algeria
99	Líbano
100	Botsuana
101	Tanzania
102	Namibia
103	Ecuador
104	Marruecos
105	Ghana
106	Siria
107	Nepal
108	Mauritania
109	Seychelles
110	Paraguay
111	Uruguay
112	Congo (Brazzaville)
113	Cuba
114	Albania
115	Nigeria
116	Zambia
117	Mozambique
118	Angola
119	Sri Lanka
120	Etiopía
121	Túnez
122	Bolivia
123	Panamá
124	Malawi
125	Liechtenstein
126	Bahrein
127	Barbados
128	Chad
129	Man, Isla de
130	Jamaica
131	Malí
132	Madagascar
133	Senegal
134	Togo
135	Honduras
136	República Dominicana
137	Mongolia
138	Irak
139	Sudáfrica
140	Aruba
141	Gibraltar
142	Afganistán
143	Andorra
144	Antigua y Barbuda
145	Bangladesh
146	Benín
147	Bután
148	Islas Virgenes Británicas
149	Brunéi
150	Burkina Faso
151	Burundi
152	Camboya
153	Cabo Verde
154	Comores
155	Congo (Kinshasa)
156	Cook, Islas
157	Costa de Marfil
158	Djibouti, Yibuti
159	Timor Oriental
160	Guinea Ecuatorial
161	Eritrea
162	Feroe, Islas
163	Fiyi
164	Polinesia Francesa
165	Gabón
166	Gambia
167	Granada
168	Guatemala
169	Guernsey
170	Guinea
171	Guinea-Bissau
172	Guyana
173	Jersey
174	Kiribati
175	Laos
176	Lesotho
177	Liberia
178	Maldivas
179	Martinica
180	Mauricio
181	Myanmar
182	Nauru
183	Antillas Holandesas
184	Nueva Caledonia
185	Nicaragua
186	Níger
187	Norfolk Island
188	Omán
189	Isla Pitcairn
190	Qatar
191	Ruanda
192	Santa Elena
193	San Cristobal y Nevis
194	Santa Lucía
195	San Pedro y Miquelón
196	San Vincente y Granadinas
197	Samoa
198	San Marino
199	San Tomé y Príncipe
200	Serbia y Montenegro
201	Sierra Leona
202	Islas Salomón
203	Somalia
204	Sudán
205	Swazilandia
206	Tokelau
207	Tonga
208	Trinidad y Tobago
209	Tuvalu
210	Vanuatu
211	Wallis y Futuna
212	Sáhara Occidental
213	Yemen
214	Puerto Rico
\.


--
-- TOC entry 3268 (class 0 OID 90041)
-- Dependencies: 239
-- Data for Name: rig_palabras_claves; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_palabras_claves (id, palabra) FROM stdin;
1	verde
2	fresca
3	optimista
4	natural
5	libre
6	deshinibida
7	cítrico
8	juvenil
9	efímero
10	volatil
11	estimulante
12	olor fuerte
13	placer
14	verano
15	refrescante
16	floral
17	fresco
18	tranquilidad
19	relajante
20	alegre
21	vivo
22	frutal
23	tropical
24	felicidad
25	ganas de vivir
26	aromático
27	vital
28	asertivo
29	tenaz
30	lucidez
31	vigor
32	familiaridad
33	profundidad
34	energía
35	confianza
36	atemporal
37	cálido
38	seco
39	amaderado
40	almizclado
41	sensual
42	intensos
43	oriental
44	empolvados
45	otros
\.


--
-- TOC entry 3272 (class 0 OID 90061)
-- Dependencies: 243
-- Data for Name: rig_palabras_familias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_palabras_familias (id_pal, id_fao) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	2
8	2
9	2
10	2
11	2
12	2
13	2
14	2
15	2
16	3
17	3
18	3
19	3
20	3
21	3
15	3
30	3
22	4
23	4
24	4
25	4
15	4
14	4
26	5
27	5
28	5
29	5
30	5
31	5
32	5
33	6
34	6
35	6
36	6
37	7
38	7
39	8
37	8
38	8
40	9
41	9
42	9
43	9
44	9
37	9
38	9
45	10
\.


--
-- TOC entry 3287 (class 0 OID 90262)
-- Dependencies: 258
-- Data for Name: rig_pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_pedidos (id, fcha_reg, estatus, factura, total, id_prod_conp, id_prov_conp, id_ctra_conp, id_conp, id_prod_cone, id_prov_cone, id_ctra_cone, id_cone) FROM stdin;
\.


--
-- TOC entry 3259 (class 0 OID 89963)
-- Dependencies: 230
-- Data for Name: rig_perfumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_perfumes (id, id_prod, nombre, genero, tipo, edad, fcha_crea, des) FROM stdin;
1	1	Acqua di Giò de Giorgio Armani	M	FASES	ADULTO	1996	Acqua di Giò no es solo agua. Es una fragancia de la vida, una oda voluptuosa a la naturaleza y su perfección, a un hombre que ama la libertad y seguro de sí mismo, que se convierte en uno con el mar.
2	1	Boss Bottled de Hugo Boss	M	FASES	ADULTO	2008	Boss Bottled Intense reveals the Man of Today and his strength of character. The fragrance is laden with more woods, spices and a powerful concentration of precious oils. Bright apple is tempered by a calmer and more composed green orange blossom. The effect is a fragrance that is less sweet, yet more luxurious, and emphatically, unapologetically masculine.
3	1	Romance de Ralph Lauren	F	FASES	ADULTO	1999	Es un aroma de amor romántico y momentos íntimos llenos de alegría y felicidad, con un aura infinitamente positiva. Al comienzo de la composición, las notas de rosa se mezclan con aceites cítricos y reciben una melodía inusual y única.
4	2	Joseph Abboud de Joseph Abboud	M	FASES	ADULTO	2016	Un aroma masculino refrescante, el índigo descolorido de Joseph Abboud se basa en aromas amaderados aromáticos con notas medias marinas refrescantes. Las notas altas de limón picante completan este fino aroma, ideal para el uso diario y en ocasiones especiales.
5	2	Pistachio Brûlée de Urban Outfitters	F	MONO	ADULTO	2014	Pistachio Brulee Eau De Parfum para mujer. Pistachio Brulee: mousse de vainilla con leche, pistacho y vainilla. Las fragancias sin crueldad le permiten optar por algo fresco, femenino o dulce, todo dependiendo de su estado de ánimo. días de verano con elegantes flores frescas o la fresca brisa del mar, estos son elementos imprescindibles sin los que no podemos vivir
6	2	Paris, She Met Him In Secret de Fictions Perfume	F	MONO	ADULTO	2019	Paris: She Met Him in Secret is an exploration of unauthorized love. This Fictions perfume is classified as a floral chypre fragrance, characterized by a contrast between fresh floral notes and a deep, sensual dry down. 
7	3	Exotic Musk	F	MONO	ADULTO	2019	Mostrando el preciado ingrediente aromático que evoca vívidamente un destino exótico, cada fragancia de Bentley Beyond - The Collection traduce un viaje en aroma. Compuesto por tres nuevos perfumistas jóvenes, el primer trío de la colección nos lleva a tres países diferentes, cada uno asociado con una nota olfativa y un tema de color inspirado en
8	3	Let you Love Me de Blumarine	F	MONO	ADULTO	2020	La nueva fragancia femenina Let You Love Me huele a audacia y sensualidad, determinación y feminidad, y la fuerza invencible de una mujer apasionada que besa al hombre de sus sueños y le dice: "Te dejo amarme". La fragancia pertenece al Familia olfativa de aromáticos orientales.
9	3	Gris Charnel de BDK Parfums	U	FASES	ADULTO	2019	Gris Charnel es un aroma de piel, creado con la idea de la sensualidad, la intimidad. Evoca mañanas parisinas grises, donde uno se despierta con un deseo de capullo, todavía consolado por el calor del otro. Es una fragancia que actúa como una segunda piel, sacando su dulzura de un cremoso acuerdo de sándalo indio.
\.


--
-- TOC entry 3263 (class 0 OID 89999)
-- Dependencies: 234
-- Data for Name: rig_perfumes_perfumistas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_perfumes_perfumistas (id_perf, id_prefta) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	7
\.


--
-- TOC entry 3261 (class 0 OID 89980)
-- Dependencies: 232
-- Data for Name: rig_perfumistas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_perfumistas (id, nombre, genero, fcha_nac, id_ubic) FROM stdin;
1	Giorgio Armani	M	1934-07-11	29
2	Annick Menardo	F	1985-09-13	29
3	Ralph Lauren	M	1939-10-04	55
4	Joseph Abboud	M	1950-05-05	55
5	Olivier Polge	M	1978-01-07	29
6	Alexandra Monet	F	1970-06-08	29
7	Mathilde Bijaoui	F	1975-08-03	64
8	Veronique Nyberg	F	1964-07-15	18
\.


--
-- TOC entry 3253 (class 0 OID 89911)
-- Dependencies: 224
-- Data for Name: rig_presentaciones_ingredientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_presentaciones_ingredientes (id_prov, id_ing, cod_present, medida, unidad, precio) FROM stdin;
3	1	1	4.00	ml	3.25
3	1	2	15.00	ml	5.00
3	1	3	30.00	ml	6.25
3	1	4	80.00	ml	14.31
3	1	5	250.00	g	41.00
3	1	6	500.00	g	69.00
3	1	7	1.00	kg	118.00
3	2	8	4.00	ml	3.00
3	2	9	15.00	ml	6.00
3	2	10	30.00	ml	6.30
3	2	11	80.00	ml	14.43
3	2	12	250.00	g	28.00
3	3	13	4.00	ml	3.00
3	3	14	15.00	ml	6.00
3	3	15	30.00	ml	10.00
3	3	16	80.00	ml	15.00
3	3	17	250.00	g	25.00
3	3	18	500.00	g	35.00
1	4	19	4.00	ml	4.50
1	4	20	15.00	ml	10.50
1	4	21	30.00	ml	18.50
1	4	22	80.00	ml	40.50
1	4	23	250.00	g	122.00
1	4	24	500.00	g	232.00
1	5	25	4.00	ml	3.00
1	5	26	15.00	ml	6.00
1	5	27	30.00	ml	10.00
1	5	28	80.00	ml	20.00
1	5	29	250.00	g	50.00
1	5	30	500.00	g	75.00
1	5	31	1.00	kg	150.00
1	6	32	4.00	ml	3.00
1	6	33	15.00	ml	6.00
1	6	34	30.00	ml	9.00
1	6	35	80.00	ml	15.00
1	6	36	250.00	g	23.00
2	7	37	4.00	ml	3.00
2	7	38	15.00	ml	6.00
2	7	39	30.00	ml	9.00
2	7	40	80.00	ml	15.00
2	8	41	4.00	ml	3.00
2	8	42	15.00	ml	6.00
2	8	43	30.00	ml	8.00
2	8	44	80.00	ml	11.00
2	8	45	250.00	g	26.50
2	8	46	500.00	g	48.00
2	8	47	1.00	kg	62.00
2	9	48	4.00	ml	3.00
2	9	49	15.00	ml	6.00
2	9	50	30.00	ml	9.00
2	9	51	80.00	ml	12.00
4	10	52	4.00	ml	3.00
4	10	53	15.00	ml	6.00
4	10	54	30.00	ml	9.00
4	10	55	80.00	ml	15.00
4	11	56	4.00	ml	3.00
4	11	57	15.00	ml	6.00
4	11	58	30.00	ml	9.00
4	11	59	80.00	ml	15.00
4	12	60	4.00	ml	3.00
4	12	61	15.00	ml	6.00
4	12	62	30.00	ml	9.00
4	12	63	80.00	ml	15.00
5	13	64	8.00	g	3.00
5	13	65	30.00	g	9.00
5	13	66	80.00	g	15.00
5	14	67	4.00	ml	5.00
5	14	68	15.00	ml	8.00
5	14	69	30.00	ml	10.00
5	14	70	80.00	ml	15.00
5	15	71	4.00	ml	5.00
5	15	72	15.00	ml	8.00
5	15	73	30.00	ml	10.00
5	15	74	80.00	ml	15.00
6	16	75	4.00	ml	3.00
6	17	76	4.00	ml	3.00
6	17	77	15.00	ml	7.50
6	17	78	30.00	ml	12.00
6	17	79	80.00	ml	28.00
6	18	80	4.00	ml	4.50
6	18	81	15.00	ml	9.00
6	18	82	30.00	ml	15.00
\.


--
-- TOC entry 3256 (class 0 OID 89934)
-- Dependencies: 227
-- Data for Name: rig_presentaciones_otros_ingredientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_presentaciones_otros_ingredientes (cas_otr_ing, cod_present, precio, volumen, unidad, otra_pre, des) FROM stdin;
14314422	1	23.30	100.00	L	\N	Bidón de 100 litros
14314422	2	40.23	200.00	L	\N	Bidón de 200 litros
14314422	3	59.99	500.00	L	\N	Bidón de 500 litros
120514	4	20.00	20.00	ml	\N	Frasco de vidrio
120514	5	38.00	40.00	ml	\N	Frasco sellado para larga duración
100516	6	8.00	20.00	ml	\N	Envase de plástico
100516	7	15.00	40.00	ml	\N	Envase de plástico
4430186	8	3.00	1.00	Kg	\N	Empaque de aluminio con protección de humedad
4430186	9	100.00	25.00	Kg	\N	Barril de 25 Kg con protección de humedad
1934210	10	2.00	1.00	Kg	\N	Empaque de aluminio con protección de humedad
1934210	11	93.56	25.00	Kg	\N	Barril de 25 Kg con protección de humedad
\.


--
-- TOC entry 3266 (class 0 OID 90028)
-- Dependencies: 237
-- Data for Name: rig_presentaciones_perfumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_presentaciones_perfumes (id_perf, id_int, id, vol, unidad) FROM stdin;
1	1	1	8.10	ml
1	1	2	30.00	ml
1	1	3	51.00	ml
1	1	4	100.00	ml
1	1	5	200.00	ml
2	2	6	8.10	ml
2	2	7	30.00	ml
2	2	8	50.00	ml
2	2	9	100.00	ml
2	2	10	200.00	ml
3	3	11	10.00	ml
3	3	12	30.00	ml
3	3	13	50.00	ml
3	3	14	90.00	ml
3	3	15	150.00	ml
4	4	16	15.00	ml
4	4	17	35.00	ml
4	4	18	60.00	ml
4	4	19	120.00	ml
4	4	20	180.00	ml
5	5	21	12.00	ml
5	5	22	24.00	ml
5	5	23	50.00	ml
6	6	24	12.00	ml
6	6	25	50.00	ml
6	6	26	80.00	ml
6	6	27	130.00	ml
7	7	28	15.00	ml
7	7	29	35.00	ml
7	7	30	60.00	ml
7	7	31	120.00	ml
7	7	32	180.00	ml
8	8	33	15.00	ml
8	8	34	35.00	ml
8	8	35	70.00	ml
8	8	36	130.00	ml
8	8	37	150.00	ml
9	9	38	25.00	ml
9	9	39	40.00	ml
9	9	40	85.00	ml
9	9	41	115.00	ml
\.


--
-- TOC entry 3235 (class 0 OID 89720)
-- Dependencies: 206
-- Data for Name: rig_productores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_productores (id, nombre, pag, info_cto, email, telf, id_aso_nac) FROM stdin;
1	Firmenich	www.firmenich.com	Rue de la Bergère 7 P.O. Box 148 Switzerland	firmenich@ifra.com	+41 22 780 22 11	\N
2	Tru Fragance	www.trufragrance.com	350 Fifth Ave. Ste 6100 New York, NY 10118	customercare@trufragrance.com	+1 800 443 3000	21
3	MANE	www.mane.com	Avenue Jean Monnet	info@mane.com	+33 2 43 62 11 00	7
\.


--
-- TOC entry 3286 (class 0 OID 90242)
-- Dependencies: 257
-- Data for Name: rig_productos_contratados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_productos_contratados (id_prod, id_prov, id_ctra, id, id_prov_ing, id_ing, cas_otr_ing) FROM stdin;
\.


--
-- TOC entry 3252 (class 0 OID 89905)
-- Dependencies: 223
-- Data for Name: rig_prohibidas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_prohibidas (cas, nombre, tipo) FROM stdin;
100516	Benzyl alcohol	R
100527	Benzaldehyde	R
101393	α-Methyl cinnamic aldehyde	R
101859	α-Amyl cinnamic alcohol	R
101860	α-Hexyl cinnamic aldehyde	R
103413	Benzyl cinnamate	R
103504	Dibenzyl ether	R
103640	Bromostyrene	P
103957	Cyclamen aldehyde	R-S
103694684	2,2-Dimethyl-3-(3-tolyl)propan-1-ol	R-S
104278	α-Methyl anisylidene acetone	P
105135	Anisyl alcohol	R
1331813	Anisyl alcohol	R
106025	Cyclopentadecanolide	R
1117619	Citronellol	R
26489010	Citronellol	R
141253	Citronellol	R
7540514	Citronellol	R
106230	Citronellal	R
5949053	Citronellal	R
106241	Geraniol	R
107755	Hydroxycitronellal	R
107898544	3,3-Dimethyl-5-(2,2,3-trimethyl-3-cyclopenten-1-yl)-4-penten-2-ol	R
108883	Toluene	P-S
109864	Ethylene glycol monomethyl ether	P
110496	Ethylene glycol monomethyl acetate	P
110805	Ethylene glycol monoethyl ether	P
111159	Ethylene glycol monoethyl acetate	P
11028425	Cedrene	R
469614	Cedrene	R
546281	Cedrene	R
111126	Methyl heptine carbonate	R
111284	2,4-Hexadien-1-ol	P
17102646	2,4-Hexadien-1-ol	P
111808	Methyl octine carbonate	R
116267	2,6,6-Trimethylcyclohex-1,3-dienyl methanal	R
116665	Musk moskene	P
118581	Benzyl salicylate	R
119846	Dihydrocoumarin	R
120514	Benzyl benzoate	R
1205170	α-Methyl-1,3-benzodioxole-5-propionaldehyde (MMDHCA)	R
122032	Cuminaldehyde	R
122394	Diphenylamine	P
122407	α-Amyl cinnamic aldehyde	R
122576	Benzylidene acetone	P
122781	Phenylacetaldehyde	R
123115	p-Methoxybenzaldehyde	R
13144882	1-(2,4,4,5,5-Pentamethyl-1-cyclopenten-1-yl)ethan-1-one	R
13257448	2-Nonyn-1-al dimethyl acetal	R
1335462	Methyl ionone, mixed isomers	R-S
127424	Methyl ionone, mixed isomers	R-S
127435	Methyl ionone, mixed isomers	R-S
127515	Methyl ionone, mixed isomers	R-S
7779308	Methyl ionone, mixed isomers	R-S
79890	Methyl ionone, mixed isomers	R-S
1335940	Methyl ionone, mixed isomers	R-S
1335666	Isocyclocitral	R
1423467	Isocyclocitral	R
67634075	Isocyclocitral	R
13393936	Hydroabietyl alcohol, Dihydroabietyl alcohol	P
26266773	Hydroabietyl alcohol, Dihydroabietyl alcohol	P
1333897	Hydroabietyl alcohol, Dihydroabietyl alcohol	R
13706860	Acetyl isovaleryl	P
138863	Limonene	S
7705148	Limonene	S
5989275	Limonene	S
5989548	Limonene	S
140294	Benzyl cyanide	R-P
140670	Estragole	R
1407278	Estragole	R
77525189	Estragole	R
140885	Ethyl acrylate	P
141059	Diethyl maleate	P
141106	Pseudoionone	P-S
144020224	Acetic acid, anhydride with 1,5,10-Trimethyl-1,5,9-cyclododecatriene	R
28371995	Acetic acid, anhydride with 1,5,10-Trimethyl-1,5,9-cyclododecatriene	R
145391	Musk tibetene	P
150765	Hydroquinone monomethyl ether	P
1504741	o-Methoxycinnamaldehyde	R
15323350	Acetyl hexamethyl indan (AHMI)	R
1604280	6-Methyl-3,5-heptadien-2-one	R
16251777	3-Phenylbutanal	R
17369594	3-Propylidenephthalide	R
17373896	α-Hexylidene cyclopentanone	R
17488652	4-Phenyl-3-buten-2-ol	R
17874349	4,6-Dimethyl-8-tert-butylcoumarin	P
18127010	p-tert-Butyldihydrocinnamaldehyde	R
18318837	trans-2-Hexenal dimethyl acetal	P
18485386	2,4-Dodecadien-1-ol, (2E, 4E)	P
18829555	trans-2-Heptenal	P
1885387	Cinnamyl nitrile	P
4360478	Cinnamyl nitrile	R
19317114	Farnesal	R
19343783	1,2,3,4-Tetrahydro-4-methylquinoline	S
2111753	Perilla aldehyde	R
23696857	Rose ketones	R
23726934	Rose ketones	R
59739638	Rose ketones	R
43052875	Rose ketones	R
24720090	Rose ketones	R
23726945	Rose ketones	R
23726923	Rose ketones	R
23726912	Rose ketones	R
35044689	Rose ketones	R
57378684	Rose ketones	R
71048823	Rose ketones	R
35087491	Rose ketones	R
39872576	Rose ketones	R
70266487	Rose ketones	R
33673711	Rose ketones	R
87064195	Rose ketones	R
24048144	2,6,10-Trimethylundeca-5,9-dien-1-ol	R
185019196	2,6,10-Trimethylundeca-5,9-dien-1-ol	R
58001880	2,6,10-Trimethylundeca-5,9-dien-1-ol	R
58001879	2,6,10-Trimethylundeca-5,9-dien-1-ol	R
1373932230	2,6,10-Trimethylundeca-5,9-dien-1-ol	R
1018832079	2,6,10-Trimethylundeca-5,9-dien-1-ol	R
2442106	1-Octen-3-yl acetate	R
2445832	7-Methylcoumarin	P
25564221	Amylcyclopentenone	P
2563077	2-Ethoxy-4-methylphenol	P
25677401	2-Pentylidene cyclohexanone	P
26651967	1,2,3,4-Tetrahydro-4-methylquinoline	P-S
72968253	1,2,3,4-Tetrahydro-4-methylquinoline	P-S
1117415	1,2,3,4-Tetrahydro-4-methylquinoline	P-S
\.


--
-- TOC entry 3237 (class 0 OID 89741)
-- Dependencies: 208
-- Data for Name: rig_proveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_proveedores (id, nombre, pag, info_cto, email, telf, id_ubic, id_aso_nac) FROM stdin;
1	Privi Organics India Limited	www.privi.com	Privi House, A-71,TTC Industrial Area, Thane Belapur Road,Kopar Khairane, Navi Mumbai - 400 709, India	info@privi.co.in	+91 22 33043500	25	\N
2	Ethernis Fine Chemicals	www.eternis.com	1004 Peninsula Tower Peninsula Corporate Park G.K. Marg, Lower Parel Mumbai 400 013 India	info@eternis.com	+91 22 66513400	25	\N
3	BASF	www.basf.com	Bahnsteigstraße, 67063 Ludwigshafen am Rhein, Alemania	info@basf.com	+49 0621 60-0	18	\N
4	Destilerías Muñoz Gálvez S.A.	www.dmg.es	Av. Ciudad de Almería, 162, 30010, Murcia	info@dmg.es	+34 968 25 3500	28	12
5	Lluch Essence	www.lluche.com	Lo Gaiter, 160 08820 Prat de Llobregat Barcelona	web@lluche.com	+34 93 3793849	28	12
6	Perfumers Apprentice	www.shop.perfumersapprentice.com	200 Technology Circle Scotts Valley, California, 95066	admin@perfumersapprentice.com	+1 831 316 7138	55	21
\.


--
-- TOC entry 3283 (class 0 OID 90209)
-- Dependencies: 254
-- Data for Name: rig_renovaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_renovaciones (id_prod, id_prov, id_ctra, id, fcha_reg) FROM stdin;
\.


--
-- TOC entry 3245 (class 0 OID 89831)
-- Dependencies: 216
-- Data for Name: rig_resultados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_resultados (id_prod, id_prov, fcha_reg, tipo_eval, res) FROM stdin;
\.


--
-- TOC entry 3240 (class 0 OID 89776)
-- Dependencies: 211
-- Data for Name: rig_sucursales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_sucursales (id_ubic, id_prod) FROM stdin;
66	1
2	1
9	1
22	1
64	1
18	1
29	1
115	1
46	1
47	1
50	1
139	1
28	1
13	1
1	1
35	1
25	1
74	1
70	1
69	1
77	1
78	1
92	1
15	1
5	1
12	1
82	1
42	1
55	1
55	2
64	3
18	3
13	3
66	3
28	3
104	3
105	3
157	3
115	3
139	3
97	3
50	3
188	3
59	3
\.


--
-- TOC entry 3246 (class 0 OID 89847)
-- Dependencies: 217
-- Data for Name: rig_variables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rig_variables (id, nombre, des) FROM stdin;
1	Ubicación geografica	Ubicación geográfica del proveedor
2	Metodos de pago	Metodos de pagos ofrecidos por el productor
3	Alternativas de envio	Cantidad de métodos que ofrece el proveedor
4	Cumplimiento de envios	Rendimiento del proveedor a lo largo del período
5	Exito	Mínimo aprobatorio de la fórmula
\.


--
-- TOC entry 3316 (class 0 OID 0)
-- Dependencies: 205
-- Name: rig_asociaciones_nacionales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_asociaciones_nacionales_id_seq', 21, true);


--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 213
-- Name: rig_condiciones_de_pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_condiciones_de_pago_id_seq', 12, true);


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 253
-- Name: rig_contrato_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_contrato_id_seq', 1, false);


--
-- TOC entry 3319 (class 0 OID 0)
-- Dependencies: 260
-- Name: rig_factura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_factura_id_seq', 1, false);


--
-- TOC entry 3320 (class 0 OID 0)
-- Dependencies: 242
-- Name: rig_familias_olfativas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_familias_olfativas_id_seq', 10, true);


--
-- TOC entry 3321 (class 0 OID 0)
-- Dependencies: 221
-- Name: rig_ingredientes_esencias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_ingredientes_esencias_id_seq', 18, true);


--
-- TOC entry 3322 (class 0 OID 0)
-- Dependencies: 236
-- Name: rig_intensidades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_intensidades_id_seq', 9, true);


--
-- TOC entry 3323 (class 0 OID 0)
-- Dependencies: 203
-- Name: rig_paises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_paises_id_seq', 214, true);


--
-- TOC entry 3324 (class 0 OID 0)
-- Dependencies: 240
-- Name: rig_palabras_claves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_palabras_claves_id_seq', 45, true);


--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 259
-- Name: rig_pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_pedidos_id_seq', 1, false);


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 231
-- Name: rig_perfumes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_perfumes_id_seq', 9, true);


--
-- TOC entry 3327 (class 0 OID 0)
-- Dependencies: 233
-- Name: rig_perfumistas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_perfumistas_id_seq', 8, true);


--
-- TOC entry 3328 (class 0 OID 0)
-- Dependencies: 225
-- Name: rig_presentaciones_ingredientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_presentaciones_ingredientes_id_seq', 82, true);


--
-- TOC entry 3329 (class 0 OID 0)
-- Dependencies: 228
-- Name: rig_presentaciones_otros_ingredientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_presentaciones_otros_ingredientes_id_seq', 11, true);


--
-- TOC entry 3330 (class 0 OID 0)
-- Dependencies: 238
-- Name: rig_presentaciones_perfumes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_presentaciones_perfumes_id_seq', 41, true);


--
-- TOC entry 3331 (class 0 OID 0)
-- Dependencies: 207
-- Name: rig_productores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_productores_id_seq', 3, true);


--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 209
-- Name: rig_proveedores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_proveedores_id_seq', 6, true);


--
-- TOC entry 3333 (class 0 OID 0)
-- Dependencies: 255
-- Name: rig_renovaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_renovaciones_id_seq', 1, false);


--
-- TOC entry 3334 (class 0 OID 0)
-- Dependencies: 218
-- Name: rig_variables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rig_variables_id_seq', 5, true);


--
-- TOC entry 2933 (class 2606 OID 89710)
-- Name: rig_asociaciones_nacionales rig_asociaciones_nacionales_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_asociaciones_nacionales
    ADD CONSTRAINT rig_asociaciones_nacionales_nombre_key UNIQUE (nombre);


--
-- TOC entry 2935 (class 2606 OID 89708)
-- Name: rig_asociaciones_nacionales rig_asociaciones_nacionales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_asociaciones_nacionales
    ADD CONSTRAINT rig_asociaciones_nacionales_pkey PRIMARY KEY (id);


--
-- TOC entry 3027 (class 2606 OID 90164)
-- Name: rig_componentes_funcionales rig_componentes_funcionales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_componentes_funcionales
    ADD CONSTRAINT rig_componentes_funcionales_pkey PRIMARY KEY (cas_otr_ing, id_perf);


--
-- TOC entry 3035 (class 2606 OID 90226)
-- Name: rig_condiciones_contratos rig_condiciones_contratos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_contratos
    ADD CONSTRAINT rig_condiciones_contratos_pkey PRIMARY KEY (id_prod, id_prov, id_ctra, id);


--
-- TOC entry 2965 (class 2606 OID 89809)
-- Name: rig_condiciones_de_envio rig_condiciones_de_envio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_de_envio
    ADD CONSTRAINT rig_condiciones_de_envio_pkey PRIMARY KEY (id_prov, id_ubic);


--
-- TOC entry 2963 (class 2606 OID 89795)
-- Name: rig_condiciones_de_pago rig_condiciones_de_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_de_pago
    ADD CONSTRAINT rig_condiciones_de_pago_pkey PRIMARY KEY (id_prov, id);


--
-- TOC entry 3031 (class 2606 OID 90194)
-- Name: rig_contratos rig_contratos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_contratos
    ADD CONSTRAINT rig_contratos_pkey PRIMARY KEY (id_prod, id_prov, id);


--
-- TOC entry 3043 (class 2606 OID 90291)
-- Name: rig_detalles_pedidos rig_detalles_pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_detalles_pedidos
    ADD CONSTRAINT rig_detalles_pedidos_pkey PRIMARY KEY (id_ped, renglon);


--
-- TOC entry 2967 (class 2606 OID 89825)
-- Name: rig_escalas rig_escalas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_escalas
    ADD CONSTRAINT rig_escalas_pkey PRIMARY KEY (id_prod, fcha_reg);


--
-- TOC entry 3015 (class 2606 OID 90097)
-- Name: rig_esencias_perfumes rig_esencias_perfumes_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_esencias_perfumes
    ADD CONSTRAINT rig_esencias_perfumes_nombre_key UNIQUE (nombre);


--
-- TOC entry 3017 (class 2606 OID 90095)
-- Name: rig_esencias_perfumes rig_esencias_perfumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_esencias_perfumes
    ADD CONSTRAINT rig_esencias_perfumes_pkey PRIMARY KEY (cas);


--
-- TOC entry 3025 (class 2606 OID 90149)
-- Name: rig_esencias rig_esencias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_esencias
    ADD CONSTRAINT rig_esencias_pkey PRIMARY KEY (id_fao, id_esenp);


--
-- TOC entry 2975 (class 2606 OID 89861)
-- Name: rig_evaluaciones_criterios rig_evaluaciones_criterios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_evaluaciones_criterios
    ADD CONSTRAINT rig_evaluaciones_criterios_pkey PRIMARY KEY (id_prod, id_var, fcha_reg);


--
-- TOC entry 3007 (class 2606 OID 90057)
-- Name: rig_familias_olfativas rig_familias_olfativas_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_familias_olfativas
    ADD CONSTRAINT rig_familias_olfativas_nombre_key UNIQUE (nombre);


--
-- TOC entry 3009 (class 2606 OID 90055)
-- Name: rig_familias_olfativas rig_familias_olfativas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_familias_olfativas
    ADD CONSTRAINT rig_familias_olfativas_pkey PRIMARY KEY (id);


--
-- TOC entry 3013 (class 2606 OID 90080)
-- Name: rig_familias_perfumes rig_familias_perfumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_familias_perfumes
    ADD CONSTRAINT rig_familias_perfumes_pkey PRIMARY KEY (id_perf, id_fao);


--
-- TOC entry 2977 (class 2606 OID 89880)
-- Name: rig_ingredientes_esencias rig_ingredientes_esencias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_esencias
    ADD CONSTRAINT rig_ingredientes_esencias_pkey PRIMARY KEY (id_prov, id);


--
-- TOC entry 2989 (class 2606 OID 89952)
-- Name: rig_ingredientes_extras rig_ingredientes_extras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_extras
    ADD CONSTRAINT rig_ingredientes_extras_pkey PRIMARY KEY (id_prov_ing, id_ing, cas_otr_ing);


--
-- TOC entry 3019 (class 2606 OID 90103)
-- Name: rig_ingredientes_familias rig_ingredientes_familias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_familias
    ADD CONSTRAINT rig_ingredientes_familias_pkey PRIMARY KEY (id_prov, id_ing, id_fao);


--
-- TOC entry 2999 (class 2606 OID 90018)
-- Name: rig_intensidades rig_intensidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_intensidades
    ADD CONSTRAINT rig_intensidades_pkey PRIMARY KEY (id_perf, id);


--
-- TOC entry 2959 (class 2606 OID 89774)
-- Name: rig_membresias rig_membresias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_membresias
    ADD CONSTRAINT rig_membresias_pkey PRIMARY KEY (fcha_reg);


--
-- TOC entry 3023 (class 2606 OID 90134)
-- Name: rig_monoliticos rig_monoliticos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_monoliticos
    ADD CONSTRAINT rig_monoliticos_pkey PRIMARY KEY (id_perf, id_esenp);


--
-- TOC entry 3021 (class 2606 OID 90118)
-- Name: rig_notas rig_notas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_notas
    ADD CONSTRAINT rig_notas_pkey PRIMARY KEY (id_perf, id_esenp);


--
-- TOC entry 2979 (class 2606 OID 89894)
-- Name: rig_origenes_ingredientes_esencias rig_origenes_ingredientes_esencias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_origenes_ingredientes_esencias
    ADD CONSTRAINT rig_origenes_ingredientes_esencias_pkey PRIMARY KEY (id_prov, id_ing, id_ubic);


--
-- TOC entry 3029 (class 2606 OID 90179)
-- Name: rig_origenes rig_origenes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_origenes
    ADD CONSTRAINT rig_origenes_pkey PRIMARY KEY (id_fao, id_esenp);


--
-- TOC entry 2985 (class 2606 OID 89928)
-- Name: rig_otros_ingredientes rig_otros_ingredientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_otros_ingredientes
    ADD CONSTRAINT rig_otros_ingredientes_pkey PRIMARY KEY (cas);


--
-- TOC entry 3045 (class 2606 OID 90312)
-- Name: rig_pagos rig_pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_pagos
    ADD CONSTRAINT rig_pagos_pkey PRIMARY KEY (id_ped, id_ord);


--
-- TOC entry 2929 (class 2606 OID 89700)
-- Name: rig_paises rig_paises_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_paises
    ADD CONSTRAINT rig_paises_nombre_key UNIQUE (nombre);


--
-- TOC entry 2931 (class 2606 OID 89698)
-- Name: rig_paises rig_paises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_paises
    ADD CONSTRAINT rig_paises_pkey PRIMARY KEY (id);


--
-- TOC entry 3003 (class 2606 OID 90047)
-- Name: rig_palabras_claves rig_palabras_claves_palabra_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_palabras_claves
    ADD CONSTRAINT rig_palabras_claves_palabra_key UNIQUE (palabra);


--
-- TOC entry 3005 (class 2606 OID 90045)
-- Name: rig_palabras_claves rig_palabras_claves_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_palabras_claves
    ADD CONSTRAINT rig_palabras_claves_pkey PRIMARY KEY (id);


--
-- TOC entry 3011 (class 2606 OID 90065)
-- Name: rig_palabras_familias rig_palabras_familias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_palabras_familias
    ADD CONSTRAINT rig_palabras_familias_pkey PRIMARY KEY (id_pal, id_fao);


--
-- TOC entry 3039 (class 2606 OID 90269)
-- Name: rig_pedidos rig_pedidos_factura_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_pedidos
    ADD CONSTRAINT rig_pedidos_factura_key UNIQUE (factura);


--
-- TOC entry 3041 (class 2606 OID 90267)
-- Name: rig_pedidos rig_pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_pedidos
    ADD CONSTRAINT rig_pedidos_pkey PRIMARY KEY (id);


--
-- TOC entry 2997 (class 2606 OID 90003)
-- Name: rig_perfumes_perfumistas rig_perfumes_perfumistas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumes_perfumistas
    ADD CONSTRAINT rig_perfumes_perfumistas_pkey PRIMARY KEY (id_perf, id_prefta);


--
-- TOC entry 2991 (class 2606 OID 89970)
-- Name: rig_perfumes rig_perfumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumes
    ADD CONSTRAINT rig_perfumes_pkey PRIMARY KEY (id);


--
-- TOC entry 2993 (class 2606 OID 89989)
-- Name: rig_perfumistas rig_perfumistas_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumistas
    ADD CONSTRAINT rig_perfumistas_nombre_key UNIQUE (nombre);


--
-- TOC entry 2995 (class 2606 OID 89987)
-- Name: rig_perfumistas rig_perfumistas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumistas
    ADD CONSTRAINT rig_perfumistas_pkey PRIMARY KEY (id);


--
-- TOC entry 2983 (class 2606 OID 89915)
-- Name: rig_presentaciones_ingredientes rig_presentaciones_ingredientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_ingredientes
    ADD CONSTRAINT rig_presentaciones_ingredientes_pkey PRIMARY KEY (id_prov, id_ing, cod_present);


--
-- TOC entry 2987 (class 2606 OID 89938)
-- Name: rig_presentaciones_otros_ingredientes rig_presentaciones_otros_ingredientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_otros_ingredientes
    ADD CONSTRAINT rig_presentaciones_otros_ingredientes_pkey PRIMARY KEY (cas_otr_ing, cod_present);


--
-- TOC entry 3001 (class 2606 OID 90032)
-- Name: rig_presentaciones_perfumes rig_presentaciones_perfumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_perfumes
    ADD CONSTRAINT rig_presentaciones_perfumes_pkey PRIMARY KEY (id_perf, id_int, id);


--
-- TOC entry 2937 (class 2606 OID 89730)
-- Name: rig_productores rig_productores_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productores
    ADD CONSTRAINT rig_productores_email_key UNIQUE (email);


--
-- TOC entry 2939 (class 2606 OID 89726)
-- Name: rig_productores rig_productores_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productores
    ADD CONSTRAINT rig_productores_nombre_key UNIQUE (nombre);


--
-- TOC entry 2941 (class 2606 OID 89728)
-- Name: rig_productores rig_productores_pag_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productores
    ADD CONSTRAINT rig_productores_pag_key UNIQUE (pag);


--
-- TOC entry 2943 (class 2606 OID 89724)
-- Name: rig_productores rig_productores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productores
    ADD CONSTRAINT rig_productores_pkey PRIMARY KEY (id);


--
-- TOC entry 2945 (class 2606 OID 89732)
-- Name: rig_productores rig_productores_telf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productores
    ADD CONSTRAINT rig_productores_telf_key UNIQUE (telf);


--
-- TOC entry 3037 (class 2606 OID 90246)
-- Name: rig_productos_contratados rig_productos_contratados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productos_contratados
    ADD CONSTRAINT rig_productos_contratados_pkey PRIMARY KEY (id_prod, id_prov, id_ctra, id);


--
-- TOC entry 2981 (class 2606 OID 89909)
-- Name: rig_prohibidas rig_prohibidas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_prohibidas
    ADD CONSTRAINT rig_prohibidas_pkey PRIMARY KEY (cas);


--
-- TOC entry 2947 (class 2606 OID 89753)
-- Name: rig_proveedores rig_proveedores_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores
    ADD CONSTRAINT rig_proveedores_email_key UNIQUE (email);


--
-- TOC entry 2949 (class 2606 OID 89751)
-- Name: rig_proveedores rig_proveedores_info_cto_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores
    ADD CONSTRAINT rig_proveedores_info_cto_key UNIQUE (info_cto);


--
-- TOC entry 2951 (class 2606 OID 89747)
-- Name: rig_proveedores rig_proveedores_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores
    ADD CONSTRAINT rig_proveedores_nombre_key UNIQUE (nombre);


--
-- TOC entry 2953 (class 2606 OID 89749)
-- Name: rig_proveedores rig_proveedores_pag_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores
    ADD CONSTRAINT rig_proveedores_pag_key UNIQUE (pag);


--
-- TOC entry 2955 (class 2606 OID 89745)
-- Name: rig_proveedores rig_proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores
    ADD CONSTRAINT rig_proveedores_pkey PRIMARY KEY (id);


--
-- TOC entry 2957 (class 2606 OID 89755)
-- Name: rig_proveedores rig_proveedores_telf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores
    ADD CONSTRAINT rig_proveedores_telf_key UNIQUE (telf);


--
-- TOC entry 3033 (class 2606 OID 90213)
-- Name: rig_renovaciones rig_renovaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_renovaciones
    ADD CONSTRAINT rig_renovaciones_pkey PRIMARY KEY (id_prod, id_prov, id_ctra, id);


--
-- TOC entry 2969 (class 2606 OID 89835)
-- Name: rig_resultados rig_resultados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_resultados
    ADD CONSTRAINT rig_resultados_pkey PRIMARY KEY (id_prod, id_prov, fcha_reg);


--
-- TOC entry 2961 (class 2606 OID 89780)
-- Name: rig_sucursales rig_sucursales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_sucursales
    ADD CONSTRAINT rig_sucursales_pkey PRIMARY KEY (id_ubic, id_prod);


--
-- TOC entry 2971 (class 2606 OID 89853)
-- Name: rig_variables rig_variables_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_variables
    ADD CONSTRAINT rig_variables_nombre_key UNIQUE (nombre);


--
-- TOC entry 2973 (class 2606 OID 89851)
-- Name: rig_variables rig_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_variables
    ADD CONSTRAINT rig_variables_pkey PRIMARY KEY (id);


--
-- TOC entry 3046 (class 2606 OID 89715)
-- Name: rig_asociaciones_nacionales rig_asociacion_nacional_id_ubic_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_asociaciones_nacionales
    ADD CONSTRAINT rig_asociacion_nacional_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES public.rig_paises(id);


--
-- TOC entry 3087 (class 2606 OID 90170)
-- Name: rig_componentes_funcionales rig_componentes_funcionales_id_perf_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_componentes_funcionales
    ADD CONSTRAINT rig_componentes_funcionales_id_perf_fk FOREIGN KEY (id_perf) REFERENCES public.rig_perfumes(id);


--
-- TOC entry 3086 (class 2606 OID 90165)
-- Name: rig_componentes_funcionales rig_componentes_funcionales_otro_ing_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_componentes_funcionales
    ADD CONSTRAINT rig_componentes_funcionales_otro_ing_fk FOREIGN KEY (cas_otr_ing) REFERENCES public.rig_otros_ingredientes(cas);


--
-- TOC entry 3094 (class 2606 OID 90232)
-- Name: rig_condiciones_contratos rig_condiciones_contratos_cond_env_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_contratos
    ADD CONSTRAINT rig_condiciones_contratos_cond_env_fk FOREIGN KEY (id_prov_ce, id_ubic) REFERENCES public.rig_condiciones_de_envio(id_prov, id_ubic);


--
-- TOC entry 3095 (class 2606 OID 90237)
-- Name: rig_condiciones_contratos rig_condiciones_contratos_cond_pgo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_contratos
    ADD CONSTRAINT rig_condiciones_contratos_cond_pgo_fk FOREIGN KEY (id_prov_cp, id_condpgo) REFERENCES public.rig_condiciones_de_pago(id_prov, id);


--
-- TOC entry 3093 (class 2606 OID 90227)
-- Name: rig_condiciones_contratos rig_condiciones_contratos_id_ctra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_contratos
    ADD CONSTRAINT rig_condiciones_contratos_id_ctra_fk FOREIGN KEY (id_prod, id_prov, id_ctra) REFERENCES public.rig_contratos(id_prod, id_prov, id);


--
-- TOC entry 3053 (class 2606 OID 89811)
-- Name: rig_condiciones_de_envio rig_condiciones_de_envio_id_prov_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_de_envio
    ADD CONSTRAINT rig_condiciones_de_envio_id_prov_fk FOREIGN KEY (id_prov) REFERENCES public.rig_proveedores(id);


--
-- TOC entry 3054 (class 2606 OID 89816)
-- Name: rig_condiciones_de_envio rig_condiciones_de_envio_id_ubic_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_de_envio
    ADD CONSTRAINT rig_condiciones_de_envio_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES public.rig_paises(id);


--
-- TOC entry 3052 (class 2606 OID 89800)
-- Name: rig_condiciones_de_pago rig_condiciones_de_pago_id_prov_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_condiciones_de_pago
    ADD CONSTRAINT rig_condiciones_de_pago_id_prov_fk FOREIGN KEY (id_prov) REFERENCES public.rig_proveedores(id);


--
-- TOC entry 3090 (class 2606 OID 90199)
-- Name: rig_contratos rig_contrato_id_prod_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_contratos
    ADD CONSTRAINT rig_contrato_id_prod_fk FOREIGN KEY (id_prod) REFERENCES public.rig_productores(id);


--
-- TOC entry 3091 (class 2606 OID 90204)
-- Name: rig_contratos rig_contrato_id_prov_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_contratos
    ADD CONSTRAINT rig_contrato_id_prov_fk FOREIGN KEY (id_prov) REFERENCES public.rig_proveedores(id);


--
-- TOC entry 3103 (class 2606 OID 90303)
-- Name: rig_detalles_pedidos rig_detalles_pedidos_id_ped_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_detalles_pedidos
    ADD CONSTRAINT rig_detalles_pedidos_id_ped_fk FOREIGN KEY (id_ped) REFERENCES public.rig_pedidos(id);


--
-- TOC entry 3101 (class 2606 OID 90293)
-- Name: rig_detalles_pedidos rig_detalles_pedidos_ing_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_detalles_pedidos
    ADD CONSTRAINT rig_detalles_pedidos_ing_fk FOREIGN KEY (id_prov_ing, id_ing, cod_pre_ing) REFERENCES public.rig_presentaciones_ingredientes(id_prov, id_ing, cod_present);


--
-- TOC entry 3102 (class 2606 OID 90298)
-- Name: rig_detalles_pedidos rig_detalles_pedidos_otr_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_detalles_pedidos
    ADD CONSTRAINT rig_detalles_pedidos_otr_fk FOREIGN KEY (cas_otr_ing, cod_pre_otr) REFERENCES public.rig_presentaciones_otros_ingredientes(cas_otr_ing, cod_present);


--
-- TOC entry 3055 (class 2606 OID 89826)
-- Name: rig_escalas rig_escalas_id_prod; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_escalas
    ADD CONSTRAINT rig_escalas_id_prod FOREIGN KEY (id_prod) REFERENCES public.rig_productores(id);


--
-- TOC entry 3085 (class 2606 OID 90155)
-- Name: rig_esencias rig_esencias_id_esenp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_esencias
    ADD CONSTRAINT rig_esencias_id_esenp FOREIGN KEY (id_esenp) REFERENCES public.rig_esencias_perfumes(cas);


--
-- TOC entry 3084 (class 2606 OID 90150)
-- Name: rig_esencias rig_esencias_id_fao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_esencias
    ADD CONSTRAINT rig_esencias_id_fao FOREIGN KEY (id_fao) REFERENCES public.rig_familias_olfativas(id);


--
-- TOC entry 3058 (class 2606 OID 89863)
-- Name: rig_evaluaciones_criterios rig_evaluaciones_criterios_id_prod_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_evaluaciones_criterios
    ADD CONSTRAINT rig_evaluaciones_criterios_id_prod_fk FOREIGN KEY (id_prod) REFERENCES public.rig_productores(id);


--
-- TOC entry 3059 (class 2606 OID 89868)
-- Name: rig_evaluaciones_criterios rig_evaluaciones_criterios_id_var_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_evaluaciones_criterios
    ADD CONSTRAINT rig_evaluaciones_criterios_id_var_fk FOREIGN KEY (id_var) REFERENCES public.rig_variables(id);


--
-- TOC entry 3077 (class 2606 OID 90086)
-- Name: rig_familias_perfumes rig_familias_perfumes_id_fao_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_familias_perfumes
    ADD CONSTRAINT rig_familias_perfumes_id_fao_fk FOREIGN KEY (id_fao) REFERENCES public.rig_familias_olfativas(id);


--
-- TOC entry 3076 (class 2606 OID 90081)
-- Name: rig_familias_perfumes rig_familias_perfumes_id_perf_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_familias_perfumes
    ADD CONSTRAINT rig_familias_perfumes_id_perf_fk FOREIGN KEY (id_perf) REFERENCES public.rig_perfumes(id);


--
-- TOC entry 3060 (class 2606 OID 89885)
-- Name: rig_ingredientes_esencias rig_ingrediente_esencia_id_prod_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_esencias
    ADD CONSTRAINT rig_ingrediente_esencia_id_prod_fk FOREIGN KEY (id_prov) REFERENCES public.rig_proveedores(id);


--
-- TOC entry 3066 (class 2606 OID 89953)
-- Name: rig_ingredientes_extras rig_ingredientes_extras_ing_ese_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_extras
    ADD CONSTRAINT rig_ingredientes_extras_ing_ese_fk FOREIGN KEY (id_prov_ing, id_ing) REFERENCES public.rig_ingredientes_esencias(id_prov, id);


--
-- TOC entry 3067 (class 2606 OID 89958)
-- Name: rig_ingredientes_extras rig_ingredientes_extras_otr_ing_gk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_extras
    ADD CONSTRAINT rig_ingredientes_extras_otr_ing_gk FOREIGN KEY (cas_otr_ing) REFERENCES public.rig_otros_ingredientes(cas);


--
-- TOC entry 3079 (class 2606 OID 90109)
-- Name: rig_ingredientes_familias rig_ingredientes_familias_id_fao_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_familias
    ADD CONSTRAINT rig_ingredientes_familias_id_fao_fk FOREIGN KEY (id_fao) REFERENCES public.rig_familias_olfativas(id);


--
-- TOC entry 3078 (class 2606 OID 90104)
-- Name: rig_ingredientes_familias rig_ingredientes_familias_id_ing_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_ingredientes_familias
    ADD CONSTRAINT rig_ingredientes_familias_id_ing_fk FOREIGN KEY (id_prov, id_ing) REFERENCES public.rig_ingredientes_esencias(id_prov, id);


--
-- TOC entry 3072 (class 2606 OID 90023)
-- Name: rig_intensidades rig_intensidad_id_perf_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_intensidades
    ADD CONSTRAINT rig_intensidad_id_perf_fk FOREIGN KEY (id_perf) REFERENCES public.rig_perfumes(id);


--
-- TOC entry 3083 (class 2606 OID 90140)
-- Name: rig_monoliticos rig_monoliticos_id_esenp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_monoliticos
    ADD CONSTRAINT rig_monoliticos_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES public.rig_esencias_perfumes(cas);


--
-- TOC entry 3082 (class 2606 OID 90135)
-- Name: rig_monoliticos rig_monoliticos_id_perf_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_monoliticos
    ADD CONSTRAINT rig_monoliticos_id_perf_fk FOREIGN KEY (id_perf) REFERENCES public.rig_perfumes(id);


--
-- TOC entry 3081 (class 2606 OID 90125)
-- Name: rig_notas rig_notas_id_esenp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_notas
    ADD CONSTRAINT rig_notas_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES public.rig_esencias_perfumes(cas);


--
-- TOC entry 3080 (class 2606 OID 90120)
-- Name: rig_notas rig_notas_id_perf_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_notas
    ADD CONSTRAINT rig_notas_id_perf_fk FOREIGN KEY (id_perf) REFERENCES public.rig_perfumes(id);


--
-- TOC entry 3089 (class 2606 OID 90185)
-- Name: rig_origenes rig_origenes_funcionales_id_esenp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_origenes
    ADD CONSTRAINT rig_origenes_funcionales_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES public.rig_esencias_perfumes(cas);


--
-- TOC entry 3088 (class 2606 OID 90180)
-- Name: rig_origenes rig_origenes_id_fao_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_origenes
    ADD CONSTRAINT rig_origenes_id_fao_fk FOREIGN KEY (id_fao) REFERENCES public.rig_familias_olfativas(id);


--
-- TOC entry 3061 (class 2606 OID 89895)
-- Name: rig_origenes_ingredientes_esencias rig_origenes_ingredientes_esencias_ing; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_origenes_ingredientes_esencias
    ADD CONSTRAINT rig_origenes_ingredientes_esencias_ing FOREIGN KEY (id_prov, id_ing) REFERENCES public.rig_ingredientes_esencias(id_prov, id);


--
-- TOC entry 3062 (class 2606 OID 89900)
-- Name: rig_origenes_ingredientes_esencias rig_origenes_ingredientes_esencias_ubic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_origenes_ingredientes_esencias
    ADD CONSTRAINT rig_origenes_ingredientes_esencias_ubic FOREIGN KEY (id_ubic) REFERENCES public.rig_paises(id);


--
-- TOC entry 3064 (class 2606 OID 89929)
-- Name: rig_otros_ingredientes rig_otros_ingredientes_id_prov_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_otros_ingredientes
    ADD CONSTRAINT rig_otros_ingredientes_id_prov_fk FOREIGN KEY (id_prov) REFERENCES public.rig_proveedores(id);


--
-- TOC entry 3104 (class 2606 OID 90313)
-- Name: rig_pagos rig_pagos_id_ped; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_pagos
    ADD CONSTRAINT rig_pagos_id_ped FOREIGN KEY (id_ped) REFERENCES public.rig_pedidos(id);


--
-- TOC entry 3075 (class 2606 OID 90071)
-- Name: rig_palabras_familias rig_palabras_familias_id_fao_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_palabras_familias
    ADD CONSTRAINT rig_palabras_familias_id_fao_fk FOREIGN KEY (id_fao) REFERENCES public.rig_familias_olfativas(id);


--
-- TOC entry 3074 (class 2606 OID 90066)
-- Name: rig_palabras_familias rig_palabras_familias_id_pal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_palabras_familias
    ADD CONSTRAINT rig_palabras_familias_id_pal_fk FOREIGN KEY (id_pal) REFERENCES public.rig_palabras_claves(id);


--
-- TOC entry 3099 (class 2606 OID 90277)
-- Name: rig_pedidos rig_pedido_conev_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_pedidos
    ADD CONSTRAINT rig_pedido_conev_fk FOREIGN KEY (id_prod_cone, id_prov_cone, id_ctra_cone, id_cone) REFERENCES public.rig_condiciones_contratos(id_prod, id_prov, id_ctra, id);


--
-- TOC entry 3100 (class 2606 OID 90282)
-- Name: rig_pedidos rig_pedido_conp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_pedidos
    ADD CONSTRAINT rig_pedido_conp_fk FOREIGN KEY (id_prod_conp, id_prov_conp, id_ctra_conp, id_conp) REFERENCES public.rig_condiciones_contratos(id_prod, id_prov, id_ctra, id);


--
-- TOC entry 3068 (class 2606 OID 89975)
-- Name: rig_perfumes rig_perfumes_id_prod_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumes
    ADD CONSTRAINT rig_perfumes_id_prod_fk FOREIGN KEY (id_prod) REFERENCES public.rig_productores(id);


--
-- TOC entry 3070 (class 2606 OID 90004)
-- Name: rig_perfumes_perfumistas rig_perfumes_perfumistas_id_perf_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumes_perfumistas
    ADD CONSTRAINT rig_perfumes_perfumistas_id_perf_fk FOREIGN KEY (id_perf) REFERENCES public.rig_perfumes(id);


--
-- TOC entry 3071 (class 2606 OID 90009)
-- Name: rig_perfumes_perfumistas rig_perfumes_perfumistas_id_prefta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumes_perfumistas
    ADD CONSTRAINT rig_perfumes_perfumistas_id_prefta_fk FOREIGN KEY (id_prefta) REFERENCES public.rig_perfumistas(id);


--
-- TOC entry 3069 (class 2606 OID 89994)
-- Name: rig_perfumistas rig_perfumistas_id_ubic_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_perfumistas
    ADD CONSTRAINT rig_perfumistas_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES public.rig_paises(id);


--
-- TOC entry 3063 (class 2606 OID 89919)
-- Name: rig_presentaciones_ingredientes rig_presentaciones_ingredientes_ing_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_ingredientes
    ADD CONSTRAINT rig_presentaciones_ingredientes_ing_fk FOREIGN KEY (id_prov, id_ing) REFERENCES public.rig_ingredientes_esencias(id_prov, id);


--
-- TOC entry 3065 (class 2606 OID 89943)
-- Name: rig_presentaciones_otros_ingredientes rig_presentaciones_otros_ingredientes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_otros_ingredientes
    ADD CONSTRAINT rig_presentaciones_otros_ingredientes_fk FOREIGN KEY (cas_otr_ing) REFERENCES public.rig_otros_ingredientes(cas);


--
-- TOC entry 3073 (class 2606 OID 90036)
-- Name: rig_presentaciones_perfumes rig_presentaciones_perfumes_id_perf_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_presentaciones_perfumes
    ADD CONSTRAINT rig_presentaciones_perfumes_id_perf_fk FOREIGN KEY (id_perf, id_int) REFERENCES public.rig_intensidades(id_perf, id);


--
-- TOC entry 3047 (class 2606 OID 89736)
-- Name: rig_productores rig_productores_id_asoc_nac_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productores
    ADD CONSTRAINT rig_productores_id_asoc_nac_fk FOREIGN KEY (id_aso_nac) REFERENCES public.rig_asociaciones_nacionales(id);


--
-- TOC entry 3096 (class 2606 OID 90247)
-- Name: rig_productos_contratados rig_productos_contratados_id_ctra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productos_contratados
    ADD CONSTRAINT rig_productos_contratados_id_ctra_fk FOREIGN KEY (id_prod, id_prov, id_ctra) REFERENCES public.rig_contratos(id_prod, id_prov, id);


--
-- TOC entry 3097 (class 2606 OID 90252)
-- Name: rig_productos_contratados rig_productos_contratados_ing_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productos_contratados
    ADD CONSTRAINT rig_productos_contratados_ing_fk FOREIGN KEY (id_prov_ing, id_ing) REFERENCES public.rig_ingredientes_esencias(id_prov, id);


--
-- TOC entry 3098 (class 2606 OID 90257)
-- Name: rig_productos_contratados rig_productos_contratados_otr_ing_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_productos_contratados
    ADD CONSTRAINT rig_productos_contratados_otr_ing_fk FOREIGN KEY (cas_otr_ing) REFERENCES public.rig_otros_ingredientes(cas);


--
-- TOC entry 3049 (class 2606 OID 89764)
-- Name: rig_proveedores rig_proveedores_id_asoc_nac_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores
    ADD CONSTRAINT rig_proveedores_id_asoc_nac_fk FOREIGN KEY (id_aso_nac) REFERENCES public.rig_asociaciones_nacionales(id);


--
-- TOC entry 3048 (class 2606 OID 89759)
-- Name: rig_proveedores rig_proveedores_id_ubic_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_proveedores
    ADD CONSTRAINT rig_proveedores_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES public.rig_paises(id);


--
-- TOC entry 3092 (class 2606 OID 90217)
-- Name: rig_renovaciones rig_renovaciones_id_ctra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_renovaciones
    ADD CONSTRAINT rig_renovaciones_id_ctra FOREIGN KEY (id_prod, id_prov, id_ctra) REFERENCES public.rig_contratos(id_prod, id_prov, id);


--
-- TOC entry 3056 (class 2606 OID 89837)
-- Name: rig_resultados rig_resultados_id_prod_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_resultados
    ADD CONSTRAINT rig_resultados_id_prod_fk FOREIGN KEY (id_prod) REFERENCES public.rig_productores(id);


--
-- TOC entry 3057 (class 2606 OID 89842)
-- Name: rig_resultados rig_resultados_id_prov_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_resultados
    ADD CONSTRAINT rig_resultados_id_prov_fk FOREIGN KEY (id_prov) REFERENCES public.rig_proveedores(id);


--
-- TOC entry 3051 (class 2606 OID 89786)
-- Name: rig_sucursales rig_sucursales_id_prod_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_sucursales
    ADD CONSTRAINT rig_sucursales_id_prod_fk FOREIGN KEY (id_prod) REFERENCES public.rig_productores(id);


--
-- TOC entry 3050 (class 2606 OID 89781)
-- Name: rig_sucursales rig_sucursales_id_ubic_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rig_sucursales
    ADD CONSTRAINT rig_sucursales_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES public.rig_paises(id);


-- Completed on 2020-07-29 20:50:01

--
-- PostgreSQL database dump complete
--

