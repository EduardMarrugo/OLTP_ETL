<<<<<<< HEAD
-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION azure_pg_admin;
-- public.ingreso_hechos definition

-- Drop table

-- DROP TABLE public.ingreso_hechos;

CREATE TABLE public.ingreso_hechos (
	proyecto_key int4 NOT NULL,
	time_key int4 NOT NULL,
	utilidad int4 NULL,
	CONSTRAINT ingreso_hechos_pk PRIMARY KEY (proyecto_key, time_key)
);


-- public.product_owner definition

-- Drop table

-- DROP TABLE public.product_owner;

CREATE TABLE public.product_owner (
	product_owner_key int4 NOT NULL,
	product_owner_id int4 NULL,
	nombre varchar(15) NULL,
	apellido varchar(15) NULL,
	telefono varchar(10) NULL,
	correo varchar(50) NULL,
	modificacion date NULL,
	CONSTRAINT product_owner_pk PRIMARY KEY (product_owner_key)
);


-- public.sprint definition

-- Drop table

-- DROP TABLE public.sprint;

CREATE TABLE public.sprint (
	sprint_key int4 NOT NULL,
	sprint_id int4 NULL,
	tarea_id int4 NULL,
	nombre_tarea varchar(20) NULL,
	descripcion_tarea varchar(280) NULL,
	estado_tarea varchar(15) NULL,
	dificultad_tarea varchar(10) NULL,
	problemas_tarea varchar(140) NULL,
	descripcion_sprint varchar(140) NULL,
	estado_sprint varchar(15) NULL,
	modificacion date NULL,
	CONSTRAINT sprint_pk PRIMARY KEY (sprint_key)
);


-- public.stakeholder definition

-- Drop table

-- DROP TABLE public.stakeholder;

CREATE TABLE public.stakeholder (
	stakeholder_key int4 NOT NULL,
	stakeholder_id int4 NULL,
	nombre varchar(15) NULL,
	apellido varchar(15) NULL,
	telefono varchar(10) NULL,
	correo varchar(50) NULL,
	empresa varchar(50) NULL,
	modificacion date NULL,
	CONSTRAINT stakeholder_pk PRIMARY KEY (stakeholder_key)
);
CREATE UNIQUE INDEX idx_stakeholder_pk ON public.stakeholder USING btree (stakeholder_key);


-- public.tecnologia definition

-- Drop table

-- DROP TABLE public.tecnologia;

CREATE TABLE public.tecnologia (
	tecnologia_key int4 NOT NULL,
	tecnologia_id int4 NULL,
	nombre varchar(20) NULL,
	"version" varchar(10) NULL,
	modificacion date NULL,
	CONSTRAINT tecnologia_pk PRIMARY KEY (tecnologia_key)
);


-- public."time" definition

-- Drop table

-- DROP TABLE public."time";

CREATE TABLE public."time" (
	time_key int4 NOT NULL,
	full_date date NULL,
	"year" int4 NULL,
	quarter int4 NULL,
	"month" int4 NULL,
	"day" int4 NULL,
	modificacion date NULL,
	CONSTRAINT time_pk PRIMARY KEY (time_key)
);


-- public.trabajador definition

-- Drop table

-- DROP TABLE public.trabajador;

CREATE TABLE public.trabajador (
	trabajador_key int4 NOT NULL,
	trabajador_id int4 NULL,
	equipo_id int4 NULL,
	nombre varchar(15) NULL,
	apellido varchar(15) NULL,
	telefono varchar(10) NULL,
	especialidad varchar(20) NULL,
	correo varchar(50) NULL,
	fecha_contratacion date NULL,
	nombre_equipo varchar(15) NULL,
	area_equipo varchar(20) NULL,
	modificacion date NULL,
	CONSTRAINT trabajador_pk PRIMARY KEY (trabajador_key)
);


-- public.proyecto definition

-- Drop table

-- DROP TABLE public.proyecto;

