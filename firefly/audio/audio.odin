
package audio

Freq :: struct {
	h: f32,
}

Time :: struct {
	s: u32,
}

// Audio node created by `add_sine`.
Sine :: struct {
	id: u32,
}

// Audio node created by `add_square`.
Square :: struct {
	id: u32,
}

// Audio node created by `add_sawtooth`.
Sawtooth :: struct {
	id: u32,
}

// Audio node created by `add_triangle`.
Triangle :: struct {
	id: u32,
}

// Audio node created by `add_noise`.
Noise :: struct {
	id: u32,
}

// Audio node created by `add_empty`.
Empty :: struct {
	id: u32,
}

// Audio node created by `add_zero`.
Zero :: struct {
	id: u32,
}

// Audio node created by `add_file`.
File :: struct {
	id: u32,
}

// Audio node created by `add_mix`.
Mix :: struct {
	id: u32,
}

// Audio node created by `add_all_for_one`.
AllForOne :: struct {
	id: u32,
}

// Audio node created by `add_gain`.
Gain :: struct {
	id: u32,
}

// Audio node created by `add_loop`.
Loop :: struct {
	id: u32,
}

// Audio node created by `add_concat`.
Concat :: struct {
	id: u32,
}

// Audio node created by `add_pan`.
Pan :: struct {
	id: u32,
}

// Audio node created by `add_mute`.
Mute :: struct {
	id: u32,
}

// Audio node created by `add_pause`.
Pause :: struct {
	id: u32,
}

// Audio node created by `add_track_position`.
TrackPosition :: struct {
	id: u32,
}

// Audio node created by `add_low_pass`.
LowPass :: struct {
	id: u32,
}

// Audio node created by `add_high_pass`.
HighPass :: struct {
	id: u32,
}

// Audio node created by `add_take_left`.
TakeLeft :: struct {
	id: u32,
}

// Audio node created by `add_take_right`.
TakeRight :: struct {
	id: u32,
}

// Audio node created by `add_swap`.
Swap :: struct {
	id: u32,
}

// Audio node created by `add_clip`.
Clip :: struct {
	id: u32,
}

SourceNode :: union #no_nil {
	Sine,
	Square,
	Sawtooth,
	Triangle,
	Noise,
	Empty,
	Zero,
}

ParentNode :: union #no_nil {
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

Node :: union #no_nil {
	SourceNode,
	ParentNode,
}


@(private)
@(require_results)
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

// Add sine wave oscillator source (`∿`).
add_sine :: proc "contextless" (parent: ParentNode, freq: Freq, phase: f32) -> Sine {
	id := b_add_sine(get_node_id(parent), freq.h, phase)
	return Sine{id}
}

// Add square wave oscillator source (`⎍`).
add_square :: proc "contextless" (parent: ParentNode, freq: Freq, phase: f32) -> Square {
	id := b_add_square(get_node_id(parent), freq.h, phase)
	return Square{id}
}

// Add sawtooth wave oscillator source (`╱│`).
add_sawtooth :: proc "contextless" (parent: ParentNode, freq: Freq, phase: f32) -> Sawtooth {
	id := b_add_sawtooth(get_node_id(parent), freq.h, phase)
	return Sawtooth{id}
}

// Add triangle wave oscillator source (`╱╲`).
add_triangle :: proc "contextless" (parent: ParentNode, freq: Freq, phase: f32) -> Triangle {
	id := b_add_triangle(get_node_id(parent), freq.h, phase)
	return Triangle{id}
}

// Add white noise source (amplitude on each tick is random).
add_noise :: proc "contextless" (parent: ParentNode, seed: i32) -> Noise {
	id := b_add_noise(get_node_id(parent), seed)
	return Noise{id}
}

// Add always stopped source.
add_empty :: proc "contextless" (parent: ParentNode) -> Empty {
	id := b_add_empty(get_node_id(parent))
	return Empty{id}
}

