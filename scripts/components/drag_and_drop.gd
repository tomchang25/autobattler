class_name DragAndDrop
extends Node

signal drag_started
signal drag_canceled(starting_position: Vector2)
signal dropped(starting_position: Vector2)

@export var target: Node2D

@export var enabled: bool = true


var starting_position: Vector2
var offset: Vector2 = Vector2.ZERO
var dragging: bool = false


func _ready() -> void:
    if target == null or target is not Node2D:
        push_error("DragAndDrop Component must be attached to a Node2D")

    target.input_event.connect(_on_target_input_event.unbind(1))

func _process(_delta: float) -> void:
    if dragging and target:
        target.global_position = target.get_global_mouse_position() + offset

func _input(event: InputEvent) -> void:
    if dragging:
        if event.is_action_pressed("cancel_drag"):
            _cancel_dragging()
        elif event.is_action_released("select"):
            _drop()

func _on_target_input_event(_viewport: Node, event: InputEvent) -> void:
    if not enabled:
        return

    # Only allow one object to be dragged at a time
    var dragging_object := get_tree().get_first_node_in_group("dragging")
    if not dragging and dragging_object:
        return

    if not dragging and event.is_action_pressed("select"):
        _start_dragging()

func _end_dragging() -> void:
    dragging = false
    target.remove_from_group("dragging")

func _cancel_dragging() -> void:
    _end_dragging()

    drag_canceled.emit(starting_position)

func _start_dragging() -> void:
    dragging = true
    starting_position = target.global_position

    target.add_to_group("dragging")
    offset = target.global_position - target.get_global_mouse_position()

    drag_started.emit()

func _drop() -> void:
    _end_dragging()

    dropped.emit(starting_position)
