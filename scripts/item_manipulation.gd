extends Node
#json 			: name , type, upgrade id, price, rarity, chance, description, image
# name 			: string 	(name of the item)
# type 			: string 	("ball" | "pale" | "sticker" | "nudge")
# upgrade_id	: int 		(number of id for root application)
# price			: int 		(price in points)
# rarity		: int 		(0-3 changes how often it gets stored in)
# chance_by_pool: {pool:int}(chance in % for it to be selected on get, sorted by pool, default value 30%)
# description 	: string 	(description for the card) [MAKE AN AUTODESCRIPTOR]
# image 		: PATH 		(link to image file)
var items = [] #list of all items

#Function : returns all items who match the parameters (PARAMETERS ARE ADDITIVE, A∩B NOT A∪B)
func get_items_in(params : Dictionary): #params{} "rarity" : int | "pool" : string | "type" : string
	pass 
	for i in params.keys() :
		match i :
			
			"type":
				match params[i]:
					"ball":
						pass
					"pale":
						pass
					"sticker":
						pass
					"nudge":
						pass
					_:
						print("invalid type name")
			
			"pool":
				pass
			"rarity":
				pass
			_:
				pass
	#pass through each param
		#pass through each item
			#add if param yes!
	
