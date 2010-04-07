package com.vizzuality.view.components
{

	
	import com.adobe.serialization.json.JSON;
	import com.vizzuality.utils.*;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.xml.XMLNode;
	
	import gs.TweenLite;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.List;
	import mx.controls.Tree;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.core.Application;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.effects.AnimateProperty;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.ResizeEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDirection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

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
	    private var _detailRenderer:IFactory = new ClassFactory(ItemDetailRenderer);
		// this is included only so that we have access to default tree styles
		private var tree:Tree;
		private var index: int;
		private var column: TreeBrowserList;
		private var columnActive: TreeBrowserList;
		private var lengthLabel: int;
		
		private var dataChild: ArrayCollection;
		private var i: int;
		private var dataLength: int;
		public var auxArrayCollec : ArrayCollection;
		public var buttonsArray : Array = new Array();
		private var dataProviderLenght: int;
		private var loadMorePosition: int;
		private var httpsrv2:HTTPService;
		private var lastID: int;
		
		/**
		 * @private
		 */
		private static function initializeStyles():void
		{
			var selector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TreeBrowser");
			
			if(!selector)
			{
				selector = new CSSStyleDeclaration();
			}
			
			selector.defaultFactory = function():void
			{
				this.scrollTweenRate = 3;
			}
			
			StyleManager.setStyleDeclaration("TreeBrowser", selector, false);
		}
		initializeStyles();

		public function TreeBrowser()
		{
			super();
			setStyle("horizontalGap", "-1");
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
	    

	    public function get showDetails():Boolean{
	    	return _showDetails;
	    }
	    

	    public function set showDetails(value:Boolean):void{
	    	_showDetails = value;
	    }
	    

	    public function get detailRenderer():IFactory{
	    	return _detailRenderer;
	    }
	    

	    public function set detailRenderer(value:IFactory):void{
	    	_detailRenderer = value;
	    }
	    

	    public function get iconField():String
	    {
	        return _iconField;
	    }
	

	    public function set iconField(value:String):void
	    {
	        _iconField = value;
	        iconFieldChanged = true;
	        invalidateProperties();
	    }
	

	    public function get iconFunction():Function
	    {
	        return _iconFunction;
	    }
	

	    public function set iconFunction(value:Function):void
	    {
	        _iconFunction = value;
			iconFunctionChanged = true;
			invalidateProperties();
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
		
	    
		private function createColumn():TreeBrowserList{
			var list:TreeBrowserList = new TreeBrowserList();
			
			
			list.setStyle("paddingBottom","0");
			list.setStyle("paddingLeft","-1");
			list.setStyle("paddingRight","-1");
			list.setStyle("paddingTop","-1");
			list.percentHeight = 100;
			list.percentWidth = 100;
			list.width = list.minWidth = columnWidth - 2; 
			list.doubleClickEnabled = doubleClickEnabled;			
			//list.addEventListener(ListEvent.ITEM_CLICK, updateDataProvider);
			list.addEventListener(ScrollEvent.SCROLL, listScrollEvent);
			list.itemRenderer = new ClassFactory(ItemListRenderer);
			list.addEventListener(ListEvent.CHANGE, updateDataProvider);
			list.addEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
			
			return list;
 		}
 		
 		private function listScrollEvent(event: ScrollEvent):void {
 			columnActive = event.currentTarget as TreeBrowserList;
			index = getChildIndex(columnActive);
 			if(event.direction == ScrollEventDirection.VERTICAL && event.delta > 0) {
				if(columnActive.maxVerticalScrollPosition - event.position < 1 ) {
					if (index != 0) {
						callNewItems();
					}
				}
			}
 		}
 		
 		private function callNewItems():void {
 			var page:int;
			if (((columnActive.dataProvider as ArrayCollection).length % 25) > 0) {
				page = Number((columnActive.dataProvider as ArrayCollection).length / 25) + 2;
			} else {
				page = ((columnActive.dataProvider as ArrayCollection).length / 25) + 1;
			}
			if (index!=1) {
				httpsrv2 = new HTTPService();
				httpsrv2.concurrency="last";
				httpsrv2.resultFormat = "text";
				httpsrv2.url = (parent as TaxonomicBrowser).ecatServices+"nav/?pagesize=25&page=" + page.toString() + "&ranks=kpcofg&image=true&id="+((columnActive.dataProvider as ArrayCollection)[0].parent).toString();			
				httpsrv2.addEventListener(ResultEvent.RESULT,checkMoreItems);
				httpsrv2.send();
			} else {
				httpsrv2 = new HTTPService();
				httpsrv2.concurrency="last";
				httpsrv2.resultFormat = "text";
				httpsrv2.url = (parent as TaxonomicBrowser).ecatServices+"nav/?rkey=1&showAll=false&rank=k&image=true&pagesize=25&sort=alpha&page=" + page.toString();
				httpsrv2.addEventListener(ResultEvent.RESULT,checkMoreItems);
				httpsrv2.send();
			}
 		}
 		
 		private function checkMoreItems(ev: ResultEvent):void {
 			var event: Event = new Event("loadingFinish",true);
			dispatchEvent(event);
 			httpsrv2.removeEventListener(ResultEvent.RESULT,checkMoreItems);
 			var resultObj:Object = JSON.decode(String(ev.result));				
			var resultAc:ArrayCollection = new ArrayCollection();
			
			for each(var co:Object in resultObj) {
					var clasOb:Object= new Object();
					clasOb.id = co.taxonID;
					clasOb.type = co.rank;
					clasOb.description ="";
					if (co.imageURL!=null) {
						clasOb.imageURL =co.imageURL;
					} else {
						clasOb.imageURL ="";	
					}
					clasOb.labelField = co.scientificName;
					clasOb.children=(co.numChildren>0);
					clasOb.number_children = co.numChildren;
					clasOb.parent = co.higherTaxonID;
					resultAc.addItem(clasOb);
			}
			dataChild = new ArrayCollection();
			dataChild = resultAc;
			if (resultAc.length != 0) {
				columnActive.removeEventListener(ScrollEvent.SCROLL, listScrollEvent);
				addEventListener(Event.ENTER_FRAME, addComponentLoadMore);
				i = 1;
				dataProviderLenght = ((columnActive.dataProvider) as ArrayCollection).length - 1;
				((columnActive.dataProvider) as ArrayCollection).addItem(dataChild[0]);
				((_rootModel as ArrayCollection)[index] as ArrayCollection).addItem(resultAc[0]);
			}
 		}
 		

		
		private function addComponentLoadMore(ev:Event):void {
			if ((i+1)==(dataChild as ArrayCollection).length) {
				removeEventListener(Event.ENTER_FRAME,addComponentLoadMore);
				columnActive.addEventListener(ScrollEvent.SCROLL,listScrollEvent);			
			}
			((columnActive.dataProvider) as ArrayCollection).addItem(dataChild[i]);
			((_rootModel as ArrayCollection)[index] as ArrayCollection).addItem(dataChild[i]);	
			i++;
		}
		
		
		private function onClickTopButton(ev: MouseEvent):void {
			index = ev.target.data;
			column = getChildAt(index) as TreeBrowserList;
			for (var cont: int = 0; cont<(column.dataProvider as ArrayCollection).length; cont++) {
				if ((column.dataProvider as ArrayCollection)[cont].labelField == ev.target.label) {
					column.selectedIndex=cont;
					break;
				}
			}
            column.dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,true,true,0,0,null,ItemListRenderer as IListItemRenderer));
		}
		
		private function onKeyPress(event:KeyboardEvent):void {
			//trace(event.keyCode);
			//it has been pressed on the right
			if(event.keyCode==39) {
				try {
					var nextCol:TreeBrowserList = this.getChildAt(this.getChildIndex(column) +1) as TreeBrowserList;
					nextCol.selectedIndex=0;
					focusManager.setFocus(nextCol);
					nextCol.dispatchEvent(new ListEvent(ListEvent.CHANGE));
				} catch (error:Error) {
					focusManager.setFocus(column);					
				}
			}
			if(event.keyCode==37) {
				try {
					
					trace("prev: "+(this.getChildIndex(column) -1) + " current:"+this.getChildIndex(column));
					var prevCol:TreeBrowserList = this.getChildAt(this.getChildIndex(column) -1) as TreeBrowserList;
					prevCol.selectedIndex=prevCol.selectedIndex;
					column.selectedIndex=-1;
					focusManager.setFocus(prevCol);		
					clearColumns(getChildIndex(column)+1, true);		
					column = prevCol;
				} catch (error:Error) {
					//trace("error");
				}
			}			
		}
		
		private function updateDataProvider(ev:ListEvent):void {
						
			//choose the column
			column = ev.currentTarget as TreeBrowserList;
			//catch column number
			index = getChildIndex(column);
			_selectedItem = column.selectedItem;
			
			if (hasEventListener(Event.ENTER_FRAME)) {
				removeEventListener(Event.ENTER_FRAME,addComponentLoadMore);
				if (columnActive != null) {
					if (!columnActive.hasEventListener(ScrollEvent.SCROLL)) {
						columnActive.addEventListener(ScrollEvent.SCROLL,listScrollEvent);
					}
				}		
			}
			
			_selectedItem = column.selectedItem;
			if(index < numChildren - 2) {
				clearColumns(index + 1, true);	
			}
			else if(index == numChildren - 2) {
				scrollToEnd();
			} 

			//upper Canvas buttons
/* 			var button: Button = new Button();
			button.data = index;
			button.addEventListener(MouseEvent.CLICK, onClickTopButton);
			button.y = 0;
			button.useHandCursor = true;
			button.mouseChildren = false;
			button.buttonMode = true;
			if (index == 0) {
				buttonsArray = new Array();
				pplication.application.click_canvas.removeAllChildren();
				button.x = 10;
				button.y = 7;
				button.height = 31;
				button.label = 	_selectedItem.labelField;
				button.styleName = "btnBreadcrumb";
				button.setStyle("paddingLeft",12);
				Application.application.click_canvas.addChildAt(button,0);
				buttonsArray.push(button);
			} else {
				for (var i: int=buttonsArray.length - 1; i>index-1; i--) {
					TweenLite.to(buttonsArray[i], 1, {x:10});
					Application.application.click_canvas.removeChild(buttonsArray[i]);
					buttonsArray.pop();
				}
				var lastChild: UIComponent = Application.application.click_canvas.getChildAt(0);				
				button.x = lastChild.x + lastChild.width - 100;
				button.y = 7;
				button.height = 31;
				button.setStyle("paddingLeft",22);				
				button.alpha = 0;
				if(_selectedItem!=null)
					button.label = 	_selectedItem.labelField;
				if (_selectedItem==null) {
					button.styleName = "btnBreadcrumbLast";
				} else {
					button.styleName = "btnBreadcrumb";
				}
				TweenLite.to(button, 0.4, {x:lastChild.x + lastChild.width - 20, alpha:1});
				Application.application.click_canvas.addChildAt(button,0);
				
				buttonsArray.push(button);
			} */
			
			if(_selectedItem!=null) {
				var httpsrv:HTTPService = new HTTPService();
				httpsrv.resultFormat = "text";
				//httpsrv.url = "http://data.gbif.org/species/classificationSearch?view=json&allowUnconfirmed=false&providerId=2&query="+(_selectedItem.id).toString();
				if (index==0) {
					httpsrv.url = (parent as TaxonomicBrowser).ecatServices +'nav/?rkey=1&showAll=false&rank=k&image=true&pagesize=25&sort=alpha';
				} else {
					httpsrv.url = (parent as TaxonomicBrowser).ecatServices +"nav/?pagesize=25&ranks=kpcofg&page=1&image=true&id="+(_selectedItem.id).toString();
				}
				httpsrv.addEventListener(ResultEvent.RESULT,onResultGbif);
				httpsrv.send();
			}
		}
		

		
		private function onResultGbif(ev: ResultEvent):void {
			var resultObj:Object = JSON.decode(String(ev.result));				
			var resultAc:ArrayCollection = new ArrayCollection();
			//var getTaxon: Boolean = false;
			for each(var co:Object in resultObj) {
					var clasOb:Object= new Object();
					clasOb.id = co.taxonID;
					clasOb.type = co.rank;
					clasOb.description ="";
					if (co.imageURL!=null) {
						clasOb.imageURL =co.imageURL;
					} else {
						clasOb.imageURL ="";
						
					}
					clasOb.labelField = co.scientificName;
					clasOb.children=(co.numChildren>0);
					clasOb.number_children = co.numChildren;
					
					var numInmediateChild:Number=co.numChildren;
					var inmediateChildRank:String="groups";
					switch (co.rank) {
						case "kingdom":
							numInmediateChild=co.numP;
							inmediateChildRank="phyla";
							break;
						case "phylum":
							numInmediateChild=co.numC;
							inmediateChildRank="classes";
							break;
						case "class":
							numInmediateChild=co.numO;
							inmediateChildRank="orders";
							break;
						case "order":
							numInmediateChild=co.numF;
							inmediateChildRank="families";
							break;
						case "family":
							numInmediateChild=co.numG;
							inmediateChildRank="genera";
							break;
						case "genus":
							numInmediateChild=co.numSG;
							inmediateChildRank="subgenus";
							break;
						case "subgenus":
							numInmediateChild=co.numS;
							inmediateChildRank="species";
							break;
						case "species":
							numInmediateChild=co.numS;
							inmediateChildRank="infraspecies";
							break;
							
					}
					clasOb.numInmediateChild=numInmediateChild;
					clasOb.inmediateChildRank=inmediateChildRank;
					clasOb.children_rank = co.phylum;
					clasOb.parent = co.higherTaxonID;
					resultAc.addItem(clasOb);
			}			
			(_rootModel as ArrayCollection).addItemAt(resultAc,index+1);
			selectionChangeHandler();
		}

		
		private function selectionChangeHandler():void{
			var children:ICollectionView;
			if (_selectedItem){
				children = _rootModel[index+1];
				if (children.length >= 0 || showDetails){
					// item clicked has children or we are displaying object details
					var nextColumn:UIComponent;
					if (index < numChildren - 1){
						// if item clicked is not in the last column
						nextColumn = getChildAt(index + 1) as UIComponent;
						//TreeBrowserList(nextColumn).dataProvider=null;
						if (children.length == 0 || _selectedItem.type=="species"){
							if(nextColumn is TreeBrowserList){
								nextColumn = createDetailRenderer();
								removeChildAt(index + 1);
								addChildAt(nextColumn, index + 1);
							}
						}else{
							if (!(nextColumn is TreeBrowserList)){
								removeChildAt(index + 1);
								nextColumn = createColumn();
								addChildAt(nextColumn, index + 1);
							}
						}
						// reset the columns after the next one, if there are any
						/* if(index < numChildren - 2)
							clearColumns(index + 2, true);
						else if(index == numChildren - 2) 
							scrollToEnd(); */
					}else{
						// item clicked is in the last column, new column needs to be added
						if(children.length == 0 || _selectedItem.type=="species"){
							nextColumn = createDetailRenderer();	
						}else{
							nextColumn = createColumn();
						}
						addChild(nextColumn);
						// need to wait until display has updated to scroll
						addEventListener(FlexEvent.UPDATE_COMPLETE, onUpdateComplete);
					}
					if(nextColumn is TreeBrowserList) {
						dataChild = children as ArrayCollection;
						dataLength = children.length;
						auxArrayCollec = new ArrayCollection();
						i = 0;
						addEventListener(Event.ENTER_FRAME, addComponent);
						//BindingUtils.bindProperty(auxArrayCollec, "source", TreeBrowserList(nextColumn),"dataProvider");
						TreeBrowserList(nextColumn).dataProvider = auxArrayCollec;
						//TreeBrowserList(nextColumn).dataProvider = children;
					}
					else
						IListItemRenderer(nextColumn).data = column.selectedItem;
				}else{
					// item clicked has no children, clear all columns after this one
					/* if(index < numChildren - 1)
						clearColumns(index + 1, true); */
				}
			}else{
				// selectedItem is null, item must have been deselected by control-clicking
				/* clearColumns(index + 1, true); */
				if(index > 0){
					_selectedItem = TreeBrowserList(getChildAt(index - 1)).selectedItem;
					//children = _dataDescriptor.getChildren(_selectedItem, _rootModel);
				}
			}
			var ev: Event = new Event("loadingFinish",true);
			dispatchEvent(ev);
		}
		
		private function addComponent(ev:Event):void{
			if ((i+1) == 25 || (i+1) == dataLength) {
				removeEventListener(Event.ENTER_FRAME,addComponent);				
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
		private function createDetailRenderer():UIComponent{
			var renderer:UIComponent = detailRenderer.newInstance() as UIComponent;
			//for change width details window!!!!
			renderer.width = 250;
			renderer.percentHeight = 100;
			return renderer;
		}
		
		private function onUpdateComplete(event:FlexEvent):void{
			removeEventListener(FlexEvent.UPDATE_COMPLETE, onUpdateComplete);
			scrollToEnd();
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
			tween.duration = 400;
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
			if(useTween && removeCount > 0){
				var scrollTweenRate:Number = getStyle("scrollTweenRate");
				if(!tween) tween = new AnimateProperty(this);
				tween.addEventListener(EffectEvent.EFFECT_END, onRemoveTweenFinished);
				tween.property = "horizontalScrollPosition";
				storedValue = startIndex;
				// calculate scrollposition of column that will now be last
				var toValue:Number = Math.max((numChildren - removeCount) * (columnWidth - 2) - width, 0);
				tween.toValue = toValue;
				tween.duration = scrollTweenRate * (horizontalScrollPosition - toValue);
				tween.duration = 400;
				tween.play([this]);
			}
		}
		
		private function onRemoveTweenFinished(event:EffectEvent):void{
			tween.removeEventListener(EffectEvent.EFFECT_END, onRemoveTweenFinished);
			clearColumns(storedValue+1);
			/* if (index>numChildren-2)
				scrollToEnd(); */
			checkScrollBar(); 
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
	    		horizontalScrollPolicy = ScrollPolicy.ON;
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
	     override protected function commitProperties():void{
	     	super.commitProperties();
	     	if(iconFieldChanged){
	     		updateColumnProperty("iconField", iconField);
	     		iconFieldChanged = false;
	     	}
	     	if(iconFunctionChanged){
	     		updateColumnProperty("iconFunction", iconFunction);
	     		iconFunctionChanged = false;
	     	}
	     	if(labelFieldChanged){
	     		updateColumnProperty("labelField", labelField);
	     		labelFieldChanged = false;
	     	}
	     	if(labelFunctionChanged){
	     		updateColumnProperty("labelFunction", labelFunction);
	     		labelFunctionChanged = false;
	     	}
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