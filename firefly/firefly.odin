package firefly

import "core:math"

// Since Odin has no package management, the whole SDK
// is a single file, to make the distribution less painful.

// -------------- //
// -- GRAPHICS -- //
// -------------- //
_ :: 0


// The screen width in pixels.
WIDTH :: 240
// The screen height in pixels.
HEIGHT :: 240

// A point on the screen.
//
// Typically, the upper-left corner of a bounding box of a shape.
Point :: struct {
	x: int,
	y: int,
}

// Shortcut for creating a [Point].
p :: proc "contextless" (x, y: int) -> Point {
	return Point{x, y}
}

// Size of a bounding box for a shape.
//
// The width and height must be positive.
Size :: struct {
	// The width of the bounding box.
	w: int,
	// The height of the bounding box.
	h: int,
}

// Shortcut for creating a [Size].
s :: proc "contextless" (w, h: int) -> Size {
	return Size{w, h}
}


// An angle between two vectors.
//
// Used by [DrawArc] and [DrawSector].
// Constructed by [degrees] and [radians].
Angle :: struct {
	_a: f32,
}

// Define an angle in radians where Tau (doubled Pi) is the full circle.
radians :: proc(a: f32) -> Angle {
	return Angle{a}
}

// Define an angle in radians where 360.0 is the full circle.
degrees :: proc(a: f32) -> Angle {
	return Angle{a * math.PI / 180.0}
}

Color :: enum u8 {
	// No color (100% transparency). Default.
	None       = 0,
	// Black color: #1A1C2C.
	Black      = 1,
	// Purple color: #5D275D.
	Purple     = 2,
	// Red color: #B13E53.
	Red        = 3,
	// Orange color: #EF7D57.
	Orange     = 4,
	// Yellow color: #FFCD75.
	Yellow     = 5,
	// Light green color: #A7F070.
	LightGreen = 6,
	// Green color: #38B764.
	Green      = 7,
	// Dark green color: #257179.
	DarkGreen  = 8,
	// Dark blue color: #29366F.
	DarkBlue   = 9,
	// Blue color: #3B5DC9.
	Blue       = 10,
	// Light blue color: #41A6F6.
	LightBlue  = 11,
	// Cyan color: #73EFF7.
	Cyan       = 12,
	// White color: #F4F4F4.
	White      = 13,
	// Light gray color: #94B0C2.
	LightGray  = 14,
	// Gray color: #566C86.
	Gray       = 15,
	// Dark gray color: #333C57.
	DarkGray   = 16,
}

// The RGB value of a color in the palette.
RGB :: struct {
	// Red component
	r: u8,
	// Green component
	g: u8,
	// Blue component
	b: u8,
}

// Construct a new [RGB].
rgb :: proc(r, g, b: u8) -> RGB {
	return RGB{r, g, b}
}

// Style of a shape.
Style :: struct {
	// The color to use to fill the shape.
	fill_color:   Color,

	// The color to use for the shape stroke.
	stroke_color: Color,

	// The width of the shape stroke.
	//
	// If zero, a solid shape without a stroke will be drawn.
	stroke_width: int,
}

// Make [Style] for a solid shape (without stroke).
solid :: proc "contextless" (c: Color) -> Style {
	return Style{c, Color.None, 0}
}

// Make [Style] for an outlined shape (without fill).
outlined :: proc "contextless" (c: Color, w: int) -> Style {
	return Style{Color.None, c, w}
}

// The same as [Style] but without a fill color (only stroke color and width).
LineStyle :: struct {
	color: Color,
	width: int,
}

// A shortcut for creating a new [LineStyle].
l :: proc "contextless" (c: Color, w: int) -> LineStyle {
	return LineStyle{c, w}
}

Font :: struct {
	_raw: []byte,
}

Image :: struct {
	_raw: []byte,
}

SubImage :: struct {
	image: Image,
	point: Point,
	size:  Size,
}

sub_image :: proc(i: Image, p: Point, s: Size) -> SubImage {
	return SubImage{i, p, s}
}

// Canvas is an [Image] that can be drawn upon.
Canvas :: struct {
	_raw: []byte,
}

