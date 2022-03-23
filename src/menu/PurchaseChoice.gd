extends Button

var upgrade_id = 0
var Database: Resource = preload("res://data/Database.tres")
onready var title = $Info/Top/Title
onready var level = $Info/Top/Level
onready var description = $Info/Description
onready var upgrade_icon = $Info/Top/Icon

func populate_data(new_id) -> void:
	disabled = PlayerData.bought_upgrades[upgrade_id] > 3
	upgrade_id = new_id
	if upgrade_id in Database.purchase_upgrades:
		var l = PlayerData.bought_upgrades[upgrade_id]
		title.text = Database.purchase_upgrades[upgrade_id]["name"] + " " + str(l+1)
		if l < Database.purchase_upgrades[upgrade_id]["descriptions"].size():
			level.text = "Cost: " + str(Database.purchase_upgrades[upgrade_id]["cost"][l])
		else:
			level.text = ""
		if l < Database.purchase_upgrades[upgrade_id]["descriptions"].size():
			description.text = Database.purchase_upgrades[upgrade_id]["descriptions"][l]
		else:
			description.text = Database.purchase_upgrades[upgrade_id]["descriptions"][0]
		upgrade_icon.set_texture(Database.purchase_upgrades[upgrade_id]["icon"])
