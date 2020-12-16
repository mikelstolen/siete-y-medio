# IMPORTS
import pymysql


def coneccion_BBDD():
    """
    # Conexión de base de datos
    host = "siete-y-medio-database.crlfhugmgplp.us-east-1.rds.amazonaws.com"
    # Usuario de la conexión
    user = "admin"
    # Contraseña
    passwd = "123321ase"
    # Nombre de la base de datos a la cual nos vamos a conectar
    BBDD = "siete-y-medio-database"
    db = pymysql.connect(host, user, passwd, BBDD)
    # Este cursor lo usamos para ejecutar la query y almacenar sus datos
    cursor = db.cursor()
    # ejecuta el SQL query usando el metodo execute().
    cursor.execute("SELECT VERSION()")
    # procesa una unica linea usando el metodo fetchone().
    data = cursor.fetchone()
    print("Database version : {0}".format(data))
    # desconecta el servidor
    db.close()
    """
    # Conexión de base de datos
    host = "localhost"
    # Usuario de la conexión
    user = "root"
    # Contraseña
    passwd = "root"
    # Nombre de la base de datos a la cual nos vamos a conectar
    BBDD = "proyecto"
    db = pymysql.connect(host, user, passwd, BBDD)
    # Este cursor lo usamos para ejecutar la query y almacenar sus datos
    cursor = db.cursor()
    # ejecuta el SQL query usando el metodo execute().
    cursor.execute("SELECT VERSION()")
    # procesa una unica linea usando el metodo fetchone().
    data = cursor.fetchone()
    print("Database version : {0}".format(data))
    # desconecta el servidor
    db.close()


# insert-sql= "insert into usuario (idusuario,username,password,email) values(id_Usuario, username, paswd, email)
def insert_usuario():
    try:
        # Conexión a la BBDD
        host = "localhost"
        user = "root"
        passwd = "root"
        BBDD = "proyecto"
        db = pymysql.connect(host, user, passwd, BBDD)
        cursor = db.cursor()
        # MYSQL data INSERTS
        insert_sql = "INSERT INTO usuario (idusuario,username,password,email) VALUES(%s,%s,%s,%s)"
        # MYSQL data QUERY: Toma el ultimo valor de la clave principal de la tabla usuarios.
        query_sql = "SELECT MAX(idusuario) FROM proyecto.usuario"
        cursor.execute(query_sql)
        result = cursor.fetchone()
        id_usuario = int(result[0])+1
        username = "1"
        # Comprobación de que se inserta el formato correcto del campo username
        while username[0].isalpha() is False:
            username = input("Ingresa tu nombre de usuario: ")
            if username[0].isalpha() is False:
                print("¡El nombre de usuario debe empezar por una letra...!")
        paswd = input("Ingresa tu contraseña: ")
        email = input("Ingresa tu Email: ")
        # Guardamos los datos en una tupla
        recordTuple = (id_usuario, username, paswd, email)
        cursor.execute(insert_sql, recordTuple)
        # Enviamos los datos a la BBDD
        db.commit()
        print("** Record inserted successfully into usuario table **")
    except pymysql.err.ProgrammingError:
        print("Error: Unable to insert data!!")
    finally:
        # Cerramos la BBDD
        if db.open is True:
            cursor.close()
            db.close()
            print("MySQL connection is closed...")


# query-sql= "SELECT * FROM proyecto.usuario - Comprueba que el usuario este registrado en la BBDD
def loggin_user():
    try:
        # Conexión a la BBDD
        host = "localhost"
        user = "root"
        passwd = "root"
        BBDD = "proyecto"
        db = pymysql.connect(host, user, passwd, BBDD)
        cursor = db.cursor()
        # MYSQL data QUERY: Buscar el usuario
        query_sql = "SELECT * FROM proyecto.usuario"
        cursor.execute(query_sql)
        results = cursor.fetchall()
        result = list(results)
        username = input("Nombre de usuario: ")
        paswd = input("Contraseña: ")
        # Ordenacion bombolla vector
        for i in range(len(result) - 1):
            for j in range(len(result) - 1):
                if (result[j][1]).lower() > (result[j + 1][1]).lower():
                    result[j], result[j+1] = result[j+1], result[j]
        # Cerca Binaria
        inf = 0
        sup = len(result) - 1
        trobat = False

        while not trobat and inf <= sup:
            medio = int((sup + inf) / 2)
            if (result[medio][1]).lower() == username.lower():
                trobat = True
                index = medio
            if (result[medio][1]).lower() < username.lower():
                inf = medio + 1
            else:
                sup = medio - 1
        counter = 0
        if trobat:
            while paswd != result[index][2] and counter == 3:
                print("Contraseña incorrecta!!!")
                counter += 1
                print("Intento {} de 3".format(counter))
            else:
                print("Bienvenido de nuevo {}!!!".format(username))
                usuario = result[index][0]
                return usuario
        else:
            print("Lo sentimos el usuario {} no ha sido encontrado!!!".format(username))
    except pymysql.err.ProgrammingError:
        print("Error: Unable to look for data!!")
    finally:
        # Cerramos la BBDD
        if db.open is True:
            cursor.close()
            db.close()
            print("MySQL connection is closed...")


