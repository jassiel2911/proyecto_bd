-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE papeleria_probd;
-- ddl-end --

DROP TABLE public."ADQUIEREN";
DROP TABLE public."TELEFONOS";
DROP TABLE public."EMAIL";
DROP TABLE public."CLIENTES";
DROP TABLE public."COMPRA";
DROP TABLE public."INVENTARIO";
DROP TABLE public."PROVEEDORES";
DROP SEQUENCE SEC_AD;

CREATE SEQUENCE SEC_AD
AS INTEGER
MINVALUE 0
MAXVALUE 100
INCREMENT BY 1
START WITH 1;

-- object: public."CLIENTES" | type: TABLE --
-- DROP TABLE IF EXISTS public."CLIENTES" CASCADE;
CREATE TABLE public."CLIENTES" (
	rfc varchar(13) NOT NULL,
	nombre_pila varchar(30) NOT NULL,
	ap_paterno varchar(20) NOT NULL,
	ap_materno varchar(20),
	calle varchar(200) NOT NULL,
	colonia varchar(200) NOT NULL,
	numero_calle smallint,
	codigo_postal smallint NOT NULL,
	estado varchar(100) NOT NULL,
	CONSTRAINT "CLIENTES_pk" PRIMARY KEY (rfc)

);
-- ddl-end --
ALTER TABLE public."CLIENTES" OWNER TO postgres;
-- ddl-end --

-- object: public."EMAIL" | type: TABLE --
-- DROP TABLE IF EXISTS public."EMAIL" CASCADE;
CREATE TABLE public."EMAIL" (
	email varchar(70) NOT NULL,
	rfc varchar(30),
	CONSTRAINT "EMAIL_pk" PRIMARY KEY (email)

);
-- ddl-end --
ALTER TABLE public."EMAIL" OWNER TO postgres;
-- ddl-end --

-- object: public."ADQUIEREN" | type: TABLE --
-- DROP TABLE IF EXISTS public."ADQUIEREN" CASCADE;
CREATE TABLE public."ADQUIEREN" (
	codigo_barras varchar(13) NOT NULL,
	rfc varchar(13) NOT NULL,
	fecha date,
	cantidad_prod smallint,
	cantidad_pagar float,
	numero_venta varchar(9) DEFAULT 'VENT-00'||NEXTVAL('SEC_AD'),
	CONSTRAINT "ADQUIEREN_pk" PRIMARY KEY (codigo_barras,rfc)

);
-- ddl-end --
ALTER TABLE public."ADQUIEREN" OWNER TO postgres;
-- ddl-end --

-- object: public."INVENTARIO" | type: TABLE --
-- DROP TABLE IF EXISTS public."INVENTARIO" CASCADE;
CREATE TABLE public."INVENTARIO" (
	codigo_barras varchar(30) NOT NULL,
	nombre_pro varchar(30),
	marca varchar(20),
	descripcion varchar(250),
	pr_compra float,
	pr_venta float,
	fecha date,
	stock smallint,
	CONSTRAINT "INVENTARIO_pk" PRIMARY KEY (codigo_barras)

);
-- ddl-end --
ALTER TABLE public."INVENTARIO" OWNER TO postgres;
-- ddl-end --

-- object: public."COMPRA" | type: TABLE --
-- DROP TABLE IF EXISTS public."COMPRA" CASCADE;
CREATE TABLE public."COMPRA" (
	codigo_barras varchar(13) NOT NULL,
	razon_social varchar(150) NOT NULL,
	CONSTRAINT "COMPRA_pk" PRIMARY KEY (codigo_barras,razon_social)

);
-- ddl-end --
ALTER TABLE public."COMPRA" OWNER TO postgres;
-- ddl-end --

-- object: public."PROVEEDORES" | type: TABLE --
-- DROP TABLE IF EXISTS public."PROVEEDORES" CASCADE;
CREATE TABLE public."PROVEEDORES" (
	razon_social varchar(150) NOT NULL,
	calle varchar(200) NOT NULL,
	colonia varchar(200) NOT NULL,
	numero_calle smallint,
	codigo_postal integer NOT NULL,
	estado varchar(100) NOT NULL,
	nombre_pila varchar(30),
	ap_paterno varchar(30),
	ap_materno varchar(20),
	CONSTRAINT "PROVEEDORES_pk" PRIMARY KEY (razon_social)

);
-- ddl-end --
ALTER TABLE public."PROVEEDORES" OWNER TO postgres;
-- ddl-end --

-- object: public."TELEFONOS" | type: TABLE --
-- DROP TABLE IF EXISTS public."TELEFONOS" CASCADE;
CREATE TABLE public."TELEFONOS" (
	telefono bigint NOT NULL,
	razon_social varchar(150),
	CONSTRAINT "TELEFONOS_pk" PRIMARY KEY (telefono)

);
-- ddl-end --
ALTER TABLE public."TELEFONOS" OWNER TO postgres;
-- ddl-end --

