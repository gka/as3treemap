package net.vis4.treemap.display 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;

	/**
	 * Sprite3 is a Sprite that has a foreground and a background layer.
	 * 
	 * If you addChild() something to a Sprite3, it will be added between
	 * the background and the foreground sprites. Same for removeChild() etc
	 *
	 * You can access the foreground and background sprites using the public
	 * properties foreground and background. You can also use fg and bg as
 	 * shortcuts.
	 * 
	 * @author gka
	 */
	public class Sprite3 extends Sprite
	{
		protected var _background:Sprite;
		protected var _content:Sprite;
		protected var _foreground:Sprite;
		
		public function Sprite3() 
		{
			_background = new Sprite();
			_content = new Sprite();
			_foreground = new Sprite();
			
			super.addChild(_background);
			super.addChild(_content);
			super.addChild(_foreground);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			return _content.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			return _content.addChildAt(child, index);
		}
		
		override public function getChildAt(index:int):DisplayObject 
		{
			return _content.getChildAt(index);
		}
		
		override public function getChildByName(name:String):DisplayObject 
		{
			return _content.getChildByName(name);
		}
		
		override public function getChildIndex(child:DisplayObject):int 
		{
			return _content.getChildIndex(child);
		}
		
		override public function get graphics():Graphics 
		{
			return _content.graphics;
		}
		
		public function get background():Sprite 
		{
			return _background;
		}
		
		public function get foreground():Sprite 
		{
			return _foreground;
		}
		
		public function get bg():Sprite 
		{
			return background;
		}
		
		public function get fg():Sprite 
		{
			return foreground;
		}
	}

}