# Query MySQL: Listado de Usuarios
def user_list():
    try:
        # Conexión a la BBDD
        host = "localhost"
        user = "root"
        passwd = "root"
        BBDD = "proyecto"
        db = pymysql.connect(host, user, passwd, BBDD)
        cursor = db.cursor()
        # MYSQL data QUERY: Buscar el usuario
        query_sql = "SELECT * FROM proyecto.usuario"
        cursor.execute(query_sql)
        results = cursor.fetchall()
        result = list(results)
        print(" ID \tUSERNAME\tPASSWORD\tEMAIL")
        for i in range(len(result)):
            if len(result[i][1]) >= 8:
                print("{}\t\t{}\t{}\t\t{}".format(result[i][0], result[i][1], result[i][2], result[i][3]))
            else:
                print("{}\t\t{}\t\t{}\t\t{}".format(result[i][0], result[i][1], result[i][2], result[i][3]))

        res = input("Desea ordenar la lista? S or N:\t")
        if res.lower() == 's':
            ord = int(input("\t1. Ordenar por usuario.\n\t2. Ordenar por Email\nEscoja su opción: "))
            if ord == 1:
                # Ordenacion bombolla vector
                for i in range(len(result) - 1):
                    for j in range(len(result) - 1):
                        if (result[j][1]).lower() > (result[j + 1][1]).lower():
                            result[j], result[j+1] = result[j+1], result[j]
                print(" ID \tUSERNAME\tPASSWORD\tEMAIL")
                for i in range(len(result)):
                    if len(result[i][1]) >= 8:
                        print("{}\t\t{}\t{}\t\t{}".format(result[i][0], result[i][1], result[i][2], result[i][3]))
                    else:
                        print("{}\t\t{}\t\t{}\t\t{}".format(result[i][0], result[i][1], result[i][2], result[i][3]))
            if ord == 2:
                # Ordenacion bombolla vector
                for i in range(len(result) - 1):
                    for j in range(len(result) - 1):
                        if (result[j][3]).lower() > (result[j + 1][3]).lower():
                            result[j], result[j + 1] = result[j + 1], result[j]
                print(" ID \tUSERNAME\tPASSWORD\tEMAIL")
                for i in range(len(result)):
                    if len(result[i][1]) >= 8:
                        print("{}\t\t{}\t{}\t\t{}".format(result[i][0], result[i][1], result[i][2], result[i][3]))
                    else:
                        print("{}\t\t{}\t\t{}\t\t{}".format(result[i][0], result[i][1], result[i][2], result[i][3]))
    except pymysql.err.ProgrammingError:
        print("Error: Unable to list data!!")
    finally:
        # Cerramos la BBDD
        if db.open is True:
            cursor.close()
            db.close()
            print("MySQL connection is closed...")


