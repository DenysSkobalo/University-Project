extends CharacterBody2D

class_name Player

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var healthBar: ProgressBar = $"../CanvasLayer/HealthBarPlayer"
@onready var campfire: Campfire = get_node_or_null("../Campfire") as Campfire
var callable_add_health: Callable

@export var speed: int = 100
@export var branches: int = 0
@export var maxHealth: int = 100
var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN

const DISTANCE_THRESHOLD: float = 50.0

signal throw_branch_to_campfire(amount)

func _ready():
	if campfire:
		callable_add_health = Callable(campfire, "add_health")
		connect("throw_branch_to_campfire", callable_add_health)
	else:
		push_error("Campfire node not found.")

func _process(delta):
	direction = Input.get_vector("Left","Right","Up","Down")
	if Input.is_action_just_pressed("Interact") and is_near_campfire():
		throw_branch()

func throw_branch():
	if branches > 0:
		branches -= 1
		emit_signal("throw_branch_to_campfire", 2)

func is_near_campfire() -> bool:
	return campfire and global_position.distance_to(campfire.global_position) < DISTANCE_THRESHOLD

func pick_up():
	branches += 1
	#queue_free()

func _physics_process(delta):
	var moving = direction != Vector2.ZERO
	if moving:
		last_direction = direction
		anim.play(get_animation_for_direction(direction))
		anim.flip_h = direction.x > 0
		velocity = direction * speed
	else:
		anim.play(get_idle_animation_for_direction(last_direction))
		anim.flip_h = last_direction.x > 0
		velocity = Vector2.ZERO

	healthBar.value = maxHealth
	move_and_slide()

func get_animation_for_direction(dir: Vector2) -> String:
	return "Side Walk" if dir.x != 0 else ("Up Walk" if dir.y < 0 else "Down Walk")

func get_idle_animation_for_direction(dir: Vector2) -> String:
	return "Side Idle" if dir.x != 0 else ("Up Idle" if dir.y < 0 else "Down Idle")
