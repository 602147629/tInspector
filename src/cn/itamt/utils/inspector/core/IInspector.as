package cn.itamt.utils.inspector.core {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

	/**
	 * @author itamt@qq.com
	 */
	public interface IInspector {
		/**
		 * 该Inspector是否处于启用状态
		 */
		function get isOn() : Boolean;

		function get root() : DisplayObjectContainer;

		function get stage() : Stage;

		function turnOn(...paras) : void;

		function turnOff() : void;

		/**
		 * 当前正在查看的对象
		 */
		function getCurInspectTarget() : InspectTarget;

		/**
		 * 是否处于“鼠标查看”模式
		 */
		function get isLiveInspecting() : Boolean;

		/**
		 * 关闭/开启
		 */
		function toggleTurn() : void;

		function startLiveInspect() : void;

		function stopLiveInspect() : void;

		function inspect(ele : DisplayObject) : void;

		function liveInspect(ele : DisplayObject, checkIsInspectorView : Boolean = true) : void;

		function updateInsectorView() : void;

		function isInspectView(target : DisplayObject) : Boolean;

		function get pluginManager() : IInspectorPluginManager;
	}
}