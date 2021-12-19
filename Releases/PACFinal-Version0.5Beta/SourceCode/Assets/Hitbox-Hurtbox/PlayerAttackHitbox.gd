# Inherits script of hitbox (damage var)
extends "res://Assets/Hitbox-Hurtbox/Hitbox.gd"

var pushMove_direction = Vector2.ZERO
var swordDamage = 1

func _ready():
	# warning-ignore:return_value_discarded
	PlayerStats.connect("damage_modified", self, "update_damage")


func update_damage():
	swordDamage = PlayerStats.damage
