extends RigidBody3D

@export var health = 10
@export var damage = 100 #multiply by smth figure it out later
var Canmove = false
var Canturn = false
var Isarmored = false #passive shield
var shield
@export var logic_id = 0 #how the character acts

func logic(): #behave how?
	match logic_id :
		0 : pass
		_ : pass
