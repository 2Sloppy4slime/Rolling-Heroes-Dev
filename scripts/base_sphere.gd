extends RigidBody3D
@export var nudge_id = 0
@export var bounce_factor = 0.9
@export var base_points_multiplier = 1
@export var flat_damage = 1
@export var base_damage_multiplier = 1
@export var max_damage_multiplier = 4 #damage changes with speed
@export var launch_speed = 20
@export var Canbreakshield = false
@export var Ismultiball = false
@export var next_bounce_functions = []
@export var next_bounce_condition_id = 0
func _input(event):
	
	if event.is_action_pressed("nudge_up"):
		pass
	if event.is_action_pressed("nudge_down"):
		pass
	if event.is_action_pressed("nudge_left"):
		pass
	if event.is_action_pressed("nudge_right"):
		pass
		
	
func bouncecheck():
	if bounce_cond_by_id(next_bounce_condition_id) and next_bounce_functions == [] :
		pass
	
func bounce_cond_by_id(id):
	match id :
		0 : #tout
			return true
		1 : #enemi
			pass
		2 : #pales
			pass
		3 : #sticker
			pass
		4 : #bouclier
			pass
		5 : #multiball
			pass
		6 : 
			pass
		_ :
			return false
	return false

func nudge_func():
	match nudge_id :
		0 : 
			pass
		1: #multiball : splits into 3 : 1 nudged (base) 1 stopped and 1 random pushed
			pass
		2: #shieldbreaker : breaks any shield on the field
			pass
