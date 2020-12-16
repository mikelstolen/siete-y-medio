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

# Variables flags
flag_menuPrincipal, flag_menuUsuarioR, flag_menuJuegoNormal, flag_menuJuegoBots, flag_menuUsuarioNR, \
 flag_menuInformes, flag_submenuPrincipal = False, False, False, False, False, False, False

# VARIABLES
jugadores_sin_orden = []
dic_jugadores = {}
logged_user = []

# FUNCIONES


# Creación de la lista del mazo con prioridad
def creacion_mazo_prioridad(cartas):
    # Creación de la lista de palos
    palos = []
    # palo = ""
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
    return palos

print(cartas)
print(creacion_mazo_prioridad(cartas))
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
            print(logged_user)
            if logged_user is None:
                res = input("Deseas registrarte como usuario? S or N")
                if res.lower() == 's':
                    Connection_BBDD.insert_usuario()
                    break
                else:
                    flag_menuUsuarioR = True
                    flag_menuPrincipal = True
                    input("Presione ENTER para continuar....")
                break
            else:
                id_jugador = Connection_BBDD.searching_player(logged_user)
                if id_jugador is None:
                    Connection_BBDD.insert_player(id_jugador)
                else:
                    flag_menuUsuarioR = True
                    flag_menuPrincipal = True
                    flag_submenuPrincipal = False
                    input("Presione ENTER para continuar....")

        elif menu_Usuario == 2:
            print("_" * 70)
            print("{:^70}".format("LISTADO DE USUARIOS REGISTRADOS"))
            print("_" * 70)
            list_user = Connection_BBDD.user_list()
            input("Presione ENTER para continuar....")
            flag_menuUsuarioR = True
            flag_menuPrincipal = False
        elif menu_Usuario == 3:
            print("_" * 70)
            print("{:^70}".format("BUSCA UN USUARIO"))
            print("_" * 70)
            trobat = Connection_BBDD.searching_user()
            if trobat:
                logged_user = Connection_BBDD.loggin_user()
            else:
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
        menu_Informes = int(input("\t1.  Carta inicial más repetida por cada jugador.\n\t2.  Jugador que realiza la "
                                  "apuesta más alta por partida.\n\t3.  Jugador que realiza apuesta más baja por "
                                  "partida.\n\t4.  Ratio de turnos ganados por jugador en cada partida( %)\n\t5.  "
                                  "Porcentaje de partidas ganadas por Bots.\n\t6.  Mostrar los datos de los jugadores y"
                                  " el tiempo que han \n\t    durado sus partidas ganadas cuya puntuación obtenida es "
                                  "\n\t    mayor que la media de puntos de las partidas ganadas totales.\n\t7.  Cuántas"
                                  " rondas se ganan en cada partida según el palo.\n\t8.  Cuantas rondas gana la banca "
                                  "en cada partida.\n\t9.  Cuántos usuarios han sido la banca.\n\t10. Partida con la "
                                  "puntuación más alta de todos los jugadores\n\t11. Apuesta media por cada partida."
                                  "\n\t12. Mostrar los datos de los usuarios, así como cual ha sido su \n\t    última "
                                  "apuesta en cada partida que ha jugado.\n\t13. Calcular el valor total de las "
                                  "\n\t    cartas y el número total de cartas que se han dado \n\t    inicialmente en "
                                  "las manos en la partida\n\t14. Diferencia de puntos de los participantes de las "
                                  "partidas\n\t    entre la ronada 1 al 5.\n\t15. Volver al menu principal.\nEscriba "
                                  "su opción: "))
        if menu_Informes == 1:
            print("_" * 70)
            print("{:^70}".format("INFORME CARTA INICIAL MAS REPETIDA"))
            print("_" * 70)
            import carta_Inicial
            input("Presione ENTER para continuar....")
        elif menu_Informes == 2:
            print("_" * 70)
            print("{:^70}".format("INFORMES"))
            print("_" * 70)
        elif menu_Informes == 3:
            print("_" * 70)
            print("{:^70}".format("INFORMES"))
            print("_" * 70)
        elif menu_Informes == 4:
            print("_" * 70)
            print("{:^70}".format("INFORMES"))
            print("_" * 70)
        elif menu_Informes == 5:
            print("_" * 70)
            print("{:^70}".format("INFORMES"))
            print("_" * 70)
        elif menu_Informes == 6:
            print("_" * 70)
            print("{:^70}".format("INFORMES"))
            print("_" * 70)
        elif menu_Informes == 7:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
        elif menu_Informes == 8:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
        elif menu_Informes == 9:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
        elif menu_Informes == 10:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
        elif menu_Informes == 11:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
        elif menu_Informes == 12:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
        elif menu_Informes == 13:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
        elif menu_Informes == 14:
            print("_" * 70)
            print("{:^70}".format("INFORMES BANCA"))
            print("_" * 70)
        elif menu_Informes == 15:
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
            counter = 1
            cantidad_de_jugadores = int(input("¿Añade cantidad de jugadores: "))
            # Añadimos las cartas activas
            cartaActiva = []
            cartaInicial = []
            i= 0
            while i < len(cartas):
                if cartas[i][4] == 'SI':
                    cartaActiva.append(cartas[i])
                i += 1
            j = 0
            print(cartaActiva)
            while j < cantidad_de_jugadores:
                aleatorio = random.randint(0, 39)
                print(aleatorio)
                cartaInicial.append((cartaActiva[aleatorio]))
                cartaActiva.pop(aleatorio)
                j += 1

            # Añadimos primero al jugador logueado
            jugadores_sin_orden.append((logged_user, cartaInicial[0]))
            # Añadir el resto de jugadores
            while counter is not cantidad_de_jugadores:
                jugadores = Connection_BBDD.searching_user()
                jugadores_sin_orden.append((jugadores, cartaInicial[counter]))
                counter += 1
            print("1", jugadores_sin_orden)
            mazo = creacion_mazo_prioridad(cartaActiva)
            max = '0'
            for k in range(len(jugadores_sin_orden)):
                if max < jugadores_sin_orden[k][1][3]:
                    max = jugadores_sin_orden[k][1][3]
                    index = k

            print("La banca es el juegador {}: ".format(jugadores_sin_orden[index][0]))
            
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
        """