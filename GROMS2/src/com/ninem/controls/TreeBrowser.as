package com.ninem.controls{
	
	import com.ninem.controls.treebrowserclasses.TreeBrowserList;
	import com.ninem.events.TreeBrowserEvent;
	import com.vizzuality.view.overlaycomponents.SpeciesBrowser;
	import com.vizzuality.view.treebrowser.ItemListLastRenderer;
	import com.vizzuality.view.treebrowser.ItemListRenderer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.xml.XMLNode;
	
	import gs.TweenLite;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.containers.HBox;
	import mx.controls.List;
	import mx.controls.Tree;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.core.ClassFactory;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.effects.AnimateProperty;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.ResizeEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	//--------------------------------------
	//  Events
	//--------------------------------------
	
	
	[Event(name="nodeSelected", type="com.ninem.events.TreeBrowserEvent")]
	
	
	[Event(name="doubleClick", type="flash.events.MouseEvent")]
	//--------------------------------------
	//  Styles
	//--------------------------------------
	
	[Style(name="columnStyleName", type="String", inherit="no")]
	

	[Style(name="scrollTweenRate", type="Number", inherit="no")]


	[Style(name="defaultLeafIcon", type="Class", format="EmbeddedFile", inherit="no")]


	[Style(name="folderOpenIcon", type="Class", format="EmbeddedFile", inherit="no")]


	[Style(name="folderClosedIcon", type="Class", format="EmbeddedFile", inherit="no")]


	public class TreeBrowser extends HBox
	{	
		private var _columnWidth:int = 150;
	    private var columnWidthChanged:Boolean = false;
		private var _showDetails:Boolean = false;
		private var _rootModel:ICollectionView;
		private var _hasRoot:Boolean = false;
		private var _showRoot:Boolean = true;
		private var dataProviderChanged:Boolean;
		private var showRootChanged:Boolean = false;
		private var _selectedItem:Object;
	    private var _iconField:String = "icon";
	    private var iconFieldChanged:Boolean = false;
	    private var _iconFunction:Function;
	    private var iconFunctionChanged:Boolean = false;
	    private var _labelField:String = "label";
	    private var labelFieldChanged:Boolean = false;
	    private var _labelFunction:Function;
	    private var labelFunctionChanged:Boolean = false;
		private var storedValue:Number;
		private var tween:AnimateProperty;
	    private var _dataDescriptor:ITreeDataDescriptor = new DefaultDataDescriptor();
		// this is included only so that we have access to default tree styles
		private var tree:Tree;
		private var index: int;
		private var column: TreeBrowserList;
		private var lengthLabel: int;
		
		private var dataChild: ArrayCollection;
		private var i: int;
		private var dataLength: int;
		public var auxArrayCollec : ArrayCollection;
		
		public var remoteService:RemoteObject;
		[Bindable] public var comboDefault: int = 0;
		
		[Bindable] private var treeInitialized:Boolean=false;
		private var numRequest:Number=0;
		
		private var lastSelected:Array = new Array();


		public function TreeBrowser()
		{	
			super();
			setStyle("horizontalGap", 1);
			addEventListener(ResizeEvent.RESIZE, onResize);
		}
		
	   [Inspectable(category="Data")]
	
	
	    public function set dataDescriptor(value:ITreeDataDescriptor):void
	    {
	        _dataDescriptor = value;
	    }
	
	    /**
	     *  Returns the current ITreeDataDescriptor.
	     *
	     *   @default DefaultDataDescriptor
	     */
	    public function get dataDescriptor():ITreeDataDescriptor
	    {
	        return ITreeDataDescriptor(_dataDescriptor);
	    }


	    public function get showRoot():Boolean
	    {
	        return _showRoot;
	    }
	

	    public function set showRoot(value:Boolean):void
	    {
	        if (_showRoot != value)
	        {
	            _showRoot = value;
	            showRootChanged = true;
	            invalidateProperties();
	        }
	    }

	

	    public function get labelField():String
	    {
	        return _labelField;
	    }
	

	    public function set labelField(value:String):void
	    {
	        _labelField = value;
	        labelFieldChanged = true;
	        invalidateProperties();
	    }
	

	    public function get labelFunction():Function
	    {
	        return _labelFunction;
	    }
	

	    public function set labelFunction(value:Function):void
	    {
	        _labelFunction = value;
	        labelFunctionChanged = true;
	        invalidateProperties();
	    }
	    

	    public function get columnWidth():int{
	    	return _columnWidth;
	    }
	    

	    public function set columnWidth(value:int):void{
	    	_columnWidth = value;
	    	columnWidthChanged = true;
	    	invalidateDisplayList();
	    }


	    public function get dataProvider():Object
	    {
	        if (_rootModel)
	            return _rootModel;
	
	        return null;
	    }
	    
	   public function set dataProvider(value:Object):void
	    {
	        // handle strings and xml
	        if (typeof(value)=="string")
	            value = new XML(value);
	        else if (value is XMLNode)
	            value = new XML(XMLNode(value).toString());
	        else if (value is XMLList)
	            value = new XMLListCollection(value as XMLList);
	        
	        if (value is XML)
	        {
	            _hasRoot = true;
	            var xl:XMLList = new XMLList();
	            xl += value;
	            _rootModel = new XMLListCollection(xl);
	        }
	        //if already a collection dont make new one
	        else if (value is ICollectionView)
	        {
	            _rootModel = ICollectionView(value);
	            if (_rootModel.length == 1)
	            	_hasRoot = true;
	        }
	        else if (value is Array)
	        {
	            _rootModel = new ArrayCollection(value as Array);
	        }
	        	        
	        //all other types get wrapped in an ArrayCollection
	        else if (value is Object)
	        {
	            _hasRoot = true;
	            // convert to an array containing this one item
	            var tmp:Array = [];
	            tmp.push(value);
	            _rootModel = new ArrayCollection(tmp);
	        }
	        else
	        {
	            _rootModel = new ArrayCollection();
	        }
	        //flag for processing in commitProps
	        dataProviderChanged = true;
	        invalidateProperties();
	        invalidateDisplayList();
	        
	        //simulat a click to preopen the tree
	        if(!treeInitialized) {
	        	
	        	TweenLite.delayedCall(0.5,function():void {
	        	
	        		var colum:TreeBrowserList = getChildAt(0) as TreeBrowserList;
	        		colum.selectedIndex=0;
	        		index=1;
 		        	colum.dispatchEvent(
	        		new ListEvent(ListEvent.ITEM_CLICK,true,true,0,0,null,ItemListRenderer as IListItemRenderer));	        		

	        	});
	        	TweenLite.delayedCall(1,function():void {
	        	
	        		var colum:TreeBrowserList = getChildAt(1) as TreeBrowserList;
	        		colum.selectedIndex=0;
	        		index=2;
 		        	TreeBrowserList(colum).dispatchEvent(
	        		new ListEvent(ListEvent.ITEM_CLICK,false,false,0,0,null,ItemListRenderer as IListItemRenderer));	        		
		        	treeInitialized = true;
	        	});
	        	
	        }
	        
	        
	    }
	
	    /**
	     *  A reference to the selected item in the data provider.
	     * 
	     *  @default null
	     */
	    public function get selectedItem():Object{
	    	return _selectedItem;
	    }
	    
	    /**
	     *  @private
	     * 
	     *  adds or removes columns to match the current width of the component
	     */
		private function updateColumns(currentWidth:Number):void{
			var w:Number = currentWidth;
			var columnsChanged:Boolean = false;
			if(w > 0){
				var column:UIComponent;
				// this is in a loop so that it can support variable-width columns (not currently implemented)
				for(var i:int=0; i<numChildren; i++){
					column = getChildAt(i) as UIComponent;
					w -= column.width;
				}
				// if there is room remaining, add columns to fill
				if(w > 0){
					while (w > 0){
						addChild(createColumn());
						w -= columnWidth;
						columnsChanged = true
					}
				}else{
					// there are more columns than can fit; remove empty ones
					for(i=numChildren-1; i>=0; i--){
						column = getChildAt(i) as UIComponent;
						if(column.x > currentWidth && column is TreeBrowserList && !(TreeBrowserList(column).dataProvider && TreeBrowserList(column).dataProvider.length > 0)){
							removeChild(column);
							columnsChanged = true;
						}else{
							// break as soon as we hit a column that is visible or has data
							break;
						}
					}
				}
				checkScrollBar();
			}
		}
		
		
	    /**
	     *  @private
	     *  creates a new TreeBrowserList instance for a column
	     */
		private function createColumn():TreeBrowserList{
			var list:TreeBrowserList = new TreeBrowserList();
			list.addEventListener(ListEvent.ITEM_CLICK, updateDataProvider);
			list.styleName = "TreeColumn";
			list.percentHeight = 100;
			list.percentWidth = 100;
			list.verticalScrollPolicy = "auto";
			list.rowHeight = 47;
			list.width = list.minWidth = columnWidth - 2; 
			list.doubleClickEnabled = doubleClickEnabled;
			var listItemRenderer:ClassFactory = new ClassFactory(ItemListRenderer);
			listItemRenderer.properties = { treeBrowserParent: this, style: "firstColumnItem" };
			list.itemRenderer = listItemRenderer;
			return list;
 		}
 		
 		private function createColumnThird():TreeBrowserList{
			var list:TreeBrowserList = new TreeBrowserList();
			//list.addEventListener(ListEvent.ITEM_CLICK, updateDataProvider);
			list.styleName = "TreeColumn";
			list.percentHeight = 100;
			list.percentWidth = 100;
			list.rowHeight = 47;
			list.verticalScrollPolicy = "auto";
			list.width = 300;
			list.doubleClickEnabled = doubleClickEnabled;
			var listItemRenderer:ClassFactory = new ClassFactory(ItemListLastRenderer);
			listItemRenderer.properties = { treeBrowserParent: this, style: "thirdColumnItem" };
			list.itemRenderer = listItemRenderer;
			return list;
 		}
		
		private function updateDataProvider(ev:ListEvent):void {
			//choose the column
			column = ev.currentTarget as TreeBrowserList;
			
			//catch column number
			index = getChildIndex(column);
			//select the item in column
			_selectedItem = column.selectedItem;

 			if(lastSelected[index]){
 				if (index==1) {
					(lastSelected[1] as ItemListRenderer).setUnselected(); 					
 				} else {
 					(lastSelected[0] as ItemListRenderer).setUnselected();	
 					if (lastSelected.length>1) {
						(lastSelected[1] as ItemListRenderer).setUnselected(); 				 						
 					}
				}
			}
			if(ev.itemRenderer !=null) {
				lastSelected[index] = (ev.itemRenderer as ItemListRenderer);
				(lastSelected[index] as ItemListRenderer).setSelected();			
			} else {
				var array : Array = column.renderers;
				lastSelected[index] = (array[ev.rowIndex][0]);
				(lastSelected[index] as ItemListRenderer).setSelected();
			}

			if (_selectedItem.has_children) {
				remoteService.addEventListener(ResultEvent.RESULT,onResultTaxon);
				remoteService.addEventListener(FaultEvent.FAULT,onFaultTaxon);
				remoteService.getTaxon(_selectedItem.name,index+1);
			} else {
				onEmptyChildren();
			}
		}
		
		private function onEmptyChildren():void {
			var auxArray: ArrayCollection = new ArrayCollection();
			(_rootModel as ArrayCollection).addItemAt(auxArray,index+1);
			selectionChangeHandler();
		}
		
		private function onResultTaxon(ev: ResultEvent):void {
			//trace(index);
			remoteService.removeEventListener(ResultEvent.RESULT,onResultTaxon);			
			var aux2 : ArrayCollection = new ArrayCollection (ev.result as Array);
			(_rootModel as ArrayCollection).addItemAt(aux2,index+1);
			selectionChangeHandler();
			numRequest++;
			if(numRequest==2) {
				(this.parent.parent as SpeciesBrowser).currentState='';
				treeInitialized = true;
			}
		}
		
		private function onFaultTaxon(ev: FaultEvent):void {
			remoteService.removeEventListener(FaultEvent.FAULT,onFaultTaxon);
			//trace(ev.fault.faultDetail);
		}

		
		private function selectionChangeHandler():void{
			var children:ICollectionView;
			if (_selectedItem){
				children = _rootModel[index+1];
				if (children.length >= 0){
					// item clicked has children or we are displaying object details
					var nextColumn:UIComponent;
					if (index < numChildren - 1){
						// if item clicked is not in the last column
						nextColumn = getChildAt(index + 1) as UIComponent;
						//TreeBrowserList(nextColumn).dataProvider=null;
						if (children.length == 0){
							if(nextColumn is TreeBrowserList){
								//nextColumn = createDetailRenderer();
								//removeChildAt(index + 1);
								//addChildAt(nextColumn, index + 1);
							}
						}else{
							if (!(nextColumn is TreeBrowserList)){
								removeChildAt(index + 1);
								nextColumn = createColumn();
								addChildAt(nextColumn, index + 1);
							}
						}
						// reset the columns after the next one, if there are any
						if(index < numChildren - 2)
							clearColumns(index + 2, true);
						/* else if(index == numChildren - 2) 
							scrollToEnd(); */
					}else{
						// item clicked is in the last column, new column needs to be added
						/* if(children.length == 0) {
							nextColumn = createDetailRenderer();	
						}
						else{
							nextColumn = createColumn();
						} */
						addChild(nextColumn);
						// need to wait until display has updated to scroll
						addEventListener(FlexEvent.UPDATE_COMPLETE, onUpdateComplete);
					}
					if(nextColumn is TreeBrowserList) {
						if (index==1) {
							removeChildAt(index + 1);
							nextColumn = createColumnThird();	
							addChildAt(nextColumn, index + 1);
						} else {
							if (index==0) {
								((TreeBrowserList(nextColumn).itemRenderer) as ClassFactory).properties = { style: "secondColumnItem" };
							}
						}
/*  						dataChild = children as ArrayCollection;
						dataLength = children.length;
						auxArrayCollec = new ArrayCollection();
						i=0;
						addEventListener(Event.ENTER_FRAME, addComponent); */
						var ev: Event = new Event("loadingFinish",true);
						dispatchEvent(ev); 
						TreeBrowserList(nextColumn).dataProvider = children;
						//TreeBrowserList(nextColumn).dataProvider = auxArrayCollec;
					}
					else
						IListItemRenderer(nextColumn).data = column.selectedItem;
				}else{
					// item clicked has no children, clear all columns after this one
					if(index < numChildren - 1)
						clearColumns(index + 1, true);
				}
			}else{
				// selectedItem is null, item must have been deselected by control-clicking
				clearColumns(index + 1, true);
				if(index > 0){
					_selectedItem = TreeBrowserList(getChildAt(index - 1)).selectedItem;
					//children = _dataDescriptor.getChildren(_selectedItem, _rootModel);
				}
			}
		}
		
		private function addComponent(ev:Event):void{
			if ((i+1) == dataLength) {
				removeEventListener(Event.ENTER_FRAME,addComponent);
 				var ev: Event = new Event("loadingFinish",true);
				dispatchEvent(ev); 
			}
			auxArrayCollec.addItem(dataChild[i]);
			i++;
		}
		
		private function doubleClickHandler(event:MouseEvent):void{
			event.stopPropagation();
			dispatchEvent(event.clone());
		}
		
	    /**
	     *  @private
	     *  creates an instance of detailRenderer for displaying details pane
	     */

		
		private function onUpdateComplete(event:FlexEvent):void{
			removeEventListener(FlexEvent.UPDATE_COMPLETE, onUpdateComplete);
			//scrollToEnd();
		}
		
	    /**
	     *  @private
	     *  scrolls to show the last column
	     */
		private function scrollToEnd():void{
			var scrollTweenRate:Number = getStyle("scrollTweenRate");
			if(!tween) tween = new AnimateProperty(this);
			tween.addEventListener(EffectEvent.EFFECT_END, onScrollToEndFinished);
			tween.property = "horizontalScrollPosition";
			tween.toValue = maxHorizontalScrollPosition;
			tween.duration = scrollTweenRate * (maxHorizontalScrollPosition - horizontalScrollPosition);
			tween.play([this]);
		}
		
		private function onScrollToEndFinished(event:EffectEvent):void{
			tween.removeEventListener(EffectEvent.EFFECT_END, onScrollToEndFinished);
			checkScrollBar(); 
		}
		
		
		/**
		 *  @private
		 *  removes or clears data from all columns after startIndex
		 *  if useTween is true, it will scroll first and then remove columns
		 *  otherwise columns are cleared immediately
		 */
		private function clearColumns(startIndex:int, useTween:Boolean=false):void{
			var column:UIComponent;
			var removeCount:int = 0;
			for(var i:int=startIndex; i<numChildren; i++){
				column = getChildAt(i) as UIComponent;
				if(column is TreeBrowserList){		
					TreeBrowserList(column).dataProvider = null;
					TreeBrowserList(column).width = columnWidth;				
				}else{
					removeChildAt(i);
					column = createColumn();
					addChildAt(column, i);
				}
				removeCount++;
				if(column.x > width){
					if(!useTween) 
						removeChildAt(i);
				}
			}
		}

		
		private function onResize(event:ResizeEvent):void{
	    	updateColumns(width);
		}
		
		/**
		 *  @private
		 *  checks to see if scrollbar should be enabled or not
		 */
		private function checkScrollBar():void{
	    	var column:UIComponent = getChildAt(numChildren-1) as UIComponent;
	    	if(!(column is TreeBrowserList) || (TreeBrowserList(column).dataProvider && TreeBrowserList(column).dataProvider.length > 0))
	    		horizontalScrollPolicy = ScrollPolicy.AUTO;
	    	else
	    		horizontalScrollPolicy = ScrollPolicy.OFF;
		}
		
	    /**
	     *  @private
	     *  helper function to make a property change to all columns
	     */
	     private function updateColumnProperty(propName:String, newValue:Object):void{
	     	var column:UIComponent;
	     	for(var i:int=0; i<numChildren; i++){
	     		column = getChildAt(i) as UIComponent;
	     		if(column is TreeBrowserList) column[propName] = newValue;
	     	}
	     }
	    
	    /**
	     *  @private
	     *  helper function to make a style change to all columns
	     */
	     private function updateColumnStyle(styleProp:String, newValue:Object):void{
	     	var column:UIComponent;
	     	for(var i:int=0; i<numChildren; i++){
	     		column = getChildAt(i) as UIComponent;
	     		if(column is TreeBrowserList) column.setStyle(styleProp, newValue);
	     	}
	     }
	     
	    /**
	     *  @private
	     */
		override protected function measure():void{
			super.measure();
			measuredMinWidth = columnWidth;
		}
		
	     
	    /**
	     *  @private
	     */
	   override protected function updateDisplayList(w:Number, h:Number):void{
	    	super.updateDisplayList(w, h);
	    		
	        if (showRootChanged)
	        {
	            if (!_hasRoot)
	                showRootChanged = false;            
	        }
	        
	        if (dataProviderChanged || showRootChanged)
	        {
	            var tmpCollection:ICollectionView;
	            
                var rootItem:* = _rootModel.createCursor().current;
	            if (_rootModel && !_showRoot && _hasRoot)
	            {
	                if (rootItem != null &&
	                    _dataDescriptor.isBranch(rootItem, _rootModel) &&
	                    _dataDescriptor.hasChildren(rootItem, _rootModel))
	                {
	                    tmpCollection = _dataDescriptor.getChildren(rootItem, _rootModel);
	                }
	            }
	            
	            var firstColumn:List = getChildAt(0) as List;	            
	            firstColumn.dataProvider = tmpCollection ? tmpCollection : rootItem;
	            firstColumn.validateNow();

	            dataProviderChanged = false;
	            showRootChanged = false;
	        }
	     	if(columnWidthChanged){
	     		updateColumnProperty("width", columnWidth-2);
	     		updateColumns(w);
	     		columnWidthChanged = false;
	     	}
	    }
	    
	   /**
	     *  @private
	     */
	    override public function styleChanged(styleProp:String):void{
	    	if(styleProp==null || styleProp=="columnStyleName" || styleProp=="defaultLeafIcon" || styleProp=="folderOpenIcon" || styleProp=="folderClosedIcon"){
		    	var propName:String;
		    	if(styleProp == "columnStyleName") propName = "styleName";
		    	else propName = styleProp;
	    		updateColumnStyle(propName, getStyle(styleProp));
	    	}
	    	super.styleChanged(styleProp);
	    }
	}
}