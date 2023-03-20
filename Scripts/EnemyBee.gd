extends CharacterBody3D

@export var frame1 : Node3D
@export var frame2 : Node3D

@export var fire_Particles: CPUParticles3D
@export var cloud_Particles: CPUParticles3D

@export var collider : CollisionShape3D

var animate_time = 50
var counter : int = 0 
var current_frame : int = 0 
var number_of_frames : int = 2
var frames = []
var am_i_animating = true
var charging = false

var player_position = Vector3(0,0,0)
var original_position = Vector3(0,0,0)

@export var my_x = 0
@export var my_y = 0
@export var my_z = 0

func _ready():
	frames = [frame1, frame2]
	original_position = position
	

func _physics_process(delta):
	animate_bee(am_i_animating)
	get_player_position()
	if position.z > 230:
		position = original_position
		charging = false

func Kill_Me():
	fire_Particles.set_emitting(true)
	cloud_Particles.set_emitting(true)
	am_i_animating = false
	frames[0].hide()
	frames[1].hide()
	collider.set_disabled(true)
	await get_tree().create_timer(1.0, false).timeout
	queue_free()

func animate_bee(showing):
	if showing:
		counter = (counter + 1) % animate_time
		#print_debug(counter)
		current_frame = (counter / (animate_time/2)) % animate_time
		#print_debug(current_frame)
		frames[current_frame].show()
		frames[(current_frame - 1) % number_of_frames].hide()
	
	if charging:
		position += Vector3(player_position.x - position.x, 0, 2.5)

func shoot():
	pass

func charge():
	charging = true

func get_player_position():
	player_position = get_node("/root/TestingScene/GalagaShip").get_position()

func set_enemy_grid_position(x, y, z):
	my_x = x
	my_y = y
	my_z = z

func get_enemy_grid_position():
	return Vector3(my_x, my_y, my_z)
