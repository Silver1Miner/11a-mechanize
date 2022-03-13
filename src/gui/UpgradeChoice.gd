extends Button

var upgrade_id = 0
var Database: Resource = preload("res://data/Database.tres")
onready var title = $Info/Top/Title
onready var level = $Info/Top/Level
onready var description = $Info/Description
onready var upgrade_icon = $Info/Top/Icon

func populate_data(new_id) -> void:
	upgrade_id = new_id
	if upgrade_id in Database.upgrades:
		title.text = Database.upgrades[upgrade_id]["name"]
		var l = PlayerData.player_upgrades[upgrade_id]
		level.text = str(l+1)
		if l < Database.upgrades[upgrade_id]["descriptions"].size():
			description.text = Database.upgrades[upgrade_id]["descriptions"][l]
		else:
			description.text = Database.upgrades[upgrade_id]["descriptions"][0]
		upgrade_icon.set_texture(Database.upgrades[upgrade_id]["icon"])
