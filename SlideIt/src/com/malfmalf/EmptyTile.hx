package com.malfmalf;
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
class EmptyTile extends BoardTile {
	private static var font:Font;
	public function new(c:BoardCoord,p:Point) {
		super(c, p);
		if (font == null) font = new Font(Main.boardPack, "fonts/timotheos");
	}
	override public function onAdded() {
		owner.add(new ImageSprite(Main.boardPack.getTexture("img/tiles/empty")).centerAnchor().setXY(pos.x, pos.y ));
		owner.addChild(new Entity()
			.add(new TextSprite(font, coord.i + "," + coord.j).centerAnchor().setXY(32,32)));
	}	
}