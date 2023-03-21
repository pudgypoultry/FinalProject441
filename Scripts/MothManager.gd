extends Node3D

@export var delay_ratio = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	attack()

func attack():
	await get_tree().create_timer(delay_ratio, false).timeout
	for moth in get_children():
		if moth.my_x == 1:
			moth.charge()
	await get_tree().create_timer(delay_ratio/2, false).timeout
	attack_after()

func attack_after():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, 3)
	for moth in get_children():
		if moth.my_y == num:
			moth.charge()
	
	await get_tree().create_timer(delay_ratio, false).timeout
	num = rng.randi_range(0,2)
	for moth in get_children():
		if moth.my_x == num:
			moth.charge()
	
	await get_tree().create_timer(delay_ratio, false).timeout
	num = rng.randi_range(0,1)
	for moth in get_children():
		if moth.my_z == num:
			moth.charge()
	
	await get_tree().create_timer(delay_ratio, false).timeout
	attack_after()
