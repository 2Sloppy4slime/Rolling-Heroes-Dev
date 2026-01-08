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


func generate_nav(bound1,bound2):
	nav = []
	var nombre_salles = randi_range(bound1,bound2)
	var sallesspeciales = nombre_salles/6
	var second_random = true if randi_range(0,100) <=10 else false
	for i in range(nombre_salles-2):
		nav.append(["normal"])
	nav.append(["normal","shop"])
	nav.append(["boss"])
	
	for i in range(sallesspeciales):
		var pos = randi_range(1,len(nav)-3)
		if len(nav[pos]) < 3 :
			nav[pos].append("item")
		
		pos = randi_range(1,len(nav)-3)
		if len(nav[pos]) < 3 :
			nav[pos].append("hard")
		
		pos = randi_range(1,len(nav)-4)
		if len(nav[pos]) < 3 :
			nav[pos].append("hard_skip")
			
		if randi_range(0,100) > 90 :
			pos = nombre_salles/2
			nav[pos].append("shop")
	return nav
	
	
	
#assign nav (navlist)
#

#logic pour changer de level
#signal quand nav est faite
#descendre instance et baisser opacité 
#spawn la nouvelle et la fair apparaître
