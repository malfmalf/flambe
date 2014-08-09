package com.malfmalf.tiles ;
import flambe.math.Point;
import flambe.display.ImageSprite;
import com.malfmalf.blocks.Block;
import com.malfmalf.blocks.Block.MoveDirection;
/**
 * ...
 * @author ...
 */
class StopTile extends Tile{

	public function new(c:BoardCoord, p:Point,textureId:Int) {
		super(c, p,textureId);
	}
	override public function onAdded () {
		owner.add(new ImageSprite(Main.elements.getCut("tileStop")).centerAnchor());
		owner.get(ImageSprite).setXY(pos.x, pos.y);
	}
	override public function onEnterStart(block:Block) {
			block.stop();
	}
	
}