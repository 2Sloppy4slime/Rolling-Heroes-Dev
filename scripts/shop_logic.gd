extends Node

@export var spaces = 6
@onready var GAME_MANAGER = get_tree().root
var items_available  = [] #[(id,price)]
#list of rarities for each id of number  [(id,chance)] chance is % to say yes when populating
var Isabletobuy = false #if not in an animation or something where you should be able to click to get an item

func populate():
	pass
	#random number 
	#get if real upgrade 
	#roll for yes?
	#repeat until spaces = length(items)
	
func buy(itemnumber): #itemnumber = index in  items_available
	pass
	#check price compared to money
	#remove
	#apply
