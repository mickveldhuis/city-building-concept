extends Node

enum ToolType {
	AXE,
	PICKAXE,
	SWORD,
}
enum ItemType {
	EMPTY,
	WOOD,
	STONE,
}
enum PlaceableType {
	BUILDING,
	INFRASTRUCTURE,
}
enum BuildingType {
	HOUSE,
	INN,
	BLACKSMITH,
	GATHERER,
	FISHERY,
	BARN,
}
enum PlaceableGroup {
	BUILDING,
	INFRASTRUCTURE,
}
enum EntityType {
	EMPTY,
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
const TILE_SIZE = 16
const STATELESS_ENTITIES = [EntityType.TREE, EntityType.ROCK, EntityType.ROAD]
