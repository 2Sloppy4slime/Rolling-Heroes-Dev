extends RigidBody3D
@export var OG_STATS = {
	"nudgeid"					:	0,
	"bounce_factor"				:	0.5,
	"base_points_multiplier"	:	1,
	"flat_damage"				:	1,
	"base_damage_multiplier"	:	4,
	
	"launch_speed"				:	3,
	
	"Canbreakshield"			:	false,
	"Ismultiball"				:	false,
	
	"Nudgeready"				:	false,
	"pointstochargenudge"		:	100,
	"currentpointstonudge"		:	0,
	
	"next_bounce_functions"		:	[] #[ [func,collisionid,uses] ]
}


var current_stats = {}
func _ready():
	self.set_contact_monitor(true)
	self.set_max_contacts_reported(5)
	current_stats = OG_STATS
	self.physics_material_override.bounce = current_stats["bounce_factor"]



var last_bounce_list = []
var current_bounce_list = []
func _physics_process(delta: float) -> void:
	for node in get_colliding_bodies():
		var new_nbf = []
		for i in range(current_stats["next_bounce_functions"].size()) :
			var bouncefunc = current_stats["next_bounce_functions"][i]
			if (node.is_in_group(bouncefunc[1]) or (bouncefunc[1] == "any" and !node.is_in_group("flipper floor"))) and node not in last_bounce_list :
				call(bouncefunc[0])
				if bouncefunc[2] > 1: 
					bouncefunc[2] -= 1 
					new_nbf.append(bouncefunc)
					
				else : #bouncefunc has no more uses
					pass
					#print(self.name + " has ran out of bouncefunc " + bouncefunc[0])
			
			else : 
				new_nbf = current_stats["next_bounce_functions"]
			
		current_stats["next_bounce_functions"] = new_nbf
	
	last_bounce_list = get_colliding_bodies()
	

		
func _input(event):
	
	if event.is_action_pressed("nudge_up"):
		pass
	if event.is_action_pressed("nudge_down"):
		pass
	if event.is_action_pressed("nudge_left"):
		pass
	if event.is_action_pressed("nudge_right"):
		pass
		


func print_bounced() : print("bounced")
func print_bouncedtoo() : print("bounced2")



func nudge_func():
	match current_stats["nudge_id"] :
		0 : 
			pass
		1: #multiball : splits into 3 : 1 nudged (base) 1 stopped and 1 random pushed
			pass
		2: #shieldbreaker : breaks any shield on the field
			pass
		_:
			pass
