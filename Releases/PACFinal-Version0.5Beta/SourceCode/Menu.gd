extends MarginContainer

func _ready():
	MenuMusic.play()



"""MAIN MENU BUTTONS CONTROL"""
func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Assets/World/World.tscn")
	MenuMusic.stop()
func _on_About_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Assets/UI/About.tscn")
func _on_Exit_pressed():
	get_tree().quit()
