DROP TABLE IF EXISTS rig_pagos;
DROP TABLE IF EXISTS rig_detalles_pedidos;
DROP TABLE IF EXISTS rig_pedidos;
DROP TABLE IF EXISTS rig_productos_contratados;
DROP TABLE IF EXISTS rig_condiciones_contratos;
DROP TABLE IF EXISTS rig_renovaciones;
DROP TABLE IF EXISTS rig_contratos;
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
DROP TABLE IF EXISTS rig_origenes_ingredientes_esencias;
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
	fcha_reg TIMESTAMP PRIMARY KEY DEFAULT CURRENT_DATE,
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
	nombre VARCHAR (30) NOT NULL,
	porce_serv NUMERIC (3,2) NOT NULL,
	medio VARCHAR (15) NOT NULL,
	PRIMARY KEY(id_prov, id_ubic)
);

ALTER TABLE rig_condiciones_de_envio ADD CONSTRAINT rig_condiciones_de_envio_ck CHECK (medio IN ('AEREO', 'TERRESTRE', 'MARITIMO')),
	ADD CONSTRAINT rig_condiciones_de_envio_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	ADD CONSTRAINT rig_condiciones_de_envio_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises;

CREATE TABLE rig_escalas (
	id_prod SMALLINT,
	fcha_reg TIMESTAMP,
	rgo_ini SMALLINT NOT NULL,
	rgo_fin SMALLINT NOT NULL,
	fcha_fin DATE,
	PRIMARY KEY (id_prod, fcha_reg)
);

ALTER TABLE rig_escalas ADD CONSTRAINT rig_escalas_id_prod FOREIGN KEY (id_prod) REFERENCES rig_productores;

CREATE TABLE rig_resultados (
	id_prod SMALLINT,
	id_prov SMALLINT,
	fcha_reg TIMESTAMP,
	tipo_eval VARCHAR (15) NOT NULL,
	res NUMERIC (5,2) NOT NULL,
	PRIMARY KEY (id_prod, id_prov, fcha_reg)
);

ALTER TABLE rig_resultados ADD CONSTRAINT rig_resultados_ck CHECK (tipo_eval IN ('INICIAL', 'RENOVACION')),
  ADD CONSTRAINT rig_resultados_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores,
  ADD CONSTRAINT rig_resultados_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores;

CREATE TABLE rig_variables (
	id SMALLINT PRIMARY KEY,
	nombre VARCHAR (25) NOT NULL UNIQUE,
	des VARCHAR (80) NOT NULL
);

CREATE SEQUENCE rig_variables_id_seq AS SMALLINT MAXVALUE 10 OWNED BY rig_variables.id;
ALTER TABLE rig_variables ALTER COLUMN id SET DEFAULT nextval('rig_variables_id_seq');

CREATE TABLE rig_evaluaciones_criterios (
	id_prod SMALLINT,
	id_var SMALLINT,
	fcha_reg TIMESTAMP,
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
	cas BIGINT NOT NULL,
	nombre VARCHAR (50) NOT NULL,
	tipo VARCHAR (15) NOT NULL,
	des VARCHAR (500) NOT NULL,
	solubilidad VARCHAR (100),
	peligrosidad VARCHAR (15),
	vida_alm SMALLINT,
	ctrl VARCHAR (15),
	PRIMARY KEY (id_prov, id)
);
CREATE SEQUENCE rig_ingredientes_esencias_id_seq AS integer OWNED BY rig_ingredientes_esencias.id;
ALTER TABLE rig_ingredientes_esencias ADD CONSTRAINT rig_ingrediente_esencia_ck CHECK (
	(tipo IN ('NATURAL', 'SINTETICO'))	AND (peligrosidad IN ('ALTA', 'MEDIA', 'BAJA', 'NINGUNA')) AND (ctrl IN ('SI', 'NO'))),
	ADD CONSTRAINT rig_ingrediente_esencia_id_prod_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	ALTER COLUMN id SET DEFAULT nextval('rig_ingredientes_esencias_id_seq');

CREATE TABLE rig_origenes_ingredientes_esencias (
	id_prov SMALLINT,
	id_ing INTEGER,
	id_ubic SMALLINT,
	PRIMARY KEY (id_prov, id_ing, id_ubic)
);

ALTER TABLE rig_origenes_ingredientes_esencias ADD CONSTRAINT rig_origenes_ingredientes_esencias_ing FOREIGN KEY (id_prov, id_ing) REFERENCES rig_ingredientes_esencias (id_prov, id),
	ADD CONSTRAINT rig_origenes_ingredientes_esencias_ubic FOREIGN KEY (id_ubic) REFERENCES rig_paises;
	
CREATE TABLE rig_prohibidas (
	cas BIGINT PRIMARY KEY,
	nombre VARCHAR (80),
	tipo VARCHAR (3)
);

ALTER TABLE rig_prohibidas ADD CONSTRAINT rig_prohibidas_ck CHECK (tipo IN ('P', 'R', 'S', 'R-S', 'R-P', 'P-S', 'P-R-S'));

CREATE TABLE rig_presentaciones_ingredientes (
	id_prov SMALLINT,
	id_ing INTEGER,
	cod_present INTEGER,
	medida NUMERIC (10,2) NOT NULL,
	unidad VARCHAR (3) NOT NULL,
	precio NUMERIC (10,2) NOT NULL,
	PRIMARY KEY (id_prov, id_ing, cod_present)
);

CREATE SEQUENCE rig_presentaciones_ingredientes_id_seq AS INTEGER OWNED BY rig_presentaciones_ingredientes.cod_present;
ALTER TABLE rig_presentaciones_ingredientes ADD CONSTRAINT rig_presentaciones_ingredientes_ing_fk FOREIGN KEY (id_prov, id_ing) REFERENCES rig_ingredientes_esencias (id_prov, id),
	ALTER COLUMN cod_present SET DEFAULT nextval('rig_presentaciones_ingredientes_id_seq');

CREATE TABLE rig_otros_ingredientes (
	id_prov SMALLINT,
	cas BIGINT,
	nombre VARCHAR (20) NOT NULL,
	des VARCHAR (50) NOT NULL,
	PRIMARY KEY (cas)
);

ALTER TABLE rig_otros_ingredientes ADD CONSTRAINT rig_otros_ingredientes_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores;

CREATE TABLE rig_presentaciones_otros_ingredientes (
	cas_otr_ing BIGINT,
	cod_present INTEGER,
	precio NUMERIC (10,2) NOT NULL,
	volumen NUMERIC (10, 2),
	otra_pre VARCHAR (15),
	des VARCHAR (50),
	PRIMARY KEY (cas_otr_ing, cod_present)
);

CREATE SEQUENCE rig_presentaciones_otros_ingredientes_id_seq AS INTEGER OWNED BY rig_presentaciones_otros_ingredientes.cod_present;
ALTER TABLE rig_presentaciones_otros_ingredientes ADD CONSTRAINT rig_presentaciones_ingredientes_ck CHECK (otra_pre IN ('RESTRINGIDO', 'PROHIBIDO')),
	ADD CONSTRAINT rig_presentaciones_otros_ingredientes_fk FOREIGN KEY (cas_otr_ing) REFERENCES rig_otros_ingredientes (cas),
	ALTER COLUMN cod_present SET DEFAULT nextval('rig_presentaciones_otros_ingredientes_id_seq');

CREATE TABLE rig_ingredientes_extras (
	id_prov_ing SMALLINT,
	id_ing BIGINT,
	id_prov_otr SMALLINT,
	cas_otr_ing BIGINT,
	PRIMARY KEY (id_prov_ing, id_ing, id_prov_otr, cas_otr_ing)
);

ALTER TABLE rig_ingredientes_extras ADD CONSTRAINT rig_ingredientes_extras_ing_ese_fk FOREIGN KEY (id_prov_ing, id_ing) REFERENCES rig_ingredientes_esencias (id_prov, id),
	ADD CONSTRAINT rig_ingredientes_extras_otr_ing_gk FOREIGN KEY (cas_otr_ing) REFERENCES rig_otros_ingredientes (cas);

CREATE TABLE rig_perfumes (
	id INTEGER PRIMARY KEY,
	id_prod SMALLINT,
	nombre VARCHAR (100) NOT NULL,
	genero VARCHAR NOT NULL,
	tipo VARCHAR (5) NOT NULL,
	edad VARCHAR (15) NOT NULL,--Revisar,
	fcha_crea SMALLINT,
	des TEXT
);

