extends ColorRect

func _update_lore() -> void:
	$OptionButton.clear()
	for i in PlayerData.lore_collected:
		$OptionButton.add_item(titles[i])
	if $OptionButton.get_item_count() > 0:
		_on_OptionButton_item_selected(0)

var titles = ["Drops", "Old Man", "Silver-Iron", "Above-Below", "Duals", "Old Man Origins"]
var entries = [
"Though the soul gem is believed to be formed from the souls collected by the " + \
"by the fiend, it remains unknown how or where the fiends obtain the gold and " + \
"the texts occasionally found dropped by their remains.",
"The strange trader in metals is known only as 'the Old Man.' " +\
"He actively purchases 'cursed gold,' and in exchange often sells " +\
"silver and iron, which has proven effective against the fiends, as well " +\
"as various services such as repairs and upgrade to anti-fiend equipment.",
"Silver, chemical element Ag, atomic number 47. " +\
"Particularly effective against devils and lycanthropes. \n" +\
"Iron, chemical element Fe, atomic number 26. " + \
"Partifuclarly effective aganst demons and fey.",
"Though popular imagination associates 'hell' with 'below' " +\
"(and 'heaven' with 'above'), there have been proposals that " +\
"such a view is too simplisitic, and that the fiends of hell " +\
"have in fact subverted and taken advantage of such common beliefs. " +\
"Many hellish creatures now disguise their origins " +\
"by claiming to be extraterrestrial creatures visiting from " +\
"the stars above.",
"With and without mutually create \n" +\
"Hard and easy mutually complete \n" +\
"Long and short mutually compare \n" +\
"High and low mutually incline \n" +\
"Tone and noise mutually harmonize \n" +\
"Front and rear mutually follow",
"The Old Man comes from the stars. The fiends of hell also " +\
"claim to come from the stars. Is there a connection?" +\
"Can the Old Man truly be trusted?",
]

func _on_Close_pressed() -> void:
	visible = false

func _on_OptionButton_item_selected(index: int) -> void:
	$Text.text = entries[index]
