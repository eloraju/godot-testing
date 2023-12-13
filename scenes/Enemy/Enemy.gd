class_name Enemy
extends RigidBody2D

# Initial values
@export var maxHealth: int = 100
@export var speed: float = 75
@export var speedMultiplier:float = 1
@export var attackSpeed: float = 500
@export var attackRange: float = 10


# Game time variables
var currentHealth: int = 100
var target: Vector2
var state = EnemyState.SEEK
var attackStartPos: Vector2 = Vector2.ZERO
var attackEndPos: Vector2 = Vector2.ZERO

# References
@onready var ap = $AnimationPlayer
@onready var timer = $Timer

# Monster states
enum EnemyState {
	SEEK,
	CHARGE,
	ATTACK
}

func die():
	get_parent().remove_child(self)
	queue_free()

func seek_player(delta: float):
	print("seeking player...")
	if target != null:
		var direction = (target - position).normalized()
		if(direction.x > 0):
			$EnemySprite.scale.x = scale.y * 1
		elif(direction.x < 0):
			$EnemySprite.scale.x = scale.y * -1
	
		move_and_collide(direction * speed * speedMultiplier * delta)
		global_rotation = 0.0
		ap.play("move")
	# if distance to target < charge_range -> move faster & ap.play("charge") and unhide hitbox
	# could/should this be done with a signal and a ChargeRange Area2D?

func charge_attack(delta: float):
	print("Charge attack!")
	ap.play("hit")


func attack(delta: float):
	print("attacking!")
	$Collider.hide()
	if not $Hurtbox.is_visible_in_tree():
		$Hurtbox.show()
	var dir = (target - position).normalized()
	if attackStartPos == Vector2.ZERO and attackEndPos == Vector2.ZERO:
		attackStartPos = position
		attackEndPos = dir * attackRange
	if position != attackEndPos:
		move_and_collide(dir * attackSpeed * delta)
		ap.play("charge")
	else:
		state = EnemyState.SEEK


func _physics_process(delta):
	match state:
		EnemyState.SEEK:
			seek_player(delta)
		EnemyState.CHARGE:
			charge_attack(delta)
		EnemyState.ATTACK:
			attack(delta)



func player_position_update(playerPos: Vector2):
	if state != EnemyState.ATTACK:
		target = playerPos

func player_in_range(body: Node2D):
	if state == EnemyState.SEEK:
		state = EnemyState.CHARGE

func _on_animation_player_animation_finished(anim_name):
	print("animation finished", anim_name)
	if anim_name == "hit":
		print("changing state")
		state = EnemyState.ATTACK



func _on_animation_player_animation_started(anim_name):
	print(anim_name)