// Create a new [Canvas].
canvas :: proc(s: Size) -> Canvas {
	headerSize := 4
	bodySize := s.w * s.h / 2
	raw := make([]byte, headerSize + bodySize)
	raw[0] = 0x22 // magic number
	raw[1] = byte(s.w) // width
	raw[2] = byte(s.w >> 8) // width
	raw[3] = 255 // transparency
	return Canvas{raw}
}

// Fill the whole frame with the given color.
clear_screen :: proc "contextless" (c: Color) {
	b_clear_screen(cast(i32)c)
}

// Set a color value in the palette.
set_color :: proc "contextless" (c: Color, v: RGB) {
	b_set_color(cast(i32)c, cast(i32)v.r, cast(i32)v.g, cast(i32)v.b)
}

// Set all colors in the color palette.
set_palette :: proc(colors: [16]RGB) {
	for i in 1 ..= 16 {
		set_color(cast(Color)i, colors[i - 1])
	}
}

// Draw a single point (1 pixel if scaling is 1).
draw_point :: proc(p: Point, c: Color) {
	b_draw_point(cast(i32)p.x, cast(i32)p.y, cast(i32)c)
}

// Draw a straight line from point a to point b.
draw_line :: proc(a, b: Point, s: LineStyle) {
	b_draw_line(
		cast(i32)a.x,
		cast(i32)a.y,
		cast(i32)b.x,
		cast(i32)b.y,
		cast(i32)s.color,
		cast(i32)s.width,
	)
}


// Draw a rectangle filling the given bounding box.
draw_rect :: proc(p: Point, b: Size, s: Style) {
	b_draw_rect(
		cast(i32)p.x,
		cast(i32)p.y,
		cast(i32)b.w,
		cast(i32)b.h,
		cast(i32)s.fill_color,
		cast(i32)s.stroke_color,
		cast(i32)s.stroke_width,
	)
}


// Draw a rectangle with rounded corners.
draw_rounded_rect :: proc(p: Point, b, c: Size, s: Style) {
	b_draw_rounded_rect(
		cast(i32)p.x,
		cast(i32)p.y,
		cast(i32)b.w,
		cast(i32)b.h,
		cast(i32)c.w,
		cast(i32)c.h,
		cast(i32)s.fill_color,
		cast(i32)s.stroke_color,
		cast(i32)s.stroke_width,
	)
}

// Draw a circle with the given diameter.
draw_circle :: proc(p: Point, d: int, s: Style) {
	b_draw_circle(
		cast(i32)p.x,
		cast(i32)p.y,
		cast(i32)d,
		cast(i32)s.fill_color,
		cast(i32)s.stroke_color,
		cast(i32)s.stroke_width,
	)
}

// Draw an ellipse (oval).
draw_ellipse :: proc(p: Point, b: Size, s: Style) {
	b_draw_ellipse(
		cast(i32)p.x,
		cast(i32)p.y,
		cast(i32)b.w,
		cast(i32)b.h,
		cast(i32)s.fill_color,
		cast(i32)s.stroke_color,
		cast(i32)s.stroke_width,
	)
}

// Draw a triangle.
draw_triangle :: proc "contextless" (a, b, c: Point, s: Style) {
	b_draw_triangle(
		cast(i32)a.x,
		cast(i32)a.y,
		cast(i32)b.x,
		cast(i32)b.y,
		cast(i32)c.x,
		cast(i32)c.y,
		cast(i32)s.fill_color,
		cast(i32)s.stroke_color,
		cast(i32)s.stroke_width,
	)
}

// Draw an arc.
draw_arc :: proc(p: Point, d: int, start, sweep: Angle, s: Style) {
	b_draw_arc(
		cast(i32)p.x,
		cast(i32)p.y,
		cast(i32)d,
		start._a,
		sweep._a,
		cast(i32)s.fill_color,
		cast(i32)s.stroke_color,
		cast(i32)s.stroke_width,
	)
}

// Draw a sector.
draw_sector :: proc(p: Point, d: int, start, sweep: Angle, s: Style) {
	b_draw_sector(
		cast(i32)p.x,
		cast(i32)p.y,
		cast(i32)d,
		start._a,
		sweep._a,
		cast(i32)s.fill_color,
		cast(i32)s.stroke_color,
		cast(i32)s.stroke_width,
	)
}

