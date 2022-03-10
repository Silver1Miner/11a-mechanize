extends ColorRect

func _ready() -> void:
	deactivate()

func activate() -> void:
	visible = true
	get_tree().paused = true

func deactivate() -> void:
	get_tree().paused = false
	visible = false

func _on_Button_pressed() -> void:
	deactivate()