// Add silent source producing zeros.
add_zero :: proc "contextless" (parent: ParentNode) -> Zero {
	id := b_add_zero(get_node_id(parent))
	return Zero{id}
}

// Play an audio file from ROM.
add_file :: proc "contextless" (par: ParentNode, path: string) -> File {
	ptr := cast(uintptr)raw_data(path)
	len := cast(u32)(len(path))
	id := b_add_file(get_node_id(par), ptr, len)
	return File{id}
}

// Add node simply mixing all inputs.
add_mix :: proc "contextless" (parent: ParentNode) -> Mix {
	id := b_add_mix(get_node_id(parent))
	return Mix{id}
}

// Add mixer node that stops if any of the sources stops.
add_all_for_one :: proc "contextless" (parent: ParentNode) -> AllForOne {
	id := b_add_all_for_one(get_node_id(parent))
	return AllForOne{id}
}

// Add gain control node.
add_gain :: proc "contextless" (parent: ParentNode, lvl: f32) -> Gain {
	id := b_add_gain(get_node_id(parent), lvl)
	return Gain{id}
}

// Add a loop node that resets the input if it stops.
add_loop :: proc "contextless" (parent: ParentNode) -> Loop {
	id := b_add_loop(get_node_id(parent))
	return Loop{id}
}

// Add a node that plays the inputs one after the other, in the order as they added.
add_concat :: proc "contextless" (parent: ParentNode) -> Concat {
	id := b_add_concat(get_node_id(parent))
	return Concat{id}
}

// Add node panning the audio to the left (0.), right (1.), or something in between.
add_pan :: proc "contextless" (parent: ParentNode, lvl: f32) -> Pan {
	id := b_add_pan(get_node_id(parent), lvl)
	return Pan{id}
}

// Add node that can be muted using modulation.
add_mute :: proc "contextless" (parent: ParentNode) -> Mute {
	id := b_add_mute(get_node_id(parent))
	return Mute{id}
}

// Add node that can be paused using modulation.
add_pause :: proc "contextless" (parent: ParentNode) -> Pause {
	id := b_add_pause(get_node_id(parent))
	return Pause{id}
}

// Add node tracking the elapsed playback time.
add_track_position :: proc "contextless" (parent: ParentNode) -> TrackPosition {
	id := b_add_track_position(get_node_id(parent))
	return TrackPosition{id}
}

// Add lowpass filter node.
add_low_pass :: proc "contextless" (parent: ParentNode, freq: Freq, q: f32) -> LowPass {
	id := b_add_low_pass(get_node_id(parent), freq.h, q)
	return LowPass{id}
}

// Add highpass filter node.
add_high_pass :: proc "contextless" (parent: ParentNode, freq: Freq, q: f32) -> HighPass {
	id := b_add_high_pass(get_node_id(parent), freq.h, q)
	return HighPass{id}
}

// Add node converting stereo to mono by taking the left channel.
add_take_left :: proc "contextless" (parent: ParentNode) -> TakeLeft {
	id := b_add_take_left(get_node_id(parent))
	return TakeLeft{id}
}

// Add node converting stereo to mono by taking the right channel.
add_take_right :: proc "contextless" (parent: ParentNode) -> TakeRight {
	id := b_add_take_right(get_node_id(parent))
	return TakeRight{id}
}

// Add node swapping left and right channels of the stereo input.
add_swap :: proc "contextless" (parent: ParentNode) -> Swap {
	id := b_add_swap(get_node_id(parent))
	return Swap{id}
}

// Add node clamping the input amplitude. Can be used for hard distortion.
add_clip :: proc "contextless" (parent: ParentNode, low: f32, high: f32) -> Clip {
	id := b_add_clip(get_node_id(parent), low, high)
	return Clip{id}
}


// Reset the node state to how it was when it was just added.
reset :: proc "contextless" (node: Node) {
	b_reset(get_node_id(node))
}

