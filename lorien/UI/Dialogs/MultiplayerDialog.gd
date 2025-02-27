class_name MultiplayerDialog
extends PanelContainer

# -------------------------------------------------------------------------------------------------
signal connect_to(address: String, port: int)
signal listen(port: int, maximum_clients: int)

# -------------------------------------------------------------------------------------------------
@onready var _connect_to_address: LineEdit = %ConnectToAddress
@onready var _connect_to_port: SpinBox = %ConnectToPort
@onready var _btn_connect: Button = %ConnectButton
@onready var _connect_error: Label = %ConnectError

@onready var _listen_port: SpinBox = %ListenPort
@onready var _maximum_clients: SpinBox = %MaximumClients
@onready var _btn_listen: Button = %ListenButton
@onready var _listen_error: Label = %ListenError

# -------------------------------------------------------------------------------------------------
func _ready() -> void:
	get_parent().close_requested.connect(get_parent().hide)
		
	_connect_to_address.text_changed.connect(_on_connect_to_address_changed)	
	_connect_to_port.value_changed.connect(_on_connect_to_port_changed)
	_btn_connect.pressed.connect(_on_connect)
	
	_listen_port.value_changed.connect(_on_listen_port_changed)
	_maximum_clients.value_changed.connect(_on_maximum_clients_changed)
	_btn_listen.pressed.connect(_on_listen)
	
	_connect_to_address.text = Settings.get_value(Settings.MULTIPLAYER_CONNECT_TO_ADDRESS, _connect_to_address.text)
	_connect_to_port.value = Settings.get_value(Settings.MULTIPLAYER_CONNECT_TO_PORT, Config.DEFAULT_MULTIPLAYER_PORT)
	
	_listen_port.value = Settings.get_value(Settings.MULTIPLAYER_LISTEN_PORT, Config.DEFAULT_MULTIPLAYER_PORT)
	_maximum_clients.value = Settings.get_value(Settings.MULTIPLAYER_MAXIMUM_CLIENTS, Config.DEFAULT_MULTIPLAYER_MAXIMUM_CLIENTS)

# -------------------------------------------------------------------------------------------------
func set_connect_error(error: Error) -> void:
	_connect_error.text = str(error)
	_connect_error.visible = true if error else false

# -------------------------------------------------------------------------------------------------
func set_listen_error(error: Error) -> void:
	_listen_error.text = str(error)
	_listen_error.visible = true if error else false

# -------------------------------------------------------------------------------------------------
func _on_connect() -> void:
	connect_to.emit(_connect_to_address.text, _connect_to_port.value)

# -------------------------------------------------------------------------------------------------
func _on_listen() -> void:
	listen.emit(_listen_port.value, _maximum_clients.value)

# -------------------------------------------------------------------------------------------------
func _on_connect_to_address_changed(value: String) -> void:
	Settings.set_value(Settings.MULTIPLAYER_CONNECT_TO_ADDRESS, value)
	
# -------------------------------------------------------------------------------------------------
func _on_connect_to_port_changed(value: int) -> void:
	Settings.set_value(Settings.MULTIPLAYER_CONNECT_TO_PORT, value)

# -------------------------------------------------------------------------------------------------
func _on_listen_port_changed(value: int) -> void:
	Settings.set_value(Settings.MULTIPLAYER_LISTEN_PORT, value)

# -------------------------------------------------------------------------------------------------
func _on_maximum_clients_changed(value: int) -> void:
	Settings.set_value(Settings.MULTIPLAYER_MAXIMUM_CLIENTS, value)
