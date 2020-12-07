DROP DATABASE IF EXISTS sieteymedio;
CREATE DATABASE sieteymedio CHARACTER SET utf8mb4;
USE sieteymedio;
 
CREATE TABLE juego (
    ID_juego INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom_juego VARCHAR(20) NOT NULL,
	num_min_jugadores INT(2) UNSIGNED NOT NULL,
	num_max_jugadores INT(2) UNSIGNED NOT NULL,
	desc_reglas_victoria VARCHAR(70) NOT NULL,
	desc_reglas_derrota VARCHAR(70) NOT NULL,
	apuesta_min INT(2) UNSIGNED NOT NULL,
	apuesta_max INT(2) UNSIGNED NOT NULL
);

CREATE TABLE palo (
    ID_palo INT UNSIGNED PRIMARY KEY,
    prioridad TINYINT (1)UNSIGNED NOT NULL,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE carta (
    ID_carta INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    valor_juego FLOAT(1,1) UNSIGNED,
    valor_real VARCHAR(1) NOT NULL,
    activa BOOLEAN NOT NULL,
	id_juego INT UNSIGNED NOT NULL,
	id_palo INT UNSIGNED NOT NULL,
	FOREIGN KEY(id_palo) REFERENCES palo(ID_palo),
    FOREIGN KEY(id_juego) REFERENCES juego(ID_juego)
);
 
CREATE TABLE jugadores (
    ID_usuario VARCHAR(10) PRIMARY KEY,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
	id_juego INT UNSIGNED NOT NULL,
    FOREIGN KEY(id_juego) REFERENCES juego(ID_juego)
);
 
CREATE TABLE participantes (
    ID_participantes INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	tipo ENUM('Humano','Bot') NOT NULL,
	puntuacion_inicial INT(2) UNSIGNED NOT NULL,
	puntuacion_final INT(2) UNSIGNED NOT NULL,
	orden_jugador TINYINT(1) UNSIGNED NOT NULL,
	carta_inicial INT UNSIGNED NOT NULL,
	id_jugador VARCHAR(10) NOT NULL,
	FOREIGN KEY(carta_inicial) REFERENCES carta(ID_carta),
	FOREIGN KEY(id_jugador) REFERENCES jugadores(ID_usuario)	
);

CREATE TABLE banca (
	ID_banca INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	id_participante INT UNSIGNED NOT NULL,
	carta_inicial INT UNSIGNED NOT NULL,
	puntuacion_final INT(2) UNSIGNED NOT NULL,
	FOREIGN KEY(id_participante) REFERENCES participantes(ID_participantes),
	FOREIGN KEY(carta_inicial) REFERENCES carta(ID_carta)
);

CREATE TABLE partida (
	ID_partida INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	apuesta_inicial INT(2) UNSIGNED NOT NULL,
	num_jugadores INT(2) UNSIGNED NOT NULL,
	condiciones_partida VARCHAR(30) NOT NULL,
	hora_inicio TIMESTAMP NOT NULL,
	hora_fin TIMESTAMP NOT NULL,
	resultado_partida INT UNSIGNED NOT NULL,
	turnos_jugados INT(2) NOT NULL,
	FOREIGN KEY(resultado_partida) REFERENCES participantes(ID_participantes)
);


CREATE TABLE turnos (
    ID_turno INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    apuesta_min INT(2) UNSIGNED NOT NULL,
	apuesta_max INT(2) UNSIGNED NOT NULL,
    num_jugadores INT(2) UNSIGNED NOT NULL,
	carta_inicial INT UNSIGNED NOT NULL,
	ganador INT UNSIGNED NOT NULL,
	id_partida INT UNSIGNED NOT NULL,
	FOREIGN KEY(carta_inicial) REFERENCES carta(ID_carta),
	FOREIGN KEY(ganador) REFERENCES participantes(ID_participantes),
	FOREIGN KEY(id_partida) REFERENCES partida(ID_partida)
);

CREATE TABLE acciones (
	ID_accion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	accion ENUM('Robar', 'Pasar') NOT NULL,
	id_carta INT UNSIGNED NOT NULL,
	id_participante INT UNSIGNED NOT NULL,
	id_turno INT UNSIGNED NOT NULL,
	FOREIGN KEY(id_carta) REFERENCES carta(ID_carta),
	FOREIGN KEY(id_participante) REFERENCES participantes(ID_participantes),
	FOREIGN KEY(id_turno) REFERENCES turnos(ID_turno)
)