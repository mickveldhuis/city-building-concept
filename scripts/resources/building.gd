extends Resource

class_name Building


var type : int = Global.PlaceableType.BUILDING

export(String) var name = "house"
export(String) var description = "a simple house"
export(Global.BuildingType) var building_type = Global.BuildingType.HOUSE
export(Texture) var icon = null # Menu icon
export(Texture) var sprite = null
export(Vector2) var size = Vector2(1, 1)
