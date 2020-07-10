DROP TABLE IF EXISTS rig_pagos;
DROP TABLE IF EXISTS rig_detalles_pedidos;
DROP TABLE IF EXISTS rig_pedidos;
DROP TABLE IF EXISTS rig_productos_contratados;
DROP TABLE IF EXISTS rig_condiciones_contratos;
DROP TABLE IF EXISTS rig_renovacion;
DROP TABLE IF EXISTS rig_contrato;
DROP TABLE IF EXISTS rig_origenes;
DROP TABLE IF EXISTS rig_componentes_funcionales;
DROP TABLE IF EXISTS rig_esencias;
DROP TABLE IF EXISTS rig_monoliticos;
DROP TABLE IF EXISTS rig_notas;
DROP TABLE IF EXISTS rig_esencias_perfumes;
DROP TABLE IF EXISTS rig_familias_perfumes;
DROP TABLE IF EXISTS rig_palabras_familias;
DROP TABLE IF EXISTS rig_familias_olfativas;
DROP TABLE IF EXISTS rig_palabras_claves;
DROP TABLE IF EXISTS rig_presentaciones_perfumes;
DROP TABLE IF EXISTS rig_intensidades;
DROP TABLE IF EXISTS rig_perfumes_perfumistas;
DROP TABLE IF EXISTS rig_perfumistas;
DROP TABLE IF EXISTS rig_perfumes;
DROP TABLE IF EXISTS rig_ingredientes_extras;
DROP TABLE IF EXISTS rig_presentaciones_otros_ingredientes;
DROP TABLE IF EXISTS rig_otros_ingredientes;
DROP TABLE IF EXISTS rig_presentaciones_ingredientes;
DROP TABLE IF EXISTS rig_prohibidas;
DROP TABLE IF EXISTS rig_ingredientes_esencias;
DROP TABLE IF EXISTS rig_evaluaciones_criterios;
DROP TABLE IF EXISTS rig_variables;
DROP TABLE IF EXISTS rig_resultados;
DROP TABLE IF EXISTS rig_escalas;
DROP TABLE IF EXISTS rig_condiciones_de_envio;
DROP TABLE IF EXISTS rig_condiciones_de_pago;
DROP TABLE IF EXISTS rig_sucursales;
DROP TABLE IF EXISTS rig_membresias;
DROP TABLE IF EXISTS rig_proveedores;
DROP TABLE IF EXISTS rig_productores;
DROP TABLE IF EXISTS rig_asociaciones_nacionales;
DROP TABLE IF EXISTS rig_paises;

DROP SEQUENCE IF EXISTS factura_id_seq;
DROP SEQUENCE IF EXISTS rig_pedidos_id_seq;
DROP SEQUENCE IF EXISTS rig_renovacion_id_seq;
DROP SEQUENCE IF EXISTS rig_contrato_id_seq;
DROP SEQUENCE IF EXISTS rig_familias_olfativas_id;
DROP SEQUENCE IF EXISTS rig_presentaciones_perfumes_id_seq;
DROP SEQUENCE IF EXISTS rig_intensidades_id_seq;
DROP SEQUENCE IF EXISTS rig_esencias_perfumes_id_seq;
DROP SEQUENCE IF EXISTS rig_palabras_claves_id_seq;
DROP SEQUENCE IF EXISTS rig_perfumistas_id_seq;
DROP SEQUENCE IF EXISTS rig_perfumes_id_seq;
DROP SEQUENCE IF EXISTS rig_presentaciones_otros_ingredientes_id_seq;
DROP SEQUENCE IF EXISTS rig_otros_ingredientes_id_seq;
DROP SEQUENCE IF EXISTS rig_presentaciones_ingredientes_id_seq;
DROP SEQUENCE IF EXISTS rig_prohibidas_id_seq;
DROP SEQUENCE IF EXISTS rig_ingredientes_esencias_id_seq;
DROP SEQUENCE IF EXISTS rig_asociaciones_nacionales_id_seq;
DROP SEQUENCE IF EXISTS rig_variables_id_seq;
DROP SEQUENCE IF EXISTS rig_condiciones_de_pago_id_seq;
DROP SEQUENCE IF EXISTS rig_proveedores_id_seq;
DROP SEQUENCE IF EXISTS rig_productores_id_seq;
DROP SEQUENCE IF EXISTS rig_paises_id_seq;

CREATE TABLE rig_paises (
	id SMALLINT PRIMARY KEY,
	nombre VARCHAR(30) not null unique
);

CREATE SEQUENCE IF NOT EXISTS rig_paises_id AS SMALLINT MAXVALUE 300 OWNED BY rig_paises.id;
ALTER TABLE rig_paises ALTER COLUMN id SET DEFAULT nextval('rig_paises_id');

CREATE TABLE rig_asociaciones_nacionales (
	id SMALLINT PRIMARY KEY ,
	nombre VARCHAR (100) NOT NULL UNIQUE,
	region VARCHAR (20) NOT NULL,
	id_ubic BIGINT NOT NULL
);

CREATE SEQUENCE rig_asociaciones_nacionales_id_seq AS SMALLINT MAXVALUE 300 OWNED BY rig_asociaciones_nacionales.id;
ALTER TABLE rig_asociaciones_nacionales ADD	CONSTRAINT rig_asociacion_nacional_ck CHECK (
	region IN ('ASIA-PACÍFICO', 'EUROPA', 'AMÉRICA DEL NORTE', 'LATINOAMERICA')),
	ADD CONSTRAINT rig_asociacion_nacional_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises,
	ALTER COLUMN id SET DEFAULT nextval('rig_asociaciones_nacionales_id_seq');

CREATE TABLE rig_productores (
	id SMALLINT PRIMARY KEY ,
	nombre VARCHAR(50) NOT NULL UNIQUE,
	pag VARCHAR(50) NOT NULL UNIQUE,
	info_cto VARCHAR(150) NOT NULL,
	email VARCHAR(30) NOT NULL UNIQUE,
	telf VARCHAR(20) NOT NULL UNIQUE,
	id_aso_nac SMALLINT
);
-- Reglas explicitas
-- Debe existir almenos una intersecciones con paises

