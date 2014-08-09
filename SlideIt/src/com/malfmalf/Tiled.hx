package com.malfmalf;

/**
 * ...
 * @author malf
 */
class Tiled{

	public static function load(xml:Xml, loader:TiledLoader) {
		var map = xml.elementsNamed("map").next();
		for (prop in map.elementsNamed("properties").next().elementsNamed("property")) {
			loader.onProperty(prop.get("name"), prop.get("value"));
		}
		for (layer in map.elementsNamed("layer")) {
			loader.onStartLayer(layer.get("name"),Std.parseInt(layer.get("width")),Std.parseInt(layer.get("height")));
			var pos = 0;
			for (tile in layer.elementsNamed("data").next().elementsNamed("tile")) {
				var gid = Std.parseInt(tile.get("gid"));
				loader.onTile(pos, gid);
				++pos;
			}
			loader.onEndLayer();
		}

	}
}