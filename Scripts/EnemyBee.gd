extends CharacterBody3D

@export var frame1 : Node3D
@export var frame2 : Node3D

var animate_time = 50
var counter : int = 0 
var current_frame : int = 0 
var number_of_frames : int = 2
var frames = []

func _ready():
	frames = [frame1, frame2]

func _physics_process(delta):
	animate_bee()

func Kill_Me():
	queue_free()

func animate_bee():
	counter = (counter + 1) % animate_time
	#print_debug(counter)
	current_frame = (counter / (animate_time/2)) % animate_time
	#print_debug(current_frame)
	frames[current_frame].show()
	frames[(current_frame - 1) % number_of_frames].hide()
