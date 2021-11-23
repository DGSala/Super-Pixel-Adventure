extends KinematicBody2D

const DeathEffect = preload("res://Assets/Effects/DeathEffect.tscn")

export(int) var MAX_SPEED = 50
export(int) var ACCELERATION = 100
export(int) var FRICTION = 400
export(int) var PUSH = 150

#AI states
enum{
	IDLE,
	ROAM,
	CHASE
}


var pushMove = Vector2.ZERO
var state = IDLE
var motion = Vector2.ZERO

onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var blinkAnimation = $BlinkAnimation
onready var detectionZone = $DetectionZone
onready var roamController = $RoamController

# Called when the node enters the scene tree for the first time.
func _ready():
	state = random_state([IDLE, ROAM])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Knockback push vectors
	pushMove = pushMove.move_toward(Vector2.ZERO, FRICTION * delta)
	pushMove = move_and_slide(pushMove)
	"""AI STATE CONTROL BLOCK"""
	match state:
		IDLE:
			# Stop movement
			motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
			look_for_player()
			# when time left = 0, random IDLE or ROAM state
			if roamController.get_time_left() == 0:
				set_new_state()
		ROAM:
			look_for_player()
			# when time left = 0, random IDLE or ROAM state
			if roamController.get_time_left() == 0:
				set_new_state()
			chase(roamController.next_position, delta)
		CHASE:
			# If player is detected, chase player, else return to IDLE
			if detectionZone.player_detected():
				chase(detectionZone.player.global_position, delta)
			else:
				state = IDLE
	motion = move_and_slide(motion)
	"""AI STATE CONTROL END"""

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

func _on_Stats_no_health():
	load_death_effect()
	queue_free()

func load_death_effect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	stats.health -= area.swordDamage
	hurtbox.load_hit_effect()
	hurtbox.start_invincibility(0.5)
	blinkAnimation.play("Start")
	pushMove = area.pushMove_direction * PUSH

func _on_Hurtbox_end_invincibility():
	blinkAnimation.play("Stop")

# Set new random state (IDLE or ROAM) and start timer with range 1-2 seconds
func set_new_state():
	state = random_state([IDLE, ROAM])
	roamController.start_timer(rand_range(1,2))

func random_state(statesArray):
	statesArray.shuffle()
	return statesArray.pop_front()
	
