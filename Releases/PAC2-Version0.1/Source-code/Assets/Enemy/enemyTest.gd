extends KinematicBody2D

export(int) var FRICTION = 400
export(int) var PUSH = 150

var pushMove = Vector2.ZERO

onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var blinkAnimation = $BlinkAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pushMove = pushMove.move_toward(Vector2.ZERO, FRICTION * delta)
	pushMove = move_and_slide(pushMove)


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.load_hit_effect()
	hurtbox.start_invincibility(0.5)
	blinkAnimation.play("Start")
	pushMove = area.pushMove_direction * PUSH



func _on_Stats_no_health():
	queue_free()


func _on_Hurtbox_end_invincibility():
	blinkAnimation.play("Stop")
