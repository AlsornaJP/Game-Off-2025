extends Camera2D

const zoom_normal: Vector2 = Vector2(1.0, 1.0)
const max_zoom_out: Vector2 = Vector2(0.8, 0.8)
const max_zoom_in: Vector2 = Vector2(1.3, 1.3)
const zoom_speed: Vector2 = Vector2(0.1, 0.1)

func aumentar_zoom():
	if (Input.is_action_just_pressed("camera_zoom_in")) and zoom < max_zoom_in:
		set_zoom(get_zoom() + zoom_speed)
func diminuir_zoom():
	if (Input.is_action_just_pressed("camera_zoom_out")) and zoom > max_zoom_out:
		set_zoom(get_zoom() - zoom_speed)

func _ready() -> void:
	zoom = zoom_normal

func _process(delta: float) -> void:
	aumentar_zoom()
	diminuir_zoom()
	if (Input.is_action_just_pressed("camera_zoom_reset")):
		set_zoom(zoom_normal)
