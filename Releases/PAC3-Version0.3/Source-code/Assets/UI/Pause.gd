extends Control



func _input(event):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_select") :
		# Pause control
		get_tree().paused = true
		visible = true

func _on_Return_pressed():
	get_tree().paused = false
	visible = true
	PlayerStats.reset_stats()
	queue_free()
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu.tscn")

func _on_Resume_pressed():
	get_tree().paused = false
	visible = false

func _on_Exit_pressed():
	get_tree().quit()
