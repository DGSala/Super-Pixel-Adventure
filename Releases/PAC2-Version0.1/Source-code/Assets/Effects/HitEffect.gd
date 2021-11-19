extends AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	play("HitAnimation")
	# on animation finished, queue free instance
	# warning-ignore:return_value_discarded
	connect("animation_finished", self, "finish_animation")

func finish_animation():
	queue_free()
