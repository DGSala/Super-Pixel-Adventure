extends Node

export(int) var max_health = 5 setget set_max_health
export(int) var stamina = 100 setget set_stamina
export(int) var worms_killed = 0 setget set_worms_killed
export(int) var damage = 1 setget set_damage

var health setget set_health
var fireGem = false
var aquaGem = false
var goldenGem = false


signal no_health
signal health_modified(value)
signal max_health_modified(value)
signal stamina_modified(value)
signal worms_killed_modified(value)
signal damage_modified(value)
signal goldenGemObtained
signal fireGemObtained
signal aquaGemObtained
signal enterBanner
signal exitBanner

# Called when the node enters the scene tree for the first time.
func _ready():
	self.health = max_health
	fireGem = false
	aquaGem = false
	goldenGem = false
	self.worms_killed = 0

func set_damage(value):
	damage = value
	emit_signal("damage_modified")

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

func set_worms_killed(value):
	worms_killed = value
	emit_signal("worms_killed_modified")

func reset_stats():
	health = 5
	max_health = 5
	damage = 1
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

func enterRead():
	emit_signal("enterBanner")

func exitRead():
	emit_signal("exitBanner")

