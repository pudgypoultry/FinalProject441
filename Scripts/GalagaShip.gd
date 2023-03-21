extends CharacterBody3D

@export var missile : PackedScene
@export var number_of_shots : int

var ship_speed = 10000
var mode = 0
var missile_rotation = Vector3(0, PI/2, 0)

var x_movement_range = 175
var y_movement_range = 175

var can_shoot = true
var tween_position : Tween
var original_position
var GOOD_TO_GO = true

const SHIP_MODE = {
	GALAGA = 0, 
	RTYPE = 1, 
	STARFOX = 2
}


# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = position


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
		if position.x >= -x_movement_range:
			input.x += -1 
	
	if Input.is_action_pressed('ui_right'):
		if position.x <= x_movement_range:
			input.x += 1 
	
	return input


func get_input_rtype():
	var input = Vector3(0,0,0)
	if Input.is_action_pressed('ui_down'):
		if position.y >= 0:
			input.y += -1 
	
	if Input.is_action_pressed('ui_up'):
		if position.y <= y_movement_range:
			input.y += 1 
	
	return input


func get_input_starfox():
	var input = Vector3(0,0,0)
	if Input.is_action_pressed('ui_down'):
		if position.y >= 0:
			input.y += -1 
	
	if Input.is_action_pressed('ui_up'):
		if position.y <= y_movement_range:
			input.y += 1 
	
	if Input.is_action_pressed('ui_left'):
		if position.x >= -x_movement_range:
			input.x += -1 
	
	if Input.is_action_pressed('ui_right'):
		if position.x <= x_movement_range:
			input.x += 1 
	
	return input


func Set_Input_Galaga():
	mode = SHIP_MODE.GALAGA

func Set_Input_RType():
	mode = SHIP_MODE.RTYPE

func Set_Input_StarFox():
	mode = SHIP_MODE.STARFOX

func get_fire_input():
	if get_node("/root/TestingScene/MothManager").get_children().size() != 0 || get_node("/root/TestingScene/BeeManager").get_children().size() != 0:
		if can_shoot:
			get_node("./Shoot").playing = true
			if Input.is_action_just_pressed("fire_1"):
				if mode == SHIP_MODE.GALAGA:
					for i in range(-5, 6, 1):
						var galaga_bullet = missile.instantiate()
						owner.add_child(galaga_bullet)
						galaga_bullet.transform = get_node("./GalagaShip/GunOrganizer/ShootMiddle").global_transform
						galaga_bullet.put_me_where(0, i*5, 0)
						galaga_bullet.set_global_rotation(missile_rotation)
					can_shoot = false
					await get_tree().create_timer(0.75, false).timeout
					can_shoot = true
				
				if mode == SHIP_MODE.RTYPE:
					for i in range(-5, 6, 1):
						var rtype_bullet = missile.instantiate()
						owner.add_child(rtype_bullet)
						rtype_bullet.transform = get_node("./GalagaShip/GunOrganizer/ShootMiddle").global_transform
						rtype_bullet.put_me_where(i*5, 0, 0)
						rtype_bullet.set_global_rotation(missile_rotation)
					can_shoot = false
					await get_tree().create_timer(0.75, false).timeout
					can_shoot = true
					
				if mode == SHIP_MODE.STARFOX:
					var current_bullet_right = missile.instantiate()
					var current_bullet_left = missile.instantiate()
					owner.add_child(current_bullet_right)
					owner.add_child(current_bullet_left)
					current_bullet_right.transform = get_node("./GalagaShip/GunOrganizer/ShootRightFront").global_transform
					current_bullet_right.set_global_rotation(missile_rotation)
					current_bullet_left.transform = get_node("./GalagaShip/GunOrganizer/ShootLeftFront").global_transform
					current_bullet_left.set_global_rotation(missile_rotation)
					can_shoot = false
					await get_tree().create_timer(0.25, false).timeout
					can_shoot = true
	else:
		if Input.is_action_just_pressed("fire_1"):
			if GOOD_TO_GO:
				HOLDO_MANEUVER()
				GOOD_TO_GO = false


func lose_life():
	pass

func get_ship_mode():
	return mode

func HOLDO_MANEUVER():
	print_debug("ZOOM")
	make_a_da_tween(original_position)
	get_node("./MakeItSo").playing = true
	get_node("/root/TestingScene/BackgroundStars").do_it()
	make_a_da_tween(position + Vector3(0,0, 50))
	await get_tree().create_timer(4, false).timeout
	make_a_da_tween(position + Vector3(0,0,-300000))
	get_node("/root/TestingScene/BackgroundStars").hide()
	get_node("/root/TestingScene/CameraFocal").DO_IT()
	get_node("/root/TestingScene/EnemyGrabber").Kill_Me()

func make_a_da_tween(desired_pos):
	tween_position = create_tween().bind_node(self)
	tween_position.set_trans(Tween.TRANS_SINE)
	tween_position.set_ease(Tween.EASE_IN_OUT)
	tween_position.tween_property(self, "position", desired_pos, 4)
