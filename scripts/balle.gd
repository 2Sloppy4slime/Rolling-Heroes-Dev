extends RigidBody3D
@export var OG_STATS = {
	"nudgeid"					:	0,
	"bounce_factor"				:	0.5,
	"base_points_multiplier"	:	1,
	"flat_damage"				:	1,
	"base_damage_multiplier"	:	1,
	"max_damage_multiplier"		:	2,
	
	"launch_speed"				:	10,
	
	"Canbreakshield"			:	false,
	"Ismultiball"				:	false,
	
	"Nudgeready"				:	false,
	"pointstochargenudge"		:	100,
	"currentpointstonudge"		:	0,
	
	"next_bounce_functions"		:	[], #[ [func,collisionid,uses] ]
	"on_kill_functions"			:	[] # [ [func,uses] ] 
}

var ballscene = preload("res://scenes/base_sphere.tscn")

var current_stats = {}
func _ready():
	self.set_contact_monitor(true)
	self.set_max_contacts_reported(5)
	current_stats = OG_STATS
	self.physics_material_override.bounce = current_stats["bounce_factor"]



var last_bounce_list = []
var current_bounce_list = []
func _physics_process(_delta: float) -> void:
	for node in get_colliding_bodies():
		var new_nbf = []
		for i in range(current_stats["next_bounce_functions"].size()) :
			var bouncefunc = current_stats["next_bounce_functions"][i]
			if (node.is_in_group(bouncefunc[1]) or (bouncefunc[1] == "any" and !node.is_in_group("flipper floor"))) and node not in last_bounce_list :
				call(bouncefunc[0])
				if bouncefunc[2] > 1: 
					bouncefunc[2] -= 1 
					new_nbf.append(bouncefunc)
				elif bouncefunc[2] < 0 : #bouncefunc has no more uses
					new_nbf.append(bouncefunc)
				else:
					pass
					#print(self.name + " has ran out of bouncefunc " + bouncefunc[0])
			
			else : 
				new_nbf = current_stats["next_bounce_functions"]
			
		current_stats["next_bounce_functions"] = new_nbf
		
		if node.is_in_group("enemy") and node not in last_bounce_list:
			node.hurt(damage_calc(),self)
	
	last_bounce_list = get_colliding_bodies()
	

		
func _input(event):
	if current_stats["Ismultiball"] :
		$spheremesh/Decal.show()
	if event.is_action_pressed("nudge_up") or event.is_action_pressed("nudge_down") or event.is_action_pressed("nudge_left") or event.is_action_pressed("nudge_right"):
		if self.current_stats["Nudgeready"] :
			nudge_func(event.is_action_pressed("nudge_up"), event.is_action_pressed("nudge_down"), event.is_action_pressed("nudge_left"), event.is_action_pressed("nudge_right"))
		

func onkillfunctions() :
	for i in self.OG_STATS["on_kill_functions"]:
		pass

func nudge_func(up : bool,down : bool, left: bool, right : bool):
	if !self.current_stats["Ismultiball"]:
		match current_stats["nudgeid"] :
			0 : 
				# vector3 ( +x : right , -x : left, 0 , +z : down , -z : up)
				var impulse = Vector3((int(right)-int(left)),0,(int(down)-int(up)))
				self.apply_central_impulse(impulse)
			1: #multiball : splits into 3 : 1 nudged (base) 1 stopped and 1 in the other direction
				var clone1 = ballscene.instantiate()
				get_tree().root.add_child(clone1)
				clone1.position = self.position
				clone1.current_stats["Ismultiball"] = true
				
				var impulse = Vector3((int(right)-int(left))*2,0,(int(down)-int(up))*2)
				self.apply_central_impulse(impulse)
				var clone2 = ballscene.instantiate()
				get_tree().root.add_child(clone2)
				clone2.position = self.position
				clone2.current_stats["Ismultiball"] = true
				
				clone2.apply_central_impulse(-impulse)
			2: #shieldbreaker : breaks any shield on the field
				pass
			_:
				pass
	else : 
		self.apply_central_impulse(Vector3((int(right)-int(left)),0,(int(down)-int(up))))


func damage_calc():
	var speed = sqrt(linear_velocity.x * linear_velocity.x + linear_velocity.y * linear_velocity.y + linear_velocity.z * linear_velocity.z)
	#mult = base mult + (max mult- base mult) * scale(=0->1)
	#XXXXXXXXXX[-Scale---]XXXXXX
	#          Base      Max
	var mult = self.current_stats["base_damage_multiplier"] + (self.current_stats["max_damage_multiplier"] - self.current_stats["base_damage_multiplier"]) * (1 if speed >= 4 else speed/4)
	var dmg = int(10 * mult + self.current_stats["flat_damage"])
	print(dmg)
	return dmg
