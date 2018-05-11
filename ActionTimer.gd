extends ProgressBar

onready var timer = get_node("Timer")


func _ready():
	set_physics_process(false)


func start():
	timer.start()
	set_physics_process(true)


func set_wait_time(time):
	timer.set_wait_time(time)

func get_time_left():
	return timer.time_left


func _physics_process(delta):
	var val = 100 * (timer.time_left / timer.wait_time)
	self.set_value(val)
	if val == 0:
		set_physics_process(false)