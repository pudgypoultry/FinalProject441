extends Area3D

@export var missile_exclude : Node3D

var missile_speed = 450
var lifetime = 90

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector3(0,0,-1)
	
	position += direction * missile_speed * delta
	lifetime -= 1
	
	if lifetime < 0:
		queue_free()
	
	var overlaps = get_overlapping_bodies()
	if len(overlaps) > 0: #&& !(missile_exclude in overlaps):
		overlaps[0].Kill_Me()
		queue_free()

func target_acquired():
	pass
	
