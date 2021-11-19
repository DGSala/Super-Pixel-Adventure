extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerStats.health == 0:
		visible = true
		PlayerStats.reset_stats()


func _on_ReturnButton_pressed():
	visible = false
	queue_free()
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
