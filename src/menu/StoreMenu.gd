extends ColorRect

onready var _confirmation = $Confirmation
onready var _confirmation_label = $Confirmation/Label
var current_option := -1
var Database: Resource = preload("res://data/Database.tres")

func _ready() -> void:
	activate_confirmation("Upgrade 1", 3)

func activate_shop() -> void:
	$Coins.update_coins(PlayerData.current_coins)
	_confirmation.visible = false
	$PurchaseOptions/PurchaseChoice.populate_data(0)
	$PurchaseOptions/PurchaseChoice2.populate_data(1)
	$PurchaseOptions/PurchaseChoice3.populate_data(2)
	$PurchaseOptions/PurchaseChoice4.populate_data(3)
	visible = true

func activate_confirmation(id: String, cost: int) -> void:
	_confirmation_label.text = "Buy %s for %s Coins?" % [id, cost]

func _on_Close_pressed() -> void:
	visible = false

func _on_Buy_pressed() -> void:
	print("purchase confirmed")
	$PurchaseOptions/PurchaseChoice.populate_data(0)
	$PurchaseOptions/PurchaseChoice2.populate_data(1)
	$PurchaseOptions/PurchaseChoice3.populate_data(2)
	$PurchaseOptions/PurchaseChoice4.populate_data(3)
	_confirmation.visible = false

func _on_Cancel_pressed() -> void:
	_confirmation.visible = false
	current_option = -1

func _on_PurchaseChoice_pressed() -> void:
	current_option = 0
	set_confirmation_text(0)
	_confirmation.visible = true

func _on_PurchaseChoice2_pressed() -> void:
	current_option = 1
	set_confirmation_text(1)
	_confirmation.visible = true

func _on_PurchaseChoice3_pressed() -> void:
	current_option = 2
	set_confirmation_text(2)
	_confirmation.visible = true

func _on_PurchaseChoice4_pressed() -> void:
	current_option = 3
	set_confirmation_text(3)
	_confirmation.visible = true

func set_confirmation_text(id: int) -> void:
	var l = PlayerData.bought_upgrades[id]
	_confirmation_label.text = "Buy %s Level %s for %s coins?" % \
	[Database.purchase_upgrades[id]["name"],
	str(l+1),
	Database.purchase_upgrades[id]["cost"][l]]
