package com.malfmalf ;
import flambe.Component;
import nape.space.Space;

/**
 * @author Mark Knol [blog.stroep.nl]
 */
class NapeDebugView extends Component
{
	private var _space:Space;
	
	#if flash
	private var _debugView:nape.util.ShapeDebug;
	#end
	
	public function new(space:Space, width:Int, height:Int) 
	{
		_space = space;
		
		#if flash 
		  _debugView = new nape.util.ShapeDebug(width, height);
		  flash.Lib.current.stage.addChild(_debugView.display);
		#end
	}	
	
	override public function onUpdate(dt:Float) 
	{
		super.onUpdate(dt);
		
		#if flash
		 //var sprite = owner.get(Sprite);
		 //_debugView.display.x = sprite.x._;
		 //_debugView.display.y = sprite.y._;
		 
		 _debugView.clear();
		 _debugView.draw(_space);
		#end
	}
	
	override public function dispose() 
	{
		#if flash
		  flash.Lib.current.stage.removeChild(_debugView.display);
		  _debugView = null;
		#end
		
		super.dispose();
	}
}