extends Node2D


onready var sound = $AudioStreamPlayer
onready var animation = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# The aniamtion plays sound and queue_free node
func playSound():
	sound.play()


# If player health < max_health, then heal up 1 point
func _on_Area2D_body_entered(_body):
	animation.play("Sound")
	if PlayerStats.health < PlayerStats.max_health:
		PlayerStats.health += 1
