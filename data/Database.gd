extends Resource

var type_colors := [
	Color(54.0/255, 187.0/255, 245.0/255), #blue
	Color(172.0/255,57.0/255,57.0/255), # red
	Color(113.0/255, 170.0/255, 55.0/255), # yellow
]
enum PICKUPS {GEM, COIN}
var pickup_effect_text := [
	"+1 Gem",
	"+1 Coin"
]

var exp_scale := [
	0,
	30,
	60,
	80,
]
