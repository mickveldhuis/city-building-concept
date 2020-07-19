extends Resource

class_name BaseTool


export(String) var name = "axe"
export(Global.ToolType) var type = Global.ToolType.AXE
export(bool) var is_weapon = false
export(int, 0, 100) var damage = 1
export(Texture) var icon = null
export(float, 0.001, 30) var cooldown = 0.5
