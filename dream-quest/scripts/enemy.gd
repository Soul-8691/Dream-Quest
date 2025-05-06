extends CharacterBody2D

enum ENEMY_STATE { IDLE, WALK }

@export var move_speed : float = 20
@export var idle_time : float = 5
@export var walk_time : float = 2

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var timer : Timer = $Timer

var move_direction : Vector2 = Vector2.ZERO
var current_state : ENEMY_STATE = ENEMY_STATE.IDLE

func _ready():
	pick_new_state()

func _physics_process(_delta):
	if (current_state == ENEMY_STATE.WALK):
		velocity = move_direction * move_speed
		move_and_slide()

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)
	if (move_direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = move_direction
		animation_tree["parameters/Walk/blend_position"] = move_direction

func pick_new_state():
	if (current_state == ENEMY_STATE.IDLE):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		current_state = ENEMY_STATE.WALK
		select_new_direction()
		timer.start(idle_time)
	elif (current_state == ENEMY_STATE.WALK):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
		current_state = ENEMY_STATE.IDLE
		timer.start(walk_time)


func _on_timer_timeout() -> void:
	pick_new_state()
