﻿package cn.itamt.utils.inspector.core.liveinspect {
	import cn.itamt.utils.inspector.ui.InspectorButton;

	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * 调整形状和大小的点按钮.
	 * @author itamt@qq.com
	 */
	public class LiveTransformPointBtn extends InspectorButton {
		private var downHandler : Function;
		private var upHandler : Function;
		private var dragHandler : Function;

		public var lastMousePt : Point;

		public function LiveTransformPointBtn(_onMouseDown:Function = null, _onMouseUp : Function = null, onDrag : Function = null) {
			super();

			downHandler = _onMouseDown;
			upHandler = _onMouseUp;
			dragHandler = onDrag;

			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}

		private var inited : Boolean;

		private function onAdded(evt : Event) : void {
			if(inited)
				return;

			inited = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		}

		private function onRemoved(evt : Event) : void {
			inited = false;
			this.removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		}

		private function _onMouseDown(evt:MouseEvent):void 
		{
			lastMousePt = new Point(evt.stageX, evt.stageY);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);

			if(this.downHandler != null)
				this.downHandler.call(null, this);
		}

		private function _onMouseUp(evt:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);

			if(this.downHandler != null)
				this.upHandler.call(null, this);
		}

		private function _onMouseMove(evt : MouseEvent) : void {
			if(this.dragHandler != null)
				this.dragHandler.call(null, this);

			lastMousePt.x = evt.stageX;
			lastMousePt.y = evt.stageY;
		}

		override protected function buildDownState() : DisplayObject {
			var sp : Shape = new Shape();
			var g : Graphics = sp.graphics;
			g.lineStyle(1, 0xffffff);
			g.beginFill(0xff0000, 1);
			g.drawRect(-4, -4, 8, 8);
			g.endFill();
			return sp;
		}

		override protected function buildUpState() : DisplayObject {
			var sp : Shape = new Shape();
			var g : Graphics = sp.graphics;
			g.lineStyle(1, 0xffffff);
			g.beginFill(0, 1);
			g.drawRect(-4, -4, 8, 8);
			g.endFill();
			return sp;
		}

		override protected function buildOverState() : DisplayObject {
			var sp : Shape = new Shape();
			var g : Graphics = sp.graphics;
			g.lineStyle(1, 0);
			g.beginFill(0x99cc00, 1);
			g.drawRect(-4, -4, 8, 8);
			g.endFill();
			return sp;
		}

		override protected function buildHitState() : DisplayObject {
			var sp : Shape = new Shape();
			var g : Graphics = sp.graphics;
			g.lineStyle(1, 0xffffff);
			g.beginFill(0, 1);
			g.drawRect(-4, -4, 8, 8);
			g.endFill();
			return sp;
		}

		override protected function buildUnenabledState() : DisplayObject {
			var sp : Shape = new Shape();
			var g : Graphics = sp.graphics;
			g.lineStyle(1, 0xffffff);
			g.beginFill(0, 1);
			g.drawRect(-4, -4, 8, 8);
			g.endFill();
			return sp;
		}
	}
}
