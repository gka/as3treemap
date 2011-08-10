package net.vis4.treemap.data 
{
	/**
	 * ...
	 * @author gka
	 */
	public class Tree 
	{
		
		protected var _root:TreeNode;
		
		protected var _depth:uint;
		
		public function Tree(root:TreeNode, depth:uint = 0) 
		{
			_root = root;
			if (depth == 0) {
				parseTree(_root, 1);
			}
		}
		
		protected function parseTree(node:TreeNode, level:uint):void
		{
			_depth = Math.max(_depth, level);
			for each (var child:TreeNode in node.children) {
				parseTree(child, level + 1);
			}
		}
		
		public function get root():TreeNode 
		{
			return _root;
		}
		
		public function get depth():uint 
		{
			return _depth;
		}
		
	}

}