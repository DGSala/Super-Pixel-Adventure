extends KinematicBody2D

const DeathEffect = preload("res://Assets/Effects/DeathEffect.tscn")

export(int) var MAX_SPEED = 180
export(int) var ACCELERATION = 200
export(int) var FRICTION = 400

#AI states
enum{
	IDLE,
	ROAM,
	DIED
}

onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var blinkAnimation = $BlinkAnimation
onready var roamController = $RoamController
onready var timer = $Timer
onready var hitboxCollision = $Hitbox/CollisionShape2D
onready var hurtboxCollision = $Hurtbox/CollisionShape2D
onready var explosionSound = $Explosion

var motion = Vector2.ZERO
var state = IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	match state:
		IDLE:
			# Stop movement
			motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
			# when time left = 0, random IDLE or ROAM state
			if roamController.get_time_left() == 0:
				set_new_state()
		ROAM:
			# when time left = 0, random IDLE or ROAM state
			if roamController.get_time_left() == 0:
				set_new_state()
			chase(roamController.next_position, delta)
		DIED:
			# Stop movement and disable hurt/hitbox
			motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
			visible = false
			hitboxCollision.disabled = true
			hurtboxCollision.disabled = true
			
	motion = move_and_slide(motion)
	

func chase(target, delta):
	go_to_point(target, delta)

# Move enemy to some point
func go_to_point(point, delta):
	# Save point position
	var direction = global_position.direction_to(point)
	motion = motion.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

# Set new random state (IDLE or ROAM) and start timer with range 0-2 seconds
func set_new_state():
	state = random_state([IDLE, ROAM])
	roamController.start_timer(rand_range(0,2))

func random_state(statesArray):
	statesArray.shuffle()
	return statesArray.pop_front()

func _on_Hurtbox_area_entered(area):
	stats.health -= area.swordDamage
	hurtbox.load_hit_effect()
	hurtbox.start_invincibility(0.5)
	blinkAnimation.play("Start")


func _on_Hurtbox_end_invincibility():
	blinkAnimation.play("Stop")

# At Boss dying, end game after 3 seconds
func _on_Stats_no_health():
	load_death_effect()
	explosionSound.play()
	timer.start(3)
	state = DIED

func load_death_effect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position


func game_completed():
	PlayerStats.reset_stats()
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Assets/UI/GameCompleted.tscn")


func _on_Timer_timeout():
	game_completed()
