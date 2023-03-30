extends StaticBody2D
func _ready():
	pass 

#Função que faz com que um objeto interaja com a física
func _physics_process(delta):
	position += Vector2(-2,0) #A coordenada do objeto vai receber "-2" no valor do eixo X, causando a impressão de que o objeto está se aproximando
	
