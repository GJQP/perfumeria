DROP SEQuENCE IF EXISTS rig_pedidos_id;
DROP SEQUENCE IF EXISTS rig_contrato_id;
DROP SEQUENCE IF EXISTS rig_esencias_perfumes_id;
DROP SEQUENCE IF EXISTS rig_palabras_claves_id;
DROP SEQUENCE IF EXISTS rig_perfumistas_id;
DROP SEQUENCE IF EXISTS rig_perfumes_id;
DROP SEQUENCE IF EXISTS rig_prohibidas_id;
DROP SEQUENCE IF EXISTS rig_asociaciones_nacionales_id;
DROP SEQUENCE IF EXISTS rig_variables_id;
DROP SEQUENCE IF EXISTS rig_condiciones_de_pago_id;
DROP SEQUENCE IF EXISTS rig_proveedores_id;
DROP SEQUENCE IF EXISTS rig_productores_id;
DROP SEQUENCE IF EXISTS rig_paises_id;

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
DROP TABLE IF EXISTS rig_perfumes_familias;
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

CREATE TABLE rig_paises (
	id BIGINT PRIMARY KEY,
	nombre VARCHAR(20) not null unique
);

CREATE SEQUENCE IF NOT EXISTS rig_paises_id OWNED BY rig_paises.id;

CREATE TABLE rig_asociaciones_nacionales (
	id BIGINT PRIMARY KEY ,
	nombre VARCHAR (15) NOT NULL UNIQUE,
	region CHAR (15) NOT NULL,
	id_ubic BIGINT NOT NULL,
	CONSTRAINT rig_asociacion_nacional_ck CHECK (
	region IN ('ASIA', 'EUROPA', 'AMERICA DEL NORTE', 'AFRICA', 'LATINOAMERICA')),
	CONSTRAINT rig_asociacion_nacional_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises
);

CREATE SEQUENCE rig_asociaciones_nacionales_id OWNED BY rig_asociaciones_nacionales.id;

CREATE TABLE rig_productores (
	id BIGINT PRIMARY KEY ,
	nombre VARCHAR(20) NOT NULL UNIQUE,
	pag VARCHAR(50) NOT NULL UNIQUE,
	info_cto VARCHAR(50) NOT NULL,
	email VARCHAR(30) NOT NULL UNIQUE,
	telf VARCHAR(20) NOT NULL UNIQUE,
	id_aso_nac BIGINT,
	CONSTRAINT rig_productores_id_asoc_nac_fk FOREIGN KEY (id_aso_nac) REFERENCES rig_asociaciones_nacionales
);
-- Reglas explicitas
-- Debe existir almenos una intersecciones con paises

CREATE SEQUENCE rig_productores_id OWNED BY rig_productores.id;

CREATE TABLE rig_proveedores (
	id BIGINT PRIMARY KEY ,
	nombre VARCHAR(20) NOT NULL UNIQUE,
	pag VARCHAR(50) NOT NULL UNIQUE,
	info_cto VARCHAR(50) NOT NULL,
	email VARCHAR(30) NOT NULL UNIQUE,
	telf VARCHAR(20) NOT NULL UNIQUE,
	id_ubic BIGINT NOT NULL,
	id_aso_nac BIGINT,
	CONSTRAINT rig_proveedores_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises,
	CONSTRAINT rig_proveedores_id_asoc_nac_fk FOREIGN KEY (id_aso_nac) REFERENCES rig_asociaciones_nacionales
);

CREATE SEQUENCE rig_proveedores_id OWNED BY rig_proveedores.id;

CREATE TABLE rig_membresias (
	fcha_reg DATE PRIMARY KEY,
	tipo_m CHAR (15) NOT NULL,
	fcha_fin DATE,
	id_prod BIGINT,
	id_prov BIGINT,
	CONSTRAINT rig_proveedores_ck CHECK (
		(tipo_m IN ('PRINCIPAL, SECUNDARIO', 'REGIONAL'))AND (fcha_fin > fcha_reg)AND ((id_prod IS NULL) != (id_prov IS NULL)))
);

CREATE TABLE rig_sucursales (
	id_ubic BIGINT,
	id_prod BIGINT,
	PRIMARY KEY (id_ubic, id_prod),
	CONSTRAINT rig_sucursales_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises,
 	CONSTRAINT rig_sucursales_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores
);

