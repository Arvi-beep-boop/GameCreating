extends Area2D


export var score: = 10

onready var animationPlayer = $AnimationPlayer
func _ready():
	coin_animation()
func coin_animation():
	$AnimationPlayer.play("Bounce")


func _on_body_entered(body):
	PlayerData.score += score
	animationPlayer.play("fade_out")
