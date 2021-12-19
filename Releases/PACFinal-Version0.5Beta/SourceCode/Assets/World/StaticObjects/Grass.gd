extends StaticBody2D


const LeafEffect = preload("res://Assets/Effects/LeafEffect.tscn")

# Called when the node enters the scene tree for the first time.
func call_leaf_effect():
	var leafEffect = LeafEffect.instance()
	get_parent().add_child(leafEffect)
	leafEffect.global_position = global_position
	
	
func _on_Hurtbox_area_entered(_area):
	call_leaf_effect()
	queue_free()
