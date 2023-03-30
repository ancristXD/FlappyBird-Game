extends KinematicBody2D 

const UP = Vector2(0,-1)  #Adicionando a constante que vai representar a direção para cima em relação ao eixo X/Y na engine
const FLAP = -200 #Constante para indicar a força da subida da personagem quando o botão for pressionado
const MAXFALLSPEED = 200 #Constante para definir a velocidade máxima da queda da personagem
const GRAVITY = 10 #Constante que vai simular um valor para a força gravitacional

# variável responsável por receber as coordenadas da posição da personagem, mudando a posição dela e gerando a sensação de movimento
var motion = Vector2()  #Deixar um "Vector2" vazio vai permitir que a variável possa sempre receber novos valores para as coordenadas X e Y, permitindo a movimentação da personagem

var Troncos = preload("res://troncos.tscn") #É preciso colocar o caminho da Cena dos obstáculos como uma string

#Variável que mostrará a pontuação
var score = 0 

#Função base, chamada automaticamente quando a árvore de nós e seus filhos adentram a cena
func _ready():
	pass

#Função que indica que o frame vai interagir com algum tipo de física
func _physics_process(delta):
	#Atualiza a variável 'motion' com o valor de 'Gravity', no eixo Y    
	motion.y += GRAVITY #A variável recebe o valor atual dela mais o valor da constante 'GRAVIDADE', fazendo com que o jogador caia mais rápido quanto mais tempo passe caindo
	if motion.y > MAXFALLSPEED: #Condição para evitar que o personagem passe do limite de velocidade máxima de queda
		motion.y = MAXFALLSPEED #Caso o valor da variável 'movimento' ultrapasse a velocidade máxima de queda, o movimento vai receber o valor da constante 'VELMAXQUEDA', limitando o aumento
	
	#Condição para identificar uma entrada, no caso uma tecla pressionada
	if Input.is_action_just_pressed("mover"):  #Recebe como Parâmetro a entrada previamente configurada para representar a barra de espaço pressionada
		motion.y = FLAP  #Se a tecla for pressionada, a variável movimento vai receber o valor da constante 'FLAP'
	
	#Colocar a variável de movimento para receber a função 'move_and_slide()', que ajuda a Engine a identificar movimento linear e colisão
	motion = move_and_slide(motion,UP) #A função recebe como parâmetros, a variavel e a constante que indica uma direção com base em um coordenada no eixo X/Y
	 #Essa função e parte do código que finalmente permitirão a movimentação da personagem
	
	#Pega o valor da tela para alterá-lo
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)

#Função que vai resetar os obstáculos
func Troncos_reset():
	var Troncos_instance =  Troncos.instance() #instanciamento do objeto em uma variável
	Troncos_instance.position = Vector2(550, rand_range(-20,20)) #Configurando o instanciamento para coordenadas aleatórias entre limites definidos no eixo X/Y
	get_parent().call_deferred("add_child", Troncos_instance) #Instancia novos objetos para se tornarem Nós Filhos do Nó Pai

#Função que reseta um objeto (corpo) que adentrar uma área	
func _on_Area2D2_body_entered(body):
	if body.name == "Troncos":  # Se o objeto que entrar na área tiver o nome 'Troncos'...
		body.queue_free()  #então o objeto será deletado
		Troncos_reset() #e então respawnadp

# Função que determina que se o personagem entrar numa area 2D...
func _on_Area2D_area_entered(area):
	if area.name == "PointArea": #area com o nome "PointArea"
		score += 1 #A pontuação será acrescida em um ponto

# Função que determina que se o personagem entrar numa area 2D...
func _on_Area2D_body_entered(body):
	if body.name == "Troncos" or body.name == "Terreno":#area com o nome "Tronco" ou "Terreno"
		get_tree().reload_current_scene()#Toda a Árvore de Cenas será reiniciada
		
		
