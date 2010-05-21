package org.sbistram.view {
	
import de.sbistram.controls.MatchDataGrid;
import de.sbistram.utils.HTMLUtils;
import de.sbistram.utils.LogUtils;

import mx.controls.Alert;
import mx.controls.Label;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.events.ListEvent;
import mx.logging.ILogger;
	
public class Grid extends MatchDataGrid {
		
	private var _log:ILogger = LogUtils.getLogger(this);
	
	//
	// private constants
	//
	
	private static const DF_1:String		= "ik";
	private static const DF_2:String		= "name";
	private static const DF_3:String	= "street";
	private static const DF_4:String		= "code";
	private static const DF_5:String		= "city";
	private static const DF_6:String		= "ik";
	private static const DF_7:String		= "name";
	private static const DF_8:String	= "street";
	private static const DF_9:String		= "code";
	private static const DF_10:String		= "city";
	
	private static const DF_ALL:Array = [DF_1, DF_2, DF_3, DF_4, DF_5, DF_6, DF_7, DF_8, DF_9,DF_10];
	
	/**
	 * Constructor
	 */
	public function Grid() {
		super();
		columns = createColumns();		
		labelFunction = getLabelCommon;
		decoratorFunction = decorator;
		doubleClickEnabled = true;
	}
	
	/**
	 * Create data for a combobox selection of one or all columns
	 * Add the 'All' entry for selecting all columns
	 * 
	 * @return Array of all columns headerText and dataField 
	 */	
	public function columnSelectProvider():Array {
		var provider:Array = [{ label:"All", dataField:null }];
		for (var i:int = 0; i < columns.length; i++) {
			provider.push({ label:columns[i].headerText, dataField:columns[i].dataField });
		}
		return provider;
	}
				
	/**
	 * Can also be handled by listening to the event 
	 * 
	 * @see		de.sbistram.controls.MatchDataGrid 
	 * @param	event
	 */
	override protected function linkHandler(event:ListEvent):void {
		//_log.debug("linkHandler: link={0}, event={1}", event.reason, event);		
		Alert.show("IK-Nr.:" + event.reason);	// just for the demo
	}

	override protected function doubleClickHandler(event:ListEvent):void {
		var item:Object = event.currentTarget.selectedItem;
		var df:String = columns[event.columnIndex].dataField;
		Alert.show("Double click: row:" + event.rowIndex + ", column:" + event.columnIndex + ", value:" + item[df]); // just for the demo
	}	
	
	/** 
	 * @see DataGridColumn#itemToLabel
	 * @return Array of DataGridColumn
	 */
	private function createColumns():Array {
		var columns:Array = [];
		var column:DataGridColumn;
		var df:String;
		
		// create all columns
		for (var i:int = 0; i < DF_ALL.length; i++) {
			column = new DataGridColumn();
			df = DF_ALL[i];
			
			// default values
			column.dataField = df;
			column.headerText = column.dataField.charAt(0).toUpperCase() + column.dataField.substr(1);
			column.itemRenderer = _matchFactory;
			column.labelFunction = getLabelCommon;
			column.width = 100;
			columns.push(column);
			
			// column specific values
			if (df == DF_IK) {
				column.headerText = "IK-Nr."
				column.width = 90;
				column.labelFunction = getLabelIk;
				// not necessary for this demo, but...
				column.sortCompareFunction = sortCompareIk;
			} else if (df == DF_NAME) {
				column.width = 180;
			} else if (df == DF_CODE) {
				column.width = 60;
			} else if (df == DF_STREET) {
				column.width = 160;
			} else if (df == DF_CITY) {
				column.width = 100;
			}
		}
		return columns;
	}
	
	/**
	 * Common label function for all columns, can be replaced by column.labelFunction
	 * 
	 * @param	item
	 * @param	column
	 * @return 	label as String
	 * 
	 * @see mx.controls.dataGridClasses.DataGridColumn#itemToLabel
	 */
	private function getLabelCommon(item:Object, column:DataGridColumn):String {
		//_log.debug("getLabelCommon: item={0}, column={1}", item, column);
		if (item[column.dataField] == null) {
			// maybe not for all
			throw new Error("Property of item can't be null, dataField = " + column.dataField);
		}
		return item[column.dataField];
	}
	
	private function getLabelIk(item:Object, column:DataGridColumn):String {
			if (item == null || item[DF_IK] == undefined || item[DF_IK] == null) return " ";
		return "<a href=\"event:" + item[DF_IK] + "\">" + item[DF_IK] + "</a>";
	}
	
	/**
	 * Remove all HTML tags before doing the compare.
	 * 
	 * @todo The HTML stuff should be done in a more general way - maybe Gumbo ?!
	 *       Method removeHTMLTags not finished, @see LangUtils#removeHTMLTags
	 */
	private function sortCompareIk(item1:Object, item2:Object):int {
		var s1:String = HTMLUtils.stripTags(item1[DF_IK]);
		var s2:String = HTMLUtils.stripTags(item2[DF_IK]);
		//_log.debug("compareItemsIk: item1={0}, item2={1}", s1, s2);
		if 		(s1 > s2) return 1;
		else if (s1 < s2) return -1;
		else 			  return 0;
	}
		
	/**
	 * Decorator method to do some DataGrid decorator stuff:
	 * 
	 *  	- font: color, size, bold, italic, underline.
	 * 
	 * Note: Because the renderer is reused we have to set/reset the values!
	 * 		 And don't use the column index if dragging columns is enabled! Instead 
	 *       use the column like it's done here.
	 * 
	 * @param	r renderer for the current cell
	 * @param	w width of the current cell
	 * @param	h heigth of the current cell
	 */
	private function decorator(r:Object, w:Number, h:Number):void {
		// Note: r.data is the original value object for the hole row
		var column:DataGridColumn = columns[r.listData.columnIndex];
		var df:String = column.dataField;
		r.setStyle("fontWeight", df == DF_NAME ? "bold" : "normal");
		if (df != DF_IK) {
		    //r.setStyle("textDecoration", df == DF_CODE ? "underline" : "none");
			r.setStyle("fontStyle", df == DF_CODE ? "italic" : "normal");
		    //r.setStyle("fontSize", df == DF_XX ? "8" : "10");
		    //r.setStyle("color", df == DF_XX ? "#00FF00" : "#000000");
		}
		if (df == DF_NAME 
			|| ((isItemHighlighted(r.data) == true || isItemSelected(r.data) == true) && df == DF_CODE)) {
			r.setStyle("fontWeight", "bold");
		} else {
			r.setStyle("fontWeight", "normal");
		}
	}
	
}
}