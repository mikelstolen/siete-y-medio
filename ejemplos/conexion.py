import pymysql


############### CONFIGURAR ESTO ###################

# Conexión de base de datos.
conexion="127.0.0.1" #aquí pondremos nuestra dirección de la base de datos de Amazon web services
usuario="root" # usuario de la conexión
password="" #contraseña
BBDD="tienda" #base de datos a la cual nos vamos a conectar
db = pymysql.connect(conexion,usuario,password,BBDD)
##################################################

# Este cursor lo usamos para ejecutar la query y almacenar sus datos
cursor = db.cursor()

# Creamos la consulta.



def exportarquery1(outfileName):
    print("Informe sobre los productos de la tienda")
    with open(outfileName, "w") as outfile:
      db = pymysql.connect(conexion, usuario, password, BBDD)
      cursor = db.cursor()
      sql = "SELECT p.codigo,p.nombre, p.precio,f.nombre FROM producto p \
        inner join fabricante f on f.codigo=p.codigo_fabricante".format(0)
      cursor.execute(sql)
      rows = cursor.fetchall()
      outfile.write('<?xml version="1.0" ?>\n')
      outfile.write('<mydata>\n')
      for row in rows:
          codigo = row[0]
          nombre = row[1]
          precio = row[2]
          fabricante = row[3]
          # Now print fetched result
          print("codigo = {0}, nombre = {1}, precio = {2}, fabricante = {3}".format(codigo, nombre, precio, fabricante))
          outfile.write('  <row>\n')
          outfile.write('    <codigo>%s</name>\n' % row[0])
          outfile.write('    <nombre_producto>%s</desc>\n' % row[1])
          outfile.write('    <precio>%s</rating>\n' % row[2])
          outfile.write('    <nomre_fabricante>%s</rating>\n' % row[3])
          outfile.write('  </row>\n')
      outfile.write('</mydata>\n')
      outfile.close()



exportarquery1("Resultadoquery.xml")
# desconectamos
db.close()

"""
miConexion = pymysql.connect( host='localhost', user= 'root', passwd='', db='concessionari' )
cur = miConexion.cursor()
cur.execute( "SELECT id, dniEmpleat,nomEmpleat FROM venedors" )
for id, dniEmpleat,nomEmpleat in cur.fetchall() :
    print (id, dniEmpleat,nomEmpleat)
miConexion.close()


"""