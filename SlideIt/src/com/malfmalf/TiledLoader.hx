package com.malfmalf;

/**
 * @author malf
 */

interface TiledLoader {
  function onProperty(name:String, value:String):Void;
  function onStartLayer(name:String, width:Int, height:Int):Void;
  function onEndLayer():Void;
  function onTile(count:Int, gid:Int):Void;	
}