extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_ReadArea_body_entered(_body):
	PlayerStats.enterRead()


func _on_ReadArea_body_exited(_body):
	PlayerStats.exitRead()
