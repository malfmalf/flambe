package com.malfmalf.blocks;

import com.malfmalf.BoardCoord;
import flambe.math.Point;
import flambe.display.ImageSprite;

/**
 * ...
 * @author ...
 */
class MovingBlock extends Block{

	public function new(c:BoardCoord, p:Point) {
		super(c, p);
	}
	override public function onAdded () {
		owner.add(new ImageSprite(Main.boardPack.getTexture("img/blocks/moving")).centerAnchor());
		owner.get(ImageSprite).setXY(pos.x, pos.y);
		super.onAdded();
    }	
}