extends Node3D

@export var delay_ratio = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2 * delay_ratio, false).timeout
	for moth in get_children():
		if moth.my_x == 1:
			moth.charge()
	
	await get_tree().create_timer(delay_ratio, false).timeout
	for moth in get_children():
		if moth.my_x == 2 && moth.my_y == 0:
			moth.charge()
