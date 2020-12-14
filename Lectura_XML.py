# Importamos el documento XML cartas dentro de nuestro programa
# Ref: https://docs.python.org/2/library/xml.etree.elementtree.html

import xml.etree.ElementTree as ALL
cartasXML = ALL.parse('XML/Cartas.xml')
root = cartasXML.getroot()

cartas = []

for card in root.iter('carta'):
    cartas.append([card.find('codigo').text, card.find('valor').text, card.find('palo').text,
                  card.find('valor_juego').text, card.find('activa').text])

# Importamos el documento Basic_Config_Game para modificar sus datos
basicConfig = ALL.parse('XML/Basic_Config_Game.xml')
root_Basic_Config = basicConfig.getroot()

# Buscamos el tag y sobreescribimos el texto
num_min_jugadores = root_Basic_Config.find('Num_Min_Players')
num_min_jugadores.text = '1'
num_max_jugadores = root_Basic_Config.find('Num_Max_Players')
num_max_jugadores.text = '8'
num_max_rondas = root_Basic_Config.find('Num_Max_Rounds')
num_max_rondas.text = '30'
num_initial_points = root_Basic_Config.find('Num_Initial_Points')
num_initial_points.text ='20'
auto_mode = root_Basic_Config.find('Is_Allowed_Auto_Mode')
auto_mode.text = 'True'

# Actualiza y/o crea un archivo XML
basicConfig.write('XML/Basic_Config_Game.xml')