# query-sql= "SELECT * FROM proyecto.usuario" - Searching for user
def searching_user():
    try:
        # Conexión a la BBDD
        host = "localhost"
        user = "root"
        passwd = "root"
        BBDD = "proyecto"
        db = pymysql.connect(host, user, passwd, BBDD)
        cursor = db.cursor()
        # MYSQL data QUERY: Buscar el usuario
        query_sql = "SELECT * FROM proyecto.usuario"
        cursor.execute(query_sql)
        results = cursor.fetchall()
        result = list(results)
        username = input("Nombre de usuario: ")
        # Ordenacion bombolla vector
        for i in range(len(result) - 1):
            for j in range(len(result) - 1):
                if (result[j][1]).lower() > (result[j + 1][1]).lower():
                    result[j], result[j+1] = result[j+1], result[j]
        # Cerca Binaria
        inf = 0
        sup = len(result) - 1
        trobat = False

        while not trobat and inf <= sup:
            medio = int((sup + inf) / 2)
            if (result[medio][1]).lower() == username.lower():
                trobat = True
                index = medio
            if (result[medio][1]).lower() < username.lower():
                inf = medio + 1
            else:
                sup = medio - 1
        counter = 0
        if trobat:
            print("Usuario encontrado {}!!!".format(username))
            return trobat
        else:
            print("Lo sentimos el usuario {} no ha sido encontrado!!!".format(username))
    except pymysql.err.ProgrammingError:
        print("Error: Unable to look for data!!")
    finally:
        # Cerramos la BBDD
        if db.open is True:
            cursor.close()
            db.close()
            print("MySQL connection is closed...")


# Insert_SQL: Añadir usuario a tabla de jugadores
def insert_player(id_user):
    try:
        # Conexión a la BBDD
        host = "localhost"
        user = "root"
        passwd = "root"
        BBDD = "proyecto"
        db = pymysql.connect(host, user, passwd, BBDD)
        cursor = db.cursor()
        # MYSQL data INSERTS
        insert_sql = "INSERT INTO jugador (idjugador,idusuario,idbot) VALUES(%s,%s,%s)"
        # MYSQL data QUERY: Toma el ultimo valor de la clave principal de la tabla jugador.
        query_sql = "SELECT MAX(idjugador) FROM proyecto.jugador"
        cursor.execute(query_sql)
        result = cursor.fetchone()
        id_jugador = int(result[0])+1
        usuario = id_user
        id_bot = None
        # Guardamos los datos en una tupla
        recordTuple = (id_jugador, usuario, id_bot)
        cursor.execute(insert_sql, recordTuple)
        # Enviamos los datos a la BBDD
        db.commit()
        print("** Record inserted successfully into player table **")
        return id_jugador
    except pymysql.err.ProgrammingError:
        print("Error: Unable to insert data!!")
    finally:
        # Cerramos la BBDD
        if db.open is True:
            cursor.close()
            db.close()
            print("MySQL connection is closed...")


# Query_SQL: "SELECT * FROM proyecto.jugador WHERE idusuario = id_usuario
def searching_player(logged_user):
    try:
        # Conexión a la BBDD
        host = "localhost"
        user = "root"
        passwd = "root"
        BBDD = "proyecto"
        db = pymysql.connect(host, user, passwd, BBDD)
        cursor = db.cursor()
        id_usuario = logged_user
        # MYSQL data QUERY: Buscar al jugador
        query_sql = "SELECT * FROM proyecto.jugador"
        cursor.execute(query_sql)
        results = cursor.fetchall()
        result = list(results)
        # Ordenacion bombolla vector
        for i in range(len(result) - 1):
            for j in range(len(result) - 1):
                if str(result[j][1]) > str(result[j + 1][1]):
                    result[j], result[j+1] = result[j+1], result[j]
        # Cerca Binaria
        inf = 0
        sup = len(result) - 1
        trobat = False

        while not trobat and inf <= sup:
            medio = int((sup + inf) / 2)
            if result[medio][1] == id_usuario:
                trobat = True
                index = medio
            if str(result[medio][1]) < str(id_usuario):
                inf = medio + 1
            else:
                sup = medio - 1
        counter = 0
        if trobat:
            print("Jugador encontrado {}!!!".format(id_usuario))
            usuario = result[index][0]
            return usuario
        else:
            print("Lo sentimos el jugador {} no ha sido encontrado!!!".format(id_usuario))
            res = input("Deseas añadir un jugador nuevo? S or N: ")
            if res.lower() == 's':
                insert_player(id_usuario)
            else:
                print("No es posible añadirte como jugador!!")
    except pymysql.err.ProgrammingError:
        print("Error: Unable to look for data!!")
    finally:
        # Cerramos la BBDD
        if db.open is True:
            cursor.close()
            db.close()
            print("MySQL connection is closed...")
