extends StaticBody2D

export (float) var jump_force = 1.5

var used = false

func _ready():
	used = false

func _physics_process(delta):
	jump()
	
func jump():
	if used == true:
		$AnimatedSprite.play("Jump")
		$CollisionShape2D.shape.extents = Vector2($CollisionShape2D.shape.extents.x, 12)
	
func _on_Area2D_body_entered(body):
	if body.name == "Player" and used == false:
		body.spring_jump(jump_force)
		$Bounce.play() 
		used = true
