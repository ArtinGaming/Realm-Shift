extends StaticBody2D



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("Spike")
		body.hurt(position.x)
