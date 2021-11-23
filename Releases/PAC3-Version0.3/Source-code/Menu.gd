extends MarginContainer

func _ready():
	pass # Replace with function body.



"""MAIN MENU BUTTONS CONTROL"""
func _on_Start_pressed():
	get_tree().change_scene("res://Assets/World/World.tscn")
func _on_About_pressed():
	get_tree().change_scene("res://Assets/UI/About.tscn")
func _on_Exit_pressed():
	get_tree().quit()
