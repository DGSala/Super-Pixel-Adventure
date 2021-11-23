extends Area2D


const Trap = preload("res://Assets/World/Trap.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func load_trap():
	var trap = Trap.instance()
	get_parent().call_deferred("add_child", trap)
	trap.global_position = global_position


func _on_trapArea_body_entered(_body):
	load_trap()
	queue_free()
