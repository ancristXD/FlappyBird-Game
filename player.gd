extends KinematicBody2D 

const UP = Vector2(0,-1)
const FLAP = 200
const MAXFALLSPEED = 200
const GRAVITY = 10
var motion = Vector2()
var Troncos = preload("res://Troncos.tscn")
var score = 0 
func _ready():
	pass

func _physics_process(delta):
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	if Input.is_action_just_pressed("mover"):
		motion.y = -FLAP
	motion = move_and_slide(motion,UP)
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)

func Troncos_reset():
	var Troncos_instance =  Troncos.instance()
	Troncos_instance.position = Vector2(550, rand_range(-20,20))
	get_parent().call_deferred("add_child", Troncos_instance)
	
func _on_Area2D2_body_entered(body):
	if body.name == "Troncos":
		body.queue_free()
		Troncos_reset()


func _on_Area2D_area_entered(area):
	if area.name == "PointArea":
		score += 1


func _on_Area2D_body_entered(body):
	if body.name == "Troncos":
		get_tree().reload_current_scene()
