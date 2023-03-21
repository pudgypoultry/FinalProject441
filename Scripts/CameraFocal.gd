extends Node3D

var galagaAngle  : Vector3 = Vector3(0, 0, 0)
var rTypeAngle   : Vector3 = Vector3(PI/2, 0, -PI/2)
var starFoxAngle : Vector3 = Vector3(PI/2, 0, 0)
var currentAngle : Vector3
var theShip
var desired_position

var cam_arcade : Camera3D
var cam_starfox : Camera3D

var tween_rotation : Tween

const CAM_MODE = {
	ARCADE = 0,
	STARFOX = 1
}

# Called when the node enters the scene tree for the first time.
func _ready():
	currentAngle = galagaAngle
	theShip = get_node("../GalagaShip")
	cam_arcade = get_node("./OrthogonalCamera")
	cam_starfox = get_node("./FrustrumCamera")
	#tween.tween_property($Sprite, "position", Vector3(100, 200, 300), 1)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Camera_Changer()
	#set_global_rotation(currentAngle)


func Camera_Changer():
	if Input.is_action_pressed('GalagaAngleKey'):
		currentAngle = galagaAngle
		make_a_da_tween(currentAngle)
		theShip.Set_Input_Galaga()
		cam_arcade.make_current()
	
	if Input.is_action_pressed('RTypeAngleKey'):
		currentAngle = rTypeAngle
		make_a_da_tween(currentAngle)
		theShip.Set_Input_RType()
		cam_arcade.make_current()
	
	if Input.is_action_pressed('StarFoxAngleKey'):
		currentAngle = starFoxAngle
		cam_starfox.make_current()
		make_a_da_tween(currentAngle)
		theShip.Set_Input_StarFox()


func make_a_da_tween(desired_rot):
	tween_rotation = create_tween().bind_node(self)
	tween_rotation.set_trans(Tween.TRANS_SINE)
	tween_rotation.set_ease(Tween.EASE_IN_OUT)
	tween_rotation.tween_property(self, "rotation", desired_rot, 0.2)

func DO_IT():
	desired_position = get_node("../EnemyGrabber").position
	var tween_position = create_tween().bind_node(self)
	tween_position.set_trans(Tween.TRANS_SINE)
	tween_position.set_ease(Tween.EASE_IN_OUT)
	tween_position.tween_property(self, "position", desired_position + Vector3(0,0,-90), 4)
	make_a_da_tween(Vector3(PI + 0.5, -PI + 0.5, -PI - 0.5))
	var last_tween = create_tween().bind_node(self)
	last_tween.set_trans(Tween.TRANS_SINE)
	last_tween.set_ease(Tween.EASE_IN_OUT)
	last_tween.tween_property(self, "rotation", -Vector3(PI + 0.5, -PI + 0.5, -PI - 0.5), 30)
