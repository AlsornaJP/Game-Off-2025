extends CharacterBody2D

@export var speed = 400

func pegar_direcao():
	var input_direcao = Input.get_vector("left","right","up","down")
	if(Input.is_action_pressed("run")):
		velocity = (speed * 2) * input_direcao
	else:
		velocity = speed * input_direcao
	


func _physics_process(delta: float) -> void:
	pegar_direcao()
	move_and_slide()
