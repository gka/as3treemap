as3treemap
==========

net.vis4.treemap is a fork of Josh Tynjala's TreeMap Component for Adobe Flex (com.flextoolbok). 

Usage
-----

Here is how you basically use the treemap.
	
### Creating the tree data structure ###

This example shows how we create the tree structure that is used by the treemap. We will take the populare Flare tree as example.

	// step 1: load content of flare.json into data String
	var rawTreeData:Object = JSON.decode(data);
	
	// step 2: recursively create tree structure
	var treeRoot = parseFlareTree(rawTreeData);
	
	function parseFlareTree(data:Object):TreeNode 
	{
		var node:TreeNode = new TreeNode(data, data.children ? 0 : data.size);
		for each (var childData:Object in data.children) {
			var child:TreeNode = parseFlareTree(childData);
			node.weight += child.weight;
			node.addChild(child);
		}
		return node;
	}
	
###	Rendering the TreeMap ###

	var tree:Tree = new Tree(treeRoot);
	var bounds:Rectangle = new Rectangle(0,0,600,400);
	var treemap:TreeMap = new TreeMap(tree, bounds);
	addChild(treemap);
	treemap.render();
	
The output will look like this:

![plain treemap](http://vis4.net/labs/as3treemap/treemap1.png)
	
However, in most cases you want to customize the appearance of the TreeMap. This can be done by either extending the TreeMap or by hooking in replacements for the rendering functions. 

### Customizing the TreeMap rendering ###

Most of the hard rendering work is done inside two functions: *renderNode* and *renderBranch*. 

**renderNodes** will render the leafs of the TreeMap (the nodes that don't contain any further children). It is the perfect place to draw a rectangle :). The function takes three arguments: 

 * *node* - the TreeNode instance which contains the data and layout information of the node
 * *container* - the sprite the node should be rendered on
 * *level* - the node's depth level in the tree

The default implementation of *renderNode* looks like this:

	function renderNode(node:TreeNode, container:Sprite, level:uint):void
	{
		var g:Graphics = container.graphics;
		g.beginFill(0x727272, 0.3);
		g.lineStyle(0);
		g.drawRect(node.layout.x, node.layout.y, node.layout.width, node.layout.height);
	}

**renderBranch** is a bit more tricky. A branch is a node that contains child nodes (which are itself either rendered by *renderNode* or *renderBranch*). It takes almost the same arguments as *renderNode*, except for the container type which needs a little more explanation. Each node is rendered onto a sprite. The sprites of the children are added to the branch sprite. Drawing something onto the branch sprite graphics would be useless since the child sprites will be drawn on top. To get rid of this messyness I introduced an extension of the Sprite class which adds a foreground and a background layer. In absence of a better idea I named it *Sprite3*.  

Here's a first example that draws additional borders on top of the child nodes. The line width is inverse proportional to the level, so the lower the level the thicker the line. You find the complete source of this demo in BranchBorderThickness example (inside examples/GettingStarted/src)

	function renderBranch(node:TreeNode, container:Sprite3, level:uint):void 
	{			
		if (level > 0) {
			container.fg.graphics.lineStyle(5/level, 0x000000);
			container.fg.graphics.drawRect(
				node.layout.x, node.layout.y, 
				node.layout.width, node.layout.height
			);
		}
	}
	
The resulting treemap now looks like this:

![treemap 2](http://vis4.net/labs/as3treemap/treemap2a.png)

	
FAQ
---

### Why have you forked the TreeMap Components for Flex

Many flash developers don't like and will never the Flex framework. Therefor it makes perfect sense to remove all Flex crap out of wonderful visualization libraries.

### Why are you working on Flash libraries at all? Flash is dead, isn't it?

Sometimes what you need is compatibility to iPad, sometimes you need compatibility to IE7, sometimes you just want to create a quick sketch. In many of those cases, Flash is still a perfect choice from a developers perspective. Remember that Flash is fast, Flash is multi-platform, and there are many excellent Flash libraries.


### Is it ready for production use?

No, as3treemap is still in a very early stage. However, you can have a look into the first example project GettingStarted to see a running demo.


### Will as3treemap support fancy animated navigation inside treemaps?

Sometimes, maybe, but that's not what I want to do at this point.
