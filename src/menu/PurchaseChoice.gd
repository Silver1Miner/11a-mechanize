extends Button

var upgrade_id = 0
var cost = 0
var Database: Resource = preload("res://data/Database.tres")
onready var title = $Info/Top/Title
onready var level = $Info/Top/Level
onready var description = $Info/Description
onready var upgrade_icon = $Info/Top/Icon
var disabled_color = Color(115.0/255,115.0/255,115.0/255,115.0/255)
var active_color = Color(224.0/255,224.0/255,224.0/255,1)


func populate_data(new_id) -> void:
	disabled = PlayerData.bought_upgrades[upgrade_id] >= 3
	upgrade_id = new_id
	if upgrade_id in Database.purchase_upgrades:
		var l = PlayerData.bought_upgrades[upgrade_id]
		title.text = Database.purchase_upgrades[upgrade_id]["name"] + " " + str(l+1)
		if l >= 3:
			title.text = Database.purchase_upgrades[upgrade_id]["name"]
		if l < Database.purchase_upgrades[upgrade_id]["descriptions"].size():
			level.text = "Cost: " + str(Database.purchase_upgrades[upgrade_id]["cost"][l])
			if not disabled:
				disabled = Database.purchase_upgrades[upgrade_id]["cost"][l] > PlayerData.current_coins
		else:
			level.text = ""
		if l < Database.purchase_upgrades[upgrade_id]["descriptions"].size():
			description.text = Database.purchase_upgrades[upgrade_id]["descriptions"][l]
		else:
			description.text = Database.purchase_upgrades[upgrade_id]["descriptions"][0]
		upgrade_icon.set_texture(Database.purchase_upgrades[upgrade_id]["icon"])
	if disabled:
		title.self_modulate = disabled_color
		level.self_modulate = disabled_color
		description.self_modulate = disabled_color
	else:
		title.self_modulate = active_color
		level.self_modulate = active_color
		description.self_modulate = active_color
