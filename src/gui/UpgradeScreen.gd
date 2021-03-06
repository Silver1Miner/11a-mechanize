extends ColorRect

onready var choice1 = $Choices/Choice1
onready var choice2 = $Choices/Choice2
onready var choice3 = $Choices/Choice3
var available_upgrades = [-1,0,1,2,3,4,5]
var Database: Resource = preload("res://data/Database.tres")

func _ready() -> void:
	deactivate()

func activate() -> void:
	if len(available_upgrades) < 3:
		available_upgrades.append(-1)
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
	PlayerData.upgrade(choice1.upgrade_id)
	check_limits(choice1.upgrade_id)
	deactivate()

func _on_Choice2_pressed() -> void:
	PlayerData.upgrade(choice2.upgrade_id)
	check_limits(choice2.upgrade_id)
	deactivate()

func _on_Choice3_pressed() -> void:
	PlayerData.upgrade(choice3.upgrade_id)
	check_limits(choice3.upgrade_id)
	deactivate()

func check_limits(upgrade_id) -> void:
	if PlayerData.player_upgrades[upgrade_id] >= Database.upgrades[upgrade_id]["max_level"]:
		available_upgrades.erase(upgrade_id)
		print(Database.upgrades[upgrade_id]["name"] + " maxed out")
