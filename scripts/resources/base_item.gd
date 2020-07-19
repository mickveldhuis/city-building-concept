extends Resource

class_name BaseItem

enum ItemType {
	EMPTY,
	WOOD,
	STONE,
}

export(String) var name = "item"
export(ItemType) var type = ItemType.EMPTY
export(int) var amount = 0
export(int) var max_amount = 999
export(Texture) var icon = null
