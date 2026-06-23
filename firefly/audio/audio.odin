
package audio


Sine :: struct {
	id: u32,
}

Square :: struct {
	id: u32,
}

Sawtooth :: struct {
	id: u32,
}

Triangle :: struct {
	id: u32,
}

Noise :: struct {
	id: u32,
}

Empty :: struct {
	id: u32,
}

Zero :: struct {
	id: u32,
}

File :: struct {
	id: u32,
}

Mix :: struct {
	id: u32,
}

AllForOne :: struct {
	id: u32,
}

Gain :: struct {
	id: u32,
}

Loop :: struct {
	id: u32,
}

Concat :: struct {
	id: u32,
}

Pan :: struct {
	id: u32,
}

Mute :: struct {
	id: u32,
}

Pause :: struct {
	id: u32,
}

TrackPosition :: struct {
	id: u32,
}

LowPass :: struct {
	id: u32,
}

HighPass :: struct {
	id: u32,
}

TakeLeft :: struct {
	id: u32,
}

TakeRight :: struct {
	id: u32,
}

Swap :: struct {
	id: u32,
}

Clip :: struct {
	id: u32,
}

SourceNode :: union {
	Sine,
	Square,
	Sawtooth,
	Triangle,
	Noise,
	Empty,
	Zero,
}

ParentNode :: union {
	File,
	Mix,
	AllForOne,
	Gain,
	Loop,
	Concat,
	Pan,
	Mute,
	Pause,
	TrackPosition,
	LowPass,
	HighPass,
	TakeLeft,
	TakeRight,
	Swap,
	Clip,
}

Node :: union {
	SourceNode,
	ParentNode,
}


@(private)
get_node_id :: proc "contextless" (node: Node) -> u32 {
	switch node in node {
	case SourceNode:
		switch node in node {
		case Sine:
			return node.id
		case Square:
			return node.id
		case Sawtooth:
			return node.id
		case Triangle:
			return node.id
		case Noise:
			return node.id
		case Empty:
			return node.id
		case Zero:
			return node.id
		}
	case ParentNode:
		switch node in node {
		case File:
			return node.id
		case Mix:
			return node.id
		case AllForOne:
			return node.id
		case Gain:
			return node.id
		case Loop:
			return node.id
		case Concat:
			return node.id
		case Pan:
			return node.id
		case Mute:
			return node.id
		case Pause:
			return node.id
		case TrackPosition:
			return node.id
		case LowPass:
			return node.id
		case HighPass:
			return node.id
		case TakeLeft:
			return node.id
		case TakeRight:
			return node.id
		case Swap:
			return node.id
		case Clip:
			return node.id
		}
	}
	return 0
}

add_sine :: proc "contextless" (parent: ParentNode, freq: f32, phase: f32) -> Sine {
	id := b_add_sine(get_node_id(parent), freq, phase)
	return Sine{id}
}

add_square :: proc "contextless" (parent: ParentNode, freq: f32, phase: f32) -> Square {
	id := b_add_square(get_node_id(parent), freq, phase)
	return Square{id}
}

add_sawtooth :: proc "contextless" (parent: ParentNode, freq: f32, phase: f32) -> Sawtooth {
	id := b_add_sawtooth(get_node_id(parent), freq, phase)
	return Sawtooth{id}
}

add_triangle :: proc "contextless" (parent: ParentNode, freq: f32, phase: f32) -> Triangle {
	id := b_add_triangle(get_node_id(parent), freq, phase)
	return Triangle{id}
}

add_noise :: proc "contextless" (parent: ParentNode, seed: i32) -> Noise {
	id := b_add_noise(get_node_id(parent), seed)
	return Noise{id}
}

add_empty :: proc "contextless" (parent: ParentNode) -> Empty {
	id := b_add_empty(get_node_id(parent))
	return Empty{id}
}

add_zero :: proc "contextless" (parent: ParentNode) -> Zero {
	id := b_add_zero(get_node_id(parent))
	return Zero{id}
}

add_file :: proc "contextless" (par: ParentNode, ptr: u32, len: u32) -> File {
	id := b_add_file(get_node_id(par), ptr, len)
	return File{id}
}

add_mix :: proc "contextless" (parent: ParentNode) -> Mix {
	id := b_add_mix(get_node_id(parent))
	return Mix{id}
}

add_all_for_one :: proc "contextless" (parent: ParentNode) -> AllForOne {
	id := b_add_all_for_one(get_node_id(parent))
	return AllForOne{id}
}

add_gain :: proc "contextless" (parent: ParentNode, lvl: f32) -> Gain {
	id := b_add_gain(get_node_id(parent), lvl)
	return Gain{id}
}

add_loop :: proc "contextless" (parent: ParentNode) -> Loop {
	id := b_add_loop(get_node_id(parent))
	return Loop{id}
}

