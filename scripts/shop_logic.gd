extends Node

@export var spaces = 6

@onready var GAME_MANAGER = get_tree().root
@onready var ITEM_MANIPULATOR = get_tree().root.item_manipulator

var Isabletobuy = false #if not in an animation or something where you should be able to click to get an item
var items_in_shop = []
#get item pool from item_manipulation

func populate():
	pass
	while spaces > len(items_in_shop) :
		pass
		return
	
func buy(itemnumber): #itemnumber = index in items_in_shop
	pass
	#check price compared to money
	#remove
	#apply
