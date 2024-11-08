extends CanvasLayer

@onready var animation = $Animation

var scene_path: String = ""
var can_quit: bool = false


func fade_in():
	animation.play("fade_in")

func on_animation_finished(anim_name: String):
	if anim_name == "fade_in":
		if can_quit:
			get_tree().quit()
			return
			
		get_tree().change_scene_to_file(scene_path)
		animation.play("fade_out")
