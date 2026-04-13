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