CREATE SEQUENCE rig_productores_id_seq AS SMALLINT MAXVALUE 1000 OWNED BY rig_productores.id;
ALTER TABLE rig_productores ADD CONSTRAINT rig_productores_id_asoc_nac_fk FOREIGN KEY (id_aso_nac) REFERENCES rig_asociaciones_nacionales,
	ALTER COLUMN id SET DEFAULT nextval('rig_productores_id_seq');

CREATE TABLE rig_proveedores (
	id SMALLINT PRIMARY KEY ,
	nombre VARCHAR(50) NOT NULL UNIQUE,
	pag VARCHAR(50) NOT NULL UNIQUE,
	info_cto VARCHAR(150) NOT NULL UNIQUE,
	email VARCHAR(30) NOT NULL UNIQUE,
	telf VARCHAR(20) NOT NULL UNIQUE,
	id_ubic SMALLINT NOT NULL,
	id_aso_nac SMALLINT
);

CREATE SEQUENCE rig_proveedores_id_seq AS SMALLINT MAXVALUE 1000 OWNED BY rig_proveedores.id;
ALTER TABLE rig_proveedores ADD CONSTRAINT rig_proveedores_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises,
	ADD CONSTRAINT rig_proveedores_id_asoc_nac_fk FOREIGN KEY (id_aso_nac) REFERENCES rig_asociaciones_nacionales,
	ALTER COLUMN id SET DEFAULT nextval('rig_proveedores_id_seq');

CREATE TABLE rig_membresias (
	fcha_reg DATE PRIMARY KEY DEFAULT CURRENT_DATE,
	tipo_m VARCHAR (15) NOT NULL,
	fcha_fin DATE,
	id_prod SMALLINT,
	id_prov SMALLINT
);

ALTER TABLE rig_membresias ADD CONSTRAINT rig_proveedores_ck CHECK ((tipo_m IN ('PRINCIPAL', 'SECUNDARIO', 'REGIONAL')) AND ((id_prod IS NULL) != (id_prov IS NULL)));

CREATE TABLE rig_sucursales (
	id_ubic SMALLINT,
	id_prod SMALLINT,
	PRIMARY KEY (id_ubic, id_prod)
);

ALTER TABLE rig_sucursales ADD CONSTRAINT rig_sucursales_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises,
 	ADD CONSTRAINT rig_sucursales_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores;

CREATE TABLE rig_condiciones_de_pago (
	id_prov SMALLINT,
	id INTEGER,
	tipo VARCHAR (15) NOT NULL,
	coutas SMALLINT,
	porcen_cuo NUMERIC (5,2),
	cant_meses SMALLINT,
	PRIMARY KEY (id_prov, id)
);

CREATE SEQUENCE rig_condiciones_de_pago_id_seq AS INTEGER OWNED BY rig_condiciones_de_pago.id;
ALTER TABLE rig_condiciones_de_pago ADD CONSTRAINT rig_condiciones_de_pago_ck CHECK (tipo IN ('CONTADO', 'PARCIAL')),
	ADD CONSTRAINT rig_condiciones_de_pago_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	ALTER COLUMN id SET DEFAULT nextval('rig_condiciones_de_pago_id_seq');

CREATE TABLE rig_condiciones_de_envio (
	id_prov SMALLINT,
	id_ubic SMALLINT,
	nombre VARCHAR (20) NOT NULL,
	porce_serv NUMERIC (5,2) NOT NULL,
	medio VARCHAR (15) NOT NULL,
	PRIMARY KEY(id_prov, id_ubic)
);

ALTER TABLE rig_condiciones_de_envio ADD CONSTRAINT rig_condiciones_de_envio_ck CHECK (medio IN ('AEREO', 'TERRESTRE', 'MARITIMO')),
	ADD CONSTRAINT rig_condiciones_de_envio_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	ADD CONSTRAINT rig_condiciones_de_envio_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises;

CREATE TABLE rig_escalas (
	id_prod SMALLINT,
	fcha_reg DATE,
	rgo_ini SMALLINT NOT NULL,
	rgo_fin SMALLINT NOT NULL,
	fcha_fin DATE,
	PRIMARY KEY (id_prod, fcha_reg)
);

ALTER TABLE rig_escalas ADD CONSTRAINT rig_escalas_id_prod FOREIGN KEY (id_prod) REFERENCES rig_productores;

CREATE TABLE rig_resultados (
	id_prod SMALLINT,
	id_prov SMALLINT,
	fcha_reg DATE,
	tipo_eval VARCHAR (15) NOT NULL,
	res NUMERIC (5,2) NOT NULL,
	PRIMARY KEY (id_prod, id_prov, fcha_reg)
);

ALTER TABLE rig_resultados ADD CONSTRAINT rig_resultados_ck CHECK (tipo_eval IN ('INICIAL', 'RENOVACION')),
  ADD CONSTRAINT rig_resultados_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores,
  ADD CONSTRAINT rig_resultados_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores;

CREATE TABLE rig_variables (
	id SMALLINT PRIMARY KEY,
	nombre VARCHAR (15) NOT NULL UNIQUE,
	des VARCHAR (50) NOT NULL
);

CREATE SEQUENCE rig_variables_id_seq AS SMALLINT MAXVALUE 10 OWNED BY rig_variables.id;
ALTER TABLE rig_variables ALTER COLUMN id SET DEFAULT nextval('rig_variables_id_seq');

CREATE TABLE rig_evaluaciones_criterios (
	id_prod SMALLINT,
	id_var SMALLINT,
	fcha_reg DATE,
	tipo_eval VARCHAR (15) NOT NULL,
	peso NUMERIC (5,2) NOT NULL,
	fcha_fin DATE,
	PRIMARY KEY (id_prod, id_var, fcha_reg)
);

ALTER TABLE rig_evaluaciones_criterios ADD CONSTRAINT rig_evaluaciones_criterios_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores,
  ADD CONSTRAINT rig_evaluaciones_criterios_id_var_fk FOREIGN KEY (id_var) REFERENCES rig_variables,
  ADD CONSTRAINT rig_evaluaciones_criterios_ck CHECK (tipo_eval IN ('INICIAL', 'RENOVACION'));

