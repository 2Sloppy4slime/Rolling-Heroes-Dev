extends Node3D

var stickers_list = []
var upgrades_list = []
@export var points = 1000
@export var lives = 6
@export var character = "base"
var ball

@export var current_machine = "tutorial"
@export var level_number = 0
@export var difficulty = 0
var sticker_spots

var Isinbossroom = false
var Isinshop = false
var Shoulddie = false

var Ispaused = false

var Ismainmenu = false
var Ischoosingcharacter = false
var Isparametering = false

func set_ball() : 
	var temp = get_tree().get_nodes_in_group("ball")
	for i in temp :
		if i.Ismultiball :
			ball = i

func get_sticker_spots_from_level():
	pass
	
func change_state(state) :
	match state :
		"Isinbossroom" :
			Isinshop = false
			Isinbossroom = true
		"Isinshop" :
			Isinshop = true
			Isinbossroom = false
			
		"Shoulddie" :
			Shoulddie = true
			Isinshop = false
			Isinbossroom = false
			Ispaused = false

		"Ismainmenu" :
			Ismainmenu = true
			Ischoosingcharacter = false
			Isparametering = false
			Shoulddie = false
			
		"Ischoosingcharacter" :
			Ischoosingcharacter = true
			Ismainmenu = false
			Isparametering = false
			
		"Isparametering" :
			Isparametering = true
			Ischoosingcharacter = false
			Ismainmenu = false
		_:
			Ismainmenu = true
			Ischoosingcharacter = false
			Ispaused = false
			Shoulddie = false
			Isinshop = false
			Isinbossroom = false
			Isparametering = false


func ball_upgrade(id : int) : #ball upgrades are id 0-50 
	set_ball()
	
	match id: #basically just change the stats of the ball
		0: 
			ball.bounce_factor += 0.03
		1: 
			ball.base_points_multiplier += 0.3
		2: 
			ball.flat_damage += 1
		3: 
			ball.base_damage_multiplier += 0.3
		4: 
			ball.max_damage_multiplier += .6
		5:
			ball.launch_speed += 10
		6:
			ball.Canbreakshield = true
		_:
			print("no upgrades with this id")
		
func pale_upgrade(id : int) :
	pass

func sticker_upgrade(id: int):
	pass

func check_death():
	if points < 0 or lives <= 0:
		return true
	else : 
		return false
