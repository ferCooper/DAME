package org.flixel.data
{
	import flash.events.MouseEvent;
	import org.flixel.FlxG;
	
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 * This class helps contain and track the mouse pointer in your game.
	 * Automatically accounts for parallax scrolling, etc.
	 */
	public class FlxMouse
	{		
		/**
		 * Current X position of the mouse pointer in the game world.
		 */
		public var x:int;
		/**
		 * Current Y position of the mouse pointer in the game world.
		 */
		public var y:int;
		/**
		 * Current "delta" value of mouse wheel.  If the wheel was just scrolled up, it will have a positive value.  If it was just scrolled down, it will have a negative value.  If it wasn't just scroll this frame, it will be 0.
		 */
		public var wheel:int;
		/**
		 * Current X position of the mouse pointer on the screen.
		 */
		public var screenX:int;
		/**
		 * Current Y position of the mouse pointer on the screen.
		 */
		public var screenY:int;
		/**
		 * Helper variable for tracking whether the mouse was just pressed or just released.
		 */
		protected var _current:int;
		/**
		 * Helper variable for tracking whether the mouse was just pressed or just released.
		 */
		protected var _last:int;
		
		/**
		 * Constructor.
		 */
		public function FlxMouse()
		{
			x = 0;
			y = 0;
			screenX = 0;
			screenY = 0;
			_current = 0;
			_last = 0;
		}
		

		/**
		 * Called by the internal game loop to update the mouse pointer's position in the game world.
		 * Also updates the just pressed/just released flags.
		 * 
		 * @param	X			The current X position of the mouse in the window.
		 * @param	Y			The current Y position of the mouse in the window.
		 * @param	XScroll		The amount the game world has scrolled horizontally.
		 * @param	YScroll		The amount the game world has scrolled vertically.
		 */
		public function update(X:int,Y:int,XScroll:Number,YScroll:Number):void
		{
			screenX = X;
			screenY = Y;
			x = screenX-FlxU.floor(XScroll);
			y = screenY-FlxU.floor(YScroll);
			if((_last == -1) && (_current == -1))
				_current = 0;
			else if((_last == 2) && (_current == 2))
				_current = 1;
			_last = _current;
			
			if ( FlxG.zoomScale < 1 )
			{
				x /= FlxG.zoomScale;
				y /= FlxG.zoomScale;
				screenX /= FlxG.zoomScale;
				screenY /= FlxG.zoomScale;
				//screenX *= FlxG.extraZoom;
				//screenY *= FlxG.extraZoom;
			}
		}
		
		/**
		 * Resets the just pressed/just released flags and sets mouse to not pressed.
		 */
		public function reset():void
		{
			_current = 0;
			_last = 0;
		}
		
		/**
		 * Check to see if the mouse is pressed.
		 * 
		 * @return	Whether the mouse is pressed.
		 */
		public function pressed():Boolean { return _current > 0; }
		
		/**
		 * Check to see if the mouse was just pressed.
		 * 
		 * @return Whether the mouse was just pressed.
		 */
		public function justPressed():Boolean { return _current == 2; }
		
		/**
		 * Check to see if the mouse was just released.
		 * 
		 * @return	Whether the mouse was just released.
		 */
		public function justReleased():Boolean { return _current == -1; }
		
		/**
		 * Event handler so FlxGame can update the mouse.
		 * 
		 * @param	event	A <code>MouseEvent</code> object.
		 */
		public function handleMouseDown(event:MouseEvent):void
		{
			if(_current > 0) _current = 1;
			else _current = 2;
		}
		
		/**
		 * Event handler so FlxGame can update the mouse.
		 * 
		 * @param	event	A <code>MouseEvent</code> object.
		 */
		public function handleMouseUp(event:MouseEvent):void
		{
			if(_current > 0) _current = -1;
			else _current = 0;
		}
		
		/**
		 * Event handler so FlxGame can update the mouse.
		 * 
		 * @param	event	A <code>MouseEvent</code> object.
		 */
		public function handleMouseWheel(event:MouseEvent):void
		{
			wheel = event.delta;
		}
	}
}