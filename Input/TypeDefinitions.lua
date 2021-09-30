type self = self;

type KeyCode = Enum.KeyCode;
type GameProcessedEvent = boolean;
type UserInputType = Enum.UserInputType;

type Sequence = {
	Hook: (KeyCode, GameProcessedEvent) -> nil,

	new: (number?, ...KeyCode | UserInputType) -> {
		Toggle: (self, boolean) -> nil,
		Reset: () -> nil,
		Cancel: () -> nil,
		Destroy: () -> nil,

		Start: {
			Connect: (() -> (KeyCode, GameProcessedEvent)) -> RBXScriptConnection
		},
		End: {
			Connect: (() -> ()) -> ()
		},
		Pressed: {
			Connect: (() -> ()) -> ()
		},
		Index: number
	}
};

type Hold = {
	HookStart: (KeyCode, GameProcessedEvent) -> nil,
	HookEnd: (KeyCode) -> nil,

	new: (...KeyCode | UserInputType) -> {
		Cancel: () -> nil,
		Destroy: () -> nil,

		Start: {
			Connect: (() -> (KeyCode, GameProcessedEvent)) -> RBXScriptConnection
		},
		End: {
			Connect: (() -> ()) -> ()
		},
		Hold: {
			Connect: (() -> ()) -> ()
		},
		Index: number
	}
}

export type Input = {
	Sequence: Sequence,
	Hold: Hold
}

return {}
