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
	
However, in most cases you want to customize the appearance of the TreeMap. This can be done by either extending the TreeMap or by dropping in replacements for the rendering functions. 


	
FAQ
---

### Why do you forked the TreeMap Componente for Flex

Many flash developers don't like and will never the Flex framework. Therefor it makes perfect sense to remove all Flex crap out of wonderful visualization libraries.


### Is it ready for production use?

No, as3treemap is still in a very early stage. However, you can have a look into the first example project GettingStarted to see a running demo.


### Will as3treemap support fancy animated navigation inside treemaps?

Sometimes, maybe, but that's not what I want to do at this point.