// Render text using the given font.
//
// Unlike in the other drawing functions, here [Point] points not to the top-left corner
// but to the baseline start position.
draw_text :: proc(t: string, f: Font, p: Point, c: Color) {
	text_ptr := cast(uintptr)raw_data(t)
	raw_ptr := cast(uintptr)raw_data(f._raw)
	b_draw_text(
		text_ptr,
		cast(u32)(len(t)),
		raw_ptr,
		cast(u32)(len(f._raw)),
		cast(i32)p.x,
		cast(i32)p.y,
		cast(i32)c,
	)
}

// Render a QR code for the given text.
draw_qr :: proc(t: string, p: Point, black, white: Color) {
	ptr := cast(uintptr)raw_data(t)
	b_draw_qr(ptr, cast(u32)(len(t)), cast(i32)p.x, cast(i32)p.y, cast(i32)black, cast(i32)white)
}

// Render an image at the given point.
draw_image :: proc(i: Image, p: Point) {
	raw_ptr := cast(uintptr)raw_data(i._raw)
	b_draw_image(raw_ptr, cast(u32)(len(i._raw)), cast(i32)p.x, cast(i32)p.y)
}

// Draw a subregion of an image.
//
// Most often used to draw a sprite from a sprite atlas.
draw_sub_image :: proc(i: SubImage, p: Point) {
	rawPtr := cast(uintptr)raw_data(i.image._raw)
	b_draw_sub_image(
		rawPtr,
		cast(u32)(len(i.image._raw)),
		cast(i32)p.x,
		cast(i32)p.y,
		cast(i32)i.point.x,
		cast(i32)i.point.y,
		cast(u32)i.size.w,
		cast(u32)i.size.h,
	)
}

// Set the target image for all subsequent drawing operations.
set_canvas :: proc(c: Canvas) {
	rawPtr := cast(uintptr)raw_data(c._raw)
	b_set_canvas(rawPtr, cast(u32)(len(c._raw)))
}

// Make all subsequent drawing operations target the screen instead of a canvas.
//
// Cancels the effect of [SetCanvas].
unset_canvas :: proc() {
	b_unset_canvas()
}


// ----------- //
// -- INPUT -- //
// ----------- //
_ :: 0

// The lowest possible value for [Pad.x].
PAD_MIN_X :: -1000
// The lowest possible value for [Pad.y].
PAD_MIN_Y :: -1000
// The highest possible value for [Pad.x].
PAD_MAX_X :: 1000
// The highest possible value for [Pad.y].
PAD_MAX_Y :: 1000

// The minimum X or Y value when converting [Pad] into [DPad8]
// for the direction to be considered pressed.
@(private)
DPAD8_THRESHOLD :: 400

// The minimum X or Y value when converting [Pad] into [DPad4]
// for the direction to be considered pressed.
@(private)
DPAD4_THRESHOLD :: 300


// A finger position on the touch pad.
//
// Both X and Y are somewhere the range between -1000 and 1000 (both ends included).
// The 1000 X is on the right, the 1000 Y is on the top.
Pad :: struct {
	x: int,
	y: int,
}


// 4-directional DPad-like representation of the [Pad].
//
// Constructed with [Pad.DPad4]. Useful for simple games and ports.
// The middle of the pad is a "dead zone" pressing which will not activate any direction.
//
// Implements all the same methods as [DPad8].
DPad4 :: enum u8 {
	None,
	Right,
	Up,
	Left,
	Down,
}

dpad4 :: proc(p: Pad) -> DPad4 {
	x := p.x
	y := p.y
	abs_x := abs(x)
	abs_y := abs(y)
	switch {
	case y > DPAD4_THRESHOLD && y > abs_x:
		return DPad4.Up
	case y < -DPAD4_THRESHOLD && -y > abs_x:
		return DPad4.Down
	case x > DPAD4_THRESHOLD && x > abs_y:
		return DPad4.Right
	case x < -DPAD4_THRESHOLD && -x > abs_y:
		return DPad4.Left
	}
	return DPad4.None
}