CREATE TABLE public.proyecto (
	proyecto_key int4 NOT NULL,
	proyecto_id int4 NULL,
	tecnología_key int4 NULL,
	nombre varchar(80) NULL,
	duracion_estimada varchar NULL,
	presupuesto int4 NULL,
	fechainicio date NULL,
	fechafin date NULL,
	modificacion date NULL,
	CONSTRAINT proyecto_pk PRIMARY KEY (proyecto_key),
	CONSTRAINT proyecto_fk FOREIGN KEY (tecnología_key) REFERENCES public.tecnologia(tecnologia_key)
);


-- public.proyecto_hechos definition

-- Drop table

-- DROP TABLE public.proyecto_hechos;

CREATE TABLE public.proyecto_hechos (
	proyecto_key int4 NOT NULL,
	product_owner_key int4 NOT NULL,
	fecha_inicio_key int4 NOT NULL,
	fecha_fin_real_key int4 NOT NULL,
	fecha_fin_estimada_key int4 NOT NULL,
	estado varchar(15) NULL,
	requisitos_entregados int4 NULL,
	tiempo_ejecucion interval NULL,
	CONSTRAINT proyecto_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT proyecto_hechos_fk_1 FOREIGN KEY (product_owner_key) REFERENCES public.product_owner(product_owner_key),
	CONSTRAINT proyecto_hechos_fk_2 FOREIGN KEY (fecha_inicio_key) REFERENCES public."time"(time_key),
	CONSTRAINT proyecto_hechos_fk_3 FOREIGN KEY (fecha_fin_real_key) REFERENCES public."time"(time_key),
	CONSTRAINT proyecto_hechos_fk_4 FOREIGN KEY (fecha_fin_estimada_key) REFERENCES public."time"(time_key)
);


-- public.pruebas_hechos definition

-- Drop table

-- DROP TABLE public.pruebas_hechos;

CREATE TABLE public.pruebas_hechos (
	trabajador_key int4 NOT NULL,
	sprint_key int4 NOT NULL,
	proyecto_key int4 NOT NULL,
	time_key int4 NOT NULL,
	numero_puntos int4 NULL,
	resultado varchar(140) NULL,
	CONSTRAINT pruebas_hechos_fk FOREIGN KEY (trabajador_key) REFERENCES public.trabajador(trabajador_key),
	CONSTRAINT pruebas_hechos_fk_1 FOREIGN KEY (time_key) REFERENCES public."time"(time_key),
	CONSTRAINT pruebas_hechos_fk_2 FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT pruebas_hechos_fk_3 FOREIGN KEY (sprint_key) REFERENCES public.sprint(sprint_key)
);


-- public.trabajadores_hechos definition

-- Drop table

-- DROP TABLE public.trabajadores_hechos;

CREATE TABLE public.trabajadores_hechos (
	proyecto_key int4 NOT NULL,
	time_key int4 NOT NULL,
	trabajador_key int4 NOT NULL,
	CONSTRAINT trabajadores_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT trabajadores_hechos_fk_1 FOREIGN KEY (time_key) REFERENCES public."time"(time_key),
	CONSTRAINT trabajadores_hechos_fk_2 FOREIGN KEY (trabajador_key) REFERENCES public.trabajador(trabajador_key)
);


-- public.daily_scrum_hechos definition

-- Drop table

-- DROP TABLE public.daily_scrum_hechos;

CREATE TABLE public.daily_scrum_hechos (
	proyecto_key int4 NOT NULL,
	sprint_key int4 NOT NULL,
	trabajador_key int4 NOT NULL,
	fecha_key int4 NOT NULL,
	idea varchar(280) NULL,
	CONSTRAINT daily_scrum_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT daily_scrum_hechos_fk_1 FOREIGN KEY (sprint_key) REFERENCES public.sprint(sprint_key),
	CONSTRAINT daily_scrum_hechos_fk_2 FOREIGN KEY (trabajador_key) REFERENCES public.trabajador(trabajador_key),
	CONSTRAINT daily_scrum_hechos_fk_3 FOREIGN KEY (fecha_key) REFERENCES public."time"(time_key)
);


