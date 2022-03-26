extends ColorRect

func _update_lore() -> void:
	$OptionButton.clear()
	for i in PlayerData.lore_collected:
		print(i)
		$OptionButton.add_item(titles[i])
	if $OptionButton.get_item_count() > 0:
		_on_OptionButton_item_selected(0)

var titles = ["Drops", "Old Man", "Entry 3", "Entry 4", "Entry 5", "Entry 6"]
var entries = [
"Though the soul gem is believed to be formed from the souls collected by the " + \
"by the fiend, it remains unknown how or where the fiends obtain the gold and " + \
"the texts occasionally found dropped by their remains.",
"The strange trader in metals is known only as 'the Old Man.' " +\
"He actively purchases 'cursed gold,' and in exchange often sells " +\
"silver and iron, which has proven effective against the fiends, as well " +\
"as various services such as repairs and upgrade to anti-fiend equipment.",
"Entry text 3",
"Entry text 4",
"Entry text 5",
"Entry text 6",
]

func _on_Close_pressed() -> void:
	visible = false

func _on_OptionButton_item_selected(index: int) -> void:
	$Text.text = entries[index]
