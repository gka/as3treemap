package net.vis4.treemap 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import mx.controls.Label;
	import net.vis4.treemap.data.Tree;
	import net.vis4.treemap.data.TreeMapItemLayoutData;
	import net.vis4.treemap.data.TreeNode;
	import net.vis4.treemap.display.Sprite3;
	import net.vis4.treemap.layout.ITreeMapLayoutStrategy;
	import net.vis4.treemap.layout.RecursiveSquarifyLayout;
	import net.vis4.treemap.layout.SliceAndDiceLayout;
	import net.vis4.treemap.layout.SquarifyLayout;
	import net.vis4.treemap.layout.StripLayout;
	import net.vis4.treemap.renderer.BranchRenderer;
	import net.vis4.treemap.renderer.ITreeMapBranchRenderer;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TreeMap extends Sprite 
	{
		static public const STRIP_LAYOUT:String = "stripLayout";
		static public const SLICE_AND_DICE_LAYOUT:String = "sliceAndDiceLayout";
		static public const SQUARIFY_LAYOUT:String = "squarifyLayout";
		
		protected var _tree:Tree;
		
		protected var _bounds:Rectangle;
		
		protected var _layout:ITreeMapLayoutStrategy;
		
		protected var _container:Sprite3;
		protected var _renderBranch:Function;
		protected var _renderNode:Function;
		
		public function TreeMap(tree:Tree, bounds:Rectangle, layout:String = 'squarifyLayout', renderNode:Function = null, renderBranch:Function = null) 
		{
			_renderNode = renderNode;
			_renderBranch = renderBranch;
			_container = new Sprite3();
			addChild(_container);
			
			_bounds = bounds;
			_tree = tree;
			_layout = getLayout(layout);
		}
		
		protected function getLayout(layout:String):ITreeMapLayoutStrategy 
		{
			switch (layout) {
				case STRIP_LAYOUT: return new StripLayout();
				case SLICE_AND_DICE_LAYOUT: return new SliceAndDiceLayout();
				case SQUARIFY_LAYOUT: 
				default: return new SquarifyLayout();
			}
		}
		
		public function render():void 
		{
			_tree.root.layout.bounds = _bounds;
			renderSubTree(_tree.root, _container);
		}
		
		private function renderSubTree(node:TreeNode, container:Sprite3, level:uint = 0):void
		{
			renderBranch(node, container, level);
			
			if (node.hasChildren) {
				// render as branch = loop over children and coll renderBranch for each
				
				var branch:BranchRenderer = new BranchRenderer();
				branch.setNodes(node.children);
				_layout.updateLayout(ITreeMapBranchRenderer(branch), node.layout.bounds);
				
				for each (var child:TreeNode in node.children) {
					var subtreeSprite:Sprite3 = new Sprite3();
					container.addChild(subtreeSprite);
					
					renderSubTree(child, subtreeSprite, level+1);
				}
				
			} else {
				// render as node
				renderNode(node, container);
			}
		}
		
		protected function renderBranch(node:TreeNode, container:Sprite3, level:uint):void 
		{
			if (_renderBranch is Function) return _renderBranch(node, container, level);
			
			if (level > 0) {
				container.fg.graphics.lineStyle(Math.pow(Math.max(4 - level, 0),1.5), 0xffffff);
				//container.fg.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
			}
			
		}
		
		// data format
		
		
		/**
		 * will render a node
		 * 
		 * @param	node
		 * @param	layoutData
		 * @param	container
		 */
		protected function renderNode(node:TreeNode, container:Sprite):void
		{
			if (_renderNode is Function) return _renderNode(node, container);
			
			var g:Graphics = container.graphics;
			g.beginFill(0x727272, 0.3);
			g.lineStyle(0);
			g.drawRect(node.layout.x, node.layout.y, node.layout.width, node.layout.height);
		}
		
	}

}