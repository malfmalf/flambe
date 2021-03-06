package com.malfmalf.blocks ;

import flambe.display.ImageSprite;
import flambe.math.Point;
import com.malfmalf.blocks.Block.MoveDirection;
import com.malfmalf.scenes.GameScene;
/**
 * ...
 * @author ...
 */

class ColorBlock extends Block
{
	public var color(default, null):Int;
	private var dissapearing:Bool;
	public function new(color:Int, c:BoardCoord, p:Point,textureId:Int) {
		super(c, p,textureId);
		this.color = color;
		dissapearing = false;
	}
	override public function onUpdate(dt:Float) {
		if (dissapearing) {
			var spr = owner.get(ImageSprite);
			var doing = (spr.scaleX.behavior != null && !spr.scaleX.behavior.isComplete()) || (spr.scaleY.behavior != null && !spr.scaleY.behavior.isComplete());
			if (!doing) {
				GameScene.board.blocks.remove(this);
				owner.disposeChildren();
				owner.dispose();
			}
			return;
		}
		super.onUpdate(dt);
	}
	public function dissapear() {
		move = MoveDirection.NONE;
		owner.get(ImageSprite).scaleX.animateTo(3.0  , 1.0);
		owner.get(ImageSprite).scaleY.animateTo(3.0  , 1.0);
		owner.get(ImageSprite).alpha.animateTo(0.0  , 1.0);
		owner.get(ImageSprite).rotation.animateBy(720, 1.0);
		dissapearing = true;
	}
	override public function onFall() {
		super.onFall();
		Main.goFinishScene(false);
	}
}