CREATE TABLE rig_condiciones_de_pago (
	id_prov BIGINT,
	id BIGINT,
	tipo CHAR (15) NOT NULL,
	coutas SMALLINT,
	porcen_cuo NUMERIC (5,2),
	cant_meses SMALLINT,
	PRIMARY KEY (id_prov, id),
	CONSTRAINT rig_condiciones_de_pago_ck CHECK (
	(tipo IN ('CONTADO', 'PARCIAL')) AND (coutas > 0) AND (porcen_cuo > 0) AND (cant_meses > 0)),
	CONSTRAINT rig_condiciones_de_pago_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores
);

CREATE SEQUENCE rig_condiciones_de_pago_id OWNED BY rig_condiciones_de_pago.id;

CREATE TABLE rig_condiciones_de_envio (
	id_prov BIGINT,
	id_ubic BIGINT,
	nombre VARCHAR (20) NOT NULL,
	porce_serv NUMERIC (5,2) NOT NULL,
	medio CHAR (15) NOT NULL,
	PRIMARY KEY(id_prov, id_ubic),
	CONSTRAINT rig_condiciones_de_envio_ck CHECK (medio IN ('AEREO', 'TERRESTRE', 'MARITIMO')),
	CONSTRAINT rig_condiciones_de_envio_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores,
	CONSTRAINT rig_condiciones_de_envio_id_ubic_fk FOREIGN KEY (id_ubic) REFERENCES rig_paises
);

CREATE TABLE rig_escalas (
	id_prod BIGINT,
	fcha_reg DATE,
	rgo_ini INTEGER NOT NULL,
	rgo_fin INTEGER NOT NULL,
	fcha_fin DATE,
	PRIMARY KEY (id_prod, fcha_reg),
	CHECK(rgo_ini < rgo_fin)
);

ALTER TABLE rig_escalas ADD CONSTRAINT rig_escalas_id_prod FOREIGN KEY (id_prod) REFERENCES rig_productores;

CREATE TABLE rig_resultados (
	id_prod BIGINT,
	id_prov BIGINT,
	fcha_reg DATE,
	tipo_eval CHAR (15) NOT NULL,
	res NUMERIC (5,2) NOT NULL,
	PRIMARY KEY (id_prod, id_prov, fcha_reg),
	CONSTRAINT rig_resultados_ck CHECK (tipo_eval IN ('INICIAL', 'RENOVACION')),
  CONSTRAINT rig_resultados_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores,
  CONSTRAINT rig_resultados_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores
);

CREATE TABLE rig_variables (
	id BIGINT PRIMARY KEY ,
	nombre VARCHAR (15) NOT NULL UNIQUE,
	des VARCHAR (50) NOT NULL
);

CREATE SEQUENCE rig_variables_id OWNED BY rig_variables.id;

CREATE TABLE rig_evaluaciones_criterios (
	id_prod BIGINT,
	id_var BIGINT,
	fcha_reg DATE,
	tipo_eval CHAR (15) NOT NULL,
	peso NUMERIC (5,2) NOT NULL,
	fcha_fin DATE,
	PRIMARY KEY (id_prod, id_var, fcha_reg),
	CONSTRAINT rig_evaluaciones_criterios_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores,
  CONSTRAINT rig_evaluaciones_criterios_id_var_fk FOREIGN KEY (id_var) REFERENCES rig_variables,
  CONSTRAINT rig_evaluaciones_criterior_ck CHECK (tipo_eval IN ('INICIAL', 'RENOVACION'))
);

CREATE TABLE rig_ingredientes_esencias (
	id_prov BIGINT,
	id BIGINT ,
	cas VARCHAR (30) NOT NULL,
	nombre VARCHAR (15) NOT NULL,
	tipo CHAR (15) NOT NULL,
	des VARCHAR (100) NOT NULL,
	id_ubic BIGINT NOT NULL,
	solubilidad VARCHAR (50),
	peligrosidad CHAR (15),
	vida_alm SMALLINT,
	ctrl CHAR (15),
	PRIMARY KEY (id_prov, id),
	CONSTRAINT rig_ingrediente_esencia_ck CHECK (
	(tipo IN ('NATURAL', 'ARTIFICIAL'))	AND (peligrosidad IN ('ALTA', 'MEDIA', 'BAJA', 'NINGUNA')) AND (ctrl IN ('SI', 'NO')) AND (vida_alm > 0)),
	CONSTRAINT rig_ingrediente_esencia_id_prod_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores
);

CREATE TABLE rig_prohibidas (
	id BIGINT PRIMARY KEY,
	cod_inter VARCHAR (30) NOT NULL UNIQUE,
	nombre VARCHAR (15) NOT NULL UNIQUE
);

CREATE SEQUENCE rig_prohibidas_id OWNED BY rig_prohibidas.id;

