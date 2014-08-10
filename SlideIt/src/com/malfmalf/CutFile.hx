package com.malfmalf;
import com.malfmalf.CutTexture.CutData;
import flambe.asset.AssetPack;
import flambe.display.ImageSprite;
import flambe.display.SubTexture;
import flambe.display.Texture;
import haxe.Json;

/**
 * ...
 * @author ...
 */
class CutFile{
	public var cuts(default, null):Map<String,CutTexture>;
	public function new(pack:AssetPack, path:String) {
		cuts = new Map<String,CutTexture>();
		if (pack == null) return;

		var root = path.substring(0, path.lastIndexOf("/")+1);
		var json:Array<Dynamic> = Json.parse(pack.getFile(path).toString());
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
	
	public static function fromSubDivision(pack:AssetPack, path:String, nx:Int, ny:Int):CutFile {
		var texture = pack.getTexture(path);
		var dx = Math.floor(texture.width / nx);
		var dy = Math.floor(texture.height / ny);
		var x = 0;
		var y = 0;
		var file = new CutFile(null,null);
		for (i in 0...nx) {
			for (j in 0...ny) {
				var id = j * nx + i + 1;
				file.cuts.set(Std.string(id), new CutTexture( { x:x, y:y, w:dx, h:dy, center_x:0.5, center_y:0.5 }, texture));
				y += dy;
			}
			x += dx;
			y = 0;
		}
		return file;
	}
	
}