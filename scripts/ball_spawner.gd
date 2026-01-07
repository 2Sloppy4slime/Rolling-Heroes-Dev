extends Node3D
@onready var GAME_MANAGER = get_tree().root
var ballscene = preload("res://scenes/base_sphere.tscn")

func spawnball(ismulti=false):
	var ball = ballscene.instantiate()
	#var impulse = self.global_rotation * ball.OG_STATS["launch_speed"]
	var impulse = Vector3($vector_end.global_position.x-$vector_start.global_position.x * ball.OG_STATS["launch_speed"] ,$vector_end.global_position.y-$vector_start.global_position.y * ball.OG_STATS["launch_speed"],$vector_end.global_position.z-$vector_start.global_position.z * ball.OG_STATS["launch_speed"])
	
	print(impulse)
	ball.position = self.position
	ball.apply_central_impulse(impulse)
	GAME_MANAGER.add_child(ball)
	

func _input(event):
	if event.is_action_pressed("nudge_right"):
		print("right")
		spawnball()
