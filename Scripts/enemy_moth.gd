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

var player_position = Vector3(0,0,0)

func _ready():
	frames = [frame1, frame2]

func _physics_process(delta):
	animate_bee(am_i_animating)

func Kill_Me():
	fire_Particles.set_emitting(true)
	cloud_Particles.set_emitting(true)
	frames[0].hide()
	frames[1].hide()
	collider.set_disabled(true)
	am_i_animating = false
	get_player_position()

func animate_bee(showing):
	if showing:
		counter = (counter + 1) % animate_time
		#print_debug(counter)
		current_frame = (counter / (animate_time/2)) % animate_time
		#print_debug(current_frame)
		frames[current_frame].show()
		frames[(current_frame - 1) % number_of_frames].hide()

func shoot():
	pass

func charge():
	pass

func get_player_position():
	player_position = get_node("/root/TestingScene/GalagaShip").get_position()
	print_debug(player_position)
