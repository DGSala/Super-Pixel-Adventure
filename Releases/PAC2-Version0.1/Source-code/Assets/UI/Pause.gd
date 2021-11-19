extends Control

func _input(event):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_select") :
		visible = true

func _on_Return_pressed():
	visible = false
	PlayerStats.reset_stats()
	queue_free()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu.tscn")

func _on_Resume_pressed():
	visible = false

func _on_Exit_pressed():
	get_tree().quit()
