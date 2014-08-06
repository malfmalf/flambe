package com.malfmalf;
import flambe.display.Sprite;

/**
 * ...
 * @author ...
 */
class SpriteUtils{

	public static function centerOnParent(s:Sprite):Sprite {
		var sp = parentSprite(s);
		if (sp != null) {
			s.setXY(sp.getNaturalWidth() * 0.5, sp.getNaturalHeight() * 0.5);
		}
		return s;
	}
	public static function parentSprite(s:Sprite):Sprite {
		if (s.owner==null) return null;
		var p = s.owner.parent;
		while (p != null) {
			var ps = p.get(Sprite);
			if (ps != null) return ps;
			p = p.parent;
		}
		return null;
	}
	
}