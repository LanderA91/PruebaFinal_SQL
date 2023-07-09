/* PRUEBA SQL- Lander Alvarez */
/**/ /**/ Primera Etapa /**/ /**/

DROP TABLE IF EXISTS peliculas;
DROP TABLE IF EXISTS tags;

CREATE TABLE IF NOT EXISTS tags (
 id INT PRIMARY KEY,
 tag VARCHAR (32)
);

CREATE TABLE IF NOT EXISTS peliculas (
 id INT PRIMARY KEY,
 nombre VARCHAR(255),
 anno INT
);

/* INSERTAR DATOS */

INSERT INTO peliculas(id, nombre, anno) 
VALUES (1,'El viaje de Chihiro',2011),
       (2,'Gremblins',1984),
	   (3,'Harry Potter y la piedra filosofal',2001),
	   (4,'Evangelion',2021),
	   (5,'Duro de matar',1988);
	   
	   
INSERT INTO tags
VALUES (1,'Suspenso'),
       (2,'Acción'),
	   (3,'Animación'),
	   (4,'Ciencia Ficción'),
	   (5,'Aventura');
	   

/*Tabla */

CREATE TABLE IF NOT EXISTS peliculas_tags (
 pelicula_id INT REFERENCES peliculas(id),
 tag_id INT REFERENCES tags(id)
);

INSERT INTO peliculas_tags(pelicula_id,tag_id)
VALUES (1,1),
       (1,2),
	   (1,3),
	   (2,2),
	   (2,4);
	   
/* Contar la cantidad de tags que tiene cada pelicula */

SELECT p.nombre, COUNT (t.tag) cantidad_tags
FROM tags t
JOIN peliculas_tags pt
ON t.id = pt.tag_id
JOIN peliculas p
ON p.id = pt.pelicula_id
GROUP BY p.nombre
;

/**/ /**/ /**/ Segunda Etapa /**/ /**/ /**/

DROP TABLE IF EXISTS Preguntas;
DROP TABLE IF EXISTS Usuarios;

CREATE TABLE IF NOT EXISTS Preguntas (
 id INT PRIMARY KEY,
 pregunta VARCHAR (255),
 respuesta_correcta VARCHAR
);

INSERT INTO Preguntas(id, pregunta, respuesta_correcta)
VALUES (1, '¿Cómo se llama el Director de Hogwarts?','Albus Dumbledore'),
       (2, '¿Cuál es el nombre del primer Gremblin?', 'Gizmo'),
	   (3, '¿Cómo se llama el creador de Evangelion?', 'Hideaki Anno'),
	   (4, '¿Cómo se llama el villano en Duro de Matar 1?', 'Hans Gruber'),
	   (5, '¿Qué estudio creó el Viaje de Chihiro?', 'Estudios Ghibli');
	   
CREATE TABLE IF NOT EXISTS Usuarios (
 id INT PRIMARY KEY,
 nombre VARCHAR(255),
 edad INT
);

INSERT INTO Usuarios (id, nombre, edad)
VALUES (1, 'Francisco',35),
       (2, 'Alejandro',45),
	   (3, 'Samantha',23),
	   (4, 'Sofía',19),
	   (5, 'Fabián',27);

CREATE TABLE IF NOT EXISTS Respuestas (
 id INT PRIMARY KEY,
 respuesta VARCHAR (255),
 usuario_id INT REFERENCES Usuarios(id),
 pregunta_id INT REFERENCES Preguntas (id)
);

INSERT INTO Respuestas (id, respuesta, usuario_id, pregunta_id)
VALUES (1, 'Albus Dumbledore', 1, 1),
       (2, 'Albus Dumbledore', 2, 1),
	   (3, 'Hermione Granger', 3, 2),
	   (4, 'Dominique Humbold', 4, 3),
	   (5, 'Sirius Black', 5, 4);

/* Contar la cantidad de respuestas correctas totales por usuario */

SELECT u.nombre, COUNT(p.respuesta_correcta) respuestas_correctas
FROM Preguntas p
JOIN Respuestas r
ON p.respuesta_correcta = r.respuesta
JOIN Usuarios u
ON r.usuario_id = u.id
GROUP BY u.nombre
;

/* Por cada pregunta en la tabla, contar cuantos usuarios tuvieron respuestas correctas */

SELECT p.pregunta, Count(u.nombre) usuarios_respuesta_correcta
FROM Preguntas p
JOIN Respuestas r
ON p.respuesta_correcta = r.respuesta
JOIN Usuarios u
ON r.usuario_id = u.id
GROUP BY p.pregunta
ORDER BY p.pregunta ASC
;

/* Implementar un borrado en cascada de las respuesta al borrar un usuario y borrar el primer usuario para probar la implementacion */

DROP TABLE ID EXISTS Respuestas;

CREATE TABLE IF NOT EXISTS Respuestas (
 id INT PRIMARY KEY,
 respuesta VARCHAR (255),
 usuario_id INT REFERENCES Usuarios (id) ON DELETE CASCADE,
 pregunta_id INT REFERENCES Preguntas(id)
);

DELETE FROM Usuarios u
WHERE u.id = 1;

SELECT * FROM Usuarios;

/* Crear una restricción a menores de 18 años */

CREATE TABLE IF NOT EXISTS Usuarios (
 id INT PRIMARY KEY,
 nombre VARCHAR (255),
 edad INT CHECK (edad >= 18)
);

INSERT INTO Usuarios(id, nombre, edad)
VALUES (1, 'Matías',12);

/* Alterar la tabla existente de usuarios agregando el campo
email con la restriccion de unico */

ALTER TABLE Usuarios
add column email VARCHAR UNIQUE;

SELECT * FROM Usuarios;

INSERT INTO Usuarios(id, nombre , edad, email)
VALUES (10,'Andrés',18,'andres@example.com');

INSERT INTO Usuarios (id, nombre, edad, email)
VALUES (11,'Andrés',21,'andres@example.com');







	   
	   

	   
