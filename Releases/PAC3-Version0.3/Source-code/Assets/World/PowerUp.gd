extends Node2D


onready var sound = $PowerUpSound
onready var animation = $PowerUpAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Area2D_body_entered(_body):
	animation.play("Sound")

# The aniamtion plays sound and queue_free node
func playSound():
	sound.play()
	PlayerStats.set_damage(2)
