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

var menutype = "main"
var roomtype = "normal"
var paused = false

func set_ball() : 
	var temp = get_tree().get_nodes_in_group("ball")
	for i in temp :
		if !i.Ismultiball :
			ball = i

func get_sticker_spots_from_level():
	pass


func upgrade(id : int) : #ball upgrades are id 0-50 for now
	set_ball()
	
	match id: #basically just change the stats of the ball
		0: 
			ball.current_stats["bounce_factor"]					+= 0.03
		1: 
			ball.current_stats["base_points_multiplier"]		+= 0.05
		2: 
			ball.current_stats["flat_damage"]					+= 1
		3: 
			ball.current_stats["base_damage_multiplier"]		+= 0.07
		4: 
			ball.current_stats["max_damage_multiplier"]			+= .6
		5:
			ball.current_stats["launch_speed"]					+= 1
		6:
			ball.current_stats["Canbreakshield"]				= true
		_:
			print("no upgrades with this id")
		
func set_nudge(id:int) :
	match id :
		_:
			print("no upgrades with this id")
func check_death():
	if points < 0 or lives <= 0:
		return true
	else : 
		return false
