extends Node

var music_db := 0.5
var sound_db := 0.2
var time := 0.0

var total_coins := 0
var total_exp := 0
var highest_level := 1
var highest_time := 0.0

func _ready() -> void:
	pass # Replace with function body.

var main_menu = preload("res://src/menu/MainMenu.tscn")
var world = preload("res://src/world/World.tscn")