CREATE TABLE rig_ingredientes_esencias (
	id_prov SMALLINT,
	id INTEGER,
	cas VARCHAR (30) NOT NULL,
	nombre VARCHAR (15) NOT NULL,
	tipo VARCHAR (15) NOT NULL,
	des VARCHAR (100) NOT NULL,
	id_ubic SMALLINT NOT NULL,
	solubilidad VARCHAR (50),
	peligrosidad VARCHAR (15),
	vida_alm SMALLINT,
	ctrl VARCHAR (15),
	PRIMARY KEY (id_prov, id)
);

CREATE SEQUENCE rig_ingredientes_esencias_id_seq AS INTEGER OWNED BY rig_ingredientes_esencias.id;

ALTER TABLE rig_ingredientes_esencias ADD CONSTRAINT rig_ingrediente_esencia_ck CHECK (
	(tipo IN ('NATURAL', 'ARTIFICIAL'))	AND (peligrosidad IN ('ALTA', 'MEDIA', 'BAJA', 'NINGUNA')) AND (ctrl IN ('SI', 'NO'))),
	ADD CONSTRAINT rig_ingrediente_esencia_id_prod_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	ALTER COLUMN id SET DEFAULT nextval('rig_ingredientes_esencias_id_seq');

CREATE TABLE rig_prohibidas (
	id SMALLINT PRIMARY KEY,
	cod_inter VARCHAR (30) NOT NULL UNIQUE,
	nombre VARCHAR (15) NOT NULL UNIQUE
);

CREATE SEQUENCE rig_prohibidas_id_seq AS SMALLINT OWNED BY rig_prohibidas.id;
ALTER TABLE rig_prohibidas ALTER COLUMN id SET DEFAULT nextval('rig_prohibidas_id_seq');

CREATE TABLE rig_presentaciones_ingredientes (
	id_prov SMALLINT,
	id_ing INTEGER,
	cod_present INTEGER,
	nombre VARCHAR (15) NOT NULL,
	cant_u SMALLINT NOT NULL,
	vol_u NUMERIC (10,2) NOT NULL,
	precio NUMERIC (10,2) NOT NULL,
	des VARCHAR (50) NOT NULL,
	PRIMARY KEY (id_prov, id_ing, cod_present)
);

CREATE SEQUENCE rig_presentaciones_ingredientes_id_seq AS INTEGER OWNED BY rig_presentaciones_ingredientes.cod_present;
ALTER TABLE rig_presentaciones_ingredientes ADD CONSTRAINT rig_presentaciones_ingredientes_ing_fk FOREIGN KEY (id_prov, id_ing) REFERENCES rig_ingredientes_esencias (id_prov, id),
	ALTER COLUMN cod_present SET DEFAULT nextval('rig_presentaciones_ingredientes_id_seq');

CREATE TABLE rig_otros_ingredientes (
	id_prov SMALLINT,
	id INTEGER,
	cod_inter VARCHAR (30) NOT NULL,
	nombre VARCHAR (20) NOT NULL,
	des VARCHAR (50) NOT NULL,
	PRIMARY KEY (id_prov, id)
);

CREATE SEQUENCE rig_otros_ingredientes_id_seq AS INTEGER OWNED BY rig_otros_ingredientes.id;
ALTER TABLE rig_otros_ingredientes ADD CONSTRAINT rig_otros_ingredientes_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	ALTER COLUMN id SET DEFAULT nextval('rig_otros_ingredientes_id_seq');

CREATE TABLE rig_presentaciones_otros_ingredientes (
	id_prov SMALLINT,
	id_otro_ing INTEGER,
	cod_present INTEGER,
	precio NUMERIC (10,2) NOT NULL,
	volumen NUMERIC (10, 2),
	otra_pre VARCHAR (15),
	des VARCHAR (50),
	PRIMARY KEY (id_prov, id_otro_ing, cod_present)
);

CREATE SEQUENCE rig_presentaciones_otros_ingredientes_id_seq AS INTEGER OWNED BY rig_presentaciones_otros_ingredientes.cod_present;
ALTER TABLE rig_presentaciones_otros_ingredientes ADD CONSTRAINT rig_presentaciones_ingredientes_ck CHECK (otra_pre IN ('RESTRINGIDO', 'PROHIBIDO')),
	ADD CONSTRAINT rig_presentaciones_otros_ingredientes_fk FOREIGN KEY (id_prov, id_otro_ing) REFERENCES rig_otros_ingredientes (id_prov, id),
	ALTER COLUMN cod_present SET DEFAULT nextval('rig_presentaciones_otros_ingredientes_id_seq');

CREATE TABLE rig_ingredientes_extras (
	id_prov_ing SMALLINT,
	id_ing INTEGER,
	id_prov_otr SMALLINT,
	id_otro_ing INTEGER,
	PRIMARY KEY (id_prov_ing, id_ing, id_prov_otr, id_otro_ing)
);

ALTER TABLE rig_ingredientes_extras ADD CONSTRAINT rig_ingredientes_extras_ing_ese_fk FOREIGN KEY (id_prov_ing, id_ing) REFERENCES rig_ingredientes_esencias (id_prov, id),
	ADD CONSTRAINT rig_ingredientes_extras_otr_ing_gk FOREIGN KEY (id_prov_otr, id_otro_ing) REFERENCES rig_otros_ingredientes (id_prov, id);

CREATE TABLE rig_perfumes (
	id INTEGER PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	genero VARCHAR NOT NULL,
	tipo VARCHAR (5) NOT NULL,
	edad INTEGER ,--Revisar,
	fcha_crea DATE,
	des TEXT
);

CREATE SEQUENCE rig_perfumes_id_seq AS INTEGER OWNED BY rig_perfumes.id;
ALTER TABLE rig_perfumes ADD CONSTRAINT rig_perfumes_ck CHECK ((genero IN ('F', 'M')) AND (tipo IN ('MONO', 'FASES'))),
	ALTER COLUMN id SET DEFAULT nextval('rig_perfumes_id_seq');

