import pymysql

host = "localhost"
user = "root"
passwd = "root"
BBDD = "proyecto"

db = pymysql.connect(host, user, passwd, BBDD)

query_sql = "SELECT DISTINCT idpartida, u.username, apuesta FROM turnos t1 " \
            "JOIN usuario as u on u.idusuario = t1.idparticipante " \
            "WHERE apuesta = (SELECT MAX(t2.apuesta) FROM turnos t2 WHERE t1.idpartida = t2.idpartida)" \
            " ORDER BY idpartida;"


def query_to_xml(outfileName, query_sql):
    print("INFORME - JUGADOR CON LA APUESTA MÁS ALTA")
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
    print("INFORME - JUGADOR CON LA APUESTA MÁS ALTA")
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


query_to_xml("XML/Resultadoquery_2.xml", query_sql)
query_to_html("HTML/ResultadoQuery_2.html", query_sql)
db.close()