CREATE SEQUENCE rig_perfumes_id_seq AS INTEGER OWNED BY rig_perfumes.id;
ALTER TABLE rig_perfumes ADD CONSTRAINT rig_perfumes_ck CHECK ((genero IN ('F', 'M', 'U')) AND (tipo IN ('MONO', 'FASES')) AND edad IN ('JOVEN', 'ADULTO', 'MAYOR', 'ATEMPORAL')),
	ALTER COLUMN id SET DEFAULT nextval('rig_perfumes_id_seq'),
	ADD CONSTRAINT rig_perfumes_id_prov_fk FOREIGN KEY (id_prod) REFERENCES rig_productores (id);

CREATE TABLE rig_perfumistas (
	id INTEGER PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL UNIQUE,
	genero VARCHAR NOT NULL,
	fcha_nac DATE,
	id_ubic SMALLINT
);

CREATE SEQUENCE rig_perfumistas_id_seq AS INTEGER OWNED BY rig_perfumistas.id;
ALTER TABLE rig_perfumistas ADD CONSTRAINT rig_perfumistas_ck CHECK (genero IN ('F', 'M')),
	ALTER COLUMN id SET DEFAULT nextval('rig_perfumistas_id_seq'),
	ADD CONSTRAINT rig_perfumistas_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises;

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
	unidad VARCHAR (3),
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
ALTER TABLE rig_esencias_perfumes ADD CONSTRAINT rig_esencias_perfumes_ck CHECK (tipo IN ('NATURAL', 'SINTETICO')),
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
	PRIMARY KEY (id_fao, id_esenp)
);

ALTER TABLE rig_esencias ADD CONSTRAINT rig_esencias_id_fao FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas,
	ADD CONSTRAINT rig_esencias_id_esenp FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes;

CREATE TABLE rig_componentes_funcionales (
	cas_otr_ing INTEGER,
	id_perf INTEGER,
	PRIMARY KEY (cas_otr_ing, id_perf)
);

ALTER TABLE rig_componentes_funcionales ADD CONSTRAINT rig_componentes_funcionales_otro_ing_fk FOREIGN KEY (cas_otr_ing) REFERENCES rig_otros_ingredientes (cas),
	ADD CONSTRAINT rig_componentes_funcionales_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes;

CREATE TABLE rig_origenes (
	id_fao SMALLINT,
	id_esenp INTEGER,
	PRIMARY KEY (id_fao, id_esenp)
);

ALTER TABLE rig_origenes ADD CONSTRAINT rig_origenes_id_fao_fk FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas,
	ADD CONSTRAINT rig_origenes_funcionales_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes;

CREATE TABLE rig_contratos (
	id_prod SMALLINT,
	id_prov SMALLINT,
	id INTEGER,
	fcha_reg DATE NOT NULL,
	exc VARCHAR (2) NOT NULL,
	cancelante VARCHAR (50),
	fcha_fin DATE,
	mot_fin VARCHAR (50),
	PRIMARY KEY (id_prod, id_prov, id)
);

CREATE SEQUENCE rig_contrato_id_seq AS INTEGER OWNED BY rig_contratos.id;
ALTER TABLE rig_contratos ADD CONSTRAINT rig_contrato_ck CHECK (exc IN ('SI', 'NO')),
	ADD CONSTRAINT rig_contrato_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores,
	ADD CONSTRAINT rig_contrato_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	ALTER COLUMN id SET DEFAULT nextval('rig_contrato_id_seq');

CREATE TABLE rig_renovaciones (
	id_prod SMALLINT,
	id_prov SMALLINT,
	id_ctra INTEGER,
	id INTEGER,
	fcha_reg DATE,
	PRIMARY KEY (id_prod, id_prov, id_ctra, id)
);

CREATE SEQUENCE rig_renovaciones_id_seq AS INTEGER OWNED BY rig_renovaciones.id;
ALTER TABLE rig_renovaciones ADD CONSTRAINT rig_renovaciones_id_ctra FOREIGN KEY (id_prod, id_prov, id_ctra) REFERENCES rig_contratos,
	ALTER COLUMN id SET DEFAULT nextval('rig_renovaciones_id_seq');

CREATE TABLE rig_condiciones_contratos (
	id_prod SMALLINT,
	id_prov SMALLINT,
	id_ctra INTEGER,
	id SMALLINT, --No amerita una secuencia ya que nunca cambia
	id_prov_ce SMALLINT,
	id_ubic SMALLINT,
	id_prov_cp SMALLINT,
	id_condpgo INTEGER,
	PRIMARY KEY (id_prod, id_prov, id_ctra, id)
);

ALTER TABLE rig_condiciones_contratos ADD CONSTRAINT rig_condiciones_contratos_id_ctra_fk FOREIGN KEY (id_prod, id_prov, id_ctra) REFERENCES rig_contratos,
	ADD CONSTRAINT rig_condiciones_contratos_cond_env_fk FOREIGN KEY (id_prov_ce, id_ubic) REFERENCES rig_condiciones_de_envio (id_prov, id_ubic),
	ADD CONSTRAINT rig_condiciones_contratos_cond_pgo_fk FOREIGN KEY (id_prov_cp, id_condpgo) REFERENCES rig_condiciones_de_pago (id_prov, id);


CREATE TABLE rig_productos_contratados (
	id_prod SMALLINT,
	id_prov SMALLINT,
	id_ctra INTEGER,
	id SMALLINT, --No amerita una secuencia ya que nunca cambia
	id_prov_ing SMALLINT,
	id_ing INTEGER,
	cas_otr_ing BIGINT,
	PRIMARY KEY (id_prod, id_prov, id_ctra, id) --AK
);

ALTER TABLE rig_productos_contratados ADD CONSTRAINT rig_productos_contratados_id_ctra_fk FOREIGN KEY (id_prod, id_prov, id_ctra) REFERENCES rig_contratos,
	ADD CONSTRAINT rig_productos_contratados_ing_fk FOREIGN KEY (id_prov_ing, id_ing) REFERENCES rig_ingredientes_esencias (id_prov, id),
	ADD CONSTRAINT rig_productos_contratados_otr_ing_fk FOREIGN KEY (cas_otr_ing) REFERENCES rig_otros_ingredientes (cas);

CREATE TABLE rig_pedidos (
	id BIGINT PRIMARY KEY,
	fcha_reg DATE NOT NULL,
	estatus VARCHAR (10) NOT NULL DEFAULT 'NO ENVIADO',
	factura INTEGER UNIQUE,
	total NUMERIC(20,2),
	id_prod_conp SMALLINT,
	id_prov_conp SMALLINT,
	id_ctra_conp BIGINT,
	id_conp BIGINT,
	id_prod_cone SMALLINT,
	id_prov_cone SMALLINT,
	id_ctra_cone BIGINT,
	id_cone BIGINT
);

CREATE SEQUENCE rig_pedidos_id_seq AS BIGINT OWNED BY rig_pedidos.id;
CREATE SEQUENCE rig_factura_id_seq OWNED BY rig_pedidos.factura;
ALTER TABLE rig_pedidos ADD CONSTRAINT rig_pedido_ck CHECK (estatus IN ('ENVIADO', 'NO ENVIADO')),
	ADD CONSTRAINT rig_pedido_conev_fk FOREIGN KEY (id_prod_cone, id_prov_cone, id_ctra_cone, id_cone) REFERENCES rig_condiciones_contratos (id_prod, id_prov, id_ctra, id),
	ADD CONSTRAINT rig_pedido_conp_fk FOREIGN KEY (id_prod_conp, id_prov_conp, id_ctra_conp, id_conp) REFERENCES rig_condiciones_contratos (id_prod, id_prov, id_ctra, id),
	ALTER COLUMN id SET DEFAULT nextval('rig_pedidos_id_seq'),
	ALTER COLUMN factura SET DEFAULT nextval('rig_factura_id_seq');

CREATE TABLE rig_detalles_pedidos (
	id_ped INTEGER,
	renglon SMALLINT, --No amerita una secuencia
	cantidad INTEGER NOT NULL,
	id_prov_ing BIGINT,
	id_ing BIGINT,
	cod_pre_ing BIGINT,
	cas_otr_ing BIGINT,
	cod_pre_otr BIGINT,
	PRIMARY KEY (id_ped, renglon)
);

ALTER TABLE rig_detalles_pedidos ADD CONSTRAINT rig_detalles_pedidos_ck CHECK (cantidad > 0), --AK
	ADD CONSTRAINT rig_detalles_pedidos_ing_fk FOREIGN KEY (id_prov_ing, id_ing, cod_pre_ing) REFERENCES rig_presentaciones_ingredientes (id_prov, id_ing, cod_present),
	ADD CONSTRAINT rig_detalles_pedidos_otr_fk FOREIGN KEY (cas_otr_ing, cod_pre_otr) REFERENCES rig_presentaciones_otros_ingredientes (cas_otr_ing, cod_present);

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