CREATE TABLE rig_presentaciones_ingredientes (
	id_prov BIGINT,
	id_ing BIGINT,
	cod_present BIGINT ,
	nombre VARCHAR (15) NOT NULL,
	cant_u INTEGER NOT NULL,
	vol_u NUMERIC (10,2) NOT NULL,
	precio NUMERIC (10,2) NOT NULL,
	des VARCHAR (50) NOT NULL,
	PRIMARY KEY (id_prov, id_ing, cod_present),
	CONSTRAINT rig_presentaciones_ingredientes_ing_fk FOREIGN KEY (id_prov, id_ing) REFERENCES rig_ingredientes_esencias (id_prov, id)
);

CREATE TABLE rig_otros_ingredientes (
	id_prov BIGINT,
	id BIGINT ,
	cod_inter VARCHAR (30) NOT NULL,
	nombre VARCHAR (20) NOT NULL,
	des VARCHAR (50) NOT NULL,
	PRIMARY KEY (id_prov, id),
	CONSTRAINT rig_otros_ingredientes_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores
);

CREATE TABLE rig_presentaciones_otros_ingredientes (
	id_prov BIGINT,
	id_otro_ing BIGINT,
	cod_present BIGINT,
	precio NUMERIC (10,2) NOT NULL,
	volumen NUMERIC (10, 2),
	otra_pre CHAR (15),
	des VARCHAR (50),
	PRIMARY KEY (id_prov, id_otro_ing, cod_present),
	CONSTRAINT rig_presentaciones_ingredientes_ck CHECK (otra_pre IN ('RESTRINGIDO', 'PROHIBIDO')),
	CONSTRAINT rig_presentaciones_otros_ingredientes_fk FOREIGN KEY (id_prov, id_otro_ing) REFERENCES rig_otros_ingredientes (id_prov, id)
);

CREATE TABLE rig_ingredientes_extras (
	id_prov_ing BIGINT,
	id_ing BIGINT,
	id_prov_otr BIGINT,
	id_otro_ing BIGINT,
	PRIMARY KEY (id_prov_ing, id_ing, id_prov_otr, id_otro_ing),
	CONSTRAINT rig_ingredientes_extras_ing_ese_fk FOREIGN KEY (id_prov_ing, id_ing) REFERENCES rig_ingredientes_esencias (id_prov, id),
	CONSTRAINT rig_ingredientes_extras_otr_ing_gk FOREIGN KEY (id_prov_otr, id_otro_ing) REFERENCES rig_otros_ingredientes (id_prov, id)
);

CREATE TABLE rig_perfumes (
	id BIGINT PRIMARY KEY,
	nombre VARCHAR (30) NOT NULL,
	genero CHAR NOT NULL,
	tipo CHAR (5) NOT NULL,
	edad INTEGER ,--Revisar,
	fcha_crea DATE,
	des TEXT,
	CONSTRAINT rig_perfumes_ck CHECK ((genero IN ('F', 'M')) AND (tipo IN ('MONO', 'FASES')))
);

CREATE SEQUENCE rig_perfumes_id OWNED BY rig_perfumes.id;

CREATE TABLE rig_perfumistas (
	id BIGINT PRIMARY KEY,
	nombre VARCHAR (50) NOT NULL UNIQUE,
	genero CHAR NOT NULL,
	fcha_nac DATE,
	CONSTRAINT rig_perfumistas_ck CHECK (genero IN ('F', 'M'))
);

CREATE SEQUENCE rig_perfumistas_id OWNED BY rig_perfumistas.id;

CREATE TABLE rig_perfumes_perfumistas (
	id_perf BIGINT,
	id_prefta BIGINT,
	PRIMARY KEY (id_perf, id_prefta),
	CONSTRAINT rig_perfumes_perfumistas_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	CONSTRAINT rig_perfumes_perfumistas_id_prefta_fk FOREIGN KEY (id_prefta) REFERENCES rig_perfumistas
);

CREATE TABLE rig_intensidades (
	id_perf BIGINT,
	id BIGINT,
	tipo CHAR (3) NOT NULL,
	porcen NUMERIC (5,2),
	des VARCHAR (50),
	PRIMARY KEY (id_perf, id),
	CONSTRAINT rig_intensidad_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	CONSTRAINT rig_intensidades_ck CHECK (tipo IN ('P', 'EdP', 'EdT', 'EdC', 'EdS'))
);

CREATE TABLE rig_presentaciones_perfumes (
	id_perf BIGINT,
	id_int BIGINT,
	id BIGINT,
	vol NUMERIC(10, 2),
	PRIMARY KEY (id_perf, id_int, id),
	CONSTRAINT rig_presentaciones_perfumes_id FOREIGN KEY (id_perf, id_int) REFERENCES rig_intensidades (id_perf, id)
);

