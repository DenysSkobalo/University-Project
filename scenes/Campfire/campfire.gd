extends CharacterBody2D

class_name Campfire

@export var maxHealth: int = 100
@onready var healthBar = $"../CanvasLayer/HealthBarCampfire"
@onready var healthBarLabel = $"../CanvasLayer/HealthBarCampfire/Label"

var decrease_rate: int = 1
var max_decrease_rate: int = 5
var time_passed: float = 0.0
var next_decrease_time: float = 20.0  # Час до наступного збільшення швидкості зниження здоров'я

func _ready():
	update_health_display()  # Оновити відображення здоров'я при запуску

# Функція для відновлення здоров'я багаття
func add_health(amount: int):
	maxHealth = min(maxHealth + amount, 100) # Переконуємося, що здоров'я не перевищить максимальне значення
	update_health_display() # Оновлюємо інтерфейс здоров'я


func _on_timer_timeout():
	time_passed += 1.0
	maxHealth = max(maxHealth - decrease_rate, 0)  # Запобігаємо від'ємному здоров'ю
	update_health_display()  # Оновлюємо інтерфейс
	
	if time_passed >= next_decrease_time and decrease_rate < max_decrease_rate:
		decrease_rate += 1
		next_decrease_time += 20.0  # Встановлюємо час наступного збільшення швидкості зниження здоров'я
		print("Speed increase to: ", decrease_rate)

func update_health_display():
	healthBar.value = maxHealth
	healthBarLabel.text = "Campfire: " + str(maxHealth)
