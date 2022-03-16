extends Area2D

export var max_hp := 10.0
export var hp := 10.0 setget set_hp
export var speed := 30
enum MONSTER_TYPE {SILVER, IRON}
enum MONSTER_SPECIES {RAT}
export var species := MONSTER_SPECIES.RAT
export var type := MONSTER_TYPE.SILVER
export var active := true

export (PackedScene) var Explosion = preload("res://src/world/effects/Explosion.tscn")
export (PackedScene) var FCT = preload("res://src/world/effects/FCT.tscn")
export (PackedScene) var Pickup = preload("res://src/world/pickups/Pickup.tscn")
var Database: Resource = preload("res://data/Database.tres")
var invulnerable := false
onready var manager = get_parent()
var target_position := Vector2.ZERO
var direction := Vector2.ZERO
var path := PoolVector2Array() setget set_path

func _ready() -> void:
	add_to_group("enemy")
	set_process(false)
	set_species_data(species)
	find_target()
	$Sprite.modulate = Database.type_colors[type]

func set_species_data(species_id: int) -> void:
	if species_id < Database.enemy_species.size():
		max_hp = Database.enemy_species[species_id]["hp"]
		hp = max_hp
		speed = Database.enemy_species[species_id]["speed"]

func assign_color_type(new_type: int) -> void:
	type = new_type
	$Sprite.modulate = Database.type_colors[type]

func find_target() -> void:
	if manager and manager.get_parent() and manager.get_parent().get_parent().has_node("Player"):
		target_position = manager.get_parent().get_parent().get_node("Player").position
		direction = (target_position - position).normalized()
		set_path(manager.get_parent().get_simple_path(position, target_position))
	else:
		print("no target")

var move_accumulated = 0
var cooldown = 0.5
func _process(delta: float) -> void:
	if active:
		var move_distance := speed * delta
		move_along_path(move_distance)
		move_accumulated += delta
		if move_accumulated > cooldown:
			find_target()
			move_accumulated = 0

func move_along_path(distance: float) -> void:
	var start_point = position
	for _i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance > 0.0:
			position = start_point.linear_interpolate(path[0], distance/distance_to_next)
			look_at(path[0])
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func set_path(value: PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)

func set_hp(new_hp: float) -> void:
	hp = clamp(new_hp, 0.0, max_hp)
	if hp <= 0:
		die()

func take_damage(damage_value: float, damage_type: int) -> void:
	if invulnerable:
		return
	$DamageFlash.frame = 0
	$DamageFlash.play()
	var crit = (damage_type == type)
	var damage = damage_value
	if crit:
		damage *= 3
	var fct = FCT.instance()
	if manager and manager.get_parent():
		manager.get_parent().add_child(fct)
	fct.rect_position = get_global_position() + Vector2(0,-16)
	fct.show_value(str(damage), Vector2(0,-8), 1, PI/2, crit, Database.type_colors[damage_type])
	set_hp(hp - damage)

func create_explosion() -> void:
	if manager and manager.get_parent():
		var explosion_instance = Explosion.instance()
		manager.get_parent().add_child(explosion_instance)
		explosion_instance.position = get_global_position()

func die() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	if manager and manager.get_parent():
		var pickup_instance = Pickup.instance()
		manager.get_parent().get_node("Drops").call_deferred("add_child",pickup_instance)
		pickup_instance.position = get_global_position()
	invulnerable = true
	create_explosion()
	queue_free()
