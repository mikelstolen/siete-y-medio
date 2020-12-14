"""
PROYECTO SIETE Y MEDIO
AMWS1
PARTICIPANTES:
# Sergio  de la Torre: SDelaTorreSergio.cf@iesesteveterradas.cat
# Angela Maria Hincapié Morales: AHincapieMorales.cf@iesesteveterradas.cat
# Miguel Hurtado Diaz: MHurtadoDiaz.cf@iesesteveterradas.cat
"""


# IMPORTS
import Connection_BBDD
import random

# Llamo al archivo de conexión de la BBDD
Connection_BBDD.coneccion_BBDD()

# Lectura del archivo XML
from Lectura_XML import cartas

# Creación de la lista de palos
palos = []
palo = ""
index = 0
j = 0

for i in range(len(cartas)):
    palo = cartas[i][2]
    if len(palos) == 0:
        if palo == 'Oros':
            index += 1
            palos.append([index, 4, palo])
        if palo == 'Copas':
            index += 1
            palos.append([index + 1, 3, palo])
        if palo == 'Espadas':
            index += 1
            palos.append([index + 1, 2, palo])
        if palo == 'Bastos':
            index += 1
            palos.append([index, 1, palo])
    while j in range(len(palos)):
        if palo not in palos[j][2]:
            if palo == 'Oros':
                index += 1
                palos.append([index, 4, palo])
            if palo == 'Copas':
                index += 1
                palos.append([index, 3, palo])
            if palo == 'Espadas':
                index += 1
                palos.append([index, 2, palo])
            if palo == 'Bastos':
                index += 1
                palos.append([index, 1, palo])
        else:
            break
        j += 1

# Variables flags
flag_menuPrincipal, flag_menuUsuarioR, flag_menuJuegoNormal, flag_menuJuegoBots, flag_menuUsuarioNR, \
 flag_menuInformes, flag_submenuPrincipal = False, False, False, False, False, False, False

# JUGADORES EN LA SIGUENTE LISTA SE GUARDARAN A LOS JUGADORES
jugadores_sin_orden = []
dic_jugadores = {}
salir = False
logged_user = []

