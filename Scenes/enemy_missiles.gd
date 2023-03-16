extends Area3D

@export var missile_exclude : Node3D

var missile_speed = 450
var lifetime = 90
var direction = Vector3(0,0,1)
var my_scale = Vector3(1,1,1)
var my_position = Vector3(0,0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale = my_scale
	position += direction * missile_speed * delta
	lifetime -= 1
	
	if lifetime < 0:
		queue_free()
	
	var overlaps = get_overlapping_bodies()
	if len(overlaps) > 0: #&& !(missile_exclude in overlaps):
		overlaps[0].Kill_Me()
		queue_free()

func send_me_where(x_speed, y_speed, z_speed):
	direction += Vector3(x_speed, y_speed, z_speed)

func set_my_scale(x, y, z):
	my_scale = Vector3(x, y, z)

func put_me_where(x_offset, y_offset, z_offset):
	position += Vector3(x_offset, y_offset, z_offset)

