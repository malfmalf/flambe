package com.malfmalf.tiles;

import com.malfmalf.BoardCoord;
import flambe.math.Point;
import flambe.display.ImageSprite;
import com.malfmalf.blocks.Block;

/**
 * ...
 * @author malf
 */
class SwitchableTile extends Tile{
	private var switchId:Int;
	private var state:Null<Bool>;
	public function new(switchId:Int,c:BoardCoord, p:Point, textureId:Int) {
		super(c, p, textureId);
		this.switchId = switchId;
		state = null;
	}
	public override function onUpdate(dt:Float) {
		var st = SwitchTile.switches.get(switchId).state;
		if (st != state) {
			state = st;
			setTexture();
		}
	}
	override public function onEnterStart(block:Block) {
		if(state) block.stop();
	}

	private function setTexture() {
		var spr = owner.get(ImageSprite);
		if (state) {
			spr.texture = Main.elements.getCut(Std.string(textureId));
		}
		else {
			spr.texture = Main.elements.getCut(Std.string(2));			
		}
	}
	
	
}