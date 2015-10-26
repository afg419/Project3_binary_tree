# Project3_binary_tree

These files envision a binary tree as being made up of a root value, and up to two other binary trees (left and right).
A binary tree will never contain empty trees (trees with root == nil) except on initialization.
All methods are performed purely recursively, except those methods related to deleting a node.  There, the main method,
'destructive_merge_with_new_tree' is recursive, but calling in in the right place depends on iterative movement of
a reader attribute.

The method for deletion is roughly as follows: iteratively identify the location of the value in the tree.  Recursively
remove all of the sub-trees beneath that value and move them into a holding tree (new_tree).  Delete the value.  Then in
a similar way, delete all the entries in the holding tree and add them back into the original tree using the 'add_node'
method.


lib- 
  recursive_binary_tree : contains the binary tree class
  file_read_write : contains the class for reading input and writing output
  binary_tree_executable : run to read tree_entries.txt and write to tree_entries_sorted.txt
  
test-
  tests for binary tree class
