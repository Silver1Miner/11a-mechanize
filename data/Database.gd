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
	5,
	15,
]

var upgrades := {
	-1: {"name": "Bounty Bonus", "max_level": 1,
	"descriptions": [
		"+1 Coin"
	]
	},
	0: {"name": "Iron Revolver", "max_level": 11,
	"descriptions": [
		"A reliable wrist-mounted revolver.", #0
		"A reliable wrist-mounted revolver. Damage +2", #1
	],
	"icon": preload("res://assets/guns/turret2.png")
	},
	1: {"name": "Silver SMG", "max_level": 11,
	"descriptions": [
		"A wrist-mounted submachine gun.",
		"A wrist-mounted submachine gun. Damage +2", #1
	],
	"icon": preload("res://assets/guns/turret1.png")
	},
	2: {"name": "Iron Slug", "max_level": 11,
	"descriptions": [
		"A waist-mounted shotgun.", #0
		"Upgrade 1.",
	],
	"icon": preload("res://assets/guns/turret2.png")
	},
	3: {"name": "Silver Chaingun", "max_level": 11,
	"descriptions": [
		"A shoulder-mounted machine gun.",
	],
	"icon": preload("res://assets/guns/turret1.png")
	},
	4: {"name": "Iron Rocket", "max_level": 11,
	"descriptions": [
		"A shoulder-mounted rocket launcher.",
	],
	"icon": preload("res://assets/guns/turret2.png")
	},
	5: {"name": "Silver Flame", "max_level": 11,
	"descriptions": [
		"A waist-mounted flamethrower.",
	],
	"icon": preload("res://assets/guns/turret2.png")
	},
	6: {"name": "Max Health", "max_level": 4,
	"descriptions": [
		"Increase maximum healthy by 25.",
	],
	},
}