INSERT INTO rig_asociaciones_nacionales VALUES 
	(DEFAULT, 'FFAANZ - Flavour & Fragrance Association of Australia & New Zealand', 'ASIA-PACÍFICO', 45),
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

INSERT INTO rig_productores VALUES 
	(DEFAULT, 'Firmenich', 'www.firmenich.com', 'Rue de la Bergère 7 P.O. Box 148 Switzerland', 'firmenich@ifra.com','+41 22 780 22 11');
INSERT INTO rig_productores VALUES 
	(DEFAULT, 'Tru Fragance', 'www.trufragrance.com', '350 Fifth Ave. Ste 6100 New York, NY 10118', 'customercare@trufragrance.com','+1 800 443 3000',21),
	(DEFAULT, 'MANE', 'www.mane.com', 'Avenue Jean Monnet', 'info@mane.com','+33 2 43 62 11 00',7);

--rig_proveedores

INSERT INTO rig_proveedores VALUES 
	(DEFAULT, 'Privi Organics India Limited', 'www.privi.com', 'Privi House, A-71,TTC Industrial Area, Thane Belapur Road,Kopar Khairane, Navi Mumbai - 400 709, India', 'info@privi.co.in','+91 22 33043500', 25),
	(DEFAULT, 'Ethernis Fine Chemicals', 'www.eternis.com', '1004 Peninsula Tower Peninsula Corporate Park G.K. Marg, Lower Parel Mumbai 400 013 India', 'info@eternis.com','+91 22 66513400', 25),
	(DEFAULT, 'BASF', 'www.basf.com', 'Bahnsteigstraße, 67063 Ludwigshafen am Rhein, Alemania', 'info@basf.com','+49 0621 60-0', 18);

INSERT INTO rig_proveedores VALUES 
	(DEFAULT, 'Destilerías Muñoz Gálvez S.A.', 'www.dmg.es', 'Av. Ciudad de Almería, 162, 30010, Murcia', 'info@dmg.es','+34 968 25 3500', 28, 12),
	(DEFAULT, 'Lluch Essence', 'www.lluche.com', 'Lo Gaiter, 160 08820 Prat de Llobregat Barcelona', 'web@lluche.com','+34 93 3793849', 28, 12),
	(DEFAULT, 'Perfumers Apprentice', 'www.shop.perfumersapprentice.com', '200 Technology Circle Scotts Valley, California, 95066', 'admin@perfumersapprentice.com','+1 831 316 7138', 55, 21);

--rig_sucursales

INSERT INTO rig_sucursales VALUES 
	(66, 1), (2,1), (9,1), (22,1), (64,1), (18,1), (29,1), (115,1), (46,1), (47,1), (50,1),
	(139,1), (28,1), (13, 1), (1,1), (35,1), (25,1), (74, 1), (70,1), (69,1), (77,1), (78,1), (92,1), (15,1), (5,1), (12,1),
	(82,1),	(42,1), (55,1), (55,2), (64,3), (18,3), (13,3), (66,3), (28,3), (104,3), (105,3), (157,3), (115,3), (139,3),
	(97,3), (50,3), (188,3), (59,3);

--rig_membresias

INSERT INTO rig_membresias (fcha_reg, tipo_m, id_prod) VALUES 
	(NOW() + '1 second', 'PRINCIPAL', 1),
	(NOW() + '2 second', 'REGIONAL', 2),
	(NOW() + '3 second', 'REGIONAL', 3);

INSERT INTO rig_membresias (fcha_reg, tipo_m, id_prov) VALUES 
	(NOW(), 'SECUNDARIO', 1),
	(NOW() + '4 second', 'SECUNDARIO', 2),
	(NOW() + '5 second', 'PRINCIPAL', 3),
	(NOW() + '6 second', 'REGIONAL', 4),
	(NOW() + '7 second', 'REGIONAL', 5),
	(NOW() + '8 second', 'REGIONAL', 6);


--rig_condiciones_de_pago

INSERT INTO rig_condiciones_de_pago VALUES 
	(1, DEFAULT, 'CONTADO', 1, 100, 6),
	(1, DEFAULT, 'PARCIAL', 4, 25, 6),
	(1, DEFAULT, 'PARCIAL', 10, 10, 8),
	(2, DEFAULT, 'PARCIAL', 5, 20, 4),
	(3, DEFAULT, 'PARCIAL', 2, 50, 10),
	(3, DEFAULT, 'CONTADO', 1, 100, 3),
	(4, DEFAULT, 'CONTADO', 1, 100, 4),
	(4, DEFAULT, 'PARCIAL', 4, 25, 4),
	(5, DEFAULT, 'CONTADO', 1, 100, 5),
	(5, DEFAULT, 'PARCIAL', 3, 33, 5),
	(5, DEFAULT, 'PARCIAL', 2, 50, 6),
	(6, DEFAULT, 'PARCIAL', 2, 50, 6);

--rig_condiciones_de_envio

