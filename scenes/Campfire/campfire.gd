extends CharacterBody2D

class_name Campfire

@export var maxHealth: int = 100
@onready var healthBar: ProgressBar = $"../CanvasLayer/HealthBarCampfire"
@onready var healthBarLabel: Label = $"../CanvasLayer/HealthBarCampfire/Label"

var decrease_rate: int = 1
const MAX_DECREASE_RATE: int = 5
const DECREASE_INTERVAL: float = 20.0
var time_until_next_decrease: float = DECREASE_INTERVAL

func _ready():
	update_health_display()

func add_health(amount: int):
	maxHealth = min(maxHealth + amount, 100)
	update_health_display()

func _on_timer_timeout():
	maxHealth = max(maxHealth - decrease_rate, 0)
	update_health_display()
	
	if maxHealth <= 0:
		end_game()
	
	time_until_next_decrease -= 1.0
	if time_until_next_decrease <= 0 and decrease_rate < MAX_DECREASE_RATE:
		increase_decrease_rate()
		
		
func end_game():
	get_tree().change_scene_to_file("res://scenes/game_over/game_over.tscn")

func increase_decrease_rate():
	decrease_rate += 1
	time_until_next_decrease = DECREASE_INTERVAL
	print("Speed increase to: ", decrease_rate)

func update_health_display():
	healthBar.value = maxHealth
	healthBarLabel.text = str("Campfire: %d" % maxHealth)