// Reset the node and all child nodes to the state to how it was when they were just added.
reset_all :: proc "contextless" (node: ParentNode) {
	b_reset_all(get_node_id(node))
}

// Remove all child nodes.
//
// After it is called, you should make sure to discard all references to the old
// child nodes.
clear :: proc "contextless" (node: ParentNode) {
	b_clear(get_node_id(node))
}


// Modulator can be attached to a node to change a node parameter over time.
//
// Modulators include both LFOs (Low-Frequency Oscillator) and envelopes.
// The difference is that LFOs keep oscillating between values
// while envelopes go from one value to another and then stop.
//
// Internally, modulators only produce values from 0 to 1.
// Then, to get the final value of the parameter,
// the value from the modulator is projected on the range
// between `low` and `high` arguments passed together
// with the modulator when attaching a modulator to a node.
// For example, [`Node<Sine>::modulate`] accepts the range of modulated values
// for the sine wave frequency (which can be used for vibrato effect).
//
// Even if a node has multiple parameters that can be modulated,
// currently  single node may have at most one modulator attached.
Modulator :: union #no_nil {
	LinearModulator,
	HoldModulator,
	AdsrModulator,
	SineModulator,
	SquareModulator,
	SawtoothModulator,
}

// Linear (ramp up or down) envelope.
//
// It looks like this: `⎽╱⎺` (or `⎺╲⎽` if `low` is bigger than `high`).
//
// The value before `start_at` is 0, the value after `end_at` is 1,
// and the value between `start_at` and `end_at` changes linearly from 0 to 1.
//
// Most often used with [`Gain`] for fade in and fade out effect.
LinearModulator :: struct {
	start_at: Time,
	end_at:   Time,
}

// Hold envelope.
//
// It looks like this: `⎽│⎺` (or `⎺│⎽` if `low` is bigger than `high`).
//
// The value before `time` is 0 and the value after `time` is 1.
// Equivalent to [`LinearModulator`] with `start_at` being equal to `end_at`.
HoldModulator :: struct {
	time: Time,
}

// ADSR envelope.
//
// It looks like this: `🭋🭍🬹🬿`
//
//  1. Until `attack`, the value goes from 0 to 1;
//  2. Until `decay`, it goes from 1 to `sustain_level`;
//  3. Until `sustain`, it holds `sustain_level`;
//  4. Until `release`, it goes from `sustain_level` to 0;
//  5. After `release`, it holds 0.
//
// Most commonly used with [`Gain`].
AdsrModulator :: struct {
	// When the value reaches 1.
	attack:        Time,
	// When the value reaches `sustain_level`.
	decay:         Time,
	// Until when the value holds `sustain_level`.
	sustain:       Time,
	// The value generated from `decay` until `sustain`.
	sustain_level: f32,
	// When the value drops to 0.
	release:       Time,
}


// Sine wave low-frequency oscillator.
//
// It looks like this: `∿`.
//
// Most commonly used with [`Sine`] (or another wave generator)
// to produce vibrato effect.
SineModulator :: struct {
	freq: Freq,
}

// Square wave low-frequency oscillator.
//
// It looks like this: `🭿🭾🭿🭾🭿🭾🭿🭾`.
SquareModulator :: struct {
	period: Time,
}

// Sawtooth wave low-frequency oscillator.
//
// It looks like this: `╱│╱│╱│╱│`.
SawtoothModulator :: struct {
	period: Time,
}


// Modulate the main parameter of the Node using the given Modulator.
//
// Only some nodes can be modulated.
modulate :: proc {
	mod_sine,
	mod_square,
	mod_sawtooth,
	mod_triangle,
	mod_gain,
	mod_pan,
	mod_mute,
	mod_pause,
	mod_low_pass,
	mod_high_pass,
	mod_clip,
}

// Modulate oscillation frequency of a Sine node.
@(private)
mod_sine :: proc "contextless" (node: Sine, param: u32, low: Freq, high: Freq, mod: Modulator) {
	_modulate(node.id, 0, low.h, high.h, mod)
}

