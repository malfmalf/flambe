package com.malfmalf;

import flambe.math.Point;
import flambe.display.ImageSprite;
import com.malfmalf.Block.MoveDirection;
import format.png.Data.Color;
/**
 * ...
 * @author ...
 */
class ColorTile extends BoardTile{
	public var color(default, null):Int;
	public function new(color:Int,c:BoardCoord, p:Point) {
		super(c, p);
		this.color = color;
		
	}
	override public function onAdded () {
		owner.add(new ImageSprite(Main.boardPack.getTexture("img/tiles/"+color)).centerAnchor());
		owner.get(ImageSprite).setXY(pos.x, pos.y);
    }
	override public function onEnterEnd(block:Block) {
			if (Std.is(block, ColorBlock)) {
				var color_block = cast(block, ColorBlock);
				if (color < 0 || color == color_block.color) color_block.dissapear();				
			}
	}
		
}