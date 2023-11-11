extends StaticBody2D

export var distance = -10

export (float) var jump_force = 1

func _ready():
	$Player_Detecter/CollisionShape2D.shape.extents = Vector2(7, distance)
	
func _on_Player_Detecter_body_entered(body):
	if body.name == "Player":
		print(body.name)
		body.on_fan(jump_force)
