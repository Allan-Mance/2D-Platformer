extends Node

@onready var SM = get_parent()
@onready var enemy = get_node("../..")

func _ready():
	await enemy.ready

func start():
	enemy.set_animation("Moving")

func physics_process(_delta):
	if not enemy.is_on_floor():
		enemy.velocity.y += 50
	else: enemy.velocity.y = 0
