extends Node

@onready var GAME_MANAGER = get_tree().root
# bornes dans n'importe quel sens à part le dernier (a voir) 
@export var nav : Array
#borne 0 :  ennemis classe 1 
#borne 1 :  ennemis classe 1 , stats ennemis x1.25
#borne 2 :  ennemis classe 2 , stats ennemis x1.5
#borne 3 :  ennemis classe 2 , stats ennemis x1.75
#borne 4 :  ennemis classe 3 , stats ennemis x2
#commence tjrs par niveau normal
#fini tjrs par boss
# +5 salles par bornes
# 1 shop toujours avant le boss, 10% d'un autre au milieu
# salles/6 = possibilité salles dures (avec item à la fin) salles dures peuvent pas passer par nouvelle salle spéciale
# salles/6 = possibilité salles dures skip (avec item à la fin, skippent 1 level) salles dures peuvent pas passer par nouvelle salle
# salles/6 = possibilité salles item
# nav générée [[normal],[dure,normal],[item,normal],[normal],[dure,normal],[shop,normal],[boss]]

var room_number_bounds = [[6,8],[6,9],[8,9],[8,10],[9,10]]
func generate_nav(bornenumber):
	nav = []
	var nombre_salles = randi_range(room_number_bounds[bornenumber][0],room_number_bounds[bornenumber][1])
	var sallesitem = nombre_salles/6
	var sallehard = nombre_salles/6
	var sallehardskip = nombre_salles/6
	var second_random = true if randi_range(0,100) <=10 else false
	for i in range(nombre_salles):
		nav.append(["normal"])
#assign nav (navlist)
#

#logic pour changer de level
#signal quand nav est faite
#descendre instance et baisser opacité 
#spawn la nouvelle et la fair apparaître
