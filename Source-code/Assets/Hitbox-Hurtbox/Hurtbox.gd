extends Area2D

const hitEffect = preload("res://Assets/Effects/HitEffect.tscn")

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

signal end_invincibility

func load_hit_effect():
	# load hitEffect instance
	var hit = hitEffect.instance()
	
	# add hiteffect instance to current hurtbox in the same position
	var world = get_tree().current_scene
	world.add_child(hit)
	hit.global_position = global_position

## Enable invincibility func
## Parameter: timer duration
func start_invincibility(value):
	collisionShape.set_deferred("disabled", true)
	timer.start(value)

# Disable invincibility after timer signal
func _on_Timer_timeout():
	collisionShape.disabled = false
	emit_signal("end_invincibility")
