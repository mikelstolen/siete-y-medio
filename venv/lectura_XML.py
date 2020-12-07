import xml.etree.ElementTree as ALL

tree = ALL.parse('xml_dtd/carta.xml')
rootPlayer = tree.getroot()
tree2 = ALL.parse('xml_dtd/enemigo.xml')
rootEnemy = tree2.getroot()


# https://docs.python.org/2/library/xml.etree.elementtree.html

def cardsPrint(arg):
    for card in rootPlayer.findall('./deck/card'):
        att = card.attrib
        name = card.find('name').text
        desc = card.find('description').text
        attack = card.find('attack').text
        defense = card.find('defense').text
        print(att, "Name=", name, "Description=", desc, "Attack=", attack, "Defense=", defense)


cardsPrint(rootPlayer)
cardsPrint(rootEnemy)