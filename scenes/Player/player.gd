extends CharacterBody2D

#@onready var anim = get_node("AnimatedSprite2D")
@onready var anim = $AnimatedSprite2D

var direction: Vector2 = Vector2.ZERO
@export var speed: int = 150

func _process(delta):
	direction = Input.get_vector("Left","Right","Up","Down")

func _physics_process(delta):
	velocity = direction * speed
	if direction != Vector2.ZERO:
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
		anim.play("Down Idle")
		anim.flip_h = false
		
	move_and_slide()
