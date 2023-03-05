extends Node3D

var galagaAngle  : Vector3 = Vector3(0, 0, 0)
var rTypeAngle   : Vector3 = Vector3(PI/2, 0, -PI/2)
var starFoxAngle : Vector3 = Vector3(PI/2, 0, 0)
var currentAngle : Vector3
var theShip

var cam_arcade : Camera3D
var cam_starfox : Camera3D

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Camera_Changer()
	set_global_rotation(currentAngle)


func Camera_Changer():
	if Input.is_action_pressed('GalagaAngleKey'):
		currentAngle = galagaAngle
		theShip.Set_Input_Galaga()
		cam_arcade.make_current()
	
	if Input.is_action_pressed('RTypeAngleKey'):
		currentAngle = rTypeAngle
		theShip.Set_Input_RType()
		cam_arcade.make_current()
	
	if Input.is_action_pressed('StarFoxAngleKey'):
		currentAngle = starFoxAngle
		theShip.Set_Input_StarFox()
		cam_starfox.make_current()
