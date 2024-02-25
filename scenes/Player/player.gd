extends CharacterBody2D

# Accessing the AnimatedSprite2D node
#@onready var anim = get_node("AnimatedSprite2D")
@onready var anim = $AnimatedSprite2D

# Speed variable for the character
@export var speed: int = 150

# Variable to store the current direction of character movement
var direction: Vector2 = Vector2.ZERO
# Variable to store the last direction of character movement
var last_direction: Vector2 = Vector2.DOWN

# Processing user input
func _process(delta):
	direction = Input.get_vector("Left","Right","Up","Down")

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

	move_and_slide()
