extends Control



func _ready():
	# warning-ignore:return_value_discarded
	PlayerStats.connect("enterBanner", self, "showTips")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("exitBanner", self, "hideTips")
	
	visible = false



func showTips():
	visible = true

func hideTips():
	visible = false
