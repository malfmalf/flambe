package com.malfmalf;

import flambe.display.Font;
import flambe.display.Texture;
import flambe.util.Signal1;

/**
 * ...
 * @author ...
 */
class LevelButton extends TextButton{
	public static var texture:Texture;
	public static var levelFont:Font;
	public var levelSelect:Signal1<Int>;
	public var level(default, null):Int;
	public function new(level:Int) {
		if (texture == null) loadAssets();
		this.level = level;
		super(texture, levelFont, Std.string(level));
		levelSelect = new Signal1<Int>();
		connectClicked(onClicked);
	}
	public function connectLevelSelect(f:Listener1<Int>) {
		disposer.connect1(levelSelect, f);
	}
	
	private function onClicked() {
		levelSelect.emit(level);
	}
	private static function loadAssets() {
		texture = Main.buttons[7];
		levelFont = new Font(Main.boardPack, "fonts/comic");
	}
	
}