// Modulate oscillation frequency of a Square node.
@(private)
mod_square :: proc "contextless" (
	node: Square,
	param: u32,
	low: Freq,
	high: Freq,
	mod: Modulator,
) {
	_modulate(node.id, 0, low.h, high.h, mod)
}

// Modulate oscillation frequency of a Sawtooth node.
@(private)
mod_sawtooth :: proc "contextless" (
	node: Sawtooth,
	param: u32,
	low: Freq,
	high: Freq,
	mod: Modulator,
) {
	_modulate(node.id, 0, low.h, high.h, mod)
}

// Modulate oscillation frequency of a Triangle node.
@(private)
mod_triangle :: proc "contextless" (
	node: Triangle,
	param: u32,
	low: Freq,
	high: Freq,
	mod: Modulator,
) {
	_modulate(node.id, 0, low.h, high.h, mod)
}

// Modulate the gain level of a Gain node.
@(private)
mod_gain :: proc "contextless" (node: Gain, param: u32, low: f32, high: f32, mod: Modulator) {
	_modulate(node.id, 0, low, high, mod)
}

// Modulate the pan value (from 0. to 1.: 0. is only left, 1. is only right) of a Pan node.
@(private)
mod_pan :: proc "contextless" (node: Pan, param: u32, low: f32, high: f32, mod: Modulator) {
	_modulate(node.id, 0, low, high, mod)
}

// Modulate the muted state of a Mute node.
//
// Below 0.5 is muted, above is unmuted.
@(private)
mod_mute :: proc "contextless" (node: Mute, param: u32, low: f32, high: f32, mod: Modulator) {
	_modulate(node.id, 0, low, high, mod)
}

// Modulate the paused state of a Pause node.
//
// Below 0.5 is paused, above is playing.
@(private)
mod_pause :: proc "contextless" (node: Pause, param: u32, low: f32, high: f32, mod: Modulator) {
	_modulate(node.id, 0, low, high, mod)
}

// Modulate the cut-off frequency of a LowPass node.
@(private)
mod_low_pass :: proc "contextless" (
	node: LowPass,
	param: u32,
	low: Freq,
	high: Freq,
	mod: Modulator,
) {
	_modulate(node.id, 0, low.h, high.h, mod)
}

// Modulate the cut-off frequency of a HighPass node.
@(private)
mod_high_pass :: proc "contextless" (
	node: HighPass,
	param: u32,
	low: Freq,
	high: Freq,
	mod: Modulator,
) {
	_modulate(node.id, 0, low.h, high.h, mod)
}

// Modulate the low cut amplitude (of a Clip node) and adjust the high amplitude to keep the gap.
@(private)
mod_clip :: proc "contextless" (node: Clip, param: u32, low: f32, high: f32, mod: Modulator) {
	_modulate(node.id, 0, low, high, mod)
}

@(private)
_modulate :: proc "contextless" (node_id: u32, param: u32, low: f32, high: f32, mod: Modulator) {
	switch mod in mod {
	case LinearModulator:
		b_mod_linear(node_id, param, low, high, mod.start_at.s, mod.end_at.s)
	case HoldModulator:
		b_mod_hold(node_id, param, low, high, mod.time.s)
	case AdsrModulator:
		b_mod_adsr(
			node_id,
			param,
			low,
			high,
			mod.attack.s,
			mod.decay.s,
			mod.sustain.s,
			mod.sustain_level,
			mod.release.s,
		)
	case SineModulator:
		b_mod_sine(node_id, param, mod.freq.h, low, high)
	case SquareModulator:
		b_mod_square(node_id, param, low, high, mod.period.s)
	case SawtoothModulator:
		b_mod_sawtooth(node_id, param, low, high, mod.period.s)
	}
}


