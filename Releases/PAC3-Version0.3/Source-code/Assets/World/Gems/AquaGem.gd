extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(_body):
	if PlayerStats.worms_killed >= 5:
		PlayerStats.aquaGemObtained()
		queue_free() 
