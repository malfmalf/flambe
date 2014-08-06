package com.malfmalf;
import com.malfmalf.CutTexture.CutData;
import flambe.asset.AssetPack;
import flambe.display.ImageSprite;
import flambe.display.SubTexture;
import haxe.Json;

/**
 * ...
 * @author ...
 */
class CutFile{
	public var cuts(default, null):Map<String,CutTexture>;
	public function new(pack:AssetPack, path:String) {
		
		var root = path.substring(0, path.lastIndexOf("/")+1);
		var json:Array<Dynamic> = Json.parse(pack.getFile(path).toString());
		cuts = new Map<String,CutTexture>();
		for (entry in json) {
			var filename:String = entry.filename;
			var texture_name = root + filename;
			texture_name = texture_name.substr(0, texture_name.lastIndexOf("."));
			var texture = pack.getTexture(texture_name);
			
			for (name in Reflect.fields(entry.cuts)){
				var cut:CutData = Reflect.field(entry.cuts, name);
				cuts.set(name,new CutTexture(cut, texture));
			}
		}
	}
	public function getImageSprite(name:String):ImageSprite {
		if (!cuts.exists(name)) return null;
		return cuts.get(name).getImageSprite();
	}
	public function getCut(name:String):SubTexture{
		if (!cuts.exists(name)) {
			trace ("No cut : " + name);
			return null;
		}
		var cut = cuts.get(name);
		if(!cut.isValid()){
			trace ("Cut : " + name + " = " + cut.isValid());
			trace (cut.cutData);
			trace (cut.texture.width+","+cut.texture.height);
		}
		return cut.cut;
	}
	
}