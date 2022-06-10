-- DROP SCHEMA scrum;

CREATE SCHEMA scrum AUTHORIZATION dbadmin;
-- scrum.equipo definition

-- Drop table

-- DROP TABLE scrum.equipo;

CREATE TABLE scrum.equipo (
	idequipo int4 NOT NULL,
	nombreequipo varchar(15) NOT NULL,
	areaequipo varchar(20) NOT NULL,
	fechacreacionequipo date NOT NULL,
	CONSTRAINT equipo_pkey PRIMARY KEY (idequipo)
);


-- scrum.productowner definition

-- Drop table

-- DROP TABLE scrum.productowner;

CREATE TABLE scrum.productowner (
	idproductowner int4 NOT NULL,
	nombrepow varchar(15) NOT NULL,
	apellidopow varchar(15) NOT NULL,
	correopow varchar(50) NOT NULL,
	telefonopow varchar(10) NOT NULL,
	CONSTRAINT productowner_pkey PRIMARY KEY (idproductowner)
);


-- scrum.tecnologia definition

-- Drop table

-- DROP TABLE scrum.tecnologia;

CREATE TABLE scrum.tecnologia (
	idtecnologia int4 NOT NULL,
	nombretec varchar(20) NOT NULL,
	versiontec varchar(10) NOT NULL,
	CONSTRAINT tecnologia_pkey PRIMARY KEY (idtecnologia)
);


-- scrum.proyecto definition

-- Drop table

-- DROP TABLE scrum.proyecto;

CREATE TABLE scrum.proyecto (
	idproyecto int4 NOT NULL,
	idproductowner int4 NOT NULL,
	nombreproy varchar(80) NOT NULL,
	duracionestimadaproy interval NOT NULL,
	presupuestoproy int4 NOT NULL,
	fechainicioproy date NOT NULL,
	fechafinproy date NOT NULL,
	CONSTRAINT proyecto_pkey PRIMARY KEY (idproyecto),
	CONSTRAINT fk_productowner FOREIGN KEY (idproductowner) REFERENCES scrum.productowner(idproductowner)
);


-- scrum.proyectotecnologia definition

-- Drop table

-- DROP TABLE scrum.proyectotecnologia;

CREATE TABLE scrum.proyectotecnologia (
	idtecnologia int4 NOT NULL,
	idproyecto int4 NOT NULL,
	CONSTRAINT fk_proyecto FOREIGN KEY (idproyecto) REFERENCES scrum.proyecto(idproyecto),
	CONSTRAINT fk_tecnologia FOREIGN KEY (idtecnologia) REFERENCES scrum.tecnologia(idtecnologia)
);


-- scrum.stakeholder definition

-- Drop table

-- DROP TABLE scrum.stakeholder;

CREATE TABLE scrum.stakeholder (
	idstakeholder int4 NOT NULL,
	idproductowner int4 NOT NULL,
	nombrestake varchar(15) NOT NULL,
	apellido varchar(15) NOT NULL,
	correostake varchar(50) NOT NULL,
	telefonostake varchar(10) NOT NULL,
	empresastake varchar(50) NOT NULL,
	fechacontratostake date NOT NULL,
	CONSTRAINT stakeholder_pkey PRIMARY KEY (idstakeholder),
	CONSTRAINT fk_productowner FOREIGN KEY (idproductowner) REFERENCES scrum.productowner(idproductowner)
);


-- scrum.trabajador definition

-- Drop table

-- DROP TABLE scrum.trabajador;

CREATE TABLE scrum.trabajador (
	idtrabajador int4 NOT NULL,
	idequipo int4 NOT NULL,
	nombretrab varchar(15) NOT NULL,
	apellidotrab varchar(15) NOT NULL,
	correotrab varchar(50) NOT NULL,
	telefonotrab varchar(10) NOT NULL,
	especialidadtrab varchar(20) NOT NULL,
	fechacontratacion date NOT NULL,
	CONSTRAINT trabajador_pkey PRIMARY KEY (idtrabajador),
	CONSTRAINT fk_equipo FOREIGN KEY (idequipo) REFERENCES scrum.equipo(idequipo)
);


-- scrum.backlog definition

-- Drop table

-- DROP TABLE scrum.backlog;

CREATE TABLE scrum.backlog (
	idbacklog int4 NOT NULL,
	idproyecto int4 NOT NULL,
	historiacortabl varchar(140) NOT NULL,
	enunciadobl varchar(100) NOT NULL,
	estadobl varchar(10) NOT NULL,
	prioridadbl varchar(15) NOT NULL,
	CONSTRAINT backlog_pkey PRIMARY KEY (idbacklog),
	CONSTRAINT fk_proyecto FOREIGN KEY (idproyecto) REFERENCES scrum.proyecto(idproyecto)
);


-- scrum.equipoproyecto definition

-- Drop table

