extends Control

var health = 5 setget set_health
var maxHealth = 5 setget set_maxHealth
var stamina = 100 setget set_stamina

onready var hpLabel = $VBoxContainer/HPLabel
onready var staminaLabel = $VBoxContainer/StaminaLabel
onready var ggUI = $VBoxContainer/HBoxContainer/GG
onready var fgUI = $VBoxContainer/HBoxContainer/FG
onready var agUI = $VBoxContainer/HBoxContainer/AQ
onready var gemSound = $GemSound


# Called when the node enters the scene tree for the first time.
func _ready():
	# Get vaules from PlayerStats singleton
	self.maxHealth = PlayerStats.max_health
	self.health = PlayerStats.health
	self.stamina = PlayerStats.stamina
	
	# Set Gems Visible disabled
	self.ggUI.visible = false
	self.agUI.visible = false
	self.fgUI.visible = false
	
	# warning-ignore:return_value_discarded
	PlayerStats.connect("health_modified", self, "set_health")
	PlayerStats.connect("stamina_modified", self, "set_stamina")
	PlayerStats.connect("goldenGemObtained", self, "set_gg")
	PlayerStats.connect("aquaGemObtained", self, "set_ag")
	PlayerStats.connect("fireGemObtained", self, "set_fg")

func set_health(value):
	# clamp -> value always >0 and <maxHealth
	health = clamp(value, 0, maxHealth)
	hpLabel.text = "hp: " + str(health)
	
func set_maxHealth(value):
	# max func -> never maxHealth < 1
	maxHealth = max(value, 1)

func set_stamina(value):
	stamina = clamp(value, 0, 100)
	staminaLabel.text = "sp: " + str(int(stamina))

func set_gg():
	ggUI.visible = true
	gemSound.play()
	
func set_fg():
	fgUI.visible = true
	gemSound.play()
	
func set_ag():
	agUI.visible = true
	gemSound.play()
