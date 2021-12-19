extends StaticBody2D


onready var collisionShape = $CollisionShape2D
onready var open = $Open
onready var closed = $Closed


var keyCount = 0


# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	PlayerStats.connect("goldenGemObtained", self, "gotKey")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("aquaGemObtained", self, "gotKey")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("fireGemObtained", self, "gotKey")
	
	open.visible = false
	closed.visible = true

func gotKey():
	keyCount += 1


# warning-ignore:unused_argument
func _physics_process(delta):
	if keyCount >= 3:
		open.visible = true
		closed.visible = false
		collisionShape.disabled = true

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Assets/Enemy/BossStage.tscn")