// 8-directional DPad-like representation of the [Pad].
//
// Constructed with [Pad.DPad8]. Useful for simple games and ports.
// The middle of the pad is a "dead zone" pressing which will not activate any direction.
//
// Invariant: it's not possible for opposite directions (left and right, or down and up)
// to be active at the same time. However, it's possible for neighboring directions
// (like up and right) to be active at the same time if the player presses a diagonal.
//
// Implements all the same methods as [DPad4].
DPad8 :: struct {
	left:  bool,
	right: bool,
	up:    bool,
	down:  bool,
}

dpad8 :: proc(p: Pad) -> DPad8 {
	return DPad8 {
		left = p.x <= -DPAD8_THRESHOLD,
		right = p.x >= DPAD8_THRESHOLD,
		up = p.y <= -DPAD8_THRESHOLD,
		down = p.y >= DPAD8_THRESHOLD,
	}
}


// State of the buttons.
Buttons :: struct {
	// South. The bottom button, like A on the X-Box controller.
	//
	// Typically used for confirmation, main action, jump, etc.
	s:    bool,

	// East. The right button, like B on the X-Box controller.
	//
	// Typically used for cancellation, going to previous screen, etc.
	e:    bool,

	// West. The left button, like X on the X-Box controller.
	//
	// Typically used for attack.
	w:    bool,

	// North. The top button, like Y on the X-Box controller.
	//
	// Typically used for a secondary action, like charged attack.
	n:    bool,

	// The menu button, almost always handled by the runtime.
	menu: bool,
}

// Get the current touch pad state.
//
// The peer can be [Combined] or one of the [get_peers].
read_pad :: proc(p: Peer) -> (Pad, bool) {
	raw := b_read_pad(cast(u32)(p._raw))
	pressed := raw != 0xffff
	if !pressed {
		return Pad{}, false
	}
	pad := Pad{int(cast(i16)(raw >> 16)), int(cast(i16)raw)}
	return pad, true
}


// Get the currently pressed buttons.
//
// The peer can be [COMBINED] or one of the [get_peers].
read_buttons :: proc(p: Peer) -> Buttons {
	raw := b_read_buttons(cast(u32)p._raw)
	return Buttons {
		s = has_bit_set(raw, 0),
		e = has_bit_set(raw, 1),
		w = has_bit_set(raw, 2),
		n = has_bit_set(raw, 3),
		menu = has_bit_set(raw, 4),
	}
}

// Check if the given u32 value has the given bit set.
@(private)
has_bit_set :: proc(val: u32, bit: uint) -> bool {
	return (val >> bit) & 0b1 != 0
}

// --------- //
// -- NET -- //
// -------- //

// The peer ID.
//
// Can be obtained by getting the list of [Peers] using [get_peers]
// and then iterating over it.
Peer :: struct {
	_raw: u8,
}

// A combination of all connected peers.
//
// Can be passed in functions like [read_pad] and [read_buttons]
// to get the combined input of all peers.
//
// Useful for single-player games that want in multiplayer to handle
// inputs from all devices as one input.
COMBINED :: Peer{0xff}

// -------------- //
// -- BINDINGS -- //
// -------------- //


foreign import "graphics"
foreign import "input"
foreign import "misc"
foreign import "net"
foreign import "stats"
foreign import "fs"

