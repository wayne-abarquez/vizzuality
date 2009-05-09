package com.vizzuality.view.map.mediabrowser
{
	import mx.collections.CursorBookmark;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.HorizontalList;
	import mx.effects.AnimateProperty;
	import mx.effects.Parallel;

	public class SmoothHorizontalList extends HorizontalList
	{
		public function SmoothHorizontalList()
		{
			super();
		}
		override public function scrollToIndex(index:int):Boolean{
			//super.scrollToIndex(index);
			var newVPos:int;
			var newHPos:int;
			 
			var firstIndex:int = scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition);
			var numItemsVisible:int = ((listItems.length - offscreenExtraRowsTop - offscreenExtraRowsBottom) *
			(listItems[0].length - offscreenExtraColumnsLeft - offscreenExtraColumnsRight));
			if (index >= firstIndex + numItemsVisible || index < firstIndex)
			{
			newVPos = Math.min(indexToRow(index), maxVerticalScrollPosition);
			newHPos = Math.min(indexToColumn(index), maxHorizontalScrollPosition);
			 
			try
			{
			iterator.seek(CursorBookmark.FIRST, scrollPositionToIndex(horizontalScrollPosition, verticalScrollPosition));
			//super.horizontalScrollPosition = newHPos;
			//super.verticalScrollPosition = newVPos;
			 
			var p:Parallel = new Parallel(this);
			var ap:AnimateProperty = new AnimateProperty(this);
			var ap2:AnimateProperty = new AnimateProperty(this);
			ap.property = 'verticalScrollPosition';
			ap2.property = 'horizontalScrollPosition';
			 
			ap.toValue = newVPos;
			ap2.toValue = newHPos;
			 
			p.addChild(ap);
			p.addChild(ap2);
			 
			p.play();
			 
			}
			catch(e:ItemPendingError)
			{
			}
			return true;
			}
			return false;
		}
		
		
		
	}
}