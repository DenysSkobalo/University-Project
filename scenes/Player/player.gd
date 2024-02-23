extends CharacterBody2D

#@onready var anim = get_node("AnimatedSprite2D")
@onready var anim = $AnimatedSprite2D
@export var speed: int = 150

var direction: Vector2 = Vector2.ZERO
# Save last direction move
var last_direction: Vector2 = Vector2.DOWN

func _process(delta):
	direction = Input.get_vector("Left","Right","Up","Down")

func _physics_process(delta):
	velocity = direction * speed
	
	if direction != Vector2.ZERO:
		last_direction = direction
		
		if direction.y < 0:
			anim.play("Up Walk"	)
		elif direction.y > 0:
			anim.play("Down Walk")
		elif direction.x != 0:
			anim.play("Side Walk")
			anim.flip_h = direction.x > 0
	else: 
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		
		if last_direction.y < 0: 
			anim.play("Up Idle")
		elif last_direction.y > 0:
			anim.play("Down Idle")
		elif last_direction.x != 0:
			anim.play("Side Idle")
			anim.flip_h = last_direction.x > 0

	move_and_slide()
