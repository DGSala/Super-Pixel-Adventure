extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Avoid swordDamage issue
	if PlayerStats.damage > 1:
		PlayerStats.set_damage(2)

