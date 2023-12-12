class_name Enemy
extends RigidBody2D

# Initial values
@export var maxHealth: int = 100
@export var speed: float = 100

# Game time variables
var currentHealth: int = 100

# References
@onready var ap = $AnimationPlayer


func die():
	get_parent().remove_child(self)
	queue_free()

func take_damage(amount: int):
	currentHealth -= amount
	if currentHealth <= 0:
		die()

func heal(amount: int): 
	currentHealth = clamp(currentHealth + amount, 0, maxHealth)

func move(dir: Vector2, multiplier: float = 1):
	move(dir.normalized() * speed * multiplier)


func _physics_process(delta):
	pass
