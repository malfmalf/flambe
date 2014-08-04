package com.malfmalf;

import flambe.Component;
import flambe.display.ImageSprite;
import flambe.display.Texture;
import flambe.Disposer;
import flambe.input.PointerEvent;
import flambe.System;
import flambe.util.Signal0;

/**
 * ...
 * @author ...
 */
class Button extends Component {
	private var normalTexture:Texture;
	private var pressTexture:Texture;
	private var hoverTexture:Texture;
	private var disposer:Disposer;
	public var  clicked(default,null):Signal0;

	public function new(normal:Texture, ?press:Texture, ?hover:Texture ) {
		normalTexture = normal;
		pressTexture = press;
		hoverTexture = hover;
		disposer = new Disposer();
		clicked = new Signal0();
	}
	
	override public function onAdded() {
		super.onAdded();
		var sprite = new ImageSprite(normalTexture);
		owner.add(sprite);
		disposer.connect1(sprite.pointerIn   , pointerIn);
		disposer.connect1(sprite.pointerOut  , pointerOut);
		disposer.connect1(sprite.pointerDown , pointerDown);
		disposer.connect1(sprite.pointerUp   , pointerUp);
	}
	public function connectClicked(f:Listener0) {
		disposer.connect0(clicked, f);
	}
	
	private function pointerIn(e:PointerEvent) {
		if (System.pointer.isDown()) {
			pointerDown(e);
		}
		else{
			if(hoverTexture!=null){
				var sprite = owner.get(ImageSprite);
				sprite.texture =  hoverTexture;
			}
		}
	}
	
	private function pointerOut(e:PointerEvent) {
		var sprite = owner.get(ImageSprite);
		if(sprite.texture!=normalTexture){
			sprite.texture =  normalTexture;
		}		
	}
	
	private function pointerDown(e:PointerEvent) {
		var sprite = owner.get(ImageSprite);
		if (pressTexture == null) {
			sprite.scaleX.animateTo(0.9,0.2);
			sprite.scaleY.animateTo(0.9,0.2);
		}
		else {
			sprite.texture = pressTexture;
		}
	}
	private function pointerUp(e:PointerEvent) {
		var sprite = owner.get(ImageSprite);
		sprite.scaleX.animateTo(1.0,0.2);
		sprite.scaleY.animateTo(1.0, 0.2);

		if (sprite.contains(e.viewX, e.viewY)) {
			clicked.emit();
			if(hoverTexture!=null){
				sprite.texture =  hoverTexture;
			}
			else {
				sprite.texture = normalTexture;			
			}
		}
		else {
			sprite.texture = normalTexture;			
		}
	}
	
	
}