@(private)
@(default_calling_convention = "contextless")
foreign graphics {
	@(link_name = "clear_screen")
	b_clear_screen :: proc(c: i32) ---
	@(link_name = "set_color")
	b_set_color :: proc(c, r, g, b: i32) ---
	@(link_name = "draw_point")
	b_draw_point :: proc(x, y, c: i32) ---
	@(link_name = "draw_line")
	b_draw_line :: proc(x1, y1, x2, y2, c, sw: i32) ---
	@(link_name = "draw_rect")
	b_draw_rect :: proc(x, y, w, h, fc, sc, sw: i32) ---
	@(link_name = "draw_rounded_rect")
	b_draw_rounded_rect :: proc(x, y, w, h, cw, ch, fc, sc, sw: i32) ---
	@(link_name = "draw_circle")
	b_draw_circle :: proc(x, y, d, fc, sc, sw: i32) ---
	@(link_name = "draw_ellipse")
	b_draw_ellipse :: proc(x, y, w, h, fc, sc, sw: i32) ---
	@(link_name = "draw_triangle")
	b_draw_triangle :: proc(x1, y1, x2, y2, x3, y3, fc, sc, sw: i32) ---
	@(link_name = "draw_arc")
	b_draw_arc :: proc(x, y, d: i32, ast, asw: f32, fc, sc, sw: i32) ---
	@(link_name = "draw_sector")
	b_draw_sector :: proc(x, y, d: i32, ast, asw: f32, fc, sc, sw: i32) ---
	@(link_name = "draw_text")
	b_draw_text :: proc(textPtr: uintptr, textLen: u32, fontPtr: uintptr, fontLen: u32, x, y, color: i32) ---
	@(link_name = "draw_qr")
	b_draw_qr :: proc(textPtr: uintptr, textLen: u32, x, y, black, white: i32) ---
	@(link_name = "draw_image")
	b_draw_image :: proc(ptr: uintptr, size: u32, x, y: i32) ---
	@(link_name = "draw_sub_image")
	b_draw_sub_image :: proc(ptr: uintptr, size: u32, x, y, subX, subY: i32, subWidth, subHeight: u32) ---
	@(link_name = "set_canvas")
	b_set_canvas :: proc(ptr: uintptr, size: u32) ---
	@(link_name = "unset_canvas")
	b_unset_canvas :: proc() ---
}

@(private)
@(default_calling_convention = "contextless")
foreign input {
	@(link_name = "read_pad")
	b_read_pad :: proc(player: u32) -> i32 ---
	@(link_name = "read_buttons")
	b_read_buttons :: proc(player: u32) -> u32 ---
}

@(private)
@(default_calling_convention = "contextless")
foreign fs {
	@(link_name = "get_file_size")
	b_get_file_size :: proc(pathPtr: uintptr, pathLen: u32) -> u32 ---
	@(link_name = "load_file")
	b_load_file :: proc(pathPtr: uintptr, pathLen: u32, bufPtr: uintptr, bufLen: u32) -> u32 ---
	@(link_name = "dump_file")
	b_dump_file :: proc(pathPtr: uintptr, pathLen: u32, bufPtr: uintptr, bufLen: u32) -> u32 ---
	@(link_name = "remove_file")
	b_remove_file :: proc(pathPtr: uintptr, pathLen: u32) ---
}

@(private)
@(default_calling_convention = "contextless")
foreign net {
	@(link_name = "get_me")
	b_get_me :: proc() -> u32 ---
	@(link_name = "get_peers")
	b_get_peers :: proc() -> u32 ---
	@(link_name = "save_stash")
	b_save_stash :: proc(peerID: u32, bufPtr: uintptr, bufLen: u32) ---
	@(link_name = "load_stash")
	b_load_stash :: proc(peerID: u32, bufPtr: uintptr, bufLen: u32) -> u32 ---
}

@(private)
@(default_calling_convention = "contextless")
foreign stats {
	@(link_name = "add_progress")
	b_add_progress :: proc(peerID, badgeID: u32, val: i32) -> u32 ---
	@(link_name = "add_score")
	b_add_score :: proc(peerID, boardID: u32, val: i32) -> i32 ---
}

@(private)
@(default_calling_convention = "contextless")
foreign misc {
	@(link_name = "log_debug")
	b_log_debug :: proc(ptr: uintptr, size: u32) ---
	@(link_name = "log_error")
	b_log_error :: proc(ptr: uintptr, size: u32) ---
	@(link_name = "set_seed")
	b_set_seed :: proc(seed: u32) ---
	@(link_name = "get_random")
	b_get_random :: proc() -> u32 ---
	@(link_name = "get_name")
	b_get_name :: proc(index: u32, ptr: uintptr) -> u32 ---
	@(link_name = "get_settings")
	b_get_settings :: proc(index: u32) -> u64 ---
	@(link_name = "restart")
	b_restart :: proc() ---
	@(link_name = "quit")
	b_quit :: proc() ---
}
