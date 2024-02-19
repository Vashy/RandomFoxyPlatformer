extends HBoxContainer

@export var player_stats: PlayerStats
var heart_texture: Texture2D = preload("res://heart.png")

func _ready():
	player_stats.on_player_hit.connect(on_player_health_changed)
	player_stats.on_player_healed.connect(on_player_health_changed)
	player_stats.on_player_death.connect(clear_hearts)
	generate_hearts()

func on_player_health_changed():
	var children = get_children()
	var first = true
	for heart_slot in children:
		if first:
			first = false
			continue
		heart_slot.texture = null
	generate_hearts()

func generate_hearts():
	for i in range(1, player_stats.current_HP):
		var heart_slot = get_node("HeartSlot%s" % [i]) as TextureRect
		heart_slot.texture = heart_texture

func clear_hearts():
	for heart_slot in get_children():
		heart_slot.texture = null
