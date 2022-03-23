extends ColorRect

func _ready() -> void:
	$Record.visible = false

func activate_manual() -> void:
	visible = true

func _on_Close_pressed() -> void:
	visible = false

func _on_Back_pressed() -> void:
	$Record.visible = false

func _on_Records_pressed() -> void:
	$Record.visible = true
