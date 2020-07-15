extends Resource

class_name BaseTool

enum ToolType {
	AXE,
	PICKAXE,
	SWORD,
}

export(String) var name = "axe"
export(ToolType) var type = ToolType.AXE
export(int, 0, 100) var damage = 1
export(Texture) var icon = null