-- public.iteraciones_hechos definition

-- Drop table

-- DROP TABLE public.iteraciones_hechos;

CREATE TABLE public.iteraciones_hechos (
	proyecto_key int4 NOT NULL,
	sprint_key int4 NOT NULL,
	dia_inicio_key int4 NOT NULL,
	dia_fin_key int4 NOT NULL,
	numero_historias int4 NULL,
	CONSTRAINT iteraciones_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT iteraciones_hechos_fk_1 FOREIGN KEY (sprint_key) REFERENCES public.sprint(sprint_key),
	CONSTRAINT iteraciones_hechos_fk_2 FOREIGN KEY (dia_inicio_key) REFERENCES public."time"(time_key),
	CONSTRAINT iteraciones_hechos_fk_3 FOREIGN KEY (dia_fin_key) REFERENCES public."time"(time_key)
);


-- public.peticiones_hechos definition

-- Drop table

-- DROP TABLE public.peticiones_hechos;

CREATE TABLE public.peticiones_hechos (
	proyecto_key int4 NOT NULL,
	product_owner_key int4 NOT NULL,
	stake_holder_key int4 NOT NULL,
	fecha_peticion_key int4 NOT NULL,
	fecha_entrega_key int4 NOT NULL,
	tiempo_entrega interval NULL,
	CONSTRAINT peticiones_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT peticiones_hechos_fk_1 FOREIGN KEY (product_owner_key) REFERENCES public.product_owner(product_owner_key),
	CONSTRAINT peticiones_hechos_fk_2 FOREIGN KEY (stake_holder_key) REFERENCES public.stakeholder(stakeholder_key),
	CONSTRAINT peticiones_hechos_fk_3 FOREIGN KEY (fecha_peticion_key) REFERENCES public."time"(time_key),
	CONSTRAINT peticiones_hechos_fk_4 FOREIGN KEY (fecha_entrega_key) REFERENCES public."time"(time_key)
);
=======
-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION azure_pg_admin;
-- public.ingreso_hechos definition

-- Drop table

-- DROP TABLE public.ingreso_hechos;

CREATE TABLE public.ingreso_hechos (
	proyecto_key int4 NOT NULL,
	time_key int4 NOT NULL,
	utilidad int4 NULL,
	CONSTRAINT ingreso_hechos_pk PRIMARY KEY (proyecto_key, time_key)
);


-- public.product_owner definition

-- Drop table

-- DROP TABLE public.product_owner;

CREATE TABLE public.product_owner (
	product_owner_key int4 NOT NULL,
	product_owner_id int4 NULL,
	nombre varchar(15) NULL,
	apellido varchar(15) NULL,
	telefono varchar(10) NULL,
	correo varchar(50) NULL,
	modificacion date NULL,
	CONSTRAINT product_owner_pk PRIMARY KEY (product_owner_key)
);


-- public.sprint definition

-- Drop table

-- DROP TABLE public.sprint;

CREATE TABLE public.sprint (
	sprint_key int4 NOT NULL,
	sprint_id int4 NULL,
	tarea_id int4 NULL,
	nombre_tarea varchar(20) NULL,
	descripcion_tarea varchar(280) NULL,
	estado_tarea varchar(15) NULL,
	dificultad_tarea varchar(10) NULL,
	problemas_tarea varchar(140) NULL,
	descripcion_sprint varchar(140) NULL,
	estado_sprint varchar(15) NULL,
	modificacion date NULL,
	CONSTRAINT sprint_pk PRIMARY KEY (sprint_key)
);


-- public.stakeholder definition

-- Drop table

-- DROP TABLE public.stakeholder;

CREATE TABLE public.stakeholder (
	stakeholder_key int4 NOT NULL,
	stakeholder_id int4 NULL,
	nombre varchar(15) NULL,
	apellido varchar(15) NULL,
	telefono varchar(10) NULL,
	correo varchar(50) NULL,
	empresa varchar(50) NULL,
	modificacion date NULL,
	CONSTRAINT stakeholder_pk PRIMARY KEY (stakeholder_key)
);
CREATE UNIQUE INDEX idx_stakeholder_pk ON public.stakeholder USING btree (stakeholder_key);


