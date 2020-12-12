"""
import sys
import boto3

ENDPOINT = "sieteymedio.cif7u0be4daj.us-east-1.rds.amazonaws.com"
PORT = "3306"
USR = "root"
REGION = "us-east-1"
os.environ['LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN'] = '1'

# gets the credentials from .aws/credentials
session = boto3.Session(profile_name='RDSCreds')
client = boto3.client('rds')

token = client.generate_db_auth_token(DBHostname=ENDPOINT, Port=PORT, DBUsername=USR, Region=REGION)
"""

import pymysql

# import pandas as pd
# from sqlalchemy import create_engine

# Configuramos la BBDD

# Conexión de base de datos
host = "localhost"
# Usuario de la conexión
user = "root"
# Contraseña
passwd = "root"
# Nombre de la base de datos a la cual nos vamos a conectar
BBDD = "proyecto"

db = pymysql.connect(host, user, passwd, BBDD)
# db = create_engine('mysql+pymysql://' + user + ':' + passwd + '@' + host + ':' + str(port) + '/' + BBDD, echo=False)

# Este cursor lo usamos para ejecutar la query y almacenar sus datos
cursor = db.cursor()
