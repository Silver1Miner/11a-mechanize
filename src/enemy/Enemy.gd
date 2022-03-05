extends Area2D

export var max_hp := 10.0
export var hp := 10.0 setget set_hp
export var speed := 30
enum MONSTER_TYPE {SILVER, IRON}
export var type := MONSTER_TYPE.SILVER
export (PackedScene) var FCT = preload("res://src/effects/FCT.tscn")
var invulnerable := false
onready var manager = get_parent()
var target_position := Vector2.ZERO
var direction := Vector2.ZERO
var path := PoolVector2Array() setget set_path

func _ready() -> void:
	add_to_group("enemy")
	set_process(false)
	find_target()

func find_target() -> void:
	if manager and manager.get_parent() and manager.get_parent().get_parent().has_node("Player"):
		target_position = manager.get_parent().get_parent().get_node("Player").position
		direction = (target_position - position).normalized()
		#print(position, target_position)
		set_path(manager.get_parent().get_simple_path(position, target_position))
	else:
		print("no target")

var move_accumulated = 0
var cooldown = 0.5
func _process(delta: float) -> void:
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

func take_damage(damage_value: float, damage_type: int) -> void:
	if invulnerable:
		return
	var crit = (damage_type == type)
	var damage = damage_value
	if crit:
		damage *= 3
	set_hp(hp - damage)
	var fct = FCT.instance()
	if manager and manager.get_parent():
		manager.get_parent().add_child(fct)
	fct.rect_position = get_global_position() + Vector2(0,-16)
	fct.show_value(str(damage), Vector2(0,-8), 1, PI/2, crit, Database.type_colors[damage_type])
