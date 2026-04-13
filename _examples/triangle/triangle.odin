package main

import "../../firefly"

@(export = true)
render :: proc "contextless" () {
	firefly.clear_screen(firefly.Color.White)
	firefly.draw_triangle(
		firefly.p(60, 10),
		firefly.p(40, 40),
		firefly.p(80, 40),
		firefly.Style{firefly.Color.DarkBlue, firefly.Color.Blue, 1},
	)
}
