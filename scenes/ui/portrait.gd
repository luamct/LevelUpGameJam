class_name Portrait
extends Control

@onready var texture_rect: TextureRect = $TextureRect
@onready var frame_texture: TextureRect = $FrameTexture

func set_portrait_texture(texture: Texture2D):
	texture_rect.texture = texture
	visible = true

func select():
	frame_texture.visible = true

func unselect():
	frame_texture.visible = false
