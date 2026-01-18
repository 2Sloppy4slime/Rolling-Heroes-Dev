extends Node3D

var stickers_list = []
var upgrades_list = []
@export var points = 1000
@export var lives = 6
@export var character = "base"
var ball

var current_ball_stats = {}
@export var current_machine = "tutorial"
@export var level_number = 0
@export var difficulty = 0
var sticker_spots

var menutype = "main"
var roomtype = "normal"
var paused = false

func get_main_ball() : 
	var temp = get_tree().get_nodes_in_group("ball")
	for i in temp :
		if !i.Ismultiball :
			ball = i

func get_sticker_spots_from_level():
	pass


func upgrade(id : int) : #ball upgrades are id 0-50 for now
	get_main_ball()
	
	match id: #basically just change the stats of the ball
		0: 
			current_ball_stats["bounce_factor"]					+= 0.03
		1: 
			current_ball_stats["base_points_multiplier"]		+= 0.05
		2: 
			current_ball_stats["flat_damage"]					+= 1
		3: 
			current_ball_stats["base_damage_multiplier"]		+= 0.07
		4: 
			current_ball_stats["max_damage_multiplier"]			+= .6
		5:
			current_ball_stats["launch_speed"]					+= 1
		6:
			current_ball_stats["Canbreakshield"]				= true
		_:
			print("no upgrades with this id")
		
func set_nudge(id:int) :
	get_main_ball()
	current_ball_stats["nudgeid"] = id
	
func check_death():
	if points < 0 or lives <= 0:
		return true
	else : 
		return false
		

func set_stats_from_character(charactername : String):
	if CHARACTER_STATS[charactername.to_upper()] == null :
		print("no character with that name, base it is")
		current_ball_stats = CHARACTER_STATS["BASE"]
	else : 
		current_ball_stats = CHARACTER_STATS[charactername]
	

var CHARACTER_STATS={
	BASE = {"nudgeid":0,"bounce_factor":0.5,"base_points_multiplier":1,"flat_damage":1,"base_damage_multiplier":1,"max_damage_multiplier":2,"launch_speed":10,"Canbreakshield":false,"Ismultiball":false,"Nudgeready"	:false,"pointstochargenudge":100,"currentpointstonudge":0,"next_bounce_functions":[],"on_kill_functions":[]},
}