CREATE TABLE rig_perfumistas (
	id INTEGER PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL UNIQUE,
	genero VARCHAR NOT NULL,
	fcha_nac DATE
);

CREATE SEQUENCE rig_perfumistas_id_seq AS INTEGER OWNED BY rig_perfumistas.id;
ALTER TABLE rig_perfumistas ADD CONSTRAINT rig_perfumistas_ck CHECK (genero IN ('F', 'M')),
	ALTER COLUMN id SET DEFAULT nextval('rig_perfumistas_id_seq');

CREATE TABLE rig_perfumes_perfumistas (
	id_perf INTEGER,
	id_prefta INTEGER,
	PRIMARY KEY (id_perf, id_prefta)
);

ALTER TABLE	rig_perfumes_perfumistas ADD CONSTRAINT rig_perfumes_perfumistas_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	ADD CONSTRAINT rig_perfumes_perfumistas_id_prefta_fk FOREIGN KEY (id_prefta) REFERENCES rig_perfumistas;

CREATE TABLE rig_intensidades (
	id_perf INTEGER,
	id INTEGER,
	tipo VARCHAR (3) NOT NULL,
	porcen NUMERIC (5,2),
	des VARCHAR (50),
	PRIMARY KEY (id_perf, id)
);

CREATE SEQUENCE rig_intensidades_id_seq AS INTEGER OWNED BY rig_intensidades.id;
ALTER TABLE rig_intensidades ADD CONSTRAINT rig_intensidad_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	ADD CONSTRAINT rig_intensidades_ck CHECK (tipo IN ('P', 'EdP', 'EdT', 'EdC', 'EdS')),
	ALTER COLUMN id SET DEFAULT nextval('rig_intensidades_id_seq');

CREATE TABLE rig_presentaciones_perfumes (
	id_perf INTEGER,
	id_int INTEGER,
	id INTEGER,
	vol NUMERIC(10, 2),
	PRIMARY KEY (id_perf, id_int, id)
);

CREATE SEQUENCE rig_presentaciones_perfumes_id_seq AS INTEGER OWNED BY rig_presentaciones_perfumes.id;
ALTER TABLE rig_presentaciones_perfumes ADD CONSTRAINT rig_presentaciones_perfumes_id_perf_fk FOREIGN KEY (id_perf, id_int) REFERENCES rig_intensidades (id_perf, id),
	ALTER COLUMN id SET DEFAULT nextval('rig_presentaciones_perfumes_id_seq');

CREATE TABLE rig_palabras_claves (
	id SMALLINT PRIMARY KEY,
	palabra VARCHAR(20) NOT NULL UNIQUE
);

CREATE SEQUENCE rig_palabras_claves_id_seq AS SMALLINT MAXVALUE 100 OWNED BY rig_palabras_claves.id;
ALTER TABLE rig_palabras_claves ALTER COLUMN id SET DEFAULT nextval('rig_palabras_claves_id_seq');

CREATE TABLE rig_familias_olfativas (
	id SMALLINT PRIMARY KEY,
	nombre VARCHAR (20) UNIQUE
);

CREATE SEQUENCE rig_familias_olfativas_id_seq AS SMALLINT MAXVALUE 15 OWNED BY rig_familias_olfativas.id;
ALTER TABLE rig_familias_olfativas ALTER COLUMN id SET DEFAULT nextval('rig_familias_olfativas_id_seq');

CREATE TABLE rig_palabras_familias (
	id_pal SMALLINT,
	id_fao SMALLINT,
	PRIMARY KEY (id_pal, id_fao)
);

ALTER TABLE rig_palabras_familias ADD CONSTRAINT rig_palabras_familias_id_pal_fk FOREIGN KEY (id_pal) REFERENCES rig_palabras_claves,
	ADD CONSTRAINT  rig_palabras_familias_id_fao_fk FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas;

CREATE TABLE rig_familias_perfumes (
	id_fao SMALLINT,
	id_perf INTEGER,
	PRIMARY KEY (id_fao, id_perf)
);

ALTER TABLE rig_familias_perfumes ADD CONSTRAINT rig_familias_perfumes_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	ADD CONSTRAINT rig_familias_perfumes_id_fao_fk FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas;

CREATE TABLE rig_esencias_perfumes (
	id INTEGER PRIMARY KEY,
	cas VARCHAR (30) NOT NULL UNIQUE,
	nombre VARCHAR(20) NOT NULL UNIQUE,
	tipo VARCHAR(10)
);

CREATE SEQUENCE rig_esencias_perfumes_id_seq AS INTEGER OWNED BY rig_esencias_perfumes.id;
ALTER TABLE rig_esencias_perfumes ADD CONSTRAINT rig_esencias_perfumes_ck CHECK (tipo IN ('NATURAL', 'ARTIFICIAL')),
	ALTER COLUMN id SET DEFAULT nextval('rig_esencias_perfumes_id_seq');

CREATE TABLE rig_notas (
	id_perf INTEGER,
	id_esenp INTEGER,
	tipo VARCHAR(10),
	PRIMARY KEY (id_perf, id_esenp)
);

ALTER TABLE rig_notas ADD CONSTRAINT rig_notas_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	ADD CONSTRAINT rig_notas_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes,
	ADD CONSTRAINT rig_notas_ck CHECK (tipo IN ('NOTA', 'SALIDA', 'FONDO'));

CREATE TABLE rig_monoliticos (
	id_perf INTEGER,
	id_esenp INTEGER,
	PRIMARY KEY (id_perf, id_esenp)
);

ALTER TABLE rig_monoliticos ADD CONSTRAINT rig_monoliticos_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	ADD CONSTRAINT rig_monoliticos_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes;

CREATE TABLE rig_esencias (
	id_fao SMALLINT,
	id_esenp INTEGER,
	PRIMARY KEY (id_fao,  id_esenp)
);

ALTER TABLE rig_esencias ADD CONSTRAINT rig_esencias_id_fao FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas,
	ADD CONSTRAINT rig_esencias_id_esenp FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes;

