extends KinematicBody2D

const DeathEffect = preload("res://Assets/Effects/DeathEffect.tscn")

export(int) var MAX_SPEED = 150
export(int) var ACCELERATION = 200
export(int) var FRICTION = 400
export(int) var PUSH = 150

#AI states
enum{
	IDLE,
	CHASE
}

var pushMove = Vector2.ZERO
var state = IDLE
var motion = Vector2.ZERO

onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var blinkAnimation = $BlinkAnimation
onready var animation = $AnimatedSprite
onready var detectionZone = $DetectionZone

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pushMove = pushMove.move_toward(Vector2.ZERO, FRICTION * delta)
	pushMove = move_and_slide(pushMove)
	match state:
		IDLE:
			# Stop movement
			motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
			look_for_player()
			animation.playing = false
			animation.frame = 0
		CHASE:
			# If player is detected, chase player, else return to IDLE
			if detectionZone.player_detected():
				chase(detectionZone.player.global_position, delta)
			else:
				state = IDLE
			animation.playing = true
	motion = move_and_slide(motion)


func _on_Stats_no_health():
	load_death_effect()
	queue_free()

func load_death_effect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position

func _on_Hurtbox_end_invincibility():
	blinkAnimation.play("End")


func _on_Hurtbox_area_entered(area):
	stats.health -= area.swordDamage
	hurtbox.load_hit_effect()
	hurtbox.start_invincibility(0.5)
	blinkAnimation.play("Start")
	pushMove = area.pushMove_direction * PUSH


# If player enters detection zone, change state to CHASE
func look_for_player():
	if detectionZone.player_detected():
		state = CHASE

func chase(target, delta):
	go_to_point(target, delta)

# Move enemy to some point
func go_to_point(point, delta):
	# Save point position
	var direction = global_position.direction_to(point)
	motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

