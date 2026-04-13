package firefly

foreign import "graphics"
foreign import "input"
foreign import "misc"
foreign import "net"
foreign import "stats"
foreign import "fs"

@(private)
@(default_calling_convention = "contextless")
foreign graphics {
	clear_screen :: proc(c: i32) ---
	set_color :: proc(c, r, g, b: i32) ---
	draw_point :: proc(x, y, c: i32) ---
	draw_line :: proc(x1, y1, x2, y2, c, sw: i32) ---
	draw_rect :: proc(x, y, w, h, fc, sc, sw: i32) ---
	draw_rounded_rect :: proc(x, y, w, h, cw, ch, fc, sc, sw: i32) ---
	draw_circle :: proc(x, y, d, fc, sc, sw: i32) ---
	draw_ellipse :: proc(x, y, w, h, fc, sc, sw: i32) ---
	draw_triangle :: proc(x1, y1, x2, y2, x3, y3, fc, sc, sw: i32) ---
	draw_arc :: proc(x, y, d: i32, ast, asw: f32, fc, sc, sw: i32) ---
	draw_sector :: proc(x, y, d: i32, ast, asw: f32, fc, sc, sw: i32) ---
	draw_text :: proc(textPtr: uintptr, textLen: u32, fontPtr: uintptr, fontLen: u32, x, y, color: i32) ---
	draw_qr :: proc(textPtr: uintptr, textLen: u32, x, y, black, white: i32) ---
	draw_image :: proc(ptr: uintptr, size: u32, x, y: i32) ---
	draw_sub_image :: proc(ptr: uintptr, size: u32, x, y, subX, subY: i32, subWidth, subHeight: u32) ---
	set_canvas :: proc(ptr: uintptr, size: u32) ---
	unset_canvas :: proc() ---
}


@(private)
@(default_calling_convention = "contextless")
foreign input {
	read_pad :: proc(player: u32) -> i32 ---
	read_buttons :: proc(player: u32) -> u32 ---
}


@(private)
@(default_calling_convention = "contextless")
foreign fs {
	get_file_size :: proc(pathPtr: uintptr, pathLen: u32) -> u32 ---
	load_file :: proc(pathPtr: uintptr, pathLen: u32, bufPtr: uintptr, bufLen: u32) -> u32 ---
	dump_file :: proc(pathPtr: uintptr, pathLen: u32, bufPtr: uintptr, bufLen: u32) -> u32 ---
	remove_file :: proc(pathPtr: uintptr, pathLen: u32) ---
}

@(private)
@(default_calling_convention = "contextless")
foreign net {
	get_me :: proc() -> u32 ---
	get_peers :: proc() -> u32 ---
	save_stash :: proc(peerID: u32, bufPtr: uintptr, bufLen: u32) ---
	load_stash :: proc(peerID: u32, bufPtr: uintptr, bufLen: u32) -> u32 ---
}

@(private)
@(default_calling_convention = "contextless")
foreign stats {
	add_progress :: proc(peerID, badgeID: u32, val: i32) -> u32 ---
	add_score :: proc(peerID, boardID: u32, val: i32) -> i32 ---
}

@(private)
@(default_calling_convention = "contextless")
foreign misc {
	log_debug :: proc(ptr: uintptr, size: u32) ---
	log_error :: proc(ptr: uintptr, size: u32) ---
	set_seed :: proc(seed: u32) ---
	get_random :: proc() -> u32 ---
	get_name :: proc(index: u32, ptr: uintptr) -> u32 ---
	get_settings :: proc(index: u32) -> u64 ---
	restart :: proc() ---
	quit :: proc() ---
}
