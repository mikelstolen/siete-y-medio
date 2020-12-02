# PRIORIDAD ES IGUAL A UN NUMERO DEL 1 AL 4
# EN CASO DE EMPATE GANA EL JUGADOR QUE EL NUMERO DE PRIORIDAD SEA MAYOR
import random
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
# MENU DE SELECCIÓN DE MODO DE JUEGO
salir = False
while salir is not True:
    print("SELECCIONA UN MODO DE JUEGO")
    menu_principal = int(input("1) MODO DE JUEGO MANUAL\n2) MODO DE JUEGO HUMANO CONTRA MAQUINA\n3) SALIR\nOPCIÓN: "))
    if menu_principal == 1:
        cantidad_de_jugadores = int(input("\n¿CUANTOS JUGADORES VAIS A JUGAR?\nCANTIDAD: "))
        for c in range(0, cantidad_de_jugadores):
            nombres_jugadores = input("\nINTRODUZCA EL NOMBRE DEL JUGADOR "+str(c+1)+" .\nJUGADORES: ")
            jugadores.append(nombres_jugadores)
        print(jugadores)
    elif menu_principal == 2:
        print("hola")
    elif menu_principal == 3:
        salir = True
    else:
        print("\nSELECCIÓN NO VALIDA VUELVE A INTRODUCIR UN NUMERO\n")
