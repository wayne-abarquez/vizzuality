package org.vizzuality.components
{
	import flash.geom.Point;
	
	import mx.controls.List;
	import mx.controls.listClasses.ListRowInfo;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	public class AutoSizingList extends List
	{
		public function AutoSizingList()
		{
			super();
			this.defaultRowCount = 0;
			this.verticalScrollPolicy = "off";
		}
		
		protected var contentHeight:int = 0;
		
		protected function getMeasuredHeight( maxHeight:int ):Number 
		{
			/*if the collection has only one row, we ignore the
			maxHeight by setting it back to its default. One row
			cannot scroll, setting a max on that for one very
			large row (that is more than maxHeight pixels long)
			will force the row to be cliped */
			var count:int = ( collection )?collection.length:0;
			if( count < 0 ) count = 0;
			if( collection && count == 1 ) maxHeight = DEFAULT_MAX_HEIGHT;
			if( contentHeight >= maxHeight ) return maxHeight;
			var hh:int = 0;
			if( !rowInfo || rowInfo.length == 0 )
			{
				if( collection )
					contentHeight = Math.min(maxHeight,count * 20);
				else 
					contentHeight = 0;
				return contentHeight;
			}
			/* keep on increasing the height until either we run out
			of rows to draw or maxHeight is reached */
			var len:int = Math.min( rowInfo.length, count );
			for( var i:int=0;i<len;i++ )
			{
				if( rowInfo[i] && ListRowInfo( rowInfo[i]).uid )
					hh += ListRowInfo( rowInfo[i] ).height;
			}
		
			/* if hh is less than maxHeight and we still have rows to
			show, increase the height */
			if( hh < maxHeight && rowInfo.length < count )
			{
				/* if we have already drawn all the rows without
				hitting the maxHeight, we are good to go */
				hh = Math.min( maxHeight,hh + ( count - rowInfo.length ) * 20 );
			}
			contentHeight = Math.min( maxHeight, hh );
			return contentHeight;
		}     
	
		protected function measureHeight():void 
		{
			var buffer:int = (this.horizontalScrollBar!=null ) ? this.horizontalScrollBar.height : 0;
			var maxContentHeight:int = maxHeight - buffer;
			var listContentHeight:int = buffer + getMeasuredHeight( maxContentHeight );
			var hh:int =  listContentHeight + 2;
			if( hh == this.height ) return;
			listContent.height = listContentHeight;    
			this.height = hh;    
			if( height >= maxHeight )
				this.verticalScrollPolicy = "auto";
			else
				this.verticalScrollPolicy = "off";        
		}
		
		/**
		 * Override of the corresponding method in mx.controls.ListGrid.
		 * After drawing the rows, it calls measureHeight to figure out
		 * if the height of the grid still needs to be adjusted.
		 */
		protected override function makeRowsAndColumns( left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean=false, rowsNeeded:uint=0.0 ):Point 
		{
			var p:Point = super.makeRowsAndColumns( left, top, right, bottom, firstCol, firstRow, byCount, rowsNeeded );
			measureHeight();
			return p;
		}    
		
		/**
		 * Override of the method from ListBase.configureScrollBars.  
		 * We copy the method but make one significant change - we comment
		 * out the code that pushes the scroll bar up if any filler rows
		 * are present.  With our variableRowHeights, this code sometimes
		 * pushes up the vertical scroll when the user is trying to scroll
		 * down.  In the worst case, it doesn't allow the user to see the
		 * last few rows.
		 */ 
		override protected function configureScrollBars():void
		{
			var rowCount:int = listItems.length;
			if( rowCount == 0 ) return;
			
			// ignore nonvisible rows off the top
			var yy:Number;
			var i:int;
			var n:int = listItems.length;
			// if there is more than one row and it is a partial row we dont count it
			while( rowCount > 1 && rowInfo[n - 1].y + rowInfo[n-1].height > listContent.height - listContent.bottomOffset )
			{
				rowCount--;
				n--;
			}
			
			/* offset, when added to rowCount, is the index of the dataProvider
			item for that row.  IOW, row 10 in listItems is showing dataProvider
			item 10 + verticalScrollPosition - lockedRowCount - 1; */
			var offset:int = verticalScrollPosition - lockedRowCount - 1;
			// don't count filler rows at the bottom either.
			var fillerRows:int = 0;
			// don't count filler rows at the bottom either.
			while( rowCount && listItems[rowCount - 1].length == 0 )
			{
				if( collection && rowCount + offset >= collection.length )
				{
					rowCount--;
					++fillerRows;
				}
				else
				{
					break;
				}
			}
		
			if( listContent.topOffset )
			{
				yy = Math.abs( listContent.topOffset );
				i = 0;
				while( rowInfo[i].y + rowInfo[i].height <= yy )
				{
					rowCount--;
					i++;
					if( i == rowCount )
						break;
				}
			}
		
			var colCount:int = listItems[0].length;
			var oldHorizontalScrollBar:Object = horizontalScrollBar;
			var oldVerticalScrollBar:Object = verticalScrollBar;
			var roundedWidth:int = Math.round(unscaledWidth);
			var length:int = collection ? collection.length - lockedRowCount: 0;
			var numRows:int = rowCount - lockedRowCount;
			
			setScrollBarProperties( ( isNaN( _maxHorizontalScrollPosition ) ) ?
			                    Math.round( listContent.width ) :
			                    Math.round( _maxHorizontalScrollPosition + roundedWidth ),
			                    roundedWidth, length, numRows );
			maxVerticalScrollPosition = Math.max( length - numRows, 0 );
		
		}   
	
		/**
		* displayWidth is a private variable in mx.controls.ListBase.  We
		* need to create it here so that we can use it
		*/
		protected var displayWidth:Number;
		/**
		 * We need to override the updateDisplayList so that we can set the
		 * displayWidth.  
		 * See the displayWidth variable in mx.controls.ListBase
		 */
		protected override function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void
		{
			if( displayWidth != unscaledWidth - viewMetrics.right - viewMetrics.left )
				displayWidth = unscaledWidth - viewMetrics.right - viewMetrics.left;
			super.updateDisplayList( unscaledWidth, unscaledHeight );                    
		}
	}
}