CREATE TABLE rig_palabras_claves (
	id BIGINT PRIMARY KEY,
	palabra VARCHAR(20) NOT NULL UNIQUE
);

CREATE SEQUENCE rig_palabras_claves_id OWNED BY rig_palabras_claves.id;

CREATE TABLE rig_familias_olfativas (
	id BIGINT PRIMARY KEY,
	nombre VARCHAR (20) UNIQUE
);

CREATE SEQUENCE rig_familias_olfativas_id OWNED BY rig_familias_olfativas.id;

CREATE TABLE rig_perfumes_familias (
	id_pal BIGINT,
	id_fao BIGINT,
	PRIMARY KEY (id_pal, id_fao),
	CONSTRAINT rig_perfumes_familias_id_pal_fk FOREIGN KEY (id_pal) REFERENCES rig_palabras_claves,
	CONSTRAINT rig_perfumes_familias_id_fao_fk FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas
);

CREATE TABLE rig_esencias_perfumes (
	id BIGINT PRIMARY KEY,
	cas VARCHAR (30) NOT NULL UNIQUE,
	nombre VARCHAR(20) NOT NULL UNIQUE,
	tipo CHAR(10)
	CONSTRAINT rig_esencias_perfumes_ck CHECK (tipo IN ('NATURAL', 'ARTIFICIAL'))
);

CREATE SEQUENCE rig_esencias_perfumes_id OWNED BY rig_esencias_perfumes.id;

CREATE TABLE rig_notas (
	id_perf BIGINT,
	id_esenp BIGINT,
	tipo CHAR(10),
	PRIMARY KEY (id_perf, id_esenp),
	CONSTRAINT rig_notas_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	CONSTRAINT rig_notas_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes,
	CONSTRAINT rig_notas_ck CHECK (tipo IN ('NOTA', 'SALIDA', 'FONDO'))
);

CREATE TABLE rig_monoliticos (
	id_perf BIGINT,
	id_esenp BIGINT,
	PRIMARY KEY (id_perf, id_esenp),
	CONSTRAINT rig_monoliticos_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes,
	CONSTRAINT rig_monoliticos_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes
);

CREATE TABLE rig_esencias (
	id_fao BIGINT,
	id_esenp BIGINT,
	PRIMARY KEY (id_fao,  id_esenp),
	CONSTRAINT rig_esencias_id_fao FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas,
	CONSTRAINT rig_esencias_id_esenp FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes
);

CREATE TABLE rig_componentes_funcionales (
	id_prov BIGINT,
	id_otro_ing BIGINT,
	id_perf BIGINT,
	PRIMARY KEY (id_prov, id_otro_ing, id_perf),
	CONSTRAINT rig_componentes_funcionales_otro_ing_fk FOREIGN KEY (id_prov, id_otro_ing) REFERENCES rig_otros_ingredientes (id_prov, id),
	CONSTRAINT rig_componentes_funcionales_id_perf_fk FOREIGN KEY (id_perf) REFERENCES rig_perfumes
);

CREATE TABLE rig_origenes (
	id_fao BIGINT,
	id_esenp BIGINT,
	PRIMARY KEY (id_fao, id_esenp),
	CONSTRAINT rig_origenes_id_fao_fk FOREIGN KEY (id_fao) REFERENCES rig_familias_olfativas,
	CONSTRAINT rig_origenes_funcionales_id_esenp_fk FOREIGN KEY (id_esenp) REFERENCES rig_esencias_perfumes
);

CREATE TABLE rig_contrato (
	id BIGINT PRIMARY KEY,
	fcha_reg DATE NOT NULL,
	exc CHAR (2) NOT NULL,
	cancelante VARCHAR (20),
	fcha_fin DATE,
	mot_fin VARCHAR (50),
	id_prod BIGINT,
	id_prov BIGINT,
	CONSTRAINT rig_contrato_ck CHECK (exc IN ('SI', 'NO') AND ((id_prod IS NULL) != (id_prov IS NULL))),
	CONSTRAINT rig_contrato_id_prod_fk FOREIGN KEY (id_prod) REFERENCES rig_productores,
	CONSTRAINT rig_contrato_id_prov_fk FOREIGN KEY (id_prov) REFERENCES rig_proveedores
);

CREATE SEQUENCE rig_contrato_id OWNED BY rig_contrato.id;

