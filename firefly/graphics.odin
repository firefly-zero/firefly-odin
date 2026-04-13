package firefly

// The screen width in pixels.
width :: 240
// The screen height in pixels.
height :: 240

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


// Fill the whole frame with the given color.
clear_screen :: proc "contextless" (c: Color) {
	b_clear_screen(cast(i32)c)
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
