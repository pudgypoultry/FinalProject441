extends CharacterBody3D

@export var missile : PackedScene

var ship_speed = 10000
var mode = 0
var missile_rotation = Vector3(0, PI/2, 0)


const SHIP_MODE = {
	GALAGA = 0, 
	RTYPE = 1, 
	STARFOX = 2
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Vector3(0,0,0)
	
	if mode == SHIP_MODE.GALAGA:
		input += get_input_galaga()
	
	if mode == SHIP_MODE.RTYPE:
		input += get_input_rtype()
	
	if mode == SHIP_MODE.STARFOX:
		input += get_input_starfox()
	
	velocity = input * ship_speed * delta
	get_fire_input()
	move_and_slide()


func get_input_galaga():
	var input = Vector3(0,0,0)
	if Input.is_action_pressed('ui_left'):
		input.x += -1 
	
	if Input.is_action_pressed('ui_right'):
		input.x += 1 
	
	return input


func get_input_rtype():
	var input = Vector3(0,0,0)
	if Input.is_action_pressed('ui_down'):
		input.y += -1 
	
	if Input.is_action_pressed('ui_up'):
		input.y += 1 
	
	return input


func get_input_starfox():
	var input = Vector3(0,0,0)
	if Input.is_action_pressed('ui_down'):
		input.y += -1 
	
	if Input.is_action_pressed('ui_up'):
		input.y += 1 
	
	if Input.is_action_pressed('ui_left'):
		input.x += -1 
	
	if Input.is_action_pressed('ui_right'):
		input.x += 1 
	
	return input


func Set_Input_Galaga():
	mode = SHIP_MODE.GALAGA

func Set_Input_RType():
	mode = SHIP_MODE.RTYPE

func Set_Input_StarFox():
	mode = SHIP_MODE.STARFOX

func get_fire_input():
	if Input.is_action_just_pressed("fire_1"):
		var current_bullet_right = missile.instantiate()
		var current_bullet_left = missile.instantiate()
		owner.add_child(current_bullet_right)
		owner.add_child(current_bullet_left)
		current_bullet_right.transform = get_node("./GalagaShip/GunOrganizer/ShootRightFront").global_transform
		current_bullet_right.set_global_rotation(missile_rotation)
		current_bullet_left.transform = get_node("./GalagaShip/GunOrganizer/ShootLeftFront").global_transform
		current_bullet_left.set_global_rotation(missile_rotation)










