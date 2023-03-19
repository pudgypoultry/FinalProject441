extends Node3D

@export var max_enemy_count : int

var enemy_count = 0
var current_enemy_count = 0

var ready_to_attack = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemy_count == max_enemy_count:
		await get_tree().create_timer(4.0, false).timeout
		

func make_specific_shoot(row, column, layer):
	for child in self.get_children():
		if Vector3(row, column, layer) == child.get_enemy_grid_position():
			child.shoot()

func make_specific_charge(row, column, layer):
	for child in self.get_children():
		if Vector3(row, column, layer) == child.get_enemy_grid_position():
			child.charge()

func make_row_shoot(row):
	for child in self.get_children():
		if child.get_enemy_grid_position().y == row:
			child.shoot()

func make_row_charge(row):
	for child in self.get_children():
		if child.get_enemy_grid_position().y == row:
			child.charge()

func make_column_shoot(col):
	for child in self.get_children():
		if child.get_enemy_grid_position().x == col:
			child.shoot()

func make_column_charge(col):
	for child in self.get_children():
		if child.get_enemy_grid_position().x == col:
			child.charge()

func make_layer_shoot(layer):
	for child in self.get_children():
		if child.get_enemy_grid_position().z == layer:
			child.shoot()

func make_layer_charge(layer):
	for child in self.get_children():
		if child.get_enemy_grid_position().z == layer:
			child.charge()

func set_ready(am_i_ready):
	ready_to_attack = am_i_ready

func get_ready():
	return ready_to_attack
