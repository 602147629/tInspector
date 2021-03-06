package cn.itamt.utils.inspector.core.liveinspect {
	import cn.itamt.utils.inspector.lang.InspectorLanguageManager;
	import cn.itamt.utils.inspector.ui.InspectorButton;

	import flash.display.DisplayObject;
	import flash.display.Shape;

	/**
	 * @author tamt
	 */
	public class InspectorViewCloseButton extends InspectorButton {
		public function InspectorViewCloseButton() : void {
			super();

			_tip = InspectorLanguageManager.getStr('Close');
		}

		override protected function buildOverState() : DisplayObject {
			var sp : Shape = new Shape();
			with(sp) {
				// 背景
				graphics.beginFill(0, 1);
				graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
				graphics.endFill();

				graphics.lineStyle(3, 0xff0000);
				graphics.moveTo(8.7, 8.7);
				graphics.lineTo(14.2, 14.2);
				graphics.moveTo(8.7, 14.2);
				graphics.lineTo(14.2, 8.7);
			}
			return sp;
		}

		override protected function buildDownState() : DisplayObject {
			var sp : Shape = new Shape();
			with(sp) {
				// 背景
				graphics.beginFill(0, 1);
				graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
				graphics.endFill();

				graphics.lineStyle(3, 0xffffff);
				graphics.moveTo(8.7, 8.7);
				graphics.lineTo(14.2, 14.2);
				graphics.moveTo(8.7, 14.2);
				graphics.lineTo(14.2, 8.7);
			}
			return sp;
		}

		override protected function buildUpState() : DisplayObject {
			var sp : Shape = new Shape();
			with(sp) {
				// 背景
				graphics.beginFill(0, 0);
				graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
				graphics.endFill();

				graphics.lineStyle(3, 0xff0000);
				graphics.moveTo(8.7, 8.7);
				graphics.lineTo(14.2, 14.2);
				graphics.moveTo(8.7, 14.2);
				graphics.lineTo(14.2, 8.7);
			}
			return sp;
		}

		override protected function buildUnenabledState() : DisplayObject {
			var sp : Shape = new Shape();
			with(sp) {
				// 背景
				graphics.beginFill(0, 0);
				graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
				graphics.endFill();

				graphics.lineStyle(3, 0x000000);
				graphics.moveTo(8.7, 8.7);
				graphics.lineTo(14.2, 14.2);
				graphics.moveTo(8.7, 14.2);
				graphics.lineTo(14.2, 8.7);
			}
			return sp;
		}
	}
}