add_concat :: proc "contextless" (parent: ParentNode) -> Concat {
	id := b_add_concat(get_node_id(parent))
	return Concat{id}
}

add_pan :: proc "contextless" (parent: ParentNode, lvl: f32) -> Pan {
	id := b_add_pan(get_node_id(parent), lvl)
	return Pan{id}
}

add_mute :: proc "contextless" (parent: ParentNode) -> Mute {
	id := b_add_mute(get_node_id(parent))
	return Mute{id}
}

add_pause :: proc "contextless" (parent: ParentNode) -> Pause {
	id := b_add_pause(get_node_id(parent))
	return Pause{id}
}

add_track_position :: proc "contextless" (parent: ParentNode) -> TrackPosition {
	id := b_add_track_position(get_node_id(parent))
	return TrackPosition{id}
}

add_low_pass :: proc "contextless" (parent: ParentNode, freq: f32, q: f32) -> LowPass {
	id := b_add_low_pass(get_node_id(parent), freq, q)
	return LowPass{id}
}

add_high_pass :: proc "contextless" (parent: ParentNode, freq: f32, q: f32) -> HighPass {
	id := b_add_high_pass(get_node_id(parent), freq, q)
	return HighPass{id}
}

add_take_left :: proc "contextless" (parent: ParentNode) -> TakeLeft {
	id := b_add_take_left(get_node_id(parent))
	return TakeLeft{id}
}

add_take_right :: proc "contextless" (parent: ParentNode) -> TakeRight {
	id := b_add_take_right(get_node_id(parent))
	return TakeRight{id}
}

add_swap :: proc "contextless" (parent: ParentNode) -> Swap {
	id := b_add_swap(get_node_id(parent))
	return Swap{id}
}

add_clip :: proc "contextless" (parent: ParentNode, low: f32, high: f32) -> Clip {
	id := b_add_clip(get_node_id(parent), low, high)
	return Clip{id}
}


reset :: proc "contextless" (node: Node) {
	b_reset(get_node_id(node))
}

reset_all :: proc "contextless" (node: ParentNode) {
	b_reset_all(get_node_id(node))
}

clear :: proc "contextless" (node: ParentNode) {
	b_clear(get_node_id(node))
}

foreign import "audio"

@(private)
@(default_calling_convention = "contextless")
foreign audio {
	// generators
	@(link_name = "add_sine")
	b_add_sine :: proc "contextless" (parent_id: u32, freq: f32, phase: f32) -> u32 ---
	@(link_name = "add_square")
	b_add_square :: proc "contextless" (parent_id: u32, freq: f32, phase: f32) -> u32 ---
	@(link_name = "add_sawtooth")
	b_add_sawtooth :: proc "contextless" (parent_id: u32, freq: f32, phase: f32) -> u32 ---
	@(link_name = "add_triangle")
	b_add_triangle :: proc "contextless" (parent_id: u32, freq: f32, phase: f32) -> u32 ---
	@(link_name = "add_noise")
	b_add_noise :: proc "contextless" (parent_id: u32, seed: i32) -> u32 ---
	@(link_name = "add_empty")
	b_add_empty :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_zero")
	b_add_zero :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_file")
	b_add_file :: proc "contextless" (parent: u32, ptr: u32, len: u32) -> u32 ---

	// nodes
	@(link_name = "add_mix")
	b_add_mix :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_all_for_one")
	b_add_all_for_one :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_gain")
	b_add_gain :: proc "contextless" (parent_id: u32, lvl: f32) -> u32 ---
	@(link_name = "add_loop")
	b_add_loop :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_concat")
	b_add_concat :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_pan")
	b_add_pan :: proc "contextless" (parent_id: u32, lvl: f32) -> u32 ---
	@(link_name = "add_mute")
	b_add_mute :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_pause")
	b_add_pause :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_track_position")
	b_add_track_position :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_low_pass")
	b_add_low_pass :: proc "contextless" (parent_id: u32, freq: f32, q: f32) -> u32 ---
	@(link_name = "add_high_pass")
	b_add_high_pass :: proc "contextless" (parent_id: u32, freq: f32, q: f32) -> u32 ---
	@(link_name = "add_take_left")
	b_add_take_left :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_take_right")
	b_add_take_right :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_swap")
	b_add_swap :: proc "contextless" (parent_id: u32) -> u32 ---
	@(link_name = "add_clip")
	b_add_clip :: proc "contextless" (parent_id: u32, low: f32, high: f32) -> u32 ---

	@(link_name = "reset")
	b_reset :: proc "contextless" (node_id: u32) ---
	@(link_name = "reset_all")
	b_reset_all :: proc "contextless" (node_id: u32) ---
	@(link_name = "clear")
	b_clear :: proc "contextless" (node_id: u32) ---
	@(link_name = "set_param")
	b_set_param :: proc "contextless" (node_id: u32, param: u32, val: f32) ---

}
