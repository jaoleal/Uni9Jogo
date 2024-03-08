extends KinematicBody2D
export (int) var max_speed = 500
export (int) var min_speed = 400
export (int) var acceleration_per_frame = 20
export (int) var gravity = 100
export (int) var jump_force = 1500

const UP_DIR =  Vector2.UP
var velocity = Vector2()
var direction
var momentun_lock = false
var last_dir = 1
var actual_speed = 0

func _ready():
	pass # Replace with function body.

func apply_gravity(_item):
	_item.y += gravity
	return _item

func move(_item, _direction):
## This function that controls the character horizontal acceleration when moving to left or right
	if not is_zero_approx(_direction) and not momentun_lock:
		if direction > 0:
			last_dir = 1
		elif direction < 0:
			last_dir = -1
		else:
			last_dir = last_dir 
		if actual_speed <= max_speed:
			actual_speed += acceleration_per_frame
	else:
		if actual_speed >= min_speed:
			actual_speed -= acceleration_per_frame
			momentun_lock = true
		else:
			actual_speed = 0
			momentun_lock = false
		
	_item.x = actual_speed * last_dir

	print(_item)
	print(actual_speed)
	
	return _item

func horizontal_movement(_item):
	direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	_item = move_and_slide(move(_item, direction), UP_DIR)

	return _item


func vertical_movement(_item, is_falling, can_jump):
	_item  = apply_gravity(_item)
	if(can_jump and Input.is_action_pressed("jump")):
		_item.y = -jump_force
	return _item


##Rely all physics here
func _physics_process(delta):
	#states
	var is_falling = velocity.y > 0.0 and not is_on_floor()
	var can_jump = is_on_floor()
	var is_running =  not is_zero_approx(velocity.x) and is_on_floor()
	velocity = horizontal_movement(velocity)
	velocity = vertical_movement(velocity, is_falling, can_jump)

	

func _process(delta):

	pass 
	
