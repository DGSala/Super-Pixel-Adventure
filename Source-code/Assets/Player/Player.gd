extends KinematicBody2D

# MOTION VARIABLES
export(int) var MAX_SPEED = 70
export(int) var ACCELERATION = 300
export(int) var SLIDE_SPEED = 85
export(int) var FRICTION = 400
export(int) var SLIDE_STAMINA = 30
export(int) var STAMINA_REGEN = 5

# Character State
enum {
	ATTACK,
	MOVE,
	SLIDE
}
var state = MOVE

# local variable to work with player stats singleton
var playerStats = PlayerStats

# Acces to scene nodes
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var playerAttackHitbox = $Pivot/PlayerAttackHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimation = $BlinkAnimation


"""PLAYER MOVEMENT BLOCK"""
# Motion vectors declaration
var motion = Vector2.ZERO
var slide = Vector2.ZERO
# Get player input on axis x and y
func get_axis() -> Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	axis = axis.normalized()
	return axis

# Control Movement stats of the player
func move_control(delta):
	var axis = get_axis()
	if axis != Vector2.ZERO:
		######### Set the AnimationTree blend position
		animationTree.set("parameters/Idle/blend_position", axis)
		animationTree.set("parameters/Run/blend_position", axis)
		animationTree.set("parameters/Attack/blend_position", axis)
		animationTree.set("parameters/Slide/blend_position", axis)
		#########
		motion = motion.move_toward(get_axis() * MAX_SPEED, ACCELERATION * delta)
		animationState.travel("Run")
		# Save the direction on axis if a slide is called
		slide = axis
		# attack direction = last movement direction
		playerAttackHitbox.pushMove_direction = axis
		
	else:
		animationState.travel("Idle")
		motion = Vector2.ZERO
	attack_and_slide_call()
	move()

# Attack and slide calls (check if stamina points > 30)
func attack_and_slide_call():
	if Input.is_action_just_pressed("attack_btn"):
		state = ATTACK
	elif Input.is_action_just_pressed("slide_btn") and get_axis() != Vector2.ZERO and playerStats.stamina >= 30:
		playerStats.stamina -= SLIDE_STAMINA
		state = SLIDE

# Calling Godot "move_and_slide" function
func move():
	motion = move_and_slide(motion)
"""END OF PLAYER MOVEMENT BLOCK"""


"""PLAYER ATTACK BLOCK"""
# Stop movement and start Attack animation
func attack_control(_delta):
	motion = Vector2.ZERO
	animationState.travel("Attack")
# Return to MOVE state
func attack_end():
	state = MOVE
"""END OF PLAYER ATTACK BLOCK"""

"""PLAYER SLIDE BLOCK"""
func slide_control(_delta):
	# Set motion on max slide speed instantly
	motion = slide * SLIDE_SPEED
	animationState.travel("Slide")
	move()
# Little stop on motinon and return to MOVE state
func slide_end():
	motion = motion * 0.3
	state = MOVE
"""END OF PLAYER SLIDE BLOCK"""

# Called when the node enters the scene tree for the first time.
func _ready():
	# activate animation Tree
	animationTree.active = true
	# Connect signal of playerstats singleton
	playerStats.connect("no_health", self, "queue_free")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		MOVE:
			move_control(delta)
		ATTACK:
			attack_control(delta)
		SLIDE:
			slide_control(delta)
	playerStats.stamina = min(playerStats.stamina + (delta * STAMINA_REGEN), 100.0)

"""HURTBOX CONTROL"""
func _on_Hurtbox_area_entered(area):
	if state != SLIDE:
		playerStats.health -= area.damage
		hurtbox.start_invincibility(1)
		blinkAnimation.play("Start")
		hurtbox.load_hit_effect()

func _on_Hurtbox_end_invincibility():
	blinkAnimation.play("Stop")
"""END HURTBOX CONTROL"""