-- object: rfc | type: CONSTRAINT --
-- ALTER TABLE public."EMAIL" DROP CONSTRAINT IF EXISTS rfc CASCADE;
ALTER TABLE public."EMAIL" ADD CONSTRAINT rfc FOREIGN KEY (rfc)
REFERENCES public."CLIENTES" (rfc) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: codigo_barras | type: CONSTRAINT --
-- ALTER TABLE public."ADQUIEREN" DROP CONSTRAINT IF EXISTS codigo_barras CASCADE;
ALTER TABLE public."ADQUIEREN" ADD CONSTRAINT codigo_barras FOREIGN KEY (codigo_barras)
REFERENCES public."INVENTARIO" (codigo_barras) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rfc | type: CONSTRAINT --
-- ALTER TABLE public."ADQUIEREN" DROP CONSTRAINT IF EXISTS rfc CASCADE;
ALTER TABLE public."ADQUIEREN" ADD CONSTRAINT rfc FOREIGN KEY (rfc)
REFERENCES public."CLIENTES" (rfc) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: codigo_barras | type: CONSTRAINT --
-- ALTER TABLE public."COMPRA" DROP CONSTRAINT IF EXISTS codigo_barras CASCADE;
ALTER TABLE public."COMPRA" ADD CONSTRAINT codigo_barras FOREIGN KEY (codigo_barras)
REFERENCES public."INVENTARIO" (codigo_barras) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: razon_social | type: CONSTRAINT --
-- ALTER TABLE public."COMPRA" DROP CONSTRAINT IF EXISTS razon_social CASCADE;
ALTER TABLE public."COMPRA" ADD CONSTRAINT razon_social FOREIGN KEY (razon_social)
REFERENCES public."PROVEEDORES" (razon_social) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: razon_social | type: CONSTRAINT --
-- ALTER TABLE public."TELEFONOS" DROP CONSTRAINT IF EXISTS razon_social CASCADE;
ALTER TABLE public."TELEFONOS" ADD CONSTRAINT razon_social FOREIGN KEY (razon_social)
REFERENCES public."PROVEEDORES" (razon_social) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- INSERTANDO DATOS A LA TABLA INVENTARIO --
INSERT INTO PUBLIC."INVENTARIO" VALUES (2363548496667,'Crayolas','Ponyola','Caja de crayolas de la marca ponyola viene con 12 crayolas',52.677,58.53,'2021/12/18',50);
INSERT INTO PUBLIC."INVENTARIO" VALUES (2366985946795,'Calculadora','Casio','Calculadora cientifica de con 552 funciones Casio',162.81,180.90,'2021/12/01',30);
INSERT INTO PUBLIC."INVENTARIO" VALUES (3389553847878,'Colores','Prismacolor','Lápices de colores caja con 12 piezas largos redondos prismacolor',81.54, 90.60,'2021/03/21',40);
INSERT INTO PUBLIC."INVENTARIO" VALUES (3435978925792,'Carpeta','Avery','Carpeta de diferentes colores azul, rosa, beige',2.16, 2.40,'2021/02/14',100);
INSERT INTO PUBLIC."INVENTARIO" VALUES (3756439752522,'Caja de grapas','Pilot','Cajas con 2059 grapas',19.35,21.50,'2021/01/16',35);
INSERT INTO PUBLIC."INVENTARIO" VALUES (3923573943396,'Tijeras','Maped','Tijera Maped de diferentes colores',31.905,35.45,'2021/04/21',20);
INSERT INTO PUBLIC."INVENTARIO" VALUES (3949865933925,'Pegamento','Resistol','Pegamento Blanco Resistol 850 110gr Pega Madera Corcho',21.006,23.34,'2021/06/12',20);
INSERT INTO PUBLIC."INVENTARIO" VALUES (4339427926466,'Sacagrapas','Pegaso','Quitagrapas Desengrapadora Pegaso 501 Azor',31.50,35.00,'2021/07/30',15);
INSERT INTO PUBLIC."INVENTARIO" VALUES (4567885949555,'Regla','Pilot','Regla Pilot De 30cm plastico 1 Pieza',13.68,15.20,'2021/04/11',25);
INSERT INTO PUBLIC."INVENTARIO" VALUES (4639737987349,'Sacapuntas','Mae','1 pieza saca punta metalica marca Mae',6.615,7.35,'2021/02/04',35);
INSERT INTO PUBLIC."INVENTARIO" VALUES (4744285637489,'Tinta para sellos','Stafford','Tinta para sellos de diversos colores de la marca Stafford',33.885,37.65,'2021/06/20',10);
INSERT INTO PUBLIC."INVENTARIO" VALUES (5244752597834,'Caja de clips','Acco','Clip Estandar #2 Mae Csj Caja C/100 Pzs Niquelado',21.70,24.11,'2021/01/10',4);
INSERT INTO PUBLIC."INVENTARIO" VALUES (5432762832935,'Caja de alfiler','Artesco','Alambre resistente. Acabado liso y brilloso.',9.11,10.13,'2021/08/03',9);
INSERT INTO PUBLIC."INVENTARIO" VALUES (5443373383967,'Cuaderno','Scribe','CUADERNO PROFESIONAL RAYA SCRIBE DE 100 HOJAS PASTA SEMI RIGIDA TIPO METALICO 1 PIEZA',14.391,15.99,'2021/09/21',11);
INSERT INTO PUBLIC."INVENTARIO" VALUES (5954598237226,'Engrapadora','Manny','Engrapadora Metalica Manny 3/4 De Tira Estandar',27.189,30.21,'2021/04/19',10);
INSERT INTO public."INVENTARIO" VALUES (6422786449664,'Goma de borrar','Maped','Goma de Borrar Migasoft Blíster con 2 Piezas Maped',6.84,7.60,'2021/01/09',45);
INSERT INTO public."INVENTARIO" VALUES (6674433627826,'Corrector liquido','Smart','Corrector Líquido Blanco Tipo Pluma 7 ml Blíster Cool Colors Smart',12.20,13.56,'2021/05/12',50);
INSERT INTO public."INVENTARIO" VALUES (6793248557335,'Cinta adhesiva','Janel','Cinta Adhesiva Transparente T119 de .12 x 33 m Janel',10.53,11.70,'2020/10/10',12);
INSERT INTO public."INVENTARIO" VALUES (7558439229896,'Lapiz','Smart','Lápiz con Goma Hexagonal Número 2 Bolsa con 4 Piezas Smart Plus',5.08,5.65,'2021/06/04',29);
INSERT INTO public."INVENTARIO" VALUES (7656294498279,'Lapicero','Zebra','Lapicero de 0.5 mm Blíster M-301 Zebra',7.65,8.50,'2020/06/28',7);
INSERT INTO public."INVENTARIO" VALUES (7726773325254,'Boligrafo','Paper Mate','Bolígrafo Gel Stick 5mm Negro Blíster Paper Mate',31.95,35.50,'2021/06/24',31);
INSERT INTO public."INVENTARIO" VALUES (7735462687927,'Cutter','Smart','Cutter Navaja Grande Transparente Bolsa Smart',12.09,13.49,'2020/11/28',6);
INSERT INTO public."INVENTARIO" VALUES (8492576624558,'Pintarrón','Alfra','Pintarrón Alfra Metálico (90X120 cm)',1278,1420,'2021/03/07',19);
INSERT INTO public."INVENTARIO" VALUES (8768646463944,'Perforadora','Smart','Perforadora Un Agujero Ahulada Cool Colors Smart',90.63,100.70,'2021/03/28',14);
INSERT INTO public."INVENTARIO" VALUES (8779957272437,'Peluche','Autops','Oso De Peluche Brillante Para Niños M-034 Blanco',140.85,156.50,'2021/01/19',1);
INSERT INTO public."INVENTARIO" VALUES (8824963828688,'Pelota','Imar','Pelota Inflable de Playa',9.90,11,'2021/03/23',26);
INSERT INTO public."INVENTARIO" VALUES (9532396678842,'Marco para fotos','Union','Portarretrato Negro 10X15Cm Union',39.15,43.50,'2020/11/18',41);
INSERT INTO public."INVENTARIO" VALUES (9538297882993,'Taza','Llilng','Taza de Cerámica 354Ml Solido',72.40,80.45,'2020/10/14',10);
INSERT INTO public."INVENTARIO" VALUES (9736985947858,'Mochila','Wilson','Mochila Primaria Unisex Azul Wilson',315,350,'2020/03/05',3);
INSERT INTO public."INVENTARIO" VALUES (9883533229694,'Reloj','Bleck','Reloj Inteligente 1.44" Led Color Gris Bleck',108.72,120.80,'2020/12/02',12);

