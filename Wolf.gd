extends CharacterBody2D

@onready var SM = $StateMachine

@export var walking = 300
@export var running = 500
@export var jump = 1200
var direction = 1

func _ready():
	velocity.x = -running
	SM.set_state("Move")

func _physics_process(_delta):
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = velocity
	
	if direction < 0 and not $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = true
	if direction > 0 and $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = false
	
func set_animation(anim):
	if $AnimatedSprite2D.animation == anim: return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()

func damage(d):
	queue_free()


func attack_target():
	if $Attack.is_colliding():
		return $Attack.get_collider()
	return null

func _on_AnimatedSprite_animation_finished():
	if SM.state_name == "Attack":
		SM.set_state("Move")

