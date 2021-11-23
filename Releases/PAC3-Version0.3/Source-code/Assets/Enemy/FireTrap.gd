extends Area2D


onready var timer = $Timer
onready var animation = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("Start")

# Set new timer with a random value between 3 and 6 seconds
func set_new_timer():
	start_timer(rand_range(3,6))

func start_timer(seconds):
	timer.start(seconds)

func not_visible():
	visible = false

func _on_Timer_timeout():
	visible = true
	animation.play("Start")
