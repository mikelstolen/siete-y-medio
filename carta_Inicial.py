import pymysql

host = "localhost"
user = "root"
passwd = "root"
BBDD = "proyecto"

db = pymysql.connect(host, user, passwd, BBDD)

query_sql = "SELECT distinct u.username , concat(c.numero_carta,' ',t.descripcion) as Carta_inicial FROM proyecto.turnos t1 " \
            "join proyecto.usuario as u on t1.idparticipante = u.idusuario join proyecto.cartas as c on c.idcartas = t1.carta_inicial " \
            "join proyecto.tipo_carta as t on t.idtipo_carta = c.tipo WHERE carta_inicial = (select carta_inicial from proyecto.turnos " \
            "t2 where t1.idparticipante = t2.idparticipante group by carta_inicial order by count(*) desc limit 1 );"


def query_to_xml(outfileName, query_sql):
    print("INFORME CARTA INICIAL")
    with open(outfileName, "w") as outfile:
        db = pymysql.connect(host, user, passwd, BBDD)
        cursor = db.cursor()
        cursor.execute(query_sql)
        rows = cursor.fetchall()
        outfile.write('<?xml version="1.0" ?>\n')
        outfile.write('<mydata>\n')
        for row in rows:
            outfile.write('  <row>\n')
            for index in range(len(row)):
                outfile.write('       <{}>{}</{}>\n'.format(cursor.description[index][0], row[index],
                                                            cursor.description[index][0]))
            outfile.write('\n  </row>\n')
        outfile.write('</mydata>\n')
        outfile.close()


def query_to_html(outfileName, query_sql):
    print("INFORME CARTA INICIAL")
    with open(outfileName, "w") as outfile:
        db = pymysql.connect(host, user, passwd, BBDD)
        cursor = db.cursor()
        cursor.execute(query_sql)
        rows = cursor.fetchall()
        outfile.write('<!DOCTYPE html>\n<html>\n')
        outfile.write(' <head>\n    <title></title>\n    <link href="css/style.css" rel="stylesheet">\n  </head>\n')
        outfile.write(' <body>\n')
        outfile.write('     <table border="1">\n')
        outfile.write('         <caption>{}</caption>\n'.format(query_sql))
        outfile.write('         <thead>\n           <tr>\n')
        for index in range(len(cursor.description)):
            outfile.write('             <th>{}</th>\n'.format(cursor.description[index][0]))
        outfile.write('           </tr>\n         </thead>\n')
        outfile.write('         <tbody>\n')
        for row in rows:
            outfile.write('             <tr>\n')
            for data in row:
                outfile.write('                 <td>{}</td>\n'.format(data))
            outfile.write('             </tr>\n')
        outfile.write('            </tbody>\n')
        outfile.write('         </table>\n')
        outfile.write(' </body>\n</html>')


query_to_xml("XML/Resultadoquery_1.xml", query_sql)
query_to_html("HTML/ResultadoQuery_1.html", query_sql)
db.close()