-- INSERTANDO DATOS A LA TABLA PROOVEDORES --
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Lumen','Manjares','Cerro de la estrella',45,98756,'CDMX','Juan','Pacheco','Salgado');
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Monarca','José Vicente Villada','Espíritu Santo',43,52140,'Metepec','Aldo','Martínez','Rosas');
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Celeste','Salvador Díaz Moguel','Gustavo A. Madero',443,17400,'CDMX','Mauricio','Rosales','Meza');
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Luna','Paris','Coyoacán',74,14100,'Puebla','Antonio','Robles','Torres');
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Lineas','Av. de los Gobernadores','Morelia',208,61053,'Michoacan','Ana','Torres','Islas');
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Air Europa S.A','Miguel Hidalgo','Tepalcates',25,09210,'Tamaulipas','Antonio','Vargas','Guzman');
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Punto FA S.L','Guadalupe Victoria','Islas Turcas y Caicos',303,20563,'Oaxaca','Aldo','Ramirez','Jordan');
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Iberica S.A','Av. Rio Bravo','Bermudas',11,89342,'Republica Argentina','Giovanni','Pacheco','Vazquez');
INSERT INTO public."PROVEEDORES"(razon_social,calle,colonia,numero_calle,codigo_postal,estado,nombre_pila,ap_paterno,ap_materno) VALUES ('Restaurantes S.A','Reforma','Anguila',56,11260,'Reino de España','William','Diaz','Avila');