CREATE TABLE rig_componentes_funcionales (
	id_prov SMALLINT,
	id_otro_ing INTEGER,
	id_perf INTEGER,
	PRIMARY KEY (id_prov, id_otro_ing, id_perf)
);

ALTER TABLE rig_componentes_funcionales ADD CONSTRAINT rig_componentes_funcionales_otro_ing_fk FOREIGN KEY (id_prov, id_otro_ing) REFERENCES rig_otros_ingredientes (id_prov, id),
	ADD CONSTRAINT rig_componentes_funcionales_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes;

CREATE TABLE rig_origenes (
	id_fao SMALLINT,
	id_esenp INTEGER,
	PRIMARY KEY (id_fao, id_esenp)
);

ALTER TABLE rig_origenes ADD CONSTRAINT rig_origenes_id_fao_fk FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas,
	ADD CONSTRAINT rig_origenes_funcionales_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes;

CREATE TABLE rig_contrato (
	id INTEGER PRIMARY KEY,
	fcha_reg DATE NOT NULL,
	exc VARCHAR (2) NOT NULL,
	cancelante VARCHAR (20),
	fcha_fin DATE,
	mot_fin VARCHAR (50),
	id_prod SMALLINT,
	id_prov SMALLINT
);

CREATE SEQUENCE rig_contrato_id_seq AS INTEGER OWNED BY rig_contrato.id;
ALTER TABLE rig_contrato ADD CONSTRAINT rig_contrato_ck CHECK (exc IN ('SI', 'NO') AND ((id_prod IS NULL) != (id_prov IS NULL))),
	ADD CONSTRAINT rig_contrato_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores,
	ADD CONSTRAINT rig_contrato_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	ALTER COLUMN id SET DEFAULT nextval('rig_contrato_id_seq');

CREATE TABLE rig_renovacion (
	id_ctra INTEGER,
	id INTEGER,
	fcha_reg DATE,
	PRIMARY KEY (id_ctra, id)
);

CREATE SEQUENCE rig_renovacion_id_seq AS INTEGER OWNED BY rig_renovacion.id;
ALTER TABLE rig_renovacion ADD CONSTRAINT rig_renovacion_id_ctra FOREIGN KEY (id_ctra) REFERENCES rig_contrato,
	ALTER COLUMN id SET DEFAULT nextval('rig_renovacion_id_seq');

CREATE TABLE rig_condiciones_contratos (
	id_ctra INTEGER,
	id SMALLINT, --No amerita una secuencia ya que nunca cambia
	id_prov_ce SMALLINT,
	id_ubic SMALLINT,
	id_prov_cp SMALLINT,
	id_condpgo INTEGER,
	PRIMARY KEY (id_ctra, id)
);

ALTER TABLE rig_condiciones_contratos ADD CONSTRAINT rig_condiciones_contratos_id_ctra_fk FOREIGN KEY (id_ctra) REFERENCES rig_contrato,
	ADD CONSTRAINT rig_condiciones_contratos_cond_env_fk FOREIGN KEY (id_prov_ce, id_ubic) REFERENCES rig_condiciones_de_envio (id_prov, id_ubic),
	ADD CONSTRAINT rig_condiciones_contratos_cond_pgo_fk FOREIGN KEY (id_prov_cp, id_condpgo) REFERENCES rig_condiciones_de_pago (id_prov, id);


CREATE TABLE rig_productos_contratados (
	id_ctra INTEGER,
	id SMALLINT, --No amerita una secuencia ya que nunca cambia
	id_prov_ing SMALLINT,
	id_ing INTEGER,
	id_pre_ing INTEGER,
	id_prov_otr SMALLINT,
	id_otr_ing INTEGER,
	id_pre_otr INTEGER,
	PRIMARY KEY (id_ctra, id) --AK
);

ALTER TABLE rig_productos_contratados ADD CONSTRAINT rig_productos_contratados_id_ctra_fk FOREIGN KEY (id_ctra) REFERENCES rig_contrato,
	ADD CONSTRAINT rig_productos_contratados_ing_fk FOREIGN KEY (id_prov_ing, id_ing, id_pre_ing) REFERENCES rig_presentaciones_ingredientes (id_prov, id_ing, cod_present),
	ADD CONSTRAINT rig_productos_contratados_otr_ing_fk FOREIGN KEY (id_prov_otr, id_otr_ing, id_pre_otr) REFERENCES rig_presentaciones_otros_ingredientes (id_prov, id_otro_ing, cod_present);

CREATE TABLE rig_pedidos (
	id INTEGER PRIMARY KEY,
	fcha_reg DATE NOT NULL,
	estatus VARCHAR (10) NOT NULL DEFAULT 'NO ENVIADO',
	factura INTEGER UNIQUE,
	total NUMERIC(20,2),
	id_ctra_conp BIGINT,
	id_conp BIGINT,
	id_ctra_cone BIGINT,
	id_conev BIGINT
);

CREATE SEQUENCE rig_pedidos_id_seq AS INTEGER OWNED BY rig_pedidos.id;
CREATE SEQUENCE rig_factura_id_seq OWNED BY rig_pedidos.factura;
ALTER TABLE rig_pedidos ADD CONSTRAINT rig_pedido_ck CHECK (estatus IN ('ENVIADO', 'NO ENVIADO')),
	ADD CONSTRAINT rig_pedido_conev_fk FOREIGN KEY (id_ctra_cone, id_conev) REFERENCES rig_condiciones_contratos (id_ctra, id),
	ADD CONSTRAINT rig_pedido_conp_fk FOREIGN KEY (id_ctra_conp, id_conp) REFERENCES rig_condiciones_contratos (id_ctra, id),
	ALTER COLUMN id SET DEFAULT nextval('rig_pedidos_id_seq'),
	ALTER COLUMN factura SET DEFAULT nextval('rig_factura_id_seq');

CREATE TABLE rig_detalles_pedidos (
	id_ped INTEGER,
	renglon SMALLINT, --No amerita una secuencia
	cantidad INTEGER NOT NULL,
	id_prov_ing BIGINT,
	id_ing BIGINT,
	id_pre_ing BIGINT,
	id_prov_otr BIGINT,
	id_otro_ing BIGINT,
	id_pre_otr BIGINT,
	PRIMARY KEY (id_ped, renglon)
);

