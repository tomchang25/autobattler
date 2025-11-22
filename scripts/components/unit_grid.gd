class_name UnitGrid
extends Node

signal unit_grid_changed

@export var size: Vector2i

var units: Dictionary = {}

func _ready() -> void:
    for i in size.x:
        for j in size.y:
            units[Vector2i(i, j)] = null


func add_unit(unit: Node2D, position: Vector2i) -> void:
    units[position] = unit
    unit_grid_changed.emit(
)

func is_tile_occupied(position: Vector2i) -> bool:
    return units[position] != null

func is_grid_full() -> bool:
    return units.keys().all(is_tile_occupied)


func get_first_empty_tile() -> Vector2i:
    for tile in units.keys():
        if is_tile_occupied(tile) == false:
            return tile

    return Vector2i(-1, -1)

func get_all_units() -> Array[Unit]:
    var unit_array: Array[Unit]

    for unit: Unit in units.values():
        if unit != null:
            unit_array.append(unit)

    return unit_array
