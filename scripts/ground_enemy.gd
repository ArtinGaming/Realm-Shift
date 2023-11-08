extends KinematicBody2D

var velocity = Vector2()

export var direction = -1

export var speed = 30

#if false it falls down clifss
export var detects_cliffs = true

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$Floor_Checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$Floor_Checker.enabled = detects_cliffs
	
func _physics_process(delta):
	
	if is_on_wall() or not $Floor_Checker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$Floor_Checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Top_Checker_body_entered(body):
	if body.name == "Player":
		$Death_Sound.play()
		$AnimatedSprite.play("Dead")
		speed = 0
		set_collision_layer_bit(4, false)
		set_collision_mask_bit(0, false)
		$Top_Checker.set_collision_layer_bit(0, false)
		$Top_Checker.set_collision_mask_bit(0, false)
		$Timer.start()
		body.bounce()
	
func _on_Side_Checker_body_entered(body):
	if body.name == "Player":
		print("Ouch")
		body.hurt(position.x)
		
func _on_Timer_timeout():
	queue_free()
