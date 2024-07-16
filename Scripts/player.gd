class_name Player extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var speed : float = 100.0

var direction : Vector2 = Vector2.ZERO
var can_move : bool

func _ready():
	animation_tree.active = true

func _process(_delta):
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/walk"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/walk"] = true

	if(direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction

func _physics_process(delta):
	if (can_move):
		direction = Input.get_vector("left", "right", "up", "down").normalized()

	if can_move && direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
