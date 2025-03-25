--Escuela
CREATE TYPE genero AS ENUM ('Masculino','Femenino');

CREATE TABLE personas(
	id_persona SERIAL PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
    primerapellido VARCHAR(30) NOT NULL,
    segundoapellido VARCHAR(30) NOT NULL DEFAULT '---' ,
    genero genero,
    ciudad VARCHAR(30),
    delegacion_municipio VARCHAR(30),
    direccion VARCHAR(100),
    fecha_nacimiento DATE,
    telefono VARCHAR(50),
    correo VARCHAR(30)
);

CREATE TABLE docente(
	id_profesor SERIAL PRIMARY KEY,
	id_persona SERIAL,
    grado_academico VARCHAR(30) NOT NULL,
    area_especialidad VARCHAR(100) NOT NULL DEFAULT '---',
    numero_docente VARCHAR(100),
	CONSTRAINT fk_persona_docentes FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

CREATE TABLE estudiantes (
    id_estudiante SERIAL PRIMARY KEY,
	id_persona SERIAL,
    id_boleta BIGINT UNIQUE CHECK (id_boleta >= 2019000000),
	CONSTRAINT fk_persona_estudiantes FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

CREATE TABLE Plantel (
    id_plantel SERIAL PRIMARY KEY,
    clave_plantel VARCHAR(50),
    nombre_plantel VARCHAR(100)
);

CREATE TABLE carrera(
    id_carrera SERIAL PRIMARY KEY,
	id_plantel SERIAL,
    clave_carrera VARCHAR(50),
    nombre_carrera VARCHAR(100),
	CONSTRAINT fk_carrera_pantel FOREIGN KEY (id_plantel) REFERENCES Plantel(id_plantel)
);

CREATE TABLE materia(
	id_materia SERIAL PRIMARY KEY,
	id_carrera SERIAL,
	clave varchar(4) NOT NULL,
	nombre_materia varchar(50) NOT NULL,
	creditos float NOT NULL,
	semestre int,
	academia varchar(60),
	CONSTRAINT fk_materia_carrera FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera)
);

CREATE TABLE estudiante_materia(
	id_materia	SERIAL,
	id_boleta BIGINT,
	calificacion DOUBLE PRECISION,
	CONSTRAINT fk_materia_estudiantes FOREIGN KEY (id_materia) REFERENCES materia(id_materia),
	CONSTRAINT fk_estudiantes_materia FOREIGN KEY (id_boleta) REFERENCES estudiantes(id_boleta)
);

CREATE TABLE aula(
    id_aula SERIAL PRIMARY KEY,
    nombre_aula VARCHAR(4),
    tipo VARCHAR(20),
    capacidad INT
);


CREATE TABLE horarios(
	id_horario SERIAL PRIMARY KEY,
	id_materia SERIAL,
	id_aula SERIAL,
    dia VARCHAR(20),
    hora_inicio TIME,
    hora_fin TIME,
	CONSTRAINT fk_horario_materia FOREIGN KEY (id_materia) REFERENCES materia(id_materia),
	CONSTRAINT fk_horario_aula FOREIGN KEY (id_aula) REFERENCES aula(id_aula)
);

CREATE TABLE grupos(
	id_grupo SERIAL PRIMARY KEY,
	id_profesor SERIAL,
	id_materia SERIAL,
	grupo varchar(4) NOT NULL,
	numero_estudiantes INT NOT NULL,
	CONSTRAINT fk_grupos_profesor FOREIGN KEY (id_profesor) REFERENCES docente(id_profesor),
	CONSTRAINT fk_grupos_materia FOREIGN KEY (id_materia) REFERENCES materia(id_materia)
);
