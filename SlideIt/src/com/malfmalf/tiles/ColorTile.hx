package com.malfmalf.tiles ;

import flambe.math.Point;
import flambe.display.ImageSprite;
import com.malfmalf.blocks.Block.MoveDirection;
import com.malfmalf.blocks.ColorBlock;
import com.malfmalf.blocks.Block;

/**
 * ...
 * @author ...
 */
class ColorTile extends Tile{
	public var color(default, null):Int;
	public function new(color:Int,c:BoardCoord, p:Point,textureId:Int) {
		super(c, p,textureId);
		this.color = color;
		
	}
	override public function onAdded () {
		owner.add(new ImageSprite(Main.elements.getCut("tile"+color)).centerAnchor());
		owner.get(ImageSprite).setXY(pos.x, pos.y);
    }
	override public function onEnterEnd(block:Block) {
			if (Std.is(block, ColorBlock)) {
				var color_block = cast(block, ColorBlock);
				if (color < 0 || color == color_block.color) color_block.dissapear();				
			}
	}
		
}