
extends KinematicBody2D

export (int)var MOVE_SPD = 1200
export (float)var ACT_TIME = 0.5

var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

var grid
var timer


func cartesian_to_isometric(vector):
	return Vector2(vector.x - vector.y, (vector.x + vector.y) / 2)

func _ready():
	grid = get_parent().get_parent()
	if not timer:
		print("bleu")
		timer = get_node("ActionTimer")
	timer.set_wait_time(ACT_TIME)
	set_physics_process(true)


func _physics_process(delta):
	if is_moving:
		# We have to convert the player's motion to the isometric system.
		var motion = cartesian_to_isometric(MOVE_SPD * target_direction * delta)

		var pos = get_position()
		var distance_to_target = pos.distance_to(target_pos)
		var move_distance = motion.length()

		if move_distance > distance_to_target:
			set_position(target_pos)
			is_moving = false
		else:
			move_and_collide(motion)


func move(direction):
	if not is_moving and get_node("ActionTimer").get_time_left() == 0:
		target_direction = direction.normalized()
		if grid.is_cell_vacant(get_position(), target_direction):
			target_pos = grid.update_child_pos(get_position(), target_direction, 1)
			is_moving = true
			timer.start()
			set_physics_process(true)
			return true
	return false