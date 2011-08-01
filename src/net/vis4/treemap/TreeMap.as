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
		protected var _tree:Tree;
		
		protected var _bounds:Rectangle;
		
		protected var _layout:ITreeMapLayoutStrategy;
		
		protected var _container:Sprite3;
		
		public function TreeMap(tree:Tree, bounds:Rectangle) 
		{
			_container = new Sprite3();
			addChild(_container);
			
			_bounds = bounds;
			_tree = tree;
			_layout = ITreeMapLayoutStrategy(new StripLayout());
		}
		
		public function render():void 
		{
			renderSubTree(_tree.root, _bounds, _container);
		}
		
		protected function renderSubTree(node:TreeNode, bounds:Rectangle, container:Sprite3, level:uint = 0):void
		{
			renderBranch(node, bounds, container, level);
			
			if (node.hasChildren) {
				// render as branch = loop over children and coll renderBranch for each
				
				var branch:BranchRenderer = new BranchRenderer();
				branch.setNodes(node.children);
				_layout.updateLayout(ITreeMapBranchRenderer(branch), bounds);
				
				for each (var child:TreeNode in node.children) {
					var subtreeSprite:Sprite3 = new Sprite3();
					container.addChild(subtreeSprite);
					
					renderSubTree(child, child.layout.bounds, subtreeSprite, level+1);
				}
				
			} else {
				// render as node
				renderNode(node, node.layout, container);
			}
		}
		
		protected function renderBranch(node:TreeNode, bounds:Rectangle, container:Sprite3, level:uint):void 
		{
			if (level > 0) {
				container.fg.graphics.lineStyle(Math.pow(Math.max(4 - level, 0),1.5), 0xffffff);
				container.fg.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
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
		protected function renderNode(node:TreeNode, layoutData:TreeMapItemLayoutData, container:Sprite):void
		{
			var g:Graphics = container.graphics;
			g.beginFill(0x6CA7D2, 0.3);
			g.drawRect(layoutData.x, layoutData.y, layoutData.width, layoutData.height);
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat('Helvetica Neue,Arial,sans-serif', 11, 0x999999);
			tf.text = node.data.label;
			tf.x = layoutData.x +2;
			tf.y = layoutData.y +2;

			container.addChild(tf);
		}
		
	}

}