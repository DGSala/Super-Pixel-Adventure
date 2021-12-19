extends Node2D

onready var animation = $AnimatedSprite
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("Fall")

func _on_AnimatedSprite_animation_finished():
	queue_free()
