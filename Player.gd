extends KinematicBody2D

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO

func _ready():
	if !$Sprite.texture:
		GameManager.set_sprite($Sprite)


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func set_texture_to(filepath):
	$Sprite.texture = load(filepath)
	
func set_position_to(pos):
	var use_vec = format_string_vector(pos)
	position = use_vec
	print("Position=", use_vec)

func format_string_vector(use_string):
	var formatted_string = use_string.substr(1,use_string.length()-2)
	var tuple = formatted_string.split(",")
	var x = int(tuple[0])
	var y = int(tuple[1])
	return Vector2(x,y)
	
	
	
