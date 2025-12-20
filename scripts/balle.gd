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
@export var Nudgeready = false
@export var Pointstochargenudge = 100
@export var Currentpointstonudge = 0
@export var next_bounce_functions = [] #[(func,idcollision)]
@export var next_bounce_condition_id = 0
func _ready():
	self.set_contact_monitor(true)
	self.set_max_contacts_reported(5)
	pass

var last_bounce_list = []
func _physics_process(delta: float) -> void:
	for node in get_colliding_bodies():
		if !node.is_in_group("flipper floor") and !node in last_bounce_list:
			print(self.name + "collided with : " + node.name)
	
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
		
# mangez ma gock especes de zebzebzeb

# Function : will play functions if bounces happens correctly, call immediately after touching another hull
func bouncecheck():
	for i in next_bounce_functions :
		if bounce_cond_by_id(i[1]) :
			call(i[0])
		
	
	
	
# Function : checks which kind of hull touched the ball for pale upgrades
func bounce_cond_by_id(id):
	match id :
		0 : #tout
			return true
		1 : #ennemy
			#if latest collision was enemy then return
			pass
		2 : #pales
			#if latest collision was pale then 
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
		_:
			pass
