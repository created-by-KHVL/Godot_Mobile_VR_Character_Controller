extends XRCamera3D

@export var m_interface_display_to_lens: float = 4.0
@export var m_interface_display_width: float = 14.5
@export var m_interface_eye_height: float = 1.85
@export var m_interface_iod: float = 6.0
@export var m_interface_k1: float = 0.215
@export var m_interface_k2: float = 0.215
@export var m_interface_offset_rect: Rect2 = Rect2(0, 0, 1, 1)
@export var m_interface_oversample: float = 1.5
@export var m_interface_vrs_min_radius: float = 20.0
@export var m_interface_vrs_strength: float = 1.0

var start_m_interface_display_to_lens: float
var start_m_interface_display_width: float
var start_m_interface_eye_height: float
var start_m_interface_iod: float
var start_m_interface_k1: float
var start_m_interface_k2: float
var start_m_interface_offset_rect: Rect2
var start_m_interface_oversample: float
var start_m_interface_vrs_min_radius: float
var start_m_interface_vrs_strength: float

var mobile_interface: MobileVRInterface = XRServer.find_interface("Native mobile")

func _ready() -> void:
	
	mobile_interface.display_to_lens = m_interface_display_to_lens
	mobile_interface.display_width = m_interface_display_width
	mobile_interface.eye_height = m_interface_eye_height
	mobile_interface.iod = m_interface_iod
	mobile_interface.k1 = m_interface_k1
	mobile_interface.k2 = m_interface_k2
	mobile_interface.offset_rect = m_interface_offset_rect
	mobile_interface.oversample = m_interface_oversample
	mobile_interface.vrs_min_radius = m_interface_vrs_min_radius
	mobile_interface.vrs_strength = m_interface_vrs_strength
	
	if mobile_interface and mobile_interface.initialize():
		get_viewport().use_xr = true
	
	start_m_interface_display_to_lens = m_interface_display_to_lens
	start_m_interface_display_width = m_interface_display_width
	start_m_interface_eye_height = m_interface_eye_height
	start_m_interface_iod = m_interface_iod
	start_m_interface_k1 = m_interface_k1
	start_m_interface_k2 = m_interface_k2
	start_m_interface_offset_rect = m_interface_offset_rect
	start_m_interface_oversample = m_interface_oversample
	start_m_interface_vrs_min_radius = m_interface_vrs_min_radius
	start_m_interface_vrs_strength = m_interface_vrs_strength

func _process(_delta: float) -> void:
	if m_interface_display_to_lens != start_m_interface_display_to_lens:
		mobile_interface.display_to_lens = m_interface_display_to_lens
	if m_interface_display_width != start_m_interface_display_width:
		mobile_interface.display_width = m_interface_display_width
	if m_interface_eye_height != start_m_interface_eye_height:
		mobile_interface.eye_height = m_interface_eye_height
	if m_interface_iod != start_m_interface_iod:
		mobile_interface.iod = m_interface_iod
	if m_interface_k1 != start_m_interface_k1:
		mobile_interface.k1 = m_interface_k1
	if m_interface_k2 != start_m_interface_k2:
		mobile_interface.k2 = m_interface_k2
	if m_interface_offset_rect != start_m_interface_offset_rect:
		mobile_interface.offset_rect = m_interface_offset_rect
	if m_interface_oversample != start_m_interface_oversample:
		mobile_interface.oversample = m_interface_oversample
	if m_interface_vrs_min_radius != start_m_interface_vrs_min_radius:
		mobile_interface.vrs_min_radius = m_interface_vrs_min_radius
	if m_interface_vrs_strength != start_m_interface_vrs_strength:
		mobile_interface.vrs_strength = m_interface_vrs_strength