# MENU PRINCIPAL FUNCIONES GENERALES
while not flag_menuPrincipal:
    print("_" * 70)
    print("{:^70}".format("BIENVENID@ AL JUEGO - SIETE Y MEDIO"))
    print("_" * 70)
    print(" Menu Principal: ")
    menu_principal = int(input("\t1. Usuarios registrados\n\t2. Usuarios no registrados\n\t3. Informes\n\t4. Salir\n\t"
                               "Escriba su opcion: "))
    if menu_principal == 1:
        print("_" * 70)
        print("{:^70}".format("USUARIOS REGISTRADOS"))
        print("_" * 70)
        print(" Menu Usuarios Registrados: ")
        flag_menuPrincipal = True
        flag_menuJuegoNormal = True
        flag_menuJuegoBots = True
        flag_menuUsuarioNR = True
        flag_menuInformes = True
        flag_submenuPrincipal = True
        flag_menuUsuarioR = False
    elif menu_principal == 2:
        print("_" * 70)
        print("{:^70}".format("USUARIOS NO REGISTRADOS"))
        print("_" * 70)
        flag_menuPrincipal = True
        flag_menuJuegoNormal = True
        flag_menuJuegoBots = True
        flag_menuUsuarioR = True
        flag_menuInformes = True
        flag_submenuPrincipal = True
        flag_menuUsuarioNR = False
    elif menu_principal == 3:
        print("_" * 70)
        print("{:^70}".format("INFORMES"))
        print("_" * 70)
        print(" Menu Informes: ")
        flag_menuPrincipal = True
        flag_menuJuegoNormal = True
        flag_menuJuegoBots = True
        flag_menuUsuarioR = True
        flag_menuUsuarioNR = True
        flag_submenuPrincipal = True
        flag_menuInformes = False
    elif menu_principal == 4:
        break

    # MENU USUARIOS REGISTRADOS
    while flag_menuPrincipal and not flag_menuUsuarioR:
        menu_Usuario = int(input("\t1. Logueate...\n\t2. Lista de usuarios\n\t3. Busca un usuario\n\t"
                                 "4. Volver al menu principal\n\tEscriba su opción: "))
        if menu_Usuario == 1:
            print("_" * 70)
            print("{:^70}".format("LOGGING"))
            print("_" * 70)
            logged_user = Connection_BBDD.loggin_user()
            if len(logged_user) == 0:
                input("Presione ENTER para continuar....")
                flag_menuUsuarioR = True
                flag_menuPrincipal = False
            else:
                res = input("Deseas añadir tu usuario como jugador? S o N: ")
                if res.lower() == 's':
                    Connection_BBDD.insert_player(logged_user)
                    flag_menuUsuarioR = True
                    flag_menuPrincipal = True
                    flag_submenuPrincipal = False
                else:
                    print("IMPORTANTE: No podrás iniciar una partida, logueate de nuevo!")
                input("Presione ENTER para continuar....")

        elif menu_Usuario == 2:
            print("_" * 70)
            print("{:^70}".format("LISTADO DE USUARIOS REGISTRADOS"))
            print("_" * 70)
            list_user = Connection_BBDD.user_list()
            input("Presione ENTER para continuar....")
            flag_menuUsuarioR = True
            flag_menuPrincipal = False
            print("hola")
        elif menu_Usuario == 3:
            print("_" * 70)
            print("{:^70}".format("BUSCA UN USUARIO"))
            print("_" * 70)
            Connection_BBDD.searching_user()
            input("Presione ENTER para continuar....")
            flag_menuUsuarioR = True
            flag_menuPrincipal = False
        elif menu_Usuario == 4:
            flag_menuPrincipal = False
            flag_menuUsuarioR = True
        else:
            print("Opción no valida!!!")
            input("Presione ENTER para continuar....")
    # USUARIOS NO REGISTRADOS
    while flag_menuPrincipal and not flag_menuUsuarioNR:
        Connection_BBDD.insert_usuario()
        flag_menuUsuarioNR = True
        flag_menuPrincipal = False
        input("Presione ENTER para continuar....")

    # MENU INFORMES PARA GENERAR XML
    while flag_menuPrincipal and not flag_menuInformes:
        menu_Informes = int(input("\t1. Usuarios\n\t2. Partida\n\t3. Banca\n\t4. Volver al menu principal\n\t"
                                  "Escriba su opción"))
        if menu_Informes == 1:
            print("_" * 70)
            print("{:^70}".format("INFORMES POR JUGADOR"))
            print("_" * 70)
            submenu_Informes = int(
                input("\t1. Carta inicial más repetida por cada usuario.\n\t2. Mostrar el porcentaje de partidas que "
                      "ganan los jugadores en función del orden que tienen en la partida.\n\t3. Mostrar los datos de "
                      "los jugadores y el tiempo que han durado sus partidas ganadas cuya puntuación obtenida es mayor "
                      "que la media de puntos de las partidas ganadas totales.\n\t4. Mostrar los datos de los usuarios,"
                      " así como cual ha sido su última apuesta en cada partida que ha jugado.\n\t5. Volver al menu "
                      "principal.\n\tEscriba su opción"))
        elif menu_Informes == 2:
            print("_" * 70)
            print("{:^70}".format("INFORMES POR PARTIDAS"))
            print("_" * 70)
            submenu_Informes = int(
                input("\t1. Jugador que realiza la apuesta más alta por partida.\n\t2. Jugador que realiza apuesta más "
                      "baja por partida.\n\t3. Ratio de turnos ganados por jugador en cada partida( %)\n\t4. Apuesta "
                      "media de cada partida.\n\t5. Calcular el valor total de las cartas y el número total de cartas "
                      "que se han dado inicialmente en las manos en cada partida\n\t6. Diferencia de puntos de los "
                      "participantes de las partidas por cada ronda\n\t7. Porcentaje de partidas ganadas por Bots\n\t"
                      "8. Cuántas rondas se ganan en cada partida según el palo.\n\t9. Volver al menu principal"
                      "\n\tEscriba su opción"))
        elif menu_Informes == 3:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
            submenu_Informes = int(
                input("\t1. Cuantas rondas gana la banca en cada partida.\n\t2. Cuántos usuarios han sido la banca en "
                      "una partida con la puntuación más alta de todos los jugadores\n\t3. Volver al menu principal"
                      "\n\tEscriba su opción"))
        elif menu_Informes == 4:
            flag_menuInformes = True
            flag_menuPrincipal = False
            break

        else:
            print("Opción no valida!")
            input("Presione ENTER para continuar....")

    # MENU SUBMENU PRINCIPAL MODO DE JUEGO
    while flag_menuPrincipal and flag_menuUsuarioR and not flag_submenuPrincipal:
        print("_" * 70)
        print("{:^70}".format("SUBMENU PRINCIPAL: MODO DE JUEGO"))
        print("_" * 70)
        print(" Selecciona un modo de juego: ")
        submenu_principal = int(input("\t1. Todos los jugadores humanos\n\t2. Jugador Humano contra Bots\n\t3) Volver "
                                      "al menu principal\n\tEscriba su opción: "))
        if submenu_principal == 1:
            print("_" * 70)
            print("{:^70}".format("MODO DE JUEGO NORMAL: JUGADORES HUMANOS"))
            print("_" * 70)
            counter = 0
            cantidad_de_jugadores = int(input("¿Añade cantidad de jugadores: "))
            while counter is not cantidad_de_jugadores:
                jugadores = Connection_BBDD.searching_player()
                cartaInicial = random.choice(cartas)
                jugadores_sin_orden.append([jugadores, cartaInicial])
                counter += 1
            print(jugadores_sin_orden)
            """
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
        """
        elif submenu_principal == 2:
            print("_" * 70)
            print("{:^70}".format("MODO DE JUEGO AUTOMÁTICO: JUGADOR HUMANO CONTRA BOTS"))
            print("_" * 70)
            input("Presione ENTER para continuar....")
        elif submenu_principal == 3:
            input("Presione ENTER para continuar....")
            flag_submenuPrincipal = True
            flag_menuPrincipal = False
        else:
            print("Opción no valida!!!")
            input("Presione ENTER para continuar....")
