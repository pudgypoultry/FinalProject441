extends CharacterBody3D

@export var frame1 : Node3D
@export var frame2 : Node3D
@export var collider1 : CollisionShape3D
@export var collider2 : CollisionShape3D

@export var fire_Particles: CPUParticles3D
@export var cloud_Particles: CPUParticles3D

var animate_time = 50
var counter : int = 0 
var current_frame : int = 0 
var number_of_frames : int = 2
var frames = []
var am_i_animating = true
var grabbing = false
var killable = false

var player_position = Vector3(0,0,0)
var original_position;

var my_x = 0
var my_y = 0
var my_z = 0

func _ready():
	frames = [frame1, frame2]
	collider1.set_disabled(false)

func _physics_process(delta):
	animate_grabber(am_i_animating)
	
	if position.z > 230:
		pass
		grabbing = false
		position = original_position

func Kill_Me():
	if killable:
		fire_Particles.set_emitting(true)
		cloud_Particles.set_emitting(true)
		am_i_animating = false
		frames[0].hide()
		frames[1].hide()
		collider1.set_disabled(true)
		collider2.set_disabled(true)
		await get_tree().create_timer(1.0, false).timeout
		queue_free()

func animate_grabber(showing):
	
	if showing:
		if grabbing:
			frames[1].show()
			collider2.set_disabled(false)
			frames[0].hide()
			set_rotation(Vector3(0.020,0,0) + rotation)
			position += Vector3(0,0,0.75)
		else:
			frames[0].show()
			collider2.set_disabled(true)
			frames[1].hide()
			rotation = Vector3(0, -PI/2, 0)

func shoot():
	pass

func charge():
	grabbing = true
	original_position = position

func get_player_position():
	player_position = get_node("/root/TestingScene/GalagaShip").get_position()
	print_debug(player_position)

func set_enemy_grid_position(x, y, z):
	my_x = x
	my_y = y
	my_z = z

func get_enemy_grid_position():
	return Vector3(my_x, my_y, my_z)
