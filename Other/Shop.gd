extends Node2D

@export var item_set: Array[ShopItem]
@export var game_state: GameState
var current_shop_item: ShopItem
var is_open := false
var is_player_in_range := false

func _ready():
	%PromptTip.visible = false
	current_shop_item = item_set[0]
	game_state.on_gold_changed.connect(_on_gold_changed)
	_set_active_shop_item(current_shop_item)
	_toggle_buy_button_based_on_state()

func _process(_delta):
	if not is_player_in_range:
		return
	if Input.is_action_just_pressed("interact"):
		if %Anim.is_playing():
			return
		if not is_open:
			_open_shop()
		else:
			_close_shop()

func _on_area_2d_body_entered(body):
	if body is Player:
		%PromptTip.visible = true
		is_player_in_range = true

func _on_area_2d_body_exited(body):
	if body is Player:
		%PromptTip.visible = false
		is_player_in_range = false

func _open_shop():
	%Anim.play("TransIn")
	get_tree().paused = true
	is_open = true

func _close_shop():
	%Anim.play("TransOut")
	get_tree().paused = false
	is_open = false

func _on_exit_button_pressed():
	_close_shop()

func _on_buy_button_pressed():
	if current_shop_item.cost <= game_state.gold:
		current_shop_item.action.execute()
		game_state.spend_gold(current_shop_item.cost)

func _on_gold_changed(_new_gold: int):
	_toggle_buy_button_based_on_state()

func _toggle_buy_button_based_on_state():
	if current_shop_item.cost > game_state.gold || not current_shop_item.action.is_action_enabled():
		%ShopControl/BuyButton.disabled = true
	else:
		%ShopControl/BuyButton.disabled = false

func _set_active_shop_item(shop_item: ShopItem):
	%ShopControl/Name.text = shop_item.item_name
	%ShopControl/Description.text = shop_item.description
	%ShopControl/BuyButton.text = "Buy: %d" % [shop_item.cost]
	%ShopControl/Sprite2D.texture = shop_item.image_src
