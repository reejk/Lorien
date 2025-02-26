class_name InfiniteCanvasPeerState
extends Object

var _brush_color := Config.DEFAULT_BRUSH_COLOR
var _brush_size := Config.DEFAULT_BRUSH_SIZE
var _current_stroke: BrushStroke
var _optimizer: BrushStrokeOptimizer

static func create() -> InfiniteCanvasPeerState:
	var state := InfiniteCanvasPeerState.new()
	state._optimizer = BrushStrokeOptimizer.new()
	state._brush_size = Settings.get_value(Settings.GENERAL_DEFAULT_BRUSH_SIZE, Config.DEFAULT_BRUSH_SIZE)
	return state
