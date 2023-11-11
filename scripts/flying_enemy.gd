extends KinematicBody2D

var velocity = Vector2()

export var direction = -1

export var speed = 20

func _physics_process(delta):
	if $Floor_Checker.is_colliding():
		direction = direction * -1

	elif $Roof_Checker.is_colliding():
		direction = direction * -1
		
	velocity.y = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Top_Checker_body_entered(body):
	if body.name == "Player":
		$Death_Sound.play()
		$AnimatedSprite.play("Death")
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