INSERT INTO rig_condiciones_de_envio VALUES 
	(1, 66, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 2, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 9, 'Envio simple', 0.54, 'MARITIMO'),
	(1, 22, 'Envio simple', 0.56, 'MARITIMO'),
	(1, 64, 'Envio express', 0.1, 'TERRESTRE'),
	(1, 18, 'Envio simple', 0.55, 'MARITIMO'),
	(1, 29, 'Envio simple', 0.31, 'MARITIMO'),
	(1, 15, 'Envio simple', 0.51, 'MARITIMO'),
	(1, 115, 'Envio simple', 0.7, 'MARITIMO'),
	(1, 46, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 47, 'Envio simple', 0.3, 'MARITIMO'),
	(1, 50, 'Envio simple', 0.52, 'MARITIMO'),
	(1, 139, 'Envio simple con refrigeracion', 0.6, 'AEREO'),
	(1, 28, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 136, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 1, 'Envio con proteciones', 0.8, 'TERRESTRE'),
	(1, 25, 'Envios de gran volumen', 0.5, 'MARITIMO'),
	(1, 74, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 69, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 77, 'Envido con proteciones', 0.7, 'MARITIMO'),
	(1, 78, 'Envio simple', 0.51, 'MARITIMO'),
	(1, 92, 'Envio simple', 0.9, 'MARITIMO'),
	(1, 55, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 5, 'Envio express', 0.84, 'TERRESTRE'),
	(1, 82, 'Envio simple', 0.53, 'MARITIMO'),
	(1, 42, 'Envio simple', 0.54, 'MARITIMO'),
	(1, 13, 'Envio simple', 0.5, 'MARITIMO'),
	(1, 104, 'Envio simple', 0.7, 'AEREO'),
	(1, 188, 'Envio simple', 0.7, 'AEREO'),
	(1, 59, 'Envio simple', 0.7, 'AEREO'),
	(1, 97, 'Envio simple', 0.7, 'TERRESTRE'),
	(2, 2, 'Envio simple', 0.6, 'MARITIMO'),
	(2, 9, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 22, 'Envio simple', 0.22, 'TERRESTRE'),
	(2, 62, 'Envio express', 0.1, 'TERRESTRE'),
	(2, 18, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 21, 'Envio simple', 0.3, 'MARITIMO'),
	(2, 15, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 114, 'Envio simple', 0.6, 'TERRESTRE'),
	(2, 46, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 47, 'Envio sin embalaje', 0.3, 'MARITIMO'),
	(2, 50, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 139, 'Envio simple con refrigeracion', 0.6, 'AEREO'),
	(2, 28, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 13, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 1, 'Envio sin proteciones', 0.2, 'TERRESTRE'),
	(2, 25, 'Envios de gran volumen', 0.5, 'MARITIMO'),
	(2, 74, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 69, 'Envio express', 0.4, 'TERRESTRE'),
	(2, 71, 'Envido con proteciones', 0.7, 'MARITIMO'),
	(2, 78, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 92, 'Envio simple', 0.9, 'MARITIMO'),
	(2, 5, 'Envio simple', 0.5, 'MARITIMO'),
	(2, 54, 'Envio express', 0.8, 'TERRESTRE'),
	(2, 82, 'Envio simple', 0.4, 'MARITIMO'),
	(2, 42, 'Envio en container común', 0.3, 'MARITIMO'),
	(2, 77, 'Envio simple', 0.41, 'MARITIMO'),
	(2, 104, 'Envio simple', 0.7, 'AEREO'),
	(2, 140, 'Envio simple', 0.7, 'AEREO'),
	(2, 59, 'Envio simple', 0.7, 'AEREO'),
	(2, 97, 'Envio simple', 0.7, 'TERRESTRE'),
	(3, 2, 'Envio simple', 0.3, 'MARITIMO'),
	(3, 9, 'Envio simple', 0.4, 'MARITIMO'),
	(3, 22, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 64, 'Envio express', 0.1, 'TERRESTRE'),
	(3, 18, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 29, 'Envio simple', 0.3, 'MARITIMO'),
	(3, 15, 'Envio express con proteccion', 0.9, 'MARITIMO'),
	(3, 115, 'Envio simple', 0.7, 'MARITIMO'),
	(3, 46, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 47, 'Envio express', 0.4, 'MARITIMO'),
	(3, 50, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 139, 'Envio simple con refrigeracion', 0.6, 'AEREO'),
	(3, 28, 'Envio express', 0.9, 'AEREO'),
	(3, 68, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 1, 'Envio con proteciones', 0.8, 'TERRESTRE'),
	(3, 25, 'Envios de gran volumen', 0.5, 'MARITIMO'),
	(3, 74, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 69, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 77, 'Envido con proteciones', 0.7, 'MARITIMO'),
	(3, 78, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 92, 'Envio simple', 0.9, 'MARITIMO'),
	(3, 55, 'Envio express', 0.7, 'AEREO'),
	(3, 42, 'Envio simple', 0.55, 'MARITIMO'),
	(3, 13, 'Envio simple', 0.5, 'MARITIMO'),
	(3, 104, 'Envio simple', 0.7, 'AEREO'),
	(3, 188, 'Envio express', 0.5, 'TERRESTRE'),
	(3, 59, 'Envio simple', 0.7, 'AEREO'),
	(3, 97, 'Envio simple', 0.7, 'TERRESTRE'),
	(4, 2, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 9, 'Envio simple', 0.53, 'MARITIMO'),
	(4, 22, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 64, 'Envio express', 0.1, 'TERRESTRE'),
	(4, 18, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 29, 'Envio simple', 0.3, 'MARITIMO'),
	(4, 15, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 115, 'Envio simple', 0.71, 'MARITIMO'),
	(4, 46, 'Envio simple', 0.25, 'MARITIMO'),
	(4, 47, 'Envio simple', 0.34, 'MARITIMO'),
	(4, 50, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 139, 'Envio simple con refrigeracion', 0.6, 'AEREO'),
	(4, 28, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 13, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 1, 'Envio con proteciones', 0.81, 'TERRESTRE'),
	(4, 25, 'Envios de gran volumen', 0.5, 'MARITIMO'),
	(4, 92, 'Envio simple', 0.9, 'MARITIMO'),
	(4, 55, 'Envio simple', 0.45, 'MARITIMO'),
	(4, 5, 'Envio express', 0.8, 'TERRESTRE'),
	(4, 82, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 42, 'Envio simple', 0.5, 'MARITIMO'),
	(4, 74, 'Envio simple', 0.54, 'MARITIMO'),
	(4, 104, 'Envio simple', 0.7, 'AEREO'),
	(4, 188, 'Envio simple', 0.22, 'AEREO'),
	(4, 59, 'Envio simple', 0.84, 'AEREO'),
	(4, 97, 'Envio simple', 0.69, 'TERRESTRE'),
	(5, 2, 'Envio simple', 0.51, 'MARITIMO'),
	(5, 9, 'Envio simple', 0.5, 'MARITIMO'),
	(5, 22, 'Envio simple', 0.25, 'MARITIMO'),
	(5, 64, 'Envio express', 0.1, 'TERRESTRE'),
	(5, 18, 'Envio simple', 0.54, 'MARITIMO'),
	(5, 29, 'Envio simple', 0.3, 'TERRESTRE'),
	(5, 15, 'Envio simple', 0.35, 'MARITIMO'),
	(5, 46, 'Envio simple', 0.85, 'AEREO'),
	(5, 47, 'Envio simple', 0.3, 'MARITIMO'),
	(5, 50, 'Envio simple', 0.25, 'MARITIMO'),
	(5, 28, 'Envio simple', 0.15, 'MARITIMO'),
	(5, 121, 'Envio simple', 0.53, 'MARITIMO'),
	(5, 1, 'Envio con proteciones', 0.8, 'TERRESTRE'),
	(5, 25, 'Envios de gran volumen', 0.5, 'MARITIMO'),
	(5, 74, 'Envio simple', 0.53, 'MARITIMO'),
	(5, 69, 'Envio simple', 0.5, 'MARITIMO'),
	(5, 77, 'Envido con proteciones', 0.7, 'MARITIMO'),
	(5, 78, 'Envio simple', 0.5, 'MARITIMO'),
	(5, 55, 'Envio simple', 0.5, 'MARITIMO'),
	(5, 5, 'Envio express', 1, 'AEREO'),
	(5, 82, 'Envio simple', 0.5, 'MARITIMO'),
	(5, 42, 'Envio simple', 0.5, 'MARITIMO'),
	(5, 13, 'Envio simple', 0.5, 'MARITIMO'),
	(5, 104, 'Envio simple', 0.7, 'AEREO'),
	(5, 188, 'Envio simple', 0.7, 'AEREO'),
	(6, 2, 'Envio con refrigeracion', 0.5, 'MARITIMO'),
	(6, 9, 'Envio simple', 0.5, 'MARITIMO'),
	(6, 22, 'Envio simple', 0.5, 'MARITIMO'),
	(6, 64, 'Envio express', 0.1, 'TERRESTRE'),
	(6, 18, 'Envio simple', 0.53, 'MARITIMO'),
	(6, 29, 'Envio simple', 0.32, 'MARITIMO'),
	(6, 15, 'Envio simple', 0.5, 'MARITIMO'),
	(6, 115, 'Envio simple', 0.7, 'MARITIMO'),
	(6, 46, 'Envio con refrigeracion', 0.5, 'MARITIMO'),
	(6, 47, 'Envio simple', 0.3, 'MARITIMO'),
	(6, 50, 'Envio con refrigeracion', 0.5, 'MARITIMO'),
	(6, 139, 'Envio simple con refrigeracion', 0.6, 'AEREO'),
	(6, 28, 'Envio simple', 0.52, 'MARITIMO'),
	(6, 73, 'Envio simple', 0.1, 'MARITIMO'),
	(6, 1, 'Envio con proteciones', 0.8, 'TERRESTRE'),
	(6, 25, 'Envios de gran volumen', 0.5, 'MARITIMO'),
	(6, 74, 'Envio simple', 0.5, 'MARITIMO'),
	(6, 69, 'Envio simple', 0.5, 'MARITIMO'),
	(6, 77, 'Envido con proteciones', 0.7, 'MARITIMO'),
	(6, 78, 'Envio simple', 0.5, 'MARITIMO'),
	(6, 92, 'Envio con proteciones', 0.9, 'MARITIMO'),
	(6, 55, 'Envio simple', 0.55, 'MARITIMO'),
	(6, 5, 'Envio express', 0.8, 'TERRESTRE'),
	(6, 82, 'Envio simple', 0.55, 'MARITIMO'),
	(6, 42, 'Envio simple', 0.55, 'MARITIMO'),
	(6, 13, 'Envio simple', 0.5, 'MARITIMO'),
	(6, 104, 'Envio simple', 0.7, 'AEREO'),
	(6, 188, 'Envio simple', 0.7, 'AEREO'),
	(6, 59, 'Envio simple', 0.7, 'AEREO'),
	(6, 97, 'Envio simple', 0.7, 'TERRESTRE');

-- rig_variables

INSERT INTO rig_variables VALUES 
	(DEFAULT, 'Ubicación', 'Ubicación geográfica del proveedor'),
	(DEFAULT, 'Costos', 'Precio de los productos y servicios ofrecidos por el productor'),
	(DEFAULT,  'Alternativas de envio', 'Cantidad de métodos que ofrece el proveedor'),
	(DEFAULT, 'Cumplimiento de envios', 'Rendimiento del proveedor a lo largo del período'),
	(DEFAULT, 'Condiciones de pago', 'Alternativas de pago ofrecidas por el proveedor');

