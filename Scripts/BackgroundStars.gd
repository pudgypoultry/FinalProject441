extends CPUParticles3D

var the_tween : Tween

func do_it():
	pass
	make_a_da_tween("speed_scale", 50)
	mesh.size.z = 20
	await get_tree().create_timer(2, false).timeout
	mesh.size.z = 40

func make_a_da_tween(thing_to_tween, desired_value):
	the_tween = create_tween().bind_node(self)
	the_tween.set_trans(Tween.TRANS_SINE)
	the_tween.set_ease(Tween.EASE_IN_OUT)
	the_tween.tween_property(self, thing_to_tween, desired_value, 4)