CREATE TABLE rig_renovacion (
	id_ctra BIGINT,
	id BIGINT,
	fcha_reg DATE,
	PRIMARY KEY (id_ctra, id),
	CONSTRAINT rig_renovacion_id_ctra FOREIGN KEY (id_ctra) REFERENCES rig_contrato
);

CREATE TABLE rig_condiciones_contratos (
	id_ctra BIGINT,
	id BIGINT,
	id_prov_ce BIGINT,
	id_ubic BIGINT,
	id_prov_cp BIGINT,
	id_condpgo BIGINT,
	PRIMARY KEY (id_ctra, id),
	CONSTRAINT rig_condiciones_contratos_id_ctra_fk FOREIGN KEY (id_ctra) REFERENCES rig_contrato,
	CONSTRAINT rig_condiciones_contratos_cond_env_fk FOREIGN KEY (id_prov_ce, id_ubic) REFERENCES rig_condiciones_de_envio (id_prov, id_ubic),
	CONSTRAINT rig_condiciones_contratos_cond_pgo_fk FOREIGN KEY (id_prov_cp, id_condpgo) REFERENCES rig_condiciones_de_pago (id_prov, id)
);

CREATE TABLE rig_productos_contratados (
	id_ctra BIGINT,
	id BIGINT,
	id_prov_ing BIGINT,
	id_ing BIGINT,
	id_pre_ing BIGINT,
	id_prov_otr BIGINT,
	id_otr_ing BIGINT,
	id_pre_otr BIGINT,
	PRIMARY KEY (id_ctra, id), --AK
	CONSTRAINT rig_productos_contratados_id_ctra_fk FOREIGN KEY (id_ctra) REFERENCES rig_contrato,
	CONSTRAINT rig_productos_contratados_ing_fk FOREIGN KEY (id_prov_ing, id_ing, id_pre_ing) REFERENCES rig_presentaciones_ingredientes (id_prov, id_ing, cod_present),
	CONSTRAINT rig_productos_contratados_otr_ing_fk FOREIGN KEY (id_prov_otr, id_otr_ing, id_pre_otr) REFERENCES rig_presentaciones_otros_ingredientes (id_prov, id_otro_ing, cod_present)
);

CREATE TABLE rig_pedidos (
	id BIGINT PRIMARY KEY,
	fcha_reg DATE NOT NULL,
	estatus CHAR (10) NOT NULL DEFAULT 'NO ENVIADO',
	factura SERIAL UNIQUE,
	total NUMERIC(20,2),
	id_ctra_conp BIGINT,
	id_conp BIGINT,
	id_ctra_cone BIGINT,
	id_conev BIGINT,
	CONSTRAINT rig_pedido_ck CHECK (estatus IN ('ENVIADO', 'NO ENVIADO')),
	CONSTRAINT rig_pedido_conev_fk FOREIGN KEY (id_ctra_cone, id_conev) REFERENCES rig_condiciones_contratos (id_ctra, id),
	CONSTRAINT rig_pedido_conp_fk FOREIGN KEY (id_ctra_conp, id_conp) REFERENCES rig_condiciones_contratos (id_ctra, id)
);

CREATE SEQUENCE rig_pedidos_id OWNED BY rig_pedidos.id;

CREATE TABLE rig_detalles_pedidos (
	id_ped BIGINT,
	renglon BIGINT,
	cantidad INTEGER NOT NULL,
	id_prov_ing BIGINT,
	id_ing BIGINT,
	id_pre_ing BIGINT,
	id_prov_otr BIGINT,
	id_otro_ing BIGINT,
	id_pre_otr BIGINT,
	PRIMARY KEY (id_ped, renglon),
	CONSTRAINT rig_detalles_pedidos_ck CHECK (cantidad > 0), --AK
	CONSTRAINT rig_detalles_pedidos_ing_fk FOREIGN KEY (id_prov_ing, id_ing, id_pre_ing) REFERENCES rig_presentaciones_ingredientes (id_prov, id_ing, cod_present),
	CONSTRAINT rig_detalles_pedidos_otr_fk FOREIGN KEY (id_prov_otr, id_otro_ing, id_pre_otr) REFERENCES rig_presentaciones_otros_ingredientes (id_prov, id_otro_ing, cod_present)
);

CREATE TABle rig_pagos (
	id_ped BIGINT,
	id_ord BIGINT,
	fcha_reg DATE NOT NULL,
	total NUMERIC (20,2) NOT NULL,
	PRIMARY KEY (id_ped, id_ord),
	CONSTRAINT rig_pagos_ck CHECK (total > 0),
	CONSTRAINT rig_pagos_id_ped FOREIGN KEY (id_ped) REFERENCES rig_pedidos
);
