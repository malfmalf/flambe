package com.malfmalf.tiles;
import flambe.math.Point;
import flambe.display.ImageSprite;
import com.malfmalf.blocks.Block;
/**
 * ...
 * @author malf
 */
class BrakeTile extends Tile
{


	public function new(c:BoardCoord, p:Point,textureId:Int) {
		super(c, p,textureId);
	}
	override public function onEnterEnd(block:Block) {
			block.stop();
	}
}