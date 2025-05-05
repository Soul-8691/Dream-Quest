extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var walk_speed : float = 130.0
@export var run_speed : float = 260.0
var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animation_parameters()

func get_input():
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * walk_speed
	move_and_slide()

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	get_input()

func update_animation_parameters():
	if (velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
	animation_tree["parameters/Idle/blend_position"] = direction
	animation_tree["parameters/Walk/blend_position"] = direction
