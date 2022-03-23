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

var enemy_species := [
	{"name": "Rat", "hp": 10,"speed": 30, "attack": 5},
	{"name": "Fiend", "hp": 50,"speed": 30, "attack": 10},
	{"name": "Winged Fiend", "hp": 100,"speed": 100, "attack": 10},
	{"name": "Shaman Fiend", "hp": 400,"speed": 30, "attack": 20},
	{"name": "Armored Fiend", "hp": 1000,"speed": 20, "attack": 10},
]

var exp_scale := [
	0,
	5,
	10,
]

var purchase_upgrades := {
	0: {"name": "Max Health",
	"descriptions": [
		"+5 Max Health per Level",
		"+10 Max Health per Level",
		"+15 Maximum Health per Level",
		"SOLD OUT"
	],
	"cost": [5, 10, 15],
	"icon": preload("res://assets/pickups/coin_26.png")
	},
	1: {"name": "Regeneration",
	"descriptions": [
		"+1 Health Regeneration",
		"+2 Health Regeneration",
		"+3 Health Regeneration",
		"SOLD OUT"
	],
	"cost": [10, 15, 20],
	"icon": preload("res://assets/pickups/coin_26.png")},
	2: {"name": "Damage Bonus",
	"descriptions": [
		"+10% Damage",
		"+20% Damage",
		"+30% Damage",
		"SOLD OUT"
	],
	"cost": [5, 10, 15],
	"icon": preload("res://assets/pickups/coin_26.png")},
	3: {"name": "Critical Bonus",
	"descriptions": [
		"+10% Critical Multiplier",
		"+20% Critical Multiplier",
		"+30% Critical Multiplier",
		"SOLD OUT"
	],
	"cost": [10, 15, 20],
	"icon": preload("res://assets/pickups/coin_26.png")},
}

var upgrades := {
	-1: {"name": "Bounty Bonus", "max_level": 1,
	"descriptions": [
		"+1 Coin"
	],
	"icon": preload("res://assets/pickups/coin_26.png"),
	},
	0: {"name": "Iron Revolver", "max_level": 11,
	"descriptions": [
		"A reliable wrist-mounted revolver.", #0
		"Level 2: Damage +20% from Base", #1
		"Level 3: Fire Rate +25% from Base",
		"Level 4: Damage +60% from Base",
		"Level 5: Fire Rate +100% from Base",
		"Level 6: Damage +100% from Base",
		"Level 7: Fire Rate +150% from Base",
		"Level 8: Damage +200% from Base",
		"Level 9: Fire Rate +400% from Base",
		"Level 10: Damage +300% from Base",
		"Level 11: Damage +400% from Base",
	],
	"icon": preload("res://assets/guns/ironrevolver.png"),
	"damage": [5, 6, 6, 8, 8, 10, 10, 15, 15, 20, 25],
	"cooldown": [1.0, 1.0, 0.8, 0.8, 0.5, 0.5, 0.4, 0.4, 0.2, 0.2],
	},
	1: {"name": "Silver SMG", "max_level": 11,
	"descriptions": [
		"A wrist-mounted submachine gun.",
		"Level 2: Damage +2", #1
	],
	"icon": preload("res://assets/guns/silversmg.png"),
	"damage": [2, 4, 4, 4],
	"cooldown": [0.4, 0.4, 0.4, 0.4],
	},
	2: {"name": "Iron Slug", "max_level": 11,
	"descriptions": [
		"A waist-mounted shotgun.", #0
		"Level 2: Damage +20% from Base",
		"Level 3: Fire Rate +25% from Base",
		"Level 4: Damage +60% from Base",
		"Level 5: Fire Rate +100% from Base",
		"Level 6: Damage +100% from Base",
		"Level 7: Fire Rate +150% from Base",
		"Level 8: Damage +200% from Base",
		"Level 9: Fire Rate +400% from Base",
		"Level 10: Damage +300% from Base",
		"Level 11: Damage +400% from Base",
	],
	"icon": preload("res://assets/guns/turret2.png"),
	"damage": [5, 6, 6, 8, 8, 10, 10, 15, 15, 20, 25],
	"cooldown": [1.0, 1.0, 0.8, 0.8, 0.5, 0.5, 0.4, 0.4, 0.2, 0.2],
	"attack_range": [128,128,128,128,128,128,128,128,128,128,128]
	},
	3: {"name": "Silver Chaingun", "max_level": 11,
	"descriptions": [
		"A shoulder-mounted machine gun.",
	],
	"icon": preload("res://assets/guns/turret3.png"),
	"damage": [5, 6, 6, 8, 8, 10, 10, 15, 15, 20, 25],
	"cooldown": [1.0, 1.0, 0.8, 0.8, 0.5, 0.5, 0.4, 0.4, 0.2, 0.2],
	"attack_range": [128,128,128,128,128,128,128,128,128,128,128]
	},
	4: {"name": "Iron Rocket", "max_level": 11,
	"descriptions": [
		"A shoulder-mounted rocket launcher.",
	],
	"icon": preload("res://assets/guns/turret4.png"),
	"damage": [5, 6, 6, 8, 8, 10, 10, 15, 15, 20, 25],
	"cooldown": [1.0, 1.0, 0.8, 0.8, 0.5, 0.5, 0.4, 0.4, 0.2, 0.2],
	"attack_range": [128,128,128,128,128,128,128,128,128,128,128]
	},
	
	5: {"name": "Silver Flame", "max_level": 11,
	"descriptions": [
		"A waist-mounted flamethrower.",
	],
	"icon": preload("res://assets/guns/turret1.png"),
	"damage": [1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3],
	"cooldown": [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1],
	"attack_range": [256,256,256,256,256,256,256,256,256,256,256]
	},
}
