package com.malfmalf.tiles;

import com.malfmalf.blocks.Block;
import com.malfmalf.BoardCoord;
import flambe.display.ImageSprite;
import flambe.math.Point;

/**
 * ...
 * @author malf
 */
class SwitchTile extends Tile {
	public var switchId(default, null):Int;
	public var state(default, null):Bool;
	public static var switches(default, null):Map<Int,SwitchTile> = new Map<Int,SwitchTile>();
	public function new(switchId:Int,initialState:Bool,c:BoardCoord, p:Point, textureId:Int){
		super(c, p, textureId);
		this.switchId = switchId;
		state = initialState;
		switches.set(switchId, this);		
	}
	override public function onAdded() {
		super.onAdded();
		setTexture();
	}
	public override function onEnterEnd(b:Block) {
		state = !state;
		setTexture();
	}
	private function setTexture() {
		var spr = owner.get(ImageSprite);
		if (state) {
			spr.texture = Main.elements.getCut(Std.string(textureId));
		}
		else {
			spr.texture = Main.elements.getCut(Std.string(textureId+1));			
		}
	}
	
}