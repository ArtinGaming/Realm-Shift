extends KinematicBody2D

# Varibles
var velocity = Vector2(0,0)

var switch_realms = false

var being_hurt = false
# Const
const GRAVITY = 30

# Exports 
export var SPEED = 180

export var JUMPFORCE = -550

export var bar_increase = 0.1

func _ready():
	
	$HUD/Realm_Bar.value = Global.energy_bar_value
func _save():
	Saver.save_data(Global.stage)
	
func _physics_process(delta):
	Player_Input()
	Realms_switch()
	Health()
	Fell()
	LevelIntroText()
	$HUD/Realm_Bar.value = Global.energy_bar_value
	$Level_Timer/Timer_Text.text = str(round($Level_Timer/Timer.time_left))
	
func Player_Input():
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
		
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
	
	else: 
		$AnimatedSprite.play("Idle")
	
	if not is_on_floor():
		$AnimatedSprite.play("Jump")
		
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		$Sound/Jump.play()
	if Input.is_action_just_pressed("switch_realms") and switch_realms == false:
		switch_realms = true
		
	elif Input.is_action_just_pressed("switch_realms") and switch_realms == true:
		switch_realms = false
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x,0,0.2)

func Realms_switch():
	if switch_realms == true:
		set_collision_layer_bit(1, true)
		set_collision_mask_bit(1, true)
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
		Global.energy_bar_value -= bar_increase
		set_modulate(Color(1, 1, 1, 0.290196))
		
	elif switch_realms == false and being_hurt == false:
		set_collision_layer_bit(0, true)
		set_collision_mask_bit(0, true)
		set_collision_layer_bit(1, false)
		set_collision_mask_bit(1, false)
		set_modulate(Color(1, 1, 1, 1))
		
func Health():
	if Global.energy_bar_value <= 0:
		get_tree().change_scene("res://scenes/Game Over.tscn")
		
func bounce():
	velocity.y = JUMPFORCE * 0.75

func hurt(var enemy_pos_x):
	being_hurt = true
	$"Camera2D/Screen Shake".start()
	set_modulate(Color(0.741176, 0.294118, 0.294118))
	velocity.y = JUMPFORCE * 0.5
	Global.energy_bar_value -= 10
	
	if position.x < enemy_pos_x:
		velocity.x = -300
		
	elif position.x > enemy_pos_x:
		velocity.x = 300
	
	Input.action_release("left")
	Input.action_release("right")
	$Sound/Hit.play()
	$Color_Change_Timer.start()

func _on_Color_Change_Timer_timeout():
	if switch_realms == true:
		set_modulate(Color(1, 1, 1, 0.290196))
	elif switch_realms == false:
		set_modulate(Color(1, 1, 1))
	being_hurt = false
	
func Fell():
	if position.y > 450:
		Global.energy_bar_value -= 10
		$Sound/Hit.play()
		Saver.load_data()
		get_tree().reload_current_scene()

func Level_Timer(var time):
	$Level_Timer/Timer.wait_time = time
	$Level_Timer/Timer.start()
	
func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Game Over.tscn")

func LevelIntroText():
	$Level_Intro/Level_Name.text = get_parent().name
	
func _on_Player_tree_entered():
	$Level_Intro.show()
	Saver.save_data(Global.stage)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	$Level_Intro.hide()
