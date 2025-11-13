extends Node2D

@export var max_radius := 200.0        # raio máximo em pixels
@export var grow_speed := 400.0        # velocidade de crescimento em px/s
@export var fade_duration := 1.5       # tempo até sumir (s)
@export var soft_edge := 50.0          # transição suave em px
@export var base_alpha := 1.0          # alfa inicial multiplicador

@onready var color_rect: ColorRect = $ColorRect
@onready var shader_material: ShaderMaterial = null

var time_alive := 0.0
var current_radius := 0.0
var alpha := 1.0

func _ready():
	# Garante que o ColorRect esteja centralizado e cobrindo uma boa área
	color_rect.anchor_left = 0.5
	color_rect.anchor_top = 0.5
	color_rect.anchor_right = 0.5
	color_rect.anchor_bottom = 0.5
	color_rect.position = Vector2.ZERO

	# Cria/atribui material de shader se não existir
	if not color_rect.material:
		shader_material = ShaderMaterial.new()
		shader_material.shader = preload("res://shaders/vision_circle.gdshader")
		color_rect.material = shader_material
	else:
		shader_material = color_rect.material

	# Define tamanho do ColorRect (agora com 'size' no Godot 4)
	var size = Vector2(max_radius * 2.5, max_radius * 2.5)
	color_rect.size = size
	color_rect.position = -size * 0.5

	_update_shader_params()


func _process(delta):
	time_alive += delta

	current_radius = clamp(current_radius + grow_speed * delta, 0.0, max_radius)
	alpha = clamp(1.0 - (time_alive / fade_duration), 0.0, 1.0) * base_alpha

	_update_shader_params()

	if time_alive >= fade_duration:
		queue_free()


func _update_shader_params():
	if shader_material:
		shader_material.set_shader_parameter("u_radius", current_radius)
		shader_material.set_shader_parameter("u_alpha", alpha)
		shader_material.set_shader_parameter("u_soft_edge", soft_edge)
		shader_material.set_shader_parameter("u_size", color_rect.size)
