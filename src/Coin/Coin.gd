extends Area2D

onready var animationPlayer = $AnimationPlayer
func _ready():
	coin_animation()
func coin_animation():
	$AnimationPlayer.play("Bounce")



func _on_body_entered(body):
	animationPlayer.play("fade_out")
