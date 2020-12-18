from collections import Counter
from Lectura_XML import cartas


# Creación de la lista del mazo con prioridad
def creacion_mazo_prioridad(cartas):
    # Creación de la lista de palos
    palos = []
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


def carta_mayor(listajugadores, jugadores):
    mazo = creacion_mazo_prioridad(cartas)
    #jugador = tuple(jugadores)
    print("jugadores", jugadores)
    cnt = Counter(jugadores)
    print("Agrupa pr numero y numero de repeticiones: ", cnt.most_common())
    maxim = max(cnt)
    count = 0
    index = []
    llista = []
    i = 0
    while i < len(jugadores):
        if str(maxim) == jugadores[i]:
            print('str maxim', maxim)
            count += 1
            print('i', i)
            llista.append(i)
        i += 1
    if count > 0:
        for j in range(len(llista)):
            if listajugadores[llista[j][2]] in mazo:
        index.append(llista)

    print(mazo)
    print(index)
    return listajugadores[jugadores.index(maxim)][0]


"""
for k in range(len(jugadores_sin_orden)):
    if jugadores_sin_orden[k][1][3] > '0.5':
        contador += 1
    if contador > 0:
        # Evalua si hay valores repetidos con la carta de mayor valor
        if max < jugadores_sin_orden[k][1][3]:
            max = jugadores_sin_orden[k][1][3]
            index = k
            palo = jugadores_sin_orden[k][1][2]
    else:
        if max < jugadores_sin_orden[k][1][1]:
            max = jugadores_sin_orden[k][1][1]
            index = k
            palo = jugadores_sin_orden[k][1][2]
    if max == jugadores_sin_orden[k][1][3]:
        for i in range(len(mazo)):
            if mazo[i][2] == palo:
                print(mazo[i])
                preseleccion.append([jugadores_sin_orden[k], mazo[i][1]])

"""