-- public.tecnologia definition

-- Drop table

-- DROP TABLE public.tecnologia;

CREATE TABLE public.tecnologia (
	tecnologia_key int4 NOT NULL,
	tecnologia_id int4 NULL,
	nombre varchar(20) NULL,
	"version" varchar(10) NULL,
	modificacion date NULL,
	CONSTRAINT tecnologia_pk PRIMARY KEY (tecnologia_key)
);


-- public."time" definition

-- Drop table

-- DROP TABLE public."time";

CREATE TABLE public."time" (
	time_key int4 NOT NULL,
	full_date date NULL,
	"year" int4 NULL,
	quarter int4 NULL,
	"month" int4 NULL,
	"day" int4 NULL,
	modificacion date NULL,
	CONSTRAINT time_pk PRIMARY KEY (time_key)
);


-- public.trabajador definition

-- Drop table

-- DROP TABLE public.trabajador;

CREATE TABLE public.trabajador (
	trabajador_key int4 NOT NULL,
	trabajador_id int4 NULL,
	equipo_id int4 NULL,
	nombre varchar(15) NULL,
	apellido varchar(15) NULL,
	telefono varchar(10) NULL,
	especialidad varchar(20) NULL,
	correo varchar(50) NULL,
	fecha_contratacion date NULL,
	nombre_equipo varchar(15) NULL,
	area_equipo varchar(20) NULL,
	modificacion date NULL,
	CONSTRAINT trabajador_pk PRIMARY KEY (trabajador_key)
);


-- public.proyecto definition

-- Drop table

-- DROP TABLE public.proyecto;

CREATE TABLE public.proyecto (
	proyecto_key int4 NOT NULL,
	proyecto_id int4 NULL,
	tecnología_key int4 NULL,
	nombre varchar(80) NULL,
	duracion_estimada varchar NULL,
	presupuesto int4 NULL,
	fechainicio date NULL,
	fechafin date NULL,
	modificacion date NULL,
	CONSTRAINT proyecto_pk PRIMARY KEY (proyecto_key),
	CONSTRAINT proyecto_fk FOREIGN KEY (tecnología_key) REFERENCES public.tecnologia(tecnologia_key)
);


-- public.proyecto_hechos definition

-- Drop table

-- DROP TABLE public.proyecto_hechos;

CREATE TABLE public.proyecto_hechos (
	proyecto_key int4 NOT NULL,
	product_owner_key int4 NOT NULL,
	fecha_inicio_key int4 NOT NULL,
	fecha_fin_real_key int4 NOT NULL,
	fecha_fin_estimada_key int4 NOT NULL,
	estado varchar(15) NULL,
	requisitos_entregados int4 NULL,
	tiempo_ejecucion interval NULL,
	CONSTRAINT proyecto_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT proyecto_hechos_fk_1 FOREIGN KEY (product_owner_key) REFERENCES public.product_owner(product_owner_key),
	CONSTRAINT proyecto_hechos_fk_2 FOREIGN KEY (fecha_inicio_key) REFERENCES public."time"(time_key),
	CONSTRAINT proyecto_hechos_fk_3 FOREIGN KEY (fecha_fin_real_key) REFERENCES public."time"(time_key),
	CONSTRAINT proyecto_hechos_fk_4 FOREIGN KEY (fecha_fin_estimada_key) REFERENCES public."time"(time_key)
);


-- public.pruebas_hechos definition

-- Drop table

-- DROP TABLE public.pruebas_hechos;