ALTER TABLE rig_detalles_pedidos ADD CONSTRAINT rig_detalles_pedidos_ck CHECK (cantidad > 0), --AK
	ADD CONSTRAINT rig_detalles_pedidos_ing_fk FOREIGN KEY (id_prov_ing, id_ing, id_pre_ing) REFERENCES rig_presentaciones_ingredientes (id_prov, id_ing, cod_present),
	ADD CONSTRAINT rig_detalles_pedidos_otr_fk FOREIGN KEY (id_prov_otr, id_otro_ing, id_pre_otr) REFERENCES rig_presentaciones_otros_ingredientes (id_prov, id_otro_ing, cod_present);

CREATE TABle rig_pagos (
	id_ped INTEGER,
	id_ord SMALLINT, --No amerita una secuencia
	fcha_reg DATE NOT NULL,
	total NUMERIC (20,2) NOT NULL,
	PRIMARY KEY (id_ped, id_ord)
);

ALTER TABLE rig_pagos ADD CONSTRAINT rig_pagos_id_ped FOREIGN KEY (id_ped) REFERENCES rig_pedidos;
--COMMIT;
--################################################################################################################################

-- rig_paises
INSERT INTO rig_paises VALUES
	(DEFAULT, 'Australia'),
	(DEFAULT, 'Austria'),
	(DEFAULT, 'Azerbaiyán'),
	(DEFAULT, 'Anguilla'),
	(DEFAULT, 'Argentina'),
	(DEFAULT, 'Armenia'),
	(DEFAULT, 'Bielorrusia'),
	(DEFAULT, 'Belice'),
	(DEFAULT, 'Bélgica'),
	(DEFAULT, 'Bermudas'),
	(DEFAULT, 'Bulgaria'),
	(DEFAULT, 'Brasil'),
	(DEFAULT, 'Reino Unido'),
	(DEFAULT, 'Hungría'),
	(DEFAULT, 'Vietnam'),
	(DEFAULT, 'Haiti'),
	(DEFAULT, 'Guadalupe'),
	(DEFAULT, 'Alemania'),
	(DEFAULT, 'Países Bajos - Holanda'), 
	(DEFAULT, 'Grecia'),
	(DEFAULT, 'Georgia'),
	(DEFAULT, 'Dinamarca'),
	(DEFAULT, 'Egipto'),
	(DEFAULT, 'Israel'),
	(DEFAULT, 'India'),
	(DEFAULT, 'Irán'),
	(DEFAULT, 'Irlanda'),
	(DEFAULT, 'España'),
	(DEFAULT, 'Italia'),
	(DEFAULT, 'Kazajstán'),
	(DEFAULT, 'Camerún'),
	(DEFAULT, 'Canadá'),
	(DEFAULT, 'Chipre'),
	(DEFAULT, 'Kirguistán'),
	(DEFAULT, 'China'),
	(DEFAULT, 'Costa Rica'),
	(DEFAULT, 'Kuwait'),
	(DEFAULT, 'Letonia'),
	(DEFAULT, 'Libia'),
	(DEFAULT, 'Lituania'),
	(DEFAULT, 'Luxemburgo'),
	(DEFAULT, 'México'),
	(DEFAULT, 'Moldavia'),
	(DEFAULT, 'Mónaco'),
	(DEFAULT, 'Nueva Zelanda'),
	(DEFAULT, 'Noruega'),
	(DEFAULT, 'Polonia'),
	(DEFAULT, 'Portugal'),
	(DEFAULT, 'Reunión'),
	(DEFAULT, 'Rusia'),
	(DEFAULT, 'El Salvador'),
	(DEFAULT, 'Eslovaquia'),
	(DEFAULT, 'Eslovenia'),
	(DEFAULT, 'Surinam'),
	(DEFAULT, 'Estados Unidos'),
	(DEFAULT, 'Tadjikistan'),
	(DEFAULT, 'Turkmenistan'),
	(DEFAULT, 'Islas Turcas y Caicos'),
	(DEFAULT, 'Turquía'),
	(DEFAULT, 'Uganda'),
	(DEFAULT, 'Uzbekistán'),
	(DEFAULT, 'Ucrania'),
	(DEFAULT, 'Finlandia'),
	(DEFAULT, 'Francia'),
	(DEFAULT, 'República Checa'),
	(DEFAULT, 'Suiza'),
	(DEFAULT, 'Suecia'),
	(DEFAULT, 'Estonia'),
	(DEFAULT, 'Corea del Sur'),
	(DEFAULT, 'Japón'),
	(DEFAULT, 'Croacia'),
	(DEFAULT, 'Rumanía'),
	(DEFAULT, 'Hong Kong'),
	(DEFAULT, 'Indonesia'),
	(DEFAULT, 'Jordania'),
	(DEFAULT, 'Malasia'),
	(DEFAULT, 'Singapur'),
	(DEFAULT, 'Taiwan'),
	(DEFAULT, 'Bosnia y Herzegovina'),
	(DEFAULT, 'Bahamas'),
	(DEFAULT, 'Chile'),
	(DEFAULT, 'Colombia'),
	(DEFAULT, 'Islandia'),
	(DEFAULT, 'Corea del Norte'),
	(DEFAULT, 'Macedonia'),
	(DEFAULT, 'Malta'),
	(DEFAULT, 'Pakistán'),
	(DEFAULT, 'Papúa-Nueva Guinea'),
	(DEFAULT, 'Perú'),
	(DEFAULT, 'Filipinas'),
	(DEFAULT, 'Arabia Saudita'),
	(DEFAULT, 'Tailandia'),
	(DEFAULT, 'Emiratos árabes Unidos'),
	(DEFAULT, 'Groenlandia'),
	(DEFAULT, 'Venezuela'),
	(DEFAULT, 'Zimbabwe'),
	(DEFAULT, 'Kenia'),
	(DEFAULT, 'Algeria'),
	(DEFAULT, 'Líbano'),
	(DEFAULT, 'Botsuana'),
	(DEFAULT, 'Tanzania'),
	(DEFAULT, 'Namibia'),
	(DEFAULT, 'Ecuador'),
	(DEFAULT, 'Marruecos'),
	(DEFAULT, 'Ghana'),
	(DEFAULT, 'Siria'),
	(DEFAULT, 'Nepal'),
	(DEFAULT, 'Mauritania'),
	(DEFAULT, 'Seychelles'),
	(DEFAULT, 'Paraguay'),
	(DEFAULT, 'Uruguay'),
	(DEFAULT, 'Congo (Brazzaville)'),
	(DEFAULT, 'Cuba'),
	(DEFAULT, 'Albania'),
	(DEFAULT, 'Nigeria'),
	(DEFAULT, 'Zambia'),
	(DEFAULT, 'Mozambique'),
	(DEFAULT, 'Angola'),
	(DEFAULT, 'Sri Lanka'),
	(DEFAULT, 'Etiopía'),
	(DEFAULT, 'Túnez'),
	(DEFAULT, 'Bolivia'),
	(DEFAULT, 'Panamá'),
	(DEFAULT, 'Malawi'),
	(DEFAULT, 'Liechtenstein'),
	(DEFAULT, 'Bahrein'),
	(DEFAULT, 'Barbados'),
	(DEFAULT, 'Chad'),
	(DEFAULT, 'Man, Isla de'),
	(DEFAULT, 'Jamaica'),
	(DEFAULT, 'Malí'),
	(DEFAULT, 'Madagascar'),
	(DEFAULT, 'Senegal'),
	(DEFAULT, 'Togo'),
	(DEFAULT, 'Honduras'),
	(DEFAULT, 'República Dominicana'),
	(DEFAULT, 'Mongolia'),
	(DEFAULT, 'Irak'),
	(DEFAULT, 'Sudáfrica'),
	(DEFAULT, 'Aruba'),
	(DEFAULT, 'Gibraltar'),
	(DEFAULT, 'Afganistán'),
	(DEFAULT, 'Andorra'),
	(DEFAULT, 'Antigua y Barbuda'),
	(DEFAULT, 'Bangladesh'),
	(DEFAULT, 'Benín'),
	(DEFAULT, 'Bután'),
	(DEFAULT, 'Islas Virgenes Británicas'),
	(DEFAULT, 'Brunéi'),
	(DEFAULT, 'Burkina Faso'),
	(DEFAULT, 'Burundi'),
	(DEFAULT, 'Camboya'),
	(DEFAULT, 'Cabo Verde'),
	(DEFAULT, 'Comores'),
	(DEFAULT, 'Congo (Kinshasa)'),
	(DEFAULT, 'Cook, Islas'),
	(DEFAULT, 'Costa de Marfil'),
	(DEFAULT, 'Djibouti, Yibuti'),
	(DEFAULT, 'Timor Oriental'),
	(DEFAULT, 'Guinea Ecuatorial'),
	(DEFAULT, 'Eritrea'),
	(DEFAULT, 'Feroe, Islas'),
	(DEFAULT, 'Fiyi'),
	(DEFAULT, 'Polinesia Francesa'),
	(DEFAULT, 'Gabón'),
	(DEFAULT, 'Gambia'),
	(DEFAULT, 'Granada'),
	(DEFAULT, 'Guatemala'),
	(DEFAULT, 'Guernsey'),
	(DEFAULT, 'Guinea'),
	(DEFAULT, 'Guinea-Bissau'),
	(DEFAULT, 'Guyana'),
	(DEFAULT, 'Jersey'),
	(DEFAULT, 'Kiribati'),
	(DEFAULT, 'Laos'),
	(DEFAULT, 'Lesotho'),
	(DEFAULT, 'Liberia'),
	(DEFAULT, 'Maldivas'),
	(DEFAULT, 'Martinica'),
	(DEFAULT, 'Mauricio'),
	(DEFAULT, 'Myanmar'),
	(DEFAULT, 'Nauru'),
	(DEFAULT, 'Antillas Holandesas'),
	(DEFAULT, 'Nueva Caledonia'),
	(DEFAULT, 'Nicaragua'),
	(DEFAULT, 'Níger'),
	(DEFAULT, 'Norfolk Island'),
	(DEFAULT, 'Omán'),
	(DEFAULT, 'Isla Pitcairn'),
	(DEFAULT, 'Qatar'),
	(DEFAULT, 'Ruanda'),
	(DEFAULT, 'Santa Elena'),
	(DEFAULT, 'San Cristobal y Nevis'),
	(DEFAULT, 'Santa Lucía'),
	(DEFAULT, 'San Pedro y Miquelón'),
	(DEFAULT, 'San Vincente y Granadinas'),
	(DEFAULT, 'Samoa'),
	(DEFAULT, 'San Marino'),
	(DEFAULT, 'San Tomé y Príncipe'),
	(DEFAULT, 'Serbia y Montenegro'),
	(DEFAULT, 'Sierra Leona'),
	(DEFAULT, 'Islas Salomón'),
	(DEFAULT, 'Somalia'),
	(DEFAULT, 'Sudán'),
	(DEFAULT, 'Swazilandia'),
	(DEFAULT, 'Tokelau'),
	(DEFAULT, 'Tonga'),
	(DEFAULT, 'Trinidad y Tobago'),
	(DEFAULT, 'Tuvalu'),
	(DEFAULT, 'Vanuatu'),
	(DEFAULT, 'Wallis y Futuna'),
	(DEFAULT, 'Sáhara Occidental'),
	(DEFAULT, 'Yemen'),
	(DEFAULT, 'Puerto Rico');
