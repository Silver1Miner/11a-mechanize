extends ColorRect

onready var choice1 = $Choices/Choice1
onready var choice2 = $Choices/Choice2
onready var choice3 = $Choices/Choice3
var available_upgrades = [0,1,2]

func _ready() -> void:
	deactivate()

func activate() -> void:
	randomize()
	available_upgrades.shuffle()
	choice1.populate_data(available_upgrades[0])
	choice2.populate_data(available_upgrades[1])
	choice3.populate_data(available_upgrades[2])
	visible = true
	get_tree().paused = true

func deactivate() -> void:
	get_tree().paused = false
	visible = false

func _on_Choice1_pressed() -> void:
	print(choice1.upgrade_id)
	deactivate()

func _on_Choice2_pressed() -> void:
	print(choice2.upgrade_id)
	deactivate()

func _on_Choice3_pressed() -> void:
	print(choice3.upgrade_id)
	deactivate()
