extends Node


signal enable_mouse_action(entity)
signal disable_mouse_action(entity)

enum ToolType {
	AXE,
	PICKAXE,
	SWORD,
	HOE,
	HAMMER,
}
enum ItemType {
	EMPTY,
	WOOD,
	STONE,
	WHEAT,
}
enum PlaceableType {
	BUILDING,
	INFRASTRUCTURE,
	CROP,
}
enum BuildingType {
	HOUSE,
	BARN,
	FARM,
	INN,
	BLACKSMITH,
	GATHERER,
	FISHERY,
}
enum PlaceableGroup {
	BUILDING,
	INFRASTRUCTURE,
	CROP,
}
enum EntityType {
	EMPTY,
	CROP,
	TREE,
	ROCK,
	ROAD,
	HOUSE,
	INN,
	BLACKSMITH,
	GATHERER,
	FISHERY,
	BARN,
	FARM,
}
enum CropType {
	WHEAT,
	POTATO,
}

const TILE_SIZE : int = 16 # pixels wide & long
const STATELESS_ENTITIES : Array = [EntityType.TREE, EntityType.ROCK, EntityType.ROAD]
