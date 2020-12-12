# IMPORTS
import pymysql

# CONFIGURAMOS LA BBDD

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

# desconecta del servidor
db.close()
