extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = $AnimatedSprite
onready var sound = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RecoveryArea_body_entered(_body):
	sound.play()
	PlayerStats.heal()
