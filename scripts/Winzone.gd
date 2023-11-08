extends Area2D

export var need_key = false

export var next_level = "res://scenes/Level 01.tscn"

var player_in_winzone = false

var teleport_player = false

func _ready():
	next_level = load(next_level)
	player_in_winzone = false
	
func _physics_process(delta):
	open_without_key()
	teleport()
	
func open_without_key():
	if need_key == false and Input.is_action_just_pressed("interact") and player_in_winzone == true:
		$AnimatedSprite.play("Opening")
		teleport_player = true
		
func teleport():
	if teleport_player == true:
		Global.musicProgress = $"../Music_BG".get_playback_position()   
		get_tree().change_scene_to(next_level)
		
func _on_Winzone_body_entered(body):
	if body.name == "Player":
		player_in_winzone = true
	
func _on_Winzone_body_exited(body):
	if body.name == "Player":
		player_in_winzone = false

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("Open")