// Set the value of the Node's main parameter.
//
// Only some parameters can be changed.
set :: proc {
	set_sine,
	set_square,
	set_sawtooth,
	set_triangle,
	set_file,
	set_gain,
	set_pan,
	set_mute,
	set_pause,
	set_low_pass,
	set_high_pass,
	set_clip,
}

// Set oscillation frequency of a Sine node.
@(private)
set_sine :: proc "contextless" (node: Sine, param: u32, val: Freq) {
	b_set_param(node.id, 0, val.h)
}

// Set oscillation frequency of a Square node.
@(private)
set_square :: proc "contextless" (node: Square, param: u32, val: Freq) {
	b_set_param(node.id, 0, val.h)
}

// Set oscillation frequency of a Sawtooth node.
@(private)
set_sawtooth :: proc "contextless" (node: Sawtooth, param: u32, val: Freq) {
	b_set_param(node.id, 0, val.h)
}

// Set oscillation frequency of a Triangle node.
@(private)
set_triangle :: proc "contextless" (node: Triangle, param: u32, val: Freq) {
	b_set_param(node.id, 0, val.h)
}

// Go to the specified timestamp in the file.
@(private)
set_file :: proc "contextless" (node: File, param: u32, val: Time) {
	b_set_param(node.id, 0, f32(val.s))
}

// Set the gain level of a Gain node.
@(private)
set_gain :: proc "contextless" (node: Gain, param: u32, val: f32) {
	b_set_param(node.id, 0, val)
}

// Set the pan value (from 0. to 1.: 0. is only left, 1. is only right) of a Pan node.
@(private)
set_pan :: proc "contextless" (node: Pan, param: u32, val: f32) {
	b_set_param(node.id, 0, val)
}

// Set the muted state of a Mute node.
//
// Below 0.5 is muted, above is unmuted.
@(private)
set_mute :: proc "contextless" (node: Mute, param: u32, val: f32) {
	b_set_param(node.id, 0, val)
}

// Set the paused state of a Pause node.
//
// Below 0.5 is paused, above is playing.
@(private)
set_pause :: proc "contextless" (node: Pause, param: u32, val: f32) {
	b_set_param(node.id, 0, val)
}

// Set the cut-off frequency of a LowPass node.
@(private)
set_low_pass :: proc "contextless" (node: LowPass, param: u32, val: Freq) {
	b_set_param(node.id, 0, val.h)
}

// Set the cut-off frequency of a HighPass node.
@(private)
set_high_pass :: proc "contextless" (node: HighPass, param: u32, val: Freq) {
	b_set_param(node.id, 0, val.h)
}

// Set the low cut amplitude (of a Clip node) and adjust the high amplitude to keep the gap.
@(private)
set_clip :: proc "contextless" (node: Clip, param: u32, val: f32) {
	b_set_param(node.id, 0, val)
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
	b_add_file :: proc "contextless" (parent: u32, ptr: uintptr, len: u32) -> u32 ---

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


	@(link_name = "mod_linear")
	b_mod_linear :: proc "contextless" (node_id: u32, param: u32, start: f32, end: f32, start_at: u32, end_at: u32) ---
	@(link_name = "mod_hold")
	b_mod_hold :: proc "contextless" (id: u32, param: u32, low: f32, high: f32, time: u32) ---
	@(link_name = "mod_sine")
	b_mod_sine :: proc "contextless" (id: u32, param: u32, freq: f32, low: f32, high: f32) ---
	@(link_name = "mod_square")
	b_mod_square :: proc "contextless" (id: u32, param: u32, low: f32, high: f32, period: u32) ---
	@(link_name = "mod_sawtooth")
	b_mod_sawtooth :: proc "contextless" (id: u32, param: u32, low: f32, high: f32, period: u32) ---
	@(link_name = "mod_adsr")
	b_mod_adsr :: proc "contextless" (id: u32, param: u32, low: f32, high: f32, attack: u32, decay: u32, sustain: u32, sustain_level: f32, release: u32) ---

}
