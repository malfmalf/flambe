package com.malfmalf.tiles ;
import flambe.math.Point;
import flambe.display.Font;
import flambe.display.TextSprite;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.Entity;


/**
 * ...
 * @author ...
 */
class EmptyTile extends Tile {
	public function new(c:BoardCoord,p:Point,textureId:Int) {
		super(c, p,textureId);
	}
}