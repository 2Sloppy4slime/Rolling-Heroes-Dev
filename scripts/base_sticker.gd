extends Area3D

var ballscene = preload("res://scenes/base_sphere.tscn")
var cooldown = 5.0
var readytosticker = true
@export var sticker_id : int = 0
@export var image_replace : String = ""


func _ready():
	if image_replace != "":
		print("need to change ts now")
	
	$Timer.wait_time = cooldown

func _on_body_entered(body : Node):
	if body.is_in_group("ball") && !body.current_stats["Ismultiball"] && readytosticker:
		print("collided with : " + body.name)
		stickerfunc(sticker_id,body)
		
		$Timer.start()
		$Decal.modulate = Color(0.4, 0.4, 0.4, 1.0)
		readytosticker = false

func stickerfunc(id : int,body):
	match id :
		0 :
			var clone1 = ballscene.instantiate()
			get_tree().root.add_child(clone1)
			clone1.position = body.position
			clone1.linear_velocity = body.linear_velocity.rotated(Vector3.UP,100)
			body.linear_velocity = body.linear_velocity.rotated(Vector3.UP,-100)
			clone1.current_stats["Ismultiball"] = true


func _on_timer_timeout():
	$Decal.modulate = Color(1.0, 1.0, 1.0, 1.0)
	readytosticker = true
