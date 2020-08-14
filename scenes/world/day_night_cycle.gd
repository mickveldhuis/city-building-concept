extends CanvasModulate


export(int) var day_duration_modifier = 1

onready var anim_player : AnimationPlayer = $AnimationPlayer

const DAY_NIGHT_ANIM : String = "day_night_cycle"


func _ready():
	anim_player.play(DAY_NIGHT_ANIM, -1, day_duration_modifier)


func _on_new_day() -> void:
	WorldData.add_new_day()
