-- 1 Mostrar la Carta inicial más repetida por cada jugador(mostrar nombre jugador y carta). 

select distinct u.username , concat(c.numero_carta,' ',t.descripcion) as Carta_inicial
from turnos t1
join usuario as u on t1.idparticipante = u.idusuario
join cartas as c on c.idcartas = t1.carta_inicial
join tipo_carta as t on t.idtipo_carta = c.tipo
where carta_inicial = (
	select carta_inicial
    from turnos t2 
    where t1.idparticipante = t2.idparticipante
    group by carta_inicial
    order by count(*) desc
    limit 1 );

-- 2 Jugador que realiza la apuesta más alta por partida. (Mostrar nombre jugador)

select distinct idpartida, u.username, apuesta
from turnos t1
join usuario as u on u.idusuario = t1.idparticipante
where apuesta=(select max(t2.apuesta)
				from turnos t2
				where t1.idpartida=t2.idpartida)
order by idpartida;

-- 3 Jugador que realiza apuesta más baja por partida. (Mostrar nombre jugador)

select distinct idpartida, u.username, apuesta
from turnos t1
join usuario as u on u.idusuario = t1.idparticipante
where apuesta=(select min(t2.apuesta)
				from turnos t2
				where t1.idpartida=t2.idpartida)
order by idpartida;
                 
-- 4 Ratio  de turnos ganados por jugador en cada partida (%),mostrar columna Nombre jugador, Nombre partida, nueva columna "porcentaje %"

select u.username, p.nombre_sala
from turnos t
join usuario as u on u.idusuario = t.idparticipante
join partida as p on p.idpartida = t.idpartida;

-- 5 Porcentaje de partidas ganadas Bots en general. Nueva columna "porcentaje %"
-- 6 Mostrar los datos de los jugadores y el tiempo que han durado sus partidas ganadas cuya puntuación obtenida es mayor que la media puntos de las partidas ganadas totales.

select u.*, p.idpartida, p.hora_fin
from usuario u
join participante as n on n.id_participante = u.idusuario
join partida as p on p.idpartida = n.id_partida;

select *
from partida;

-- 7 Cuántas rondas se ganan en cada partida según el palo. Ejemplo: Partida 1 - 5 rondas - Bastos como carta inicial.
-- 8 Cuantas rondas gana la banca en cada partida.
-- 9 Cuántos usuarios han sido la banca en
-- 10 Partida con la puntuación más alta final de todos los jugadores, mostrar nombre jugador, nombre partida,así como añadir una columna nueva en la que diga si ha ganado la partida o no.
-- 11 Calcular la apuesta media por partida.

select idpartida, round(avg(apuesta),2)
from turnos t1
group by idpartida;
                 
-- 12 Mostrar los datos de los usuarios que no son bot, así como cual ha sido su última apuesta en cada partida que ha jugado.
-- 13 Calcular el valor total de las cartas y el numero total de cartas que se han dado inicialmente en las manos en la partida. Por ejemplo, en la partida se han dado 50 cartas y el valor total de las cartas es 47,5.
-- 14 Diferencia de puntos de los participantes de las partidas entre la ronda 1 y 5. Ejemplo: Rafa tenia 20 puntos, en la ronda 5 tiene 15, tiene -5 puntos de diferencia.
