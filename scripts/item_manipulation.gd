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
func get_items_in(params : Dictionary = {},itemlist = items): #params{} "rarity" : int | "pool" : string | "type" : string
	var res = []
	if len(params.keys()) == 0 :
		print("no params given, return full list")
		res = itemlist
	for i in params.keys() :
		match i :
			
			"type":
				if params["type"] in ["ball","pale","sticker","nudge"]:
					if res == []:
						for item in itemlist : #just add
							if item.type == params["type"] :
								res.append(item)
					else : #filter out
						for item in res : 
							if item.type != params["type"] :
								var removeindex = res.find(item)
								res.pop_at(removeindex)
				else : 
					print("invalid type given")
					return []
			"pool":
				#check pool in pools
				if true :
					if res == []:
							for item in itemlist : #just add
								if params["pool"] in item.chance_by_pool.keys() :
									res.append(item)
									
					else : #filter out
						for item in res : 
							if params["pool"] not in item.chance_by_pool.keys() :
								var removeindex = res.find(item)
								res.pop_at(removeindex)
				else : 
					print("invalid pool given")
					return []
					
			"rarity":
				if params["rarity"] in [0,1,2,3]:
					if res == []:
						for item in itemlist : #just add
								if item.rarity == params["rarity"] :
									res.append(item)
					else : #filter out
						for item in res :
							if item.rarity != params["rarity"] :
								var removeindex = res.find(item)
								res.pop_at(removeindex)
				else:
					print("invalid rarity given")
					return []
					
			_:
				print("invalid params given, returning whole list")
				res = itemlist
	print("returning list of length : " + str(len(res)))
	return res

func select_item(list : Array, pool = "base") : # on met les pools dedans
	#faire affecter la luck mais pour l'instant rareté 0->3 [40%, 30%, 20%, 10%]
	var rarityroll = randi_range(1,100) #[1:40] : rarity = 0 | [41:70] : rarity = 1 | [71:90] : rarity = 2 | [91:100] : rarity = 3
	var rarity = 0
	#pas vrm de meilleurs moyen que je connaisse
	if rarityroll > 40 : 
		rarity = 1
		if rarityroll > 70 : 
			rarity = 2
			if rarityroll > 90 : 
				rarity = 3

	var newlist = get_items_in({"rarity": rarity,"pool":pool},list)
	if len(newlist) == 0 :
		print("fallback, item with rarity : " + str(rarity) + " doesn't exist in list, goign back to original list")
		newlist = get_items_in({"pool":pool},list)
	var chosen = false
	while !chosen :
		var index = randi_range(0,len(newlist)-1)
		if newlist[index].chance_by_pool[pool] > randi_range(0,100) :
			chosen = true
			print("algorithm chose : " + str(newlist[index]))
			return newlist[index]
	print("error getting item, you should never ever see this btw")
	return {}
