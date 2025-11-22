class_name OutlineHighlighter
extends Node

@export var target: CanvasGroup

@export var outline_color: Color = Color("#ffffff")
@export_range(1, 10) var outline_thickness: int


func _ready() -> void:
    target.material.set_shader_parameter("line_color", outline_color)


func clear_highlight() -> void:
    target.material.set_shader_parameter("line_thickness", 0)


func highlight() -> void:
    target.material.set_shader_parameter("line_thickness", outline_thickness)