--COMMIT;

--rig_asociaciones_nacionales

INSERT INTO rig_asociaciones_nacionales VALUES (DEFAULT, 'FFAANZ - Flavour & Fragrance Association of Australia & New Zealand', 'ASIA-PACÍFICO', 45),
	(DEFAULT, 'CAFFCI - China Association of Flavor, Fragrance & Cosmetic Industries', 'ASIA-PACÍFICO', 35),
	(DEFAULT, 'AFFI - Asosiasi Flavor dan Fragran Indonesia', 'ASIA-PACÍFICO', 74),
	(DEFAULT, 'JFFMA - Japan Flavor & Fragrance Materials Association ', 'ASIA-PACÍFICO', 70),
	(DEFAULT, 'KFFA - Korea Flavor & Fragrance Association', 'ASIA-PACÍFICO', 84),
	(DEFAULT, 'FFAS - Flavor & Fragrance Association Singapore ', 'ASIA-PACÍFICO', 77),
	(DEFAULT, 'Prodarom', 'EUROPA', 64),
	(DEFAULT, 'DVRH - Deustcher Verband der Riechstoff-Hersteller E.V.', 'EUROPA', 18),
	(DEFAULT, 'AISPEC - Federchimica Assospecifici', 'EUROPA', 29),
	(DEFAULT, 'NEA', 'EUROPA', 19),
	(DEFAULT, 'SAAFFI - South African Association of the Flavour & Fragrance Industry', 'EUROPA', 139),
	(DEFAULT, 'AEFAA - Asociación Española de Fragancias y Aromas Alimentarios', 'EUROPA', 28),
	(DEFAULT, 'SFFIA - Swiss Flavour and Fragrance Industry Association', 'EUROPA', 66),
	(DEFAULT, 'AREP', 'EUROPA', 59),
	(DEFAULT, 'IFRA UK', 'EUROPA', 13),
	(DEFAULT, 'CAFEPA - Cámara Argentina de Fabricantes de Productos Aromaticos', 'LATINOAMERICA', 5),
	(DEFAULT, 'ABIFRA - Associaçao Brasileira das Industrias de Oleos Essenciais, Fragrancias, Aromas', 'LATINOAMERICA', 12),
	(DEFAULT, 'ACHISAF - Asociación Chilena de Sabores y Fragancias Asociación',  'LATINOAMERICA', 81),
	(DEFAULT, 'CISF - Cámara de la Industria de Sabores y Fragrancias', 'LATINOAMERICA', 82),
	(DEFAULT, 'ANFPA - Asociación Nacional de Fabricantes de Productos Aromáticos ', 'LATINOAMERICA', 42),
	(DEFAULT, 'Fragrance Creators Association', 'AMÉRICA DEL NORTE', 55);

