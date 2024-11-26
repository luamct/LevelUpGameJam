class_name Portrait
extends Control

@onready var texture_rect: TextureRect = $TextureRect

func set_portrait_texture(texture: Texture2D):
	texture_rect.texture = texture
	visible = true
