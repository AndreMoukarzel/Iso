extends Node2D

onready var timer = get_node("Timer")


func _ready():
	set_physics_process(false)


func tween_transparency(end_transparency, time = 0.1):
	var twn = get_node("Tween")
	twn.remove_all()
	twn.interpolate_property(self, "modulate", Color(1, 1, 1, 1 - end_transparency), Color(1, 1, 1, end_transparency), time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	twn.start()


func start():
	timer.start()
	tween_transparency(1)
	set_physics_process(true)


func set_wait_time(time):
	timer.set_wait_time(time)


func get_time_left():
	return timer.time_left


func _physics_process(delta):
	var val = 100 * (timer.time_left / timer.wait_time)
	get_node("TextureProgress").set_value(val)
	if val == 0:
		set_physics_process(false)
		tween_transparency(0, 0.2)