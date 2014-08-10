package com.malfmalf.blocks;

import com.malfmalf.BoardCoord;
import flambe.math.Point;
import flambe.display.ImageSprite;

/**
 * ...
 * @author ...
 */
class MovingBlock extends Block{

	public function new(c:BoardCoord, p:Point,textureId:Int) {
		super(c, p,textureId);
	}
}