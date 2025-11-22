class_name UnitStats
extends Resource

enum Rarity {
    COMMON,
    UNCOMMON,
    RARE,
    EPIC,
    LEGENDARY
}

const RARITY_COLORS = {
    Rarity.COMMON: Color("#ffffff"),
    Rarity.UNCOMMON: Color("#00ff00"),
    Rarity.RARE: Color("#0000ff"),
    Rarity.EPIC: Color("#ff00ff"),
    Rarity.LEGENDARY: Color("#ea940b")
}

@export var name: String

@export_category("Data")
@export var rarity: Rarity
@export var gold_cost := 1

@export_category("Visuals")
@export var skin_coordinates: Vector2i


func _to_string() -> String:
    return name
