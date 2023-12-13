class_name Enemy
extends RigidBody2D

# Initial values
@export var maxHealth: int = 100
@export var speed: float = 75
@export var attackSpeed: float = 500
@export var attackRange: float = 300


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
	if target != null:
		var direction = (target - position).normalized()
		if(direction.x > 0):
			$EnemySprite.scale.x = scale.y * 1
		elif(direction.x < 0):
			$EnemySprite.scale.x = scale.y * -1
	
		move_and_collide(direction * speed * delta)
		ap.play("move")

func charge_attack(delta: float):
	ap.play("hit")
	if attackStartPos == Vector2.ZERO and attackEndPos == Vector2.ZERO:
		var dir = (target - position).normalized()
		attackStartPos = position
		attackEndPos = attackStartPos + (dir * attackRange)


func resetAttack():
	$Hurtbox.hide()
	$Collider.show()
	attackEndPos = Vector2.ZERO
	attackStartPos = Vector2.ZERO
	state = EnemyState.SEEK

func attack(delta: float):
	$Collider.hide()
	if not $Hurtbox.is_visible_in_tree():
		$Hurtbox.show()
	
	# Here the enemy tracks a bit too eagerly.
	#if attackStartPos == Vector2.ZERO and attackEndPos == Vector2.ZERO:
		#var dir = (target - position).normalized()
		#attackStartPos = position
		#attackEndPos = attackStartPos + (dir * attackRange)
	

	if (attackEndPos - position).abs().length() > 5:
		var dir = (attackEndPos - position).normalized()
		move_and_collide(dir * attackSpeed * delta)
		ap.play("charge")
	else:
		resetAttack()


func _physics_process(delta):
	global_rotation = 0.0
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
	if anim_name == "hit":
		state = EnemyState.ATTACK
