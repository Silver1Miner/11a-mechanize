extends ColorRect

onready var _confirmation = $Confirmation
onready var _confirmation_label = $Confirmation/Label

func _ready() -> void:
	activate_confirmation("Upgrade 1", 3)

func activate_shop() -> void:
	$Coins/Label.text = str(PlayerData.total_coins)
	_confirmation.visible = false
	visible = true

func activate_confirmation(id: String, cost: int) -> void:
	_confirmation_label.text = "Buy %s for %s Coins?" % [id, cost]

func _on_Close_pressed() -> void:
	visible = false

func _on_Buy_pressed() -> void:
	print("purchase confirmed")
	_confirmation.visible = false

func _on_Cancel_pressed() -> void:
	_confirmation.visible = false
