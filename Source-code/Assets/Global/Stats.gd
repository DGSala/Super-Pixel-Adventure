extends Node

export(int) var max_health = 5 setget set_max_health
export(int) var stamina = 100 setget set_stamina

var health setget set_health
var fireGem = false
var aquaGem = false
var goldenGem = false

signal no_health
signal health_modified(value)
signal max_health_modified(value)
signal stamina_modified(value)
signal goldenGemObtained
signal fireGemObtained
signal aquaGemObtained

# Called when the node enters the scene tree for the first time.
func _ready():
	self.health = max_health
	fireGem = false
	aquaGem = false
	goldenGem = false

func set_max_health(value):
	max_health = value
	# call min method to make sure always health <= max_health
	#self.health = min(health, max_health)
	emit_signal("max_health_modified")
	
func set_health(value):
	health = value
	emit_signal("health_modified", health)
	if health <= 0:
		emit_signal("no_health")

func set_stamina(value):
	stamina = value
	emit_signal("stamina_modified", stamina)

func reset_stats():
	health = 5
	max_health = 5
	stamina = 100
	aquaGem = false
	fireGem = false
	goldenGem = false

func heal():
	health = max_health
	emit_signal("health_modified", health)
	
func goldenGemObtained():
	goldenGem = true
	emit_signal("goldenGemObtained")

func fireGemObtained():
	fireGem = true
	emit_signal("fireGemObtained")

func aquaGemObtained():
	aquaGem = true
	emit_signal("aquaGemObtained")
