"""
PROYECTO SIETE Y MEDIO
AMWS1
PARTICIPANTES:
# Sergio  de la Torre: SDelaTorreSergio.cf@iesesteveterradas.cat
# Angela Maria Hincapié Morales: AHincapieMorales.cf@iesesteveterradas.cat
# Miguel Hurtado Diaz: MHurtadoDiaz.cf@iesesteveterradas.cat
"""


# IMPORTS
import random

# PRIORIDAD ES IGUAL A UN NUMERO DEL 1 AL 4
# EN CASO DE EMPATE GANA EL JUGADOR QUE EL NUMERO DE PRIORIDAD SEA MAYOR
oro = 4
copas = 3
espadas = 2
bastos = 1
mazo = [(1, oro, 1), (2, oro, 2), (3, oro, 3), (4, oro, 4), (5, oro, 5,), (6, oro, 6), (7, oro, 7), (10, oro, 0.5),
        (11, oro, 0.5), (12, oro, 0.5), (1, copas, 1), (2, copas, 2), (3, copas, 3), (4, copas, 4), (5, copas, 5),
        (6, copas, 6), (7, copas, 7), (10, copas, 0.5), (11, copas, 0.5), (12, copas, 0.5), (1, espadas, 1),
        (2, espadas, 2), (3, espadas, 3), (4, espadas, 4), (5, espadas, 5), (6, espadas, 6), (7, espadas, 7),
        (10, espadas, 0.5), (11, espadas, 0.5), (12, espadas, 0.5), (1, bastos, 1), (2, bastos, 2), (3, bastos, 3),
        (4, bastos, 4), (5, bastos, 5), (6, bastos, 6), (7, bastos, 7), (10, bastos, 0.5), (11, bastos, 0.5),
        (12, bastos, 0.5)]
# JUGADORES EN LA SIGUENTE LISTA SE GUARDARAN A LOS JUGADORES
jugadores = []
jugadores_sin_orden = []
dic_jugadores = {}
# MENU DE SELECCIÓN DE MODO DE JUEGO
salir = False
while salir is not True:
    print("SELECCIONA UN MODO DE JUEGO")
    menu_principal = int(input("1) MODO DE JUEGO MANUAL\n2) MODO DE JUEGO HUMANO CONTRA MAQUINA\n3) SALIR\nOPCIÓN: "))
    if menu_principal == 1:
        c = 0
        # LA VARIABLE CANTIDAD_DE_JUGADPRES SIRVER PARA QUE EL PROGRAMA SEPA LA CANTIDAD DE VUELTAS
        # TIENE QUE HACER PARA RECOGER TODOS LOS JUGADORES.
        cantidad_de_jugadores = int(input("\n¿CUANTOS JUGADORES VAIS A JUGAR?\nCANTIDAD: "))
        while c is not cantidad_de_jugadores:
            nombres_jugadores = input("\nINTRODUZCA EL NOMBRE DEL JUGADOR "+str(c+1)+"."
                                      "\n-RECUERDA QUE EL NOMBRE DE JUGADO HA DE TENER SOLO UNA LETRA Y "
                                      "NO PUEDE CONTENER ESPACIOS"
                                      " Y SEGUIDA DE NUMEROS.\nJUGADOR: ")
            # LA SIGUENTE COMPARACIÓN  SIRVE PARA SABER SI LA PRIMERA LETRA ES UNA LETRA DEVUEL EL VALOR TRUE O FALSE
            # LA FUNCIÓN isalpha()
            if nombres_jugadores[0].isalpha() is False:
                print("\n¡HA DE EMPEZAR POR UNA LETRA!\n")
            else:
                # CADA VEZ QUE SE AÑADE UN NOMBRE QUE NO HAGA LA CONDICIÓN SE AÑADIRA COMO LISTA A LA LISTA JUGADORES
                jugadores_sin_orden.append([nombres_jugadores])
                c += 1
        # ESTE BUCLE SIRVE PARA REPARTIR LAS CARTAS A CADA JUGADOR
        i = 1
        while i is not cantidad_de_jugadores+1:
            jugadores_sin_orden[i-1].append(mazo[random.randint(0, len(mazo)-1)])
            i += 1
        # MÉTODO BURBUJA PARA ORDENAR LA LISTA
        # for i in range(len(jugadores_sin_orden) - 1):
        #    for j in range(len(jugadores_sin_orden) - i - 1):
        #        if jugadores_sin_orden[j][j] > jugadores_sin_orden[j + 1][j + 1]:
        #            jugadores_sin_orden[j][j], jugadores_sin_orden[j + 1][j + 1] = jugadores_sin_orden[j + 1][j + 1]
        #            , jugadores_sin_orden[j][j]
        print(jugadores_sin_orden)
        # print(jugadores)

    elif menu_principal == 2:
        print("hola")
    elif menu_principal == 3:
        salir = True
    else:
        print("\nSELECCIÓN NO VALIDA VUELVE A INTRODUCIR UN NUMERO\n")