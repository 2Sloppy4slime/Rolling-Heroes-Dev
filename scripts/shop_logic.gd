extends Node

@export var spaces = 6

@onready var GAME_MANAGER = get_tree().root
@onready var ITEM_MANIPULATOR = get_tree().get_nodes_in_group("item_manipulator")[0]

var Isabletobuy = false #if not in an animation or something where you should be able to click to get an item
var items_in_shop = []
#get item pool from item_manipulation
func _ready():
	
	populate()

func populate():
	while spaces > len(items_in_shop) :
		print("finding item for populate...")
		items_in_shop.append(ITEM_MANIPULATOR.select_item(ITEM_MANIPULATOR.get_items_in({"pool":"shop"})))
	print(items_in_shop)
	
func buy(itemindex): #itemnumber = index in items_in_shop
	if items_in_shop[itemindex]["price"] < GAME_MANAGER.points :
		var item = items_in_shop.pop_at(itemindex)
		GAME_MANAGER.upgrade(item["upgrade_id"])
		GAME_MANAGER.points -= items_in_shop[itemindex]["price"]
