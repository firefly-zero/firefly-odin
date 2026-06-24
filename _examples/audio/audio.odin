package main

import "../../firefly/audio"

@(export = true)
boot :: proc "contextless" () {
	gain := audio.add_gain(audio.OUT, 1)
	mod := audio.SineModulator{audio.hz(0.5)}
	audio.modulate(gain, 0, 1, mod)
	audio.add_sine(gain, audio.C4, 0)
}
