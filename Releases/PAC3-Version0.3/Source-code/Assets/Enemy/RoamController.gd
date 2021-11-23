extends Node2D

export(int) var roam_range = 24

onready var first_position = global_position
onready var next_position = global_position
onready var timer = $Timer

func _ready():
	set_next()

func set_next():
	# Pick a random number of range to set new position
	var next_vector = Vector2(rand_range(-roam_range, roam_range), rand_range(-roam_range, roam_range))
	next_position = first_position + next_vector

func _on_Timer_timeout():
	set_next()

func start_timer(seconds):
	timer.start(seconds)

func get_time_left():
	return timer.time_left
