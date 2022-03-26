extends ColorRect

func _ready() -> void:
	$Record.visible = false

func activate_manual() -> void:
	visible = true

func _on_Close_pressed() -> void:
	visible = false

func _on_Records_pressed() -> void:
	$Record._update_records()
	$Record.visible = true


func _on_Lore_pressed() -> void:
	$Lore._update_lore()
	$Lore.visible = true
