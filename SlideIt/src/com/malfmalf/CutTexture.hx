package com.malfmalf;
import flambe.display.ImageSprite;
import flambe.display.SubTexture;
import flambe.display.Texture;

/**
 * ...
 * @author ...
 */
typedef CutData = {
	x:Float,
	y:Float,
	w:Float,
	h:Float,
	center_x:Float,
	center_y:Float,
}

class CutTexture {
	public var cutData(default, null):CutData;
	public var texture(default, null):Texture;
	public var cut(default, null):SubTexture;
	public var center_x(default, null):Int;
	public var center_y(default, null):Int;
	public function new(data:CutData,texture:Texture) {
		this.texture = texture;
		cutData = data;
		if (isValid()) {
			cut = texture.subTexture(Std.int(cutData.x), Std.int(cutData.y), Std.int(cutData.w), Std.int(cutData.h));
			center_x = Math.round(cutData.w * cutData.center_x);
			center_y = Math.round(cutData.h * cutData.center_y);
		}
	}
	
	public function isValid():Bool {
		return texture != null && cutData.x >= 0.0 && cutData.y >= 0.0 && cutData.w >= 1.0 && cutData.h >= 1.0
				&& cutData.x+cutData.w<=texture.width && cutData.y+cutData.h<=texture.height;
	}
	public function getImageSprite():ImageSprite {
		var spr = new ImageSprite(cut);
		spr.setAnchor(center_x, center_y);
		return spr;
	}
}