CREATE TABLE public.pruebas_hechos (
	trabajador_key int4 NOT NULL,
	sprint_key int4 NOT NULL,
	proyecto_key int4 NOT NULL,
	time_key int4 NOT NULL,
	numero_puntos int4 NULL,
	resultado varchar(140) NULL,
	CONSTRAINT pruebas_hechos_fk FOREIGN KEY (trabajador_key) REFERENCES public.trabajador(trabajador_key),
	CONSTRAINT pruebas_hechos_fk_1 FOREIGN KEY (time_key) REFERENCES public."time"(time_key),
	CONSTRAINT pruebas_hechos_fk_2 FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT pruebas_hechos_fk_3 FOREIGN KEY (sprint_key) REFERENCES public.sprint(sprint_key)
);


-- public.trabajadores_hechos definition

-- Drop table

-- DROP TABLE public.trabajadores_hechos;

CREATE TABLE public.trabajadores_hechos (
	proyecto_key int4 NOT NULL,
	time_key int4 NOT NULL,
	trabajador_key int4 NOT NULL,
	CONSTRAINT trabajadores_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT trabajadores_hechos_fk_1 FOREIGN KEY (time_key) REFERENCES public."time"(time_key),
	CONSTRAINT trabajadores_hechos_fk_2 FOREIGN KEY (trabajador_key) REFERENCES public.trabajador(trabajador_key)
);


-- public.daily_scrum_hechos definition

-- Drop table

-- DROP TABLE public.daily_scrum_hechos;

CREATE TABLE public.daily_scrum_hechos (
	proyecto_key int4 NOT NULL,
	sprint_key int4 NOT NULL,
	trabajador_key int4 NOT NULL,
	fecha_key int4 NOT NULL,
	idea varchar(280) NULL,
	CONSTRAINT daily_scrum_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT daily_scrum_hechos_fk_1 FOREIGN KEY (sprint_key) REFERENCES public.sprint(sprint_key),
	CONSTRAINT daily_scrum_hechos_fk_2 FOREIGN KEY (trabajador_key) REFERENCES public.trabajador(trabajador_key),
	CONSTRAINT daily_scrum_hechos_fk_3 FOREIGN KEY (fecha_key) REFERENCES public."time"(time_key)
);


-- public.iteraciones_hechos definition

-- Drop table

-- DROP TABLE public.iteraciones_hechos;

CREATE TABLE public.iteraciones_hechos (
	proyecto_key int4 NOT NULL,
	sprint_key int4 NOT NULL,
	dia_inicio_key int4 NOT NULL,
	dia_fin_key int4 NOT NULL,
	numero_historias int4 NULL,
	CONSTRAINT iteraciones_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT iteraciones_hechos_fk_1 FOREIGN KEY (sprint_key) REFERENCES public.sprint(sprint_key),
	CONSTRAINT iteraciones_hechos_fk_2 FOREIGN KEY (dia_inicio_key) REFERENCES public."time"(time_key),
	CONSTRAINT iteraciones_hechos_fk_3 FOREIGN KEY (dia_fin_key) REFERENCES public."time"(time_key)
);


-- public.peticiones_hechos definition

-- Drop table

-- DROP TABLE public.peticiones_hechos;

CREATE TABLE public.peticiones_hechos (
	proyecto_key int4 NOT NULL,
	product_owner_key int4 NOT NULL,
	stake_holder_key int4 NOT NULL,
	fecha_peticion_key int4 NOT NULL,
	fecha_entrega_key int4 NOT NULL,
	tiempo_entrega interval NULL,
	CONSTRAINT peticiones_hechos_fk FOREIGN KEY (proyecto_key) REFERENCES public.proyecto(proyecto_key),
	CONSTRAINT peticiones_hechos_fk_1 FOREIGN KEY (product_owner_key) REFERENCES public.product_owner(product_owner_key),
	CONSTRAINT peticiones_hechos_fk_2 FOREIGN KEY (stake_holder_key) REFERENCES public.stakeholder(stakeholder_key),
	CONSTRAINT peticiones_hechos_fk_3 FOREIGN KEY (fecha_peticion_key) REFERENCES public."time"(time_key),
	CONSTRAINT peticiones_hechos_fk_4 FOREIGN KEY (fecha_entrega_key) REFERENCES public."time"(time_key)
);
>>>>>>> d9eb951440248a07059c68b52715edc3b2688d18
