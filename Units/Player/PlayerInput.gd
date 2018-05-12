extends Node

const UP = Vector2(+0, -1)
const DW = Vector2(+0, +1)
const LF = Vector2(-1, +0)
const RT = Vector2(+1, +0)

func _process(delta):
	if Input.is_action_pressed("move_up"):
		get_parent().move(UP)
	elif Input.is_action_pressed("move_down"):
		get_parent().move(DW)
	elif Input.is_action_pressed("move_left"):
		get_parent().move(LF)
	elif Input.is_action_pressed("move_right"):
		get_parent().move(RT)