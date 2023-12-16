class_name Cacodemon
extends Enemy

# Initial values
@export var attackSpeed: float = 500
@export var attackRange: float = 300


# Game time variables
var state = EnemyState.SEEK
var attackStartPos: Vector2 = Vector2.ZERO
var attackEndPos: Vector2 = Vector2.ZERO

# Monster states
enum EnemyState {
	SEEK,
	CHARGE,
	ATTACK
}

func seek_player(delta: float):
	ap.play("move")
	_move_toward_player(speed, delta)


func charge_attack(delta: float):
	ap.play("hit")
	if attackStartPos == Vector2.ZERO and attackEndPos == Vector2.ZERO:
		var dir = (_playerPos - position).normalized()
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
	$Hurtbox.show()
	if (attackEndPos - position).abs().length() > attackSpeed * delta:
		var step = (attackEndPos-position).normalized() * attackSpeed * delta
		move_and_collide(step)
		ap.play("charge")
	else:
		move_and_collide(attackEndPos - position)
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

func player_in_range(body: Node2D):
	if state == EnemyState.SEEK:
		state = EnemyState.CHARGE

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hit":
		state = EnemyState.ATTACK