-- DROP TABLE scrum.equipoproyecto;

CREATE TABLE scrum.equipoproyecto (
	idequipo int4 NOT NULL,
	idproyecto int4 NOT NULL,
	CONSTRAINT fk_equipo FOREIGN KEY (idequipo) REFERENCES scrum.equipo(idequipo),
	CONSTRAINT fk_proyecto FOREIGN KEY (idproyecto) REFERENCES scrum.proyecto(idproyecto)
);


-- scrum.sprint definition

-- Drop table

-- DROP TABLE scrum.sprint;

CREATE TABLE scrum.sprint (
	idsprint int4 NOT NULL,
	idequipo int4 NOT NULL,
	idbacklog int4 NOT NULL,
	descripcion varchar(140) NOT NULL,
	estado varchar(15) NOT NULL,
	fechainicio date NOT NULL,
	fechafin date NOT NULL,
	CONSTRAINT sprint_pkey PRIMARY KEY (idsprint),
	CONSTRAINT fk_backlog FOREIGN KEY (idbacklog) REFERENCES scrum.backlog(idbacklog),
	CONSTRAINT fk_equipo FOREIGN KEY (idequipo) REFERENCES scrum.equipo(idequipo)
);


-- scrum.sprintreviewmeeting definition

-- Drop table

-- DROP TABLE scrum.sprintreviewmeeting;

CREATE TABLE scrum.sprintreviewmeeting (
	idsprintreviewmeeting int4 NOT NULL,
	idsprint int4 NOT NULL,
	fecha date NOT NULL,
	hora time NOT NULL,
	lugar varchar(20) NOT NULL,
	observaciones varchar(80) NOT NULL,
	numerointegrantes int4 NOT NULL,
	CONSTRAINT sprintreviewmeeting_pkey PRIMARY KEY (idsprintreviewmeeting),
	CONSTRAINT fk_sprint FOREIGN KEY (idsprint) REFERENCES scrum.sprint(idsprint)
);


-- scrum.tareassprint definition

-- Drop table

-- DROP TABLE scrum.tareassprint;

CREATE TABLE scrum.tareassprint (
	idtareasprint int4 NOT NULL,
	idsprint int4 NOT NULL,
	idtrabajador int4 NOT NULL,
	nombrets varchar(20) NOT NULL,
	descripcionts varchar(280) NOT NULL,
	estadots varchar(15) NOT NULL,
	horasts int4 NULL,
	fechainiciots date NOT NULL,
	fechaestimadafin date NOT NULL,
	fecharealfin date NULL,
	niveldificultadts varchar(10) NOT NULL,
	observacionests varchar(100) NOT NULL,
	problemasencontrados varchar(140) NOT NULL,
	CONSTRAINT tareassprint_pkey PRIMARY KEY (idtareasprint),
	CONSTRAINT fk_sprint FOREIGN KEY (idsprint) REFERENCES scrum.sprint(idsprint),
	CONSTRAINT fk_trabajador FOREIGN KEY (idtrabajador) REFERENCES scrum.trabajador(idtrabajador)
);


-- scrum.casosprueba definition

-- Drop table

-- DROP TABLE scrum.casosprueba;

CREATE TABLE scrum.casosprueba (
	idprueba int4 NOT NULL,
	idtareasprint int4 NOT NULL,
	nombre varchar(20) NOT NULL,
	resultado varchar(140) NOT NULL,
	superado bool NOT NULL,
	CONSTRAINT fk_tareasprint FOREIGN KEY (idtareasprint) REFERENCES scrum.tareassprint(idtareasprint)
);


-- scrum.dailyscrum definition

-- Drop table

-- DROP TABLE scrum.dailyscrum;

CREATE TABLE scrum.dailyscrum (
	iddailyscrum int4 NOT NULL,
	idsprint int4 NOT NULL,
	hora time NOT NULL,
	fecha date NOT NULL,
	lugar varchar(20) NOT NULL,
	duracion interval NOT NULL,
	nuevasideas varchar(280) NOT NULL,
	CONSTRAINT dailyscrum_pkey PRIMARY KEY (iddailyscrum),
	CONSTRAINT fk_sprint FOREIGN KEY (idsprint) REFERENCES scrum.sprint(idsprint)
);


-- scrum.dailyscrumparticipantes definition

-- Drop table

-- DROP TABLE scrum.dailyscrumparticipantes;

CREATE TABLE scrum.dailyscrumparticipantes (
	iddailyscrum int4 NOT NULL,
	idtrabajador int4 NOT NULL,
	CONSTRAINT fk_dailyscrum FOREIGN KEY (iddailyscrum) REFERENCES scrum.dailyscrum(iddailyscrum),
	CONSTRAINT fk_trabajador FOREIGN KEY (idtrabajador) REFERENCES scrum.trabajador(idtrabajador)
);
