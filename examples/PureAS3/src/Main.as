package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import net.vis4.treemap.data.*;
	import net.vis4.treemap.events.TreeMapBranchEvent;
	import net.vis4.treemap.events.TreeMapEvent;
	import net.vis4.treemap.layout.RecursiveSquarifyLayout;
	import net.vis4.treemap.layout.SliceAndDiceLayout;
	import net.vis4.treemap.layout.SquarifyLayout;
	import net.vis4.treemap.layout.StripLayout;
	import net.vis4.treemap.TreeMap;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			
			// layout
			new RecursiveSquarifyLayout();
			new SliceAndDiceLayout();
			new SquarifyLayout();
			new StripLayout();
			
			// event
			new TreeMapEvent(TreeMapEvent.BRANCH_ZOOM);
			new TreeMapBranchEvent(TreeMapBranchEvent.LAYOUT_COMPLETE);
			
			// 
			var tree:Tree = new Tree(getNode(
				'vis4.net', 307, [
					getNode('labs', 242, [
						getNode('/index', 128),
						getNode('/57', 18),
						getNode('/99', 13),
						getNode('/29', 9),
						getNode('/68', 9),
						getNode('/82', 9),
						getNode('/61', 8),
						getNode('/79', 7),
						getNode('/92', 7),
						getNode('/5', 5),
						getNode('/52', 5),
						getNode('/87', 5),
						getNode('/74', 4),
						getNode('/33', 3),
						getNode('/42', 3),
						getNode('/18', 2),
						getNode('/37', 2),
						getNode('/48', 2),
						getNode('/1049', 1),
						getNode('/2022', 1),
						getNode('/2501', 1)						
					]),
					getNode('blog', 63, [
						getNode('/index', 23),
						getNode('en', 22, [
							getNode('posts', 20),
							getNode('page', 2)
						]),
						getNode('de', 10, []),
						getNode('posts', 5),
						getNode('en/', 4),
						getNode('de/', 1)
					]),
					getNode('/index', 2)
				]
			));
			
			var bounds:Rectangle = new Rectangle(30, 30, 800, 500);
			
			dumpTree(tree.root);
			
			var treemap:TreeMap = new TreeMap(tree, bounds);
			
			addChild(treemap);
			treemap.render();
			
		}
		
		private function dumpTree(node:TreeNode, level:String = '') {
			if (level.length > 10) return;
			trace(level + node.data.label + ' (' + node.weight + ')');
			for each (var c:TreeNode in node.children) {
				dumpTree(c, level + '  ');
			}
		}
		
		private function getNode(title:String, visits:Number, children:Array = null):TreeNode
		{
			if (children == null) children = [];
			var node:TreeNode = new TreeNode( { label: title }, visits);
			for each (var child:TreeNode in children) node.addChild(child);
			return node;
		}
		
	}
	
}