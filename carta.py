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
    cnt = Counter(jugadores)
    # print("Agrupa pr numero y numero de repeticiones: ", cnt.most_common())
    maxim = max(cnt)
    count = 0
    index = []
    llista = []
    i = 0
    while i < len(jugadores):
        if str(maxim) == jugadores[i]:
            count += 1
            llista.append(i)
        i += 1
    if count > 0:
        for j in range(len(llista)):
            for k in range(len(mazo)):
                if listajugadores[llista[j]][1][2] == mazo[k][2]:
                    index.append((listajugadores[llista[j]], mazo[k][1]))
    minim = 9
    ind = 0
    if len(index) > 1:
        for i in range(len(index)):
            if minim > index[i][1]:
                minim = index[i][1]
                ind = index[1][0][0]
        return ind
    else:
        return listajugadores[jugadores.index(maxim)][0]
