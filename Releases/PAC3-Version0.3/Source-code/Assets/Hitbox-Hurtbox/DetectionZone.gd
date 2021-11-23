extends Area2D

var player = null

func _on_DetectionZone_body_entered(body):
	player = body

func _on_DetectionZone_body_exited(_body):
	player = null

# If a player is detected, returns true
func player_detected():
	return player != null
