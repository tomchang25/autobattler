@tool
class_name Unit
extends Area2D

@export var stats: UnitStats: set = _set_stats

@onready var skin: Sprite2D = $Visuals/Skin
@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar

@onready var drag_and_drop: DragAndDrop = $DragAndDrop
@onready var velocity_based_rotation: VelocityBasedRotation = $VelocityBasedRotation
@onready var outline_highlighter: OutlineHighlighter = $OutlineHighlighter

func _ready() -> void:
    drag_and_drop.drag_started.connect(_on_drag_started)
    drag_and_drop.drag_canceled.connect(_on_drag_canceled)
    drag_and_drop.dropped.connect(_on_dropped)

    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)

func _on_drag_started() -> void:
    outline_highlighter.highlight()
    velocity_based_rotation.enabled = true

func _on_drag_canceled(starting_position: Vector2) -> void:
    outline_highlighter.clear_highlight()
    reset_after_dragging(starting_position)

func _on_dropped(_starting_position: Vector2) -> void:
    outline_highlighter.clear_highlight()

func _on_mouse_entered() -> void:
    outline_highlighter.highlight()

func _on_mouse_exited() -> void:
    if not drag_and_drop.dragging:
        outline_highlighter.clear_highlight()

func _set_stats(value: UnitStats) -> void:
    stats = value

    if value == null:
        return

    if not is_node_ready():
        await ready

    skin.region_rect.position = Vector2(stats.skin_coordinates) * Arena.CELL_SIZE

func reset_after_dragging(starting_position: Vector2) -> void:
    velocity_based_rotation.enabled = false

    global_position = starting_position
