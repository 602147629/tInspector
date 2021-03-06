package cn.itamt.utils.inspector.plugins.swfinfo {
	import cn.itamt.utils.inspector.core.BaseInspectorPlugin;
	import cn.itamt.utils.inspector.core.IInspector;
	import cn.itamt.utils.inspector.core.propertyview.DisplayObjectPropertyPanel;
	import cn.itamt.utils.inspector.core.propertyview.PropertyPanel;
	import cn.itamt.utils.inspector.core.propertyview.accessors.ObjectPropertyEditor;
	import cn.itamt.utils.inspector.core.propertyview.accessors.PropertyAccessorRender;
	import cn.itamt.utils.inspector.events.PropertyEvent;
	import cn.itamt.utils.inspector.lang.InspectorLanguageManager;
	import cn.itamt.utils.inspector.plugins.InspectorPluginId;
	import cn.itamt.utils.inspector.ui.InspectorStageReference;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author itamt[at]qq.com
	 */
	public class SwfInfoView extends BaseInspectorPlugin {
		private var panels : Array;
		private var _showed:Boolean;
		protected var panel : SwfInfoViewPanel;
		protected var swf : SWFInfo;

		public function SwfInfoView() {
			super();
		}

		override public function getPluginId() : String {
			return InspectorPluginId.SWFINFO_VIEW;
		}

		override public function onRegister(inspector : IInspector) : void {
			super.onRegister(inspector);
			
			_icon = new SwfInfoButton();
		}

		override public function contains(child : DisplayObject) : Boolean {
			if(panels) {
				var l : int = panels.length;
				for(var i : int = 0;i < l;i++) {
					if(panels[i] == child || panels[i].contains(child)) {
						return true;
					}
				}
			}
			
			return false;
		}

		override public function onActive() : void {
			super.onActive();
			
			if(swf == null) {
				swf = new SWFInfo(this._inspector.root);
			}
			
			if(this.panels == null)this.panels = [];
			
			this.panel = new SwfInfoViewPanel(InspectorLanguageManager.getStr(InspectorPluginId.SWFINFO_VIEW));
			this.panel.addEventListener(Event.CLOSE, onClickClose, false, 0, true);
			this.panel.addEventListener(PropertyEvent.UPDATE, onPropertyUpdate);
			this.panel.addEventListener("ClickShowMouse", onClickShowMouse);
			this._inspector.stage.addChild(this.panel);
			this.panel.onInspect(swf);
			this.panels.push(this.panel);
			
			InspectorStageReference.centerOnStage(this.panel);
			
			this._inspector.stage.addEventListener(PropertyEvent.INSPECT, onInspectProperty);
		}
		
		/**
		 * 单击显示鼠标
		 * @param	e
		 */
		private function onClickShowMouse(e:Event):void 
		{
			if (_showed) return;
			_showed = true;
			_inspector.stage.addEventListener(Event.ENTER_FRAME, keepMouseShow, false, int.MIN_VALUE);
			_inspector.stage.addEventListener(MouseEvent.MOUSE_MOVE, keepMouseShow, false, int.MIN_VALUE);
			_inspector.stage.addEventListener(Event.RENDER, showMouse);
			
		}
		
		/**
		 * 保持鼠标显示
		 * @param	e
		 */
		private function keepMouseShow(e:Event):void 
		{
			Mouse.show();
			_inspector.stage.invalidate();
		}
		
		/**
		 * 显示鼠标
		 * @param	e
		 */
		private function showMouse(e:Event):void 
		{
			Mouse.show();
		}

		private function onInspectProperty(evt : PropertyEvent) : void {
			if(evt.target is ObjectPropertyEditor) {
				var accessor : PropertyAccessorRender = (evt.target as ObjectPropertyEditor).parent as PropertyAccessorRender;
				var target : * = (evt.target as ObjectPropertyEditor).getValue();
				for each(var panel:PropertyPanel in this.panels) {
					if(!(panel is DisplayObjectPropertyPanel)) {
						if(panel.getSingleMode()) {
							panel.onInspect((evt.target as ObjectPropertyEditor).getValue());
							return;
							break;
						}
					}
				}
				panel = new PropertyPanel(240, 170, accessor);
				this.panels.push(panel);
				panel.addEventListener(Event.CLOSE, onClickClose, false, 0, true);
				this._inspector.stage.addChild(panel);
				panel.onInspect(target);
				
				InspectorStageReference.centerOnStage(panel);
			}
		}

		private function onPropertyUpdate(event : PropertyEvent) : void {
			//
			this.panel.onInspect(swf);
		}

		override public function onUnActive() : void {
			if(panels) {
				for each(var panel:PropertyPanel in panels) {
					if(panel.stage)panel.parent.removeChild(panel);
				}
			}
			
			this.panels = null;
			
			if(this.panel.stage)this.panel.parent.removeChild(this.panel);
			this._inspector.stage.removeEventListener(PropertyEvent.INSPECT, onInspectProperty);
			this.panel = null;
			
			super.onUnActive();
		}

		/**
		 * 当Inspector关闭时
		 */
		override public function onTurnOff() : void {
			_inspector.stage.removeEventListener(Event.ENTER_FRAME, keepMouseShow);
			_inspector.stage.removeEventListener(Event.RENDER, showMouse);
			_inspector.stage.removeEventListener(MouseEvent.MOUSE_MOVE, keepMouseShow);
			_showed = false;
			
			super.onTurnOff();
		}

		/**
		 * 玩家单击关闭按钮时
		 */
		private function onClickClose(evt : Event) : void {
			var panel : PropertyPanel = evt.target as PropertyPanel;
			var t : int = this.panels.indexOf(panel);
			if(t > -1) {
				this.panels.splice(t, 1);
				this._inspector.stage.removeChild(panel);
			}
			
			if(this.panels.length == 0) {
				this._inspector.pluginManager.unactivePlugin(InspectorPluginId.SWFINFO_VIEW);
			}
		}
	}
}
