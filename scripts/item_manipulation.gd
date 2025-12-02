extends Node
var json_path = "res://data/items.json"
var items = [] #list of all items

func _ready():
	var file = FileAccess.open(json_path,FileAccess.READ)
	if file:
		var content = file.get_as_text()
		print(content)
		items = JSON.parse_string(content)
		if items == null :
			print("failed to parse text js JSON")
		file.close()
	else:
		print("Failed to open file: ", json_path)

#json 			: name , type, upgrade id, price, rarity, chance, description, image
# name 			: string 	(name of the item)
# type 			: string 	("ball" | "pale" | "sticker" | "nudge")
# upgrade_id	: int 		(number of id for root application)
# price			: int 		(price in points)
# rarity		: int 		(0-3 changes how often it gets stored in)
# chance_by_pool: {pool:int}(chance in % for it to be selected on get, sorted by pool, default value 30%)
# description 	: string 	(description for the card) [MAKE AN AUTODESCRIPTOR]
# image 		: PATH 		(link to image file)


#Function : returns all items who match the parameters (PARAMETERS ARE ADDITIVE, A∩B NOT A∪B)
func get_items_in(params : Dictionary): #params{} "rarity" : int | "pool" : string | "type" : string
	var list = []
	for i in params.keys() :
		match i :
			
			"type":
				if params["type"] in ["ball","pale","sticker","nudge"]:
					if list == []:
						for item in items : #just add
							if item.type == params["type"] :
								list.append(item)
					else : #filter out
						for item in list : 
							if item.type != params["type"] :
								var removeindex = list.find(item)
								list.pop_at(removeindex)
				else : 
					print("invalid type given")
					return []
			"pool":
				#check pool in pools
				if true :
					if list == []:
							for item in items : #just add
								if params["pool"] in item.chance_by_pool.keys() :
									list.append(item)
									
					else : #filter out
						for item in list : 
							if params["pool"] not in item.chance_by_pool.keys() :
								var removeindex = list.find(item)
								list.pop_at(removeindex)
				else : 
					print("invalid pool given")
					return []
					
			"rarity":
				if params["rarity"] in [0,1,2,3]:
					if list == []:
						for item in items : #just add
								if item.rarity == params["rarity"] :
									list.append(item)
					else : #filter out
						for item in list :
							if item.rarity != params["rarity"] :
								var removeindex = list.find(item)
								list.pop_at(removeindex)
				else:
					print("invalid rarity given")
					return []
					
			_:
				print("no params given, returning whole list")
				return items
	return list
