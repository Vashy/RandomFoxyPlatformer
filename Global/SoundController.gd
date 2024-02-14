extends Node2D

enum SoundType {
	PlayerDeath
}

func play(sound: SoundType):
	if sound == SoundType.PlayerDeath and $PlayerDeathSfx:
		$PlayerDeathSfx.play(0.3)