--rig_productores

INSERT INTO rig_productores VALUES (DEFAULT, 'Firmenich', 'www.firmenich.com', 'Rue de la Bergère 7 P.O. Box 148 Switzerland', 'firmenich@ifra.com','+41 22 780 22 11');
INSERT INTO rig_productores VALUES 	(DEFAULT, 'Tru Fragace', 'www.trufragrance.com', '350 Fifth Ave. Ste 6100 New York, NY 10118', 'customercare@trufragrance.com','+1 800 443 3000',21),
	(DEFAULT, 'MANE', 'www.mane.com', 'Avenue Jean Monnet', 'info@mane.com','+33 2 43 62 11 00',7);

--rig_proveedores

INSERT INTO rig_proveedores VALUES (DEFAULT, 'Privi Organics India Limited', 'www.privi.com', 'Privi House, A-71,TTC Industrial Area, Thane Belapur Road,Kopar Khairane, Navi Mumbai - 400 709, India', 'info@privi.co.in','+91 22 33043500', 25),
	(DEFAULT, 'Ethernis Fine Chemicals', 'www.eternis.com', '1004 Peninsula Tower Peninsula Corporate Park G.K. Marg, Lower Parel Mumbai 400 013 India', 'info@eternis.com','+91 22 66513400', 25),
	(DEFAULT, 'BASF', 'www.basf.com', 'Bahnsteigstraße, 67063 Ludwigshafen am Rhein, Alemania', 'info@basf.com','+49 0621 60-0', 18);

INSERT INTO rig_proveedores VALUES (DEFAULT, 'Destilerías Muñoz Gálvez S.A.', 'www.dmg.es', 'Av. Ciudad de Almería, 162, 30010, Murcia', 'info@dmg.es','+34 968 25 3500', 28, 12),
	(DEFAULT, 'Lluch Essence', 'www.lluche.com', 'Lo Gaiter, 160 08820 Prat de Llobregat Barcelona', 'web@lluche.com','+34 93 3793849', 28, 12),
	(DEFAULT, 'Perfumers Apprentice', 'www.shop.perfumersapprentice.com', '200 Technology Circle Scotts Valley, California, 95066', 'admin@perfumersapprentice.com','+1 831 316 7138', 55, 21);

--rig_sucursales

INSERT INTO rig_sucursales VALUES (66, 1), (2,1), (9,1), (22,1), (64,1), (18,1), (29,1), (115,1), (46,1), (47,1), (50,1),
	(139,1), (28,1), (13, 1), (1,1), (35,1), (25,1), (74, 1), (70,1), (69,1), (77,1), (78,1), (92,1), (15,1), (5,1), (12,1), 
	(82,1),	(42,1), (55,1), (55,2), (64,3), (18,3), (13,3), (66,3), (28,3), (104,3), (105,3), (157,3), (115,3), (139,3), 
	(97,3), (50,3), (188,3), (59,3);

--rig_membresias

INSERT INTO rig_membresias (fcha_reg, tipo_m, id_prod) VALUES (CURRENT_DATE - integer '10', 'PRINCIPAL', 1),
	(CURRENT_DATE - integer '9', 'REGIONAL', 2),
	(CURRENT_DATE - integer '8', 'REGIONAL', 3);

INSERT INTO rig_membresias (fcha_reg, tipo_m, id_prov) VALUES (CURRENT_DATE - integer '7', 'SECUNDARIO', 1),
	(CURRENT_DATE - integer '6', 'SECUNDARIO', 2),
	(CURRENT_DATE - integer '5', 'PRINCIPAL', 3),
	(CURRENT_DATE - integer '4', 'REGIONAL', 4),
	(CURRENT_DATE - integer '3', 'REGIONAL', 5),
	(CURRENT_DATE - integer '2', 'REGIONAL', 6);