-- INSERTANDO DATOS A LA TABLA TELEFONOS --
INSERT INTO public."TELEFONOS" VALUES (5511659300, 'Lumen');
INSERT INTO public."TELEFONOS" VALUES (5620493258, 'Monarca');
INSERT INTO public."TELEFONOS" VALUES (5511054760, 'Celeste');
INSERT INTO public."TELEFONOS" VALUES (5514896553, 'Lineas');
INSERT INTO public."TELEFONOS" VALUES (5522034262, 'Air Europa S.A');
INSERT INTO public."TELEFONOS" VALUES (5544856211, 'Punto FA S.L');
INSERT INTO public."TELEFONOS" VALUES (5533963640, 'Iberica S.A');
INSERT INTO public."TELEFONOS" VALUES (5590142309, 'Restaurantes S.A');

-- INSERTANDO DATOS A LA TABLA CLIENTES --
INSERT INTO public."CLIENTES" VALUES ('AYGR123456780','Aldo','Guzman','Ramirez','Carranza','Miradores',78,5342,'Guerrero');

-- INSERTANDO DATOS A LA TABLA ADQUIEREN --
INSERT INTO public."ADQUIEREN" VALUES (9883533229694,'AYGR123456780','2021/12/09',4,300,DEFAULT);
INSERT INTO public."ADQUIEREN" VALUES (8779957272437,'AYGR123456780','2020/12/02',3,300,DEFAULT);

DELETE FROM public."PROVEEDORES";

DELETE FROM public."TELEFONOS";

SELECT * FROM public."INVENTARIO";

SELECT * FROM public."ADQUIEREN";

-- INTRODUCIENDO CODIGO DE BARRAS REGRESA UTILIDAD --
CREATE OR REPLACE FUNCTION obten_utilidad(codigo varchar) RETURNS TABLE(nombre varchar,descrip varchar,precio float) AS $$
BEGIN
RETURN QUERY SELECT 
nombre_pro,descripcion,pr_venta 
FROM public."INVENTARIO"
WHERE codigo_barras ILIKE codigo;
END
$$ LANGUAGE PLPGSQL;

DROP FUNCTION obten_utilidad;

SELECT * FROM obten_utilidad('3923573943396');		

-- ARTICULOS CON MENOS DE 3 UNIDADES EN STOCK --
CREATE OR REPLACE FUNCTION poco_stock() RETURNS TABLE(nombre varchar,existencias smallint) AS $$
BEGIN 
RETURN QUERY SELECT 
nombre_pro,stock
FROM public."INVENTARIO"
GROUP BY nombre_pro,stock
HAVING stock < 3;
END
$$ LANGUAGE PLPGSQL;

DROP FUNCTION poco_stock;

SELECT poco_stock();

SELECT * FROM poco_stock();

-- VENTA Y GANANCIA PARA DOS FECHAS --
CREATE OR REPLACE FUNCTION venta_periodo(f_ini date, f_fin date) RETURNS TABLE(cant_vend bigint,ganancia float) AS $$
BEGIN
RETURN QUERY SELECT 
SUM(cantidad_prod),SUM(cantidad_pagar)
FROM public."ADQUIEREN"
WHERE fecha BETWEEN f_ini
AND f_fin;
END
$$ LANGUAGE PLPGSQL;

-- VENTA Y GANANCIA  PARA UNA FECHA --
CREATE OR REPLACE FUNCTION venta_periodo(f_ini date) RETURNS TABLE(cant_vend bigint,ganancia float) AS $$
BEGIN
RETURN QUERY SELECT 
SUM(cantidad_prod),SUM(cantidad_pagar)
FROM public."ADQUIEREN"
WHERE fecha = f_ini;
END
$$ LANGUAGE PLPGSQL;

DROP FUNCTION venta_periodo;

SELECT * FROM venta_periodo('2020/12/02','2021/12/09'); 

SELECT * FROM venta_periodo('2020/12/02'); 

-- INDICE --
CREATE INDEX I_INDICE ON public."INVENTARIO"(nombre_pro);

DROP INDEX I_INDICE;
