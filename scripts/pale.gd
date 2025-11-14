extends Node3D

@export var rebound_power = 1.4

@export var left = true
@export var angleamplitude = 20 #angle at which the pale rotates
@export var rotatespeed = 1


var on_hit_upgrades = []

@onready var GAME_MANAGER = get_tree().root

func _input(event) :
	if event.is_action_pressed("accept_or_right_flipper") and !left:
		print("right_flipper hit")
	if event.is_action_pressed("refuse_or_left_flipper") and left:
		print("left_flipper hit")
		
func apply_upgrades(ball):
	for v in GAME_MANAGER.upgrades_list : #sort upgrades from number%50 so 0-50 are ball upgrades, 50-100 are pale upgrades
		if v >= 50 and v < 100:
			ball.next_bounce_functions.append(v)