-- rig_prohibidas (

INSERT INTO rig_prohibidas VALUES 
	(100516, 'Benzyl alcohol', 'R'),
	(100527, 'Benzaldehyde', 'R'),
	(101393, 'α-Methyl cinnamic aldehyde', 'R'),
	(101859, 'α-Amyl cinnamic alcohol', 'R'),
	(101860, 'α-Hexyl cinnamic aldehyde', 'R'),
	(103413, 'Benzyl cinnamate', 'R'),
	(103504, 'Dibenzyl ether', 'R'),
	(103640, 'Bromostyrene', 'P'),
	(103957, 'Cyclamen aldehyde', 'R-S'),
	(103694684, '2,2-Dimethyl-3-(3-tolyl)propan-1-ol', 'R-S'),
	(104278, 'α-Methyl anisylidene acetone', 'P'),
	(105135, 'Anisyl alcohol', 'R'),
	(1331813, 'Anisyl alcohol', 'R'),
	(106025, 'Cyclopentadecanolide', 'R'),
	(1117619  , 'Citronellol', 'R'),
	(26489010 , 'Citronellol', 'R'),
	(141253 , 'Citronellol', 'R'),
	(7540514, 'Citronellol', 'R'),
	(106230 , 'Citronellal', 'R'),
	(5949053, 'Citronellal', 'R'),
	(106241, 'Geraniol', 'R'),
	(107755, 'Hydroxycitronellal', 'R'),
	(107898544, '3,3-Dimethyl-5-(2,2,3-trimethyl-3-cyclopenten-1-yl)-4-penten-2-ol', 'R'),
	(108883, 'Toluene', 'P-S'),
	(109864, 'Ethylene glycol monomethyl ether', 'P'),
	(110496, 'Ethylene glycol monomethyl acetate', 'P'),
	(110805, 'Ethylene glycol monoethyl ether', 'P'),
	(111159, 'Ethylene glycol monoethyl acetate', 'P'),
	(11028425, 'Cedrene', 'R'),
	(469614, 'Cedrene', 'R'),
	(546281, 'Cedrene', 'R'),
	(111126, 'Methyl heptine carbonate', 'R'),
	(111284 , '2,4-Hexadien-1-ol', 'P'),
	(17102646, '2,4-Hexadien-1-ol', 'P'),
	(111808, 'Methyl octine carbonate', 'R'),
	(116267, '2,6,6-Trimethylcyclohex-1,3-dienyl methanal', 'R'),
	(116665, 'Musk moskene', 'P'),
	(118581, 'Benzyl salicylate', 'R'),
	(119846, 'Dihydrocoumarin', 'R'),
	(120514, 'Benzyl benzoate', 'R'),
	(1205170, 'α-Methyl-1,3-benzodioxole-5-propionaldehyde (MMDHCA)', 'R'),
	(122032, 'Cuminaldehyde', 'R'),
	(122394, 'Diphenylamine', 'P'),
	(122407, 'α-Amyl cinnamic aldehyde', 'R'),
	(122576, 'Benzylidene acetone', 'P'),
	(122781, 'Phenylacetaldehyde', 'R'),
	(123115, 'p-Methoxybenzaldehyde', 'R'),
	(13144882, '1-(2,4,4,5,5-Pentamethyl-1-cyclopenten-1-yl)ethan-1-one', 'R'),
	(13257448, '2-Nonyn-1-al dimethyl acetal', 'R'),
	(1335462, 'Methyl ionone, mixed isomers', 'R-S'),
	(127424, 'Methyl ionone, mixed isomers', 'R-S'),
	(127435, 'Methyl ionone, mixed isomers', 'R-S'),
	(127515, 'Methyl ionone, mixed isomers', 'R-S'),
	(7779308, 'Methyl ionone, mixed isomers', 'R-S'),
	(79890, 'Methyl ionone, mixed isomers', 'R-S'),
	(1335940, 'Methyl ionone, mixed isomers', 'R-S'),
	(1335666, 'Isocyclocitral', 'R'),
	(1423467, 'Isocyclocitral', 'R'),
	(67634075, 'Isocyclocitral', 'R'),
	(13393936, 'Hydroabietyl alcohol, Dihydroabietyl alcohol', 'P'),
	(26266773, 'Hydroabietyl alcohol, Dihydroabietyl alcohol', 'P'),
	(1333897, 'Hydroabietyl alcohol, Dihydroabietyl alcohol', 'R'),
	(13706860, 'Acetyl isovaleryl', 'P'),
	(138863, 'Limonene', 'S'),
	(7705148, 'Limonene', 'S'),
	(5989275, 'Limonene', 'S'),
	(5989548, 'Limonene', 'S'),
	(140294, 'Benzyl cyanide', 'R-P'),
	(140670, 'Estragole', 'R'),
	(1407278, 'Estragole', 'R'),
	(77525189, 'Estragole', 'R'),
	(140885, 'Ethyl acrylate', 'P'),
	(141059, 'Diethyl maleate', 'P'),
	(141106, 'Pseudoionone', 'P-S'),
	(144020224, 'Acetic acid, anhydride with 1,5,10-Trimethyl-1,5,9-cyclododecatriene', 'R'),
	(28371995, 'Acetic acid, anhydride with 1,5,10-Trimethyl-1,5,9-cyclododecatriene', 'R'),
	(145391, 'Musk tibetene', 'P'),
	(150765, 'Hydroquinone monomethyl ether', 'P'),
	(1504741, 'o-Methoxycinnamaldehyde', 'R'),
	(15323350, 'Acetyl hexamethyl indan (AHMI)', 'R'),
	(1604280, '6-Methyl-3,5-heptadien-2-one', 'R'),
	(16251777, '3-Phenylbutanal', 'R'),
	(17369594, '3-Propylidenephthalide', 'R'),
	(17373896, 'α-Hexylidene cyclopentanone', 'R'),
	(17488652, '4-Phenyl-3-buten-2-ol', 'R'),
	(17874349, '4,6-Dimethyl-8-tert-butylcoumarin', 'P'),
	(18127010, 'p-tert-Butyldihydrocinnamaldehyde', 'R'),
	(18318837, 'trans-2-Hexenal dimethyl acetal', 'P'),
	(18485386, '2,4-Dodecadien-1-ol, (2E, 4E)', 'P'),
	(18829555, 'trans-2-Heptenal', 'P'),
	(1885387 , 'Cinnamyl nitrile', 'P'),
	(4360478, 'Cinnamyl nitrile', 'R'),
	(19317114, 'Farnesal', 'R'),
	(19343783, '1,2,3,4-Tetrahydro-4-methylquinoline', 'S'),
	(2111753, 'Perilla aldehyde', 'R'),
	(23696857, 'Rose ketones', 'R'),
	(23726934, 'Rose ketones', 'R'),
	(59739638, 'Rose ketones', 'R'),
	(43052875, 'Rose ketones', 'R'),
	(24720090, 'Rose ketones', 'R'),
	(23726945, 'Rose ketones', 'R'),
	(23726923, 'Rose ketones', 'R'),
	(23726912, 'Rose ketones', 'R'),
	(35044689, 'Rose ketones', 'R'),
	(57378684, 'Rose ketones', 'R'),
	(71048823, 'Rose ketones', 'R'),
	(35087491, 'Rose ketones', 'R'),
	(39872576, 'Rose ketones', 'R'),
	(70266487, 'Rose ketones', 'R'),
	(33673711, 'Rose ketones', 'R'),
	(87064195, 'Rose ketones', 'R'),
	(24048144 , '2,6,10-Trimethylundeca-5,9-dien-1-ol', 'R'),
	(185019196 , '2,6,10-Trimethylundeca-5,9-dien-1-ol', 'R'),
	(58001880 , '2,6,10-Trimethylundeca-5,9-dien-1-ol', 'R'),
	(58001879, '2,6,10-Trimethylundeca-5,9-dien-1-ol', 'R'),
	(1373932230 , '2,6,10-Trimethylundeca-5,9-dien-1-ol', 'R'),
	(1018832079, '2,6,10-Trimethylundeca-5,9-dien-1-ol', 'R'),
	(2442106, '1-Octen-3-yl acetate', 'R'),
	(2445832, '7-Methylcoumarin', 'P'),
	(25564221, 'Amylcyclopentenone', 'P'),
	(2563077, '2-Ethoxy-4-methylphenol', 'P'),
	(25677401, '2-Pentylidene cyclohexanone', 'P'),
	(26651967, '1,2,3,4-Tetrahydro-4-methylquinoline', 'P-S'),
	(72968253, '1,2,3,4-Tetrahydro-4-methylquinoline', 'P-S'),
	(1117415, '1,2,3,4-Tetrahydro-4-methylquinoline', 'P-S');

--rig_ingredientes_esencias

INSERT INTO rig_ingredientes_esencias (id_prov, id, cas, nombre, tipo, des, solubilidad, peligrosidad, vida_alm) VALUES 
	(3, DEFAULT, 5392405, 'Citral', 'NATURAL', 'Citral tiene un fuerte olor a limón (cítrico). El olor a limón de Neral es menos intenso, pero más dulce. Por lo tanto, Citral es un compuesto aromático utilizado en perfumería por su efecto cítrico. Citral también se usa como sabor y para fortificar el aceite de limón. También tiene fuertes cualidades antimicrobianas y efectos feromonales en ácaros e insectos. Citral se usa en la síntesis de vitamina A, licopeno, ionona y metilionona, para enmascarar el olor a humo.', 'Soluble en alcohol, aceite de parafina y agua de 1340 mg/L a 25°C', 'BAJA', 24*30),
	(3, DEFAULT, 106241,'Geraniol', 'NATURAL', 'El geraniol es un monoterpenoide y un alcohol. Es el componente principal del aceite de rosa, el aceite de palmarosa y el aceite de citronela. Es un aceite incoloro, aunque las muestras comerciales pueden aparecer amarillas. El grupo funcional derivado del geraniol (en esencia, geraniol que carece del terminal -OH) se llama geranilo.','Soluble en alcohol, aceite de parafina, kerosene y agua de 25.16 mg/L a 25°C', 'BAJA', 24*30),
	(3, DEFAULT, 79776,'Beta-ionone', 'NATURAL', 'La beta-ionona es un líquido incoloro a amarillo claro con olor a madera de cedro. En una solución alcohólica muy diluida, el olor se asemeja al olor a violetas. La beta-ionona se encuentra en la zanahoria y en muchos aceites esenciales, incluido el aceite de boronia megastigma (boronia marrón) y la ionona comercial. También es un agente saborizante.','Soluble en alcohol y agua de 1340 mg/L a 25°C', 'MEDIA', 24*30),
	(1, DEFAULT, 70788306,'Propanol de madera', 'SINTETICO', 'Es un isómero muy común en la industria del perfume. Se caracteriza por su olor fuerte a madera y almizcle. Su fórmula química es 1-(2,2,6-trimethylcyclohexyl)hexan-3-ol', 'Soluble en alcohol y agua de 1.149 mg/L a 25°C', 'BAJA', 24*30),
	(1, DEFAULT, 98555,'Terpineol alpha', 'NATURAL', 'Terpineol con fórmula química C10H18O, es una forma natural de monoterpeno de alcohol que se ha aislado a partir de una variedad de fuentes tales como el aceite de cajeput, aceite de pino, y aceite petitgrain. Hay cuatro isómeros , alfa -, beta -, gamma -terpineol, y terpinen-4-ol. beta - y gamma -terpineol difieren sólo por la ubicación del doble enlace. Terpineol es por lo general una mezcla de estos isómeros con alfa -terpineol como componente principal.', 'Soluble en alcohol, aceite de parafina, kerosene y agua de 710 mg/L a 25°C' ,'BAJA', 24*30),
	(1, DEFAULT, 88415,'Otcbha', 'NATURAL', 'Compuesto de incoloro o amarillo pálido que tiene un fuerte y duradero olor a manzana. Este compuesto es usado generalmente como solvente o como componente de fragancias', 'Solubilidad en alcohol, aceite de parafina y agua de 7.462 mg/L a 25','MEDIA', 24*30),
	(2, DEFAULT, 93925,'Aceite de styrallyl', 'NATURAL', 'Compuesto de color amarillo pálido con un dulce olor frutal y herbaceo. Este compuesto es usado generalmente para otorgar un olor a gardenia', 'Solubilidad en alcohol, aceite de parafina y agua de 481.1 mg/L a 25','MEDIA', 24*30),
	(2, DEFAULT, 60128,'Alcohol fenetílico', 'NATURAL', 'El alcohol fenetílico, o 2-feniletanol, es el compuesto orgánico que consiste en un grupo de grupo fenetilo (C6H5CH2CH2) unido a OH. Es un líquido incoloro se encuentra presente ampliamente en la naturaleza, se encuentra en una variedad de aceites esenciales. Tiene un agradable olor floral.', 'Soluble en alcohol, aceite de parafina, kerosene y agua de 2.199e+004 mg/L a 25°C','BAJA', 24*30),
	(2, DEFAULT, 103957,'Aldehído de ciclamen', 'SINTETICO', 'El aldehído de ciclamen es una molécula de fragancia que se ha utilizado en jabones, detergentes, lociones y perfumes desde la década de 1920. Adicionalmete es empleado en aditivos para alimentos de forma directa', 'Soluble en alcohol, aceite de parafina y agua de 22.59 mg/L a 25°C','BAJA', 24*30),
	(4, DEFAULT, 125122,'Acetato de bornilo', 'SINTETICO', 'Acetato de Bornilo es una molécula sintética altamente utilizada en la industria del perfume y en la elaboración de fragancias',  'Soluble en alcohol, aceite de parafina, kerosene y agua de 9.721 mg/L a 25°C','BAJA', 24*30),
	(4, DEFAULT, 141128,'Acetato de nerilo', 'SINTETICO', 'Acetato de nerilo es un compuesto químico que se encuentra en los aceites de cítricos. Químicamente, es el acetato de éster de nerol. Se utiliza en sabores y en perfumería para impartir aromas florales y frutales.', 'Soluble en alcohol, aceite de parafina y agua de 18.24 mg/L a 25°C','BAJA', 24*30),
	(4, DEFAULT, 7785333,'(+)-α-Terpineol', 'NATURAL', 'Es un compuesto orgánico de la clase terpeno, uno de los dos isómeros del pineno que está presente en algunos aceites, tales como el aceite de eucalipto y aceite de cáscara de naranja', 'Soluble en alcohol y agua de 0.3194 mg/L a 25°C','BAJA', 24*30),
	(5, DEFAULT, 100061,'Acetanisola', 'SINTETICO', 'El acetanisol es un compuesto químico aromático con un aroma descrito como dulce, afrutado, a nuez y similar a la vainilla. Además, el acetanisol a veces puede oler a mantequilla o caramelo. El acetanisol se encuentra naturalmente en el castoreum, la secreción glandular del castor.', 'Soluble en alcohol y agua de 2474 mg/L a 25°C','BAJA', 24*30),
	(5, DEFAULT, 52474609,'Aldemone', 'SINTETICO', 'Es un compuesto químico de olor marino/ozono muy difuso. Su fórmula es 1-(4-methoxyphenyl)ethanone y usualmente se encuentra como cristales bláncos o amarillos muy pálidos', 'Soluble en alcohol y agua de 1.512 mg/L a 25°C','BAJA', 24*30),
	(5, DEFAULT, 2051787,'Octanoato de allil', 'SINTETICO', 'Es un compuesto químico incoloro y cristalino, de olor a piña/frutal de duración media. También es conocido bajo el nombre de prop-2-enyl butanoate', 'Soluble en alcohol y agua de 1233 mg/L a 25°C','MEDIA', 24*30),
	(6, DEFAULT, 8015734,'Aceite de albahaca dulce', 'NATURAL', 'La albahaca es una hierba aromática original de Irán, India, Pakistán y otras regiones tropicales de Asia. El aceite esencial de albahaca es rico en estragol', 'Soluble en alcohol, aceite de parafina y agua de 332.1 mg/L a 25°C','BAJA', 24*30),
	(6, DEFAULT, 8006824,'Aceite de pimienta negra', 'NATURAL', 'Proviene de un fruto de aproximadamente 5 mm que se puede usar entero o en polvo para la elaboración de fragancias picantes o como aditivo alimenticio', 'Soluble en alcohol','BAJA', 6*30),
	(6, DEFAULT, 8015881,'Aceite de semillas de zanahoria', 'NATURAL', 'El aceite esencial de zanahoria se extrae de las semillas secas de zanahoria mediante la destilación por vapor, la cual preserva perfectamente los nutrientes valiosos. Las semillas de zanahoria producen el aceite esencial pero también pueden utilizarse otras partes de la planta', 'Soluble en alcohol, aceite de parafina y agua de 8.507 mg/L a 25°C','BAJA', 24*30);

--rig_orgigenes_ingredientes_esencias

INSERT INTO rig_origenes_ingredientes_esencias VALUES
	(3, 1, 18),
	(3, 2, 24),
	(3, 3,	18),
	(1, 4, 37),
	(1, 5, 18),
	(1, 6, 24),
	(2, 7, 25),
	(2, 8, 25),
	(2, 9, 25),
	(4, 10, 25),
	(4, 11, 25),
	(4, 12, 25),
	(5, 13, 28),
	(5, 14, 28),
	(5, 15, 28),
	(6, 16, 64),
	(6, 17, 64),
	(6, 18, 64);

--rig_presentaciones_ingredientes

INSERT INTO rig_presentaciones_ingredientes VALUES 
	(3, 1, DEFAULT, 4, 'ml', 3.25), (3, 1, DEFAULT, 15, 'ml', 5.00), (3, 1, DEFAULT, 30, 'ml', 6.25), (3, 1, DEFAULT, 80, 'ml', 14.31), (3, 1, DEFAULT, 250, 'g', 41.00), (3, 1, DEFAULT, 500, 'g', 69.00), (3, 1, DEFAULT, 1, 'kg', 118.00),
	(3, 2, DEFAULT, 4, 'ml', 3.00), (3, 2, DEFAULT, 15, 'ml', 6.00), (3, 2, DEFAULT, 30, 'ml', 6.30), (3, 2, DEFAULT, 80, 'ml', 14.43), (3, 2, DEFAULT, 250, 'g', 28.00),
	(3, 3, DEFAULT, 4, 'ml', 3.00), (3, 3, DEFAULT, 15, 'ml', 6.00), (3, 3, DEFAULT, 30, 'ml', 10.00), (3, 3, DEFAULT, 80, 'ml', 15.00), (3, 3, DEFAULT, 250, 'g', 25.00), (3, 3, DEFAULT, 500, 'g', 35.00),
	(1, 4, DEFAULT, 4, 'ml', 4.50), (1, 4, DEFAULT, 15, 'ml', 10.50), (1, 4, DEFAULT, 30, 'ml', 18.50), (1, 4, DEFAULT, 80, 'ml', 40.50), (1, 4, DEFAULT, 250, 'g', 122.00), (1, 4, DEFAULT, 500, 'g', 232.00),
	(1, 5, DEFAULT, 4, 'ml', 3.00), (1, 5, DEFAULT, 15, 'ml', 6.00), (1, 5, DEFAULT, 30, 'ml', 10.0), (1, 5, DEFAULT, 80, 'ml', 20.00), (1, 5, DEFAULT, 250, 'g', 50.00), (1, 5, DEFAULT, 500, 'g', 75.00), (1, 5, DEFAULT, 1, 'kg', 150.00),
	(1, 6, DEFAULT, 4, 'ml', 3.00), (1, 6, DEFAULT, 15, 'ml', 6.00), (1, 6, DEFAULT, 30, 'ml', 9.00), (1, 6, DEFAULT, 80, 'ml', 15.00), (1, 6, DEFAULT, 250, 'g', 23.00),
	(2, 7, DEFAULT, 4, 'ml', 3.00), (2, 7, DEFAULT, 15, 'ml', 6.00), (2, 7, DEFAULT, 30, 'ml', 9.00), (2, 7, DEFAULT, 80, 'ml', 15.00),
	(2, 8, DEFAULT, 4, 'ml', 3.00), (2, 8, DEFAULT, 15, 'ml', 6.00), (2, 8, DEFAULT, 30, 'ml', 8.00), (2, 8, DEFAULT, 80, 'ml', 11.00), (2, 8, DEFAULT, 250, 'g', 26.50), (2, 8, DEFAULT, 500, 'g', 48.00), (2, 8, DEFAULT, 1, 'kg', 62.00),
	(2, 9, DEFAULT, 4, 'ml', 3.00), (2, 9, DEFAULT, 15, 'ml', 6.00), (2, 9, DEFAULT, 30, 'ml', 9.00), (2, 9, DEFAULT, 80, 'ml', 12.00),
	(4, 10, DEFAULT, 4, 'ml', 3.00), (4, 10, DEFAULT, 15, 'ml', 6.00), (4, 10, DEFAULT, 30, 'ml', 9.00), (4, 10, DEFAULT, 80, 'ml', 15.00),
	(4, 11, DEFAULT, 4, 'ml', 3.00), (4, 11, DEFAULT, 15, 'ml', 6.00), (4, 11, DEFAULT, 30, 'ml', 9.00), (4, 11, DEFAULT, 80, 'ml', 15.00),
	(4, 12, DEFAULT, 4, 'ml', 3.00), (4, 12, DEFAULT, 15, 'ml', 6.00), (4, 12, DEFAULT, 30, 'ml', 9.00), (4, 12, DEFAULT, 80, 'ml', 15.00),
	(5, 13, DEFAULT, 8, 'g', 3.00), (5, 13, DEFAULT, 30, 'g', 9.00), (5, 13, DEFAULT, 80, 'g', 15.00),
	(5, 14, DEFAULT, 4, 'ml', 5.00), (5, 14, DEFAULT, 15, 'ml', 8.00), (5, 14, DEFAULT, 30, 'ml', 10.00), (5, 14, DEFAULT, 80, 'ml', 15.00),
	(5, 15, DEFAULT, 4, 'ml', 5.00), (5, 15, DEFAULT, 15, 'ml', 8.00), (5, 15, DEFAULT, 30, 'ml', 10.00), (5, 15, DEFAULT, 80, 'ml', 15.00),
	(6, 16, DEFAULT, 4, 'ml', 3.00),
	(6, 17, DEFAULT, 4, 'ml', 3.00), (6, 17, DEFAULT, 15, 'ml', 7.50), (6, 17, DEFAULT, 30, 'ml', 12.00), (6, 17, DEFAULT, 80, 'ml', 28.00),
	(6, 18, DEFAULT, 4, 'ml', 4.50), (6, 18, DEFAULT, 15, 'ml', 9.00), (6, 18, DEFAULT, 30, 'ml', 15.00);

--rig_perfumes

INSERT INTO rig_perfumes VALUES 
	(DEFAULT, 1,'Acqua di Giò', 'M', 'FASES', 'ADULTO', 1996, 'Acqua di Giò no es solo agua. Es una fragancia de la vida, una oda voluptuosa a la naturaleza y su perfección, a un hombre que ama la libertad y seguro de sí mismo, que se convierte en uno con el mar.'),
	(DEFAULT, 1,'Boss Bottled', 'M', 'FASES', 'ADULTO', 2008, 'Boss Bottled Intense reveals the Man of Today and his strength of character. The fragrance is laden with more woods, spices and a powerful concentration of precious oils. Bright apple is tempered by a calmer and more composed green orange blossom. The effect is a fragrance that is less sweet, yet more luxurious, and emphatically, unapologetically masculine.'),
	(DEFAULT, 1,'Romance', 'F', 'FASES', 'ADULTO', 1999, 'Es un aroma de amor romántico y momentos íntimos llenos de alegría y felicidad, con un aura infinitamente positiva. Al comienzo de la composición, las notas de rosa se mezclan con aceites cítricos y reciben una melodía inusual y única.'),
	(DEFAULT, 2,'Joseph Abboud de Joseph Abboud', 'M', 'FASES', 'ADULTO', 2016, 'Un aroma masculino refrescante, el índigo descolorido de Joseph Abboud se basa en aromas amaderados aromáticos con notas medias marinas refrescantes. Las notas altas de limón picante completan este fino aroma, ideal para el uso diario y en ocasiones especiales.'),
	(DEFAULT, 2,'Pistachio Brûlée de Urban Outfitters', 'F', 'MONO', 'ADULTO', 2014, 'Pistachio Brulee Eau De Parfum para mujer. Pistachio Brulee: mousse de vainilla con leche, pistacho y vainilla. Las fragancias sin crueldad le permiten optar por algo fresco, femenino o dulce, todo dependiendo de su estado de ánimo. días de verano con elegantes flores frescas o la fresca brisa del mar, estos son elementos imprescindibles sin los que no podemos vivir'),
	(DEFAULT, 2,'Paris, She Met Him In Secret de Fictions Perfume', 'F', 'MONO', 'ADULTO', 2019, 'Paris: She Met Him in Secret is an exploration of unauthorized love. This Fictions perfume is classified as a floral chypre fragrance, characterized by a contrast between fresh floral notes and a deep, sensual dry down. '),
	(DEFAULT, 3,'Exotic Musk', 'F', 'MONO', 'ADULTO', 2019, 'Mostrando el preciado ingrediente aromático que evoca vívidamente un destino exótico, cada fragancia de Bentley Beyond - The Collection traduce un viaje en aroma. Compuesto por tres nuevos perfumistas jóvenes, el primer trío de la colección nos lleva a tres países diferentes, cada uno asociado con una nota olfativa y un tema de color inspirado en'),
	(DEFAULT, 3,'Let you Love Me de Blumarine', 'F', 'MONO', 'ADULTO', 2020, 'La nueva fragancia femenina Let You Love Me huele a audacia y sensualidad, determinación y feminidad, y la fuerza invencible de una mujer apasionada que besa al hombre de sus sueños y le dice: "Te dejo amarme". La fragancia pertenece al Familia olfativa de aromáticos orientales.'),
	(DEFAULT, 3,'Gris Charnel de BDK Parfums', 'U', 'FASES', 'ADULTO', 2019, 'Gris Charnel es un aroma de piel, creado con la idea de la sensualidad, la intimidad. Evoca mañanas parisinas grises, donde uno se despierta con un deseo de capullo, todavía consolado por el calor del otro. Es una fragancia que actúa como una segunda piel, sacando su dulzura de un cremoso acuerdo de sándalo indio.');

--rig_perfumistas

INSERT INTO rig_perfumistas VALUES 
	(DEFAULT, 'Giorgio Armani', 'M', '11-07-1934', 29),
	(DEFAULT, 'Annick Menardo', 'F', '13-09-1985', 29),
	(DEFAULT, 'Ralph Lauren', 'M', '04-10-1939', 55),
	(DEFAULT, 'Joseph Abboud', 'M', '05-5-1950', 55),
	(DEFAULT, 'Olivier Polge', 'M', '07-01-1978', 29),
	(DEFAULT, 'Alexandra Monet', 'F', '08-06-1970', 29),
	(DEFAULT, 'Mathilde Bijaoui', 'F', '03-08-1975', 64),
	(DEFAULT, 'Veronique Nyberg', 'F', '15-07-1964', 18);

--rig_perfumes_perfumistas

INSERT INTO rig_perfumes_perfumistas VALUES 
	(1, 1),	
	(2,2), 
	(3,3), 
	(4,4), 
	(5,5), 
	(6,6), 
	(7,7), 
	(8,8), 
	(9,7);

--rig_intensidades

INSERT INTO rig_intensidades VALUES 
	(1, DEFAULT, 'EdT'),
	(2, DEFAULT, 'EdP'),
	(3, DEFAULT, 'EdT'),
	(4, DEFAULT, 'EdP'),
	(5, DEFAULT, 'EdP'),
	(6, DEFAULT, 'EdP'),
	(7, DEFAULT, 'EdT'),
	(8, DEFAULT, 'EdT'),
	(9, DEFAULT, 'EdP');

--rig_presentaciones_perfumes

INSERT INTO rig_presentaciones_perfumes VALUES 
	(1, 1, DEFAULT, 8.1, 'ml'),	(1, 1, DEFAULT, 30, 'ml'),	(1, 1, DEFAULT, 51, 'ml'),	(1, 1, DEFAULT, 100, 'ml'),	(1, 1, DEFAULT, 200, 'ml'),
	(2, 2, DEFAULT, 8.1, 'ml'),	(2, 2, DEFAULT, 30, 'ml'),	(2, 2, DEFAULT, 50, 'ml'),	(2, 2, DEFAULT, 100, 'ml'),	(2, 2, DEFAULT, 200, 'ml'),
	(3, 3, DEFAULT, 10, 'ml'),	(3, 3, DEFAULT, 30, 'ml'),	(3, 3, DEFAULT, 50, 'ml'),	(3, 3, DEFAULT, 90, 'ml'),	(3, 3, DEFAULT, 150, 'ml'),
	(4, 4, DEFAULT, 15, 'ml'),	(4, 4, DEFAULT, 35, 'ml'),	(4, 4, DEFAULT, 60, 'ml'),	(4, 4, DEFAULT, 120, 'ml'),	(4, 4, DEFAULT, 180, 'ml'),
	(5, 5, DEFAULT, 12, 'ml'),	(5, 5, DEFAULT, 24, 'ml'),	(5, 5, DEFAULT, 50, 'ml'),
	(6, 6, DEFAULT, 12, 'ml'),	(6, 6, DEFAULT, 50, 'ml'),	(6, 6, DEFAULT, 80, 'ml'),	(6, 6, DEFAULT, 130, 'ml'),
	(7, 7, DEFAULT, 15, 'ml'),	(7, 7, DEFAULT, 35, 'ml'),	(7, 7, DEFAULT, 60, 'ml'),	(7, 7, DEFAULT, 120, 'ml'),	(7, 7, DEFAULT, 180, 'ml'),
	(8, 8, DEFAULT, 15, 'ml'),	(8, 8, DEFAULT, 35, 'ml'),	(8, 8, DEFAULT, 70, 'ml'),	(8, 8, DEFAULT, 130, 'ml'),	(8, 8, DEFAULT, 150, 'ml'),
	(9, 9, DEFAULT, 25, 'ml'),	(9, 9, DEFAULT, 40, 'ml'),	(9, 9, DEFAULT, 85, 'ml'),	(9, 9, DEFAULT, 115, 'ml');


--CREATE TABLE rig_palabras_claves (
--	id SMALLINT PRIMARY KEY,
--	palabra VARCHAR(20) NOT NULL UNIQUE
--);

INSERT INTO rig_palabras_claves VALUES 
	-- Verde
	(DEFAULT, 'verde'), --1
	(DEFAULT, 'fresca'),--2
	(DEFAULT, 'optimista'),--3
	(DEFAULT, 'natural'), --4
	(DEFAULT, 'libre'), --5
	(DEFAULT, 'deshinibida'), --6
	-- Cítrico
	(DEFAULT, 'cítrico'),--7
	(DEFAULT, 'juvenil'),--8
	(DEFAULT, 'efímero'), --9
	(DEFAULT, 'volatil'), --10
	(DEFAULT, 'estimulante'),--11
	(DEFAULT, 'olor fuerte'),--12
	(DEFAULT, 'placer'),--13
	(DEFAULT, 'verano'),--14
	(DEFAULT, 'refrescante'),--15
	-- Flores
	(DEFAULT, 'floral'),--16
	(DEFAULT, 'fresco'),--17
	(DEFAULT, 'tranquilidad'),--18
	(DEFAULT, 'relajante'),--19
	(DEFAULT, 'alegre'),--20
	(DEFAULT, 'vivo'),--21
	-- Frutas
	(DEFAULT, 'frutal'),--22
	(DEFAULT, 'tropical'),--23
	(DEFAULT, 'felicidad'), --24
	(DEFAULT, 'ganas de vivir'),--25
	--Aromáticos
	(DEFAULT, 'aromático'), --26
	(DEFAULT, 'vital'), --27
	(DEFAULT, 'asertivo'), --28
	(DEFAULT, 'tenaz'), --29
	(DEFAULT, 'lucidez'), --30
	(DEFAULT, 'vigor'), --31
	(DEFAULT, 'familiaridad'), --32
	--Helechos
	(DEFAULT, 'profundidad'), --33
	(DEFAULT, 'energía'), --34
	(DEFAULT, 'confianza'),--35
	(DEFAULT, 'atemporal'), --36
	--Chipre
	(DEFAULT, 'cálido'),--37
	(DEFAULT, 'seco'),--38
	--Maderas
	(DEFAULT, 'amaderado'),--39
	--Orientales
	(DEFAULT, 'almizclado'), --40
	(DEFAULT, 'sensual'), --41
	(DEFAULT, 'intensos'), --42
	(DEFAULT, 'oriental'), --43
	(DEFAULT, 'empolvados'), --44
	--Otros
	(DEFAULT, 'otros'); --45

INSERT INTO rig_familias_olfativas VALUES 
	(DEFAULT, 'Verde'),
	(DEFAULT, 'Citrico'),
	(DEFAULT, 'Flores'),
	(DEFAULT, 'Frutas'),
	(DEFAULT, 'Aromáticos'),
	(DEFAULT, 'Helechos'),
	(DEFAULT, 'Chipre'),
	(DEFAULT, 'Maderas'),
	(DEFAULT, 'Orientales'),
	(DEFAULT, 'Otros');

--CREATE TABLE rig_palabras_familias (
--	id_pal SMALLINT,
--	id_fao SMALLINT,
--	PRIMARY KEY (id_pal, id_fao)
--);

INSERT INTO rig_palabras_familias VALUES 
	-- Verde
	(1,1), (2,1), (3,1), (4,1), (5,1), (6,1),
	-- Cítrico
	(7,2), (8,2), (9,2), (10,2), (11,2), (12,2), (13,2), (14,2), (15,2),
	-- Flores
	(16,3), (17,3), (18,3), (19,3), (20,3), (21,3),(15,3), (30,3),
	-- Frutas
	(22,4), (23,4), (24,4), (25,4), (15,4), (14,4),
	-- Aromáticos
	(26,5), (27,5), (28,5), (29,5), (30,5), (31,5), (32,5),
	-- Helechos
	(33,6), (34,6), (35,6), (36,6),
	-- Chipre
	(37,7), (38,7),
	-- Maderas
	(39,8), (37,8), (38,8),
	-- Orientales
	(40,9), (41,9), (42,9), (43,9), (44,9), (37,9), (38,9),
	-- Otros
	(45,10);

	