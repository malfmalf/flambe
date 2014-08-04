package com.malfmalf;

import flambe.display.Font;
import flambe.display.Texture;
import flambe.Entity;
import flambe.display.TextSprite;
/**
 * ...
 * @author ...
 */
class TextButton extends Button{
	private var font:Font;
	private var text:String;
	public function new(normal:Texture, font:Font,text:String) {
		super(normal);
		this.font = font;
		this.text = text;
	}
	public override function onAdded() {
		super.onAdded();
		owner.addChild(new Entity()
			.add(new TextSprite(font, text).centerAnchor().setXY(32,32)));

	}
	
}