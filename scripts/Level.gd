extends Node2D

export var time_limit = 400

export var level_number = 1

var enemy = preload("res://scenes/Ground Enemy.tscn")

func _ready():
	enemy = load("res://scenes/Ground Enemy.tscn")
	$Player.Level_Timer(time_limit) 
	$Music_BG.play(Global.musicProgress)
	Global.stage = level_number
	
