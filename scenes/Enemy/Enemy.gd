class_name Enemy
extends RigidBody2D



# Initial values
@export var maxHealth: int = 100
@export var speed: float = 75
@export var sprite : Sprite2D
@export var sprite_default_direcion: SpriteDefaultDirection

enum SpriteDefaultDirection {
	LEFT,
	RIGHT
}
# Game time variables
var _currentHealth: int = 100
var _playerPos: Vector2

# References
@onready var ap = $AnimationPlayer

func _update_sprite_direction(direction: Vector2):
	if(direction.x > 0):
		sprite.flip_h = sprite_default_direcion == SpriteDefaultDirection.LEFT
	elif(direction.x < 0):
		sprite.flip_h = sprite_default_direcion == SpriteDefaultDirection.RIGHT
	pass

func _move_towards(target: Vector2, speed: float, delta: float):
	if (target - position).abs().length() > speed * delta:
		var step = (target-position).normalized() * speed * delta
		_update_sprite_direction(step)
		move_and_collide(step)
	else:
		move_and_collide(target - position)

func _move_toward_player(speed: float, delta: float):
	_move_towards(_playerPos, speed, delta)
	

func _ready():
	add_to_group("Enemies")
	_enemy_ready()

func _die():
	_before_enemy_death()
	get_parent().remove_child(self)
	queue_free()

func _player_position_update(playerPos: Vector2):
		_playerPos = playerPos

func _enemy_ready():
	pass
	
func _before_enemy_death():
	pass
