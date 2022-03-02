extends Area2D

var speed = 200
var velocity = Vector2.ZERO

func _ready() -> void:
	pass

func get_input() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if velocity != Vector2.ZERO:
		$Sprite.rotation = velocity.normalized().angle()
	velocity = velocity.normalized() * speed

func _process(delta) -> void:
	get_input()
	position += velocity * delta
	if position.x < 0 + 16:
		position.x = 0 + 16
	if position.x > 360 - 16:
		position.x = 360 - 16
	if position.y < 0 + 16:
		position.y = 0 + 16
	if position.y > 720 - 16:
		position.y = 720 - 16
