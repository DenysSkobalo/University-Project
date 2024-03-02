extends CharacterBody2D

class_name Player

# Accessing the AnimatedSprite2D node
#@onready var anim = get_node("AnimatedSprite2D")
@onready var anim = $AnimatedSprite2D

# Speed variable for the character
@export var speed: int = 100

# Variable to store the current direction of character movement
var direction: Vector2 = Vector2.ZERO
# Variable to store the last direction of character movement
var last_direction: Vector2 = Vector2.DOWN

@export var branches: int = 0

@export var maxHealth : int = 100 
@onready var healthBar = $"../CanvasLayer/HealthBarPlayer"


@export var class_campfire: Campfire
@onready var campfire = get_node_or_null("../Campfire") as Campfire

# Processing user input
func _process(delta):
	direction = Input.get_vector("Left","Right","Up","Down")
	if Input.is_action_just_pressed("Interact") and is_near_campfire():
		throw_branch()

# Приєднання сигналу до функції `add_health` багаття
func _ready():
	var callable = Callable(class_campfire, "add_health")
	connect("throw_branch_to_campfire", callable)
	
	if not campfire:
		print("Помилка: вузол 'Campfire' не знайдено.")
	else:
		print("Вузол 'Campfire' успішно знайдено.")
	
# Сигнал, який повідомляє про те, що гравець кидає гілку в багаття
signal throw_branch_to_campfire(amount)

func throw_branch():
	if branches > 0 and is_near_campfire():
		branches -= 1
		if campfire:
			campfire.add_health(2) # Переконайтесь, що метод існує в класі Campfire
		else:
			print("Помилка: спроба викликати 'add_health' на неіснуючому об'єкті.")

func is_near_campfire() -> bool:
	if not campfire:
		return false
	return global_position.distance_to(campfire.global_position) < 50


# Increase in branches
func pick_up():
	print("Pick up one branch")
	branches += 1

# Physics processing for movement and animation
func _physics_process(delta):
	# Calculating velocity based on direction
	velocity = direction * speed
	
	# Checking if the character is moving
	if direction != Vector2.ZERO:
		last_direction = direction
		
		# Choosing animation based on movement direction
		if direction.y < 0:
			anim.play("Up Walk"	)
		elif direction.y > 0:
			anim.play("Down Walk")
		elif direction.x != 0:
			anim.play("Side Walk")
			anim.flip_h = direction.x > 0
	else: 
		# Gradually reducing speed to zero
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		
		# Choosing the Idle animation based on the last direction of movement
		if last_direction.y < 0: 
			anim.play("Up Idle")
		elif last_direction.y > 0:
			anim.play("Down Idle")
		elif last_direction.x != 0:
			anim.play("Side Idle")
			anim.flip_h = last_direction.x > 0

	healthBar.value = maxHealth
	move_and_slide()
