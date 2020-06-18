//
//  PPTree.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/10/28.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation
typealias TreeNode = PPTreeNode
// MARK:🍀二叉树🍀
class PPTreeNode:CustomStringConvertible {
    
    
//    var value = 0
    public var val: Int
//    var leftNode:PPTreeNode?
//    var rightNode:PPTreeNode?
    public var left: TreeNode?
    public var right: TreeNode?

    /// 兼容其他人写的代码
    open var leftNode: PPTreeNode? {
        get { return left }
        set { left = newValue }
    }
    open var rightNode: PPTreeNode? {
        get { return right }
        set { right = newValue }
    }
    open var value: Int {
        get { return val }
        set { val = newValue }
    }
    
//    init(_ value:Int) {
//        self.val = value
//    }
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
//    static func == (lhs: PPTreeNode, rhs: PPTreeNode) -> Bool {
//        return lhs.val == rhs.val
//    }
     var description : String {
//        return "\(self.leftNode?.value ?? 0)-(\(self.value))-\(self.rightNode?.value ?? 0)  <\(Unmanaged.passUnretained(self).toOpaque())>"
        return "\(self.leftNode?.value ?? 0)-(\(self.value))-\(self.rightNode?.value ?? 0)"
    }
}

//class PPSearchTreeNode: PPTreeNode {
//
//}
///普通二叉树
open class PPTree {
    var rootNode:PPTreeNode?
    init(_ rootNode:PPTreeNode?) {
        self.rootNode = rootNode
    }
    
    func pp_insertNode(_ node:PPTreeNode) {
        if (self.rootNode == nil) {
            self.rootNode = node
            return
        }
        var p = self.rootNode
        while p != nil {
            //如果要插入的数据比节点的数据大，并且节点的右子树为空，就将新数据直接插到右子节点的位置；
            //如果不为空，就再递归遍历右子树，查找插入位置。比节点的数据小的同理
            //关键点：找到大小合适且为空的位置
            if node.value > p!.value {
                if (p!.right == nil) {
                    p!.right = node
                    return
                }
                p = p!.right!
            }
            else {
                if (p!.left == nil) {
                    p!.left = node
                    return
                }
                p = p!.left!
            }
        }
        
    }
    // MARK 插入值等于num的节点
    func pp_insertNode(_ num:Int) {
        let node = PPTreeNode(num)
        return pp_insertNode(node)
    }
    func pp_insertNodes(_ nodes:[Int]) {
        for node in nodes {
            pp_insertNode(node)
        }
    }
}







// MARK:二叉搜索树🌲
open class PPSearchTree: PPTree {
    
//    init(rootNode:PPTreeNode?) {
//        self.rootNode = rootNode
//    }
    
    // MARK: 删除节点
    //PPLeetCode450 https://leetcode-cn.com/problems/delete-node-in-a-bst/
    //JAVA风格,递归解法：https://www.cnblogs.com/libaoquan/p/7142767.html
    func pp_deleteNode(_ value:Int) -> PPSearchTree {
        var p = self.rootNode // p 指向要删除的节点，初始化指向根节点
        var pp:PPTreeNode? = nil // pp 记录的是 p 的父节点
        //找到要删除的节点
        while (p != nil && p?.value != value) {
            pp = p
            if (value > p!.value) {
                p = p?.right
            }
            else {
                p = p?.left
            }
        }
        if (p == nil) {
            return self // 没有找到
        }
//        let ppppp = p
        // 要删除的节点有两个子节点（左右节点都不为空）
        if (p?.left != nil && p?.right != nil) { // 查找右子树中最小节点
            var rightNodeMin = p!.right
            var rightNodeMinParent = p // rightNodeMinParent 表示 rightNodeMin 的父节点
            while (rightNodeMin?.left != nil) {
                rightNodeMinParent = rightNodeMin
                rightNodeMin = rightNodeMin?.left
            }
            p?.value = rightNodeMin!.value // 将 rightNodeMin 的数据替换到 p 中
            // 注意：此时p还处在要`被替换`的那个节点位置，此位置的左右节点会保持不变
            p = rightNodeMin // 下面就变成了删除 rightNodeMin 了???
            // 注意：此时p处在要`被移除`的那个节点位置
            pp = rightNodeMinParent
        }
        
        // 删除节点是叶子节点或者仅有一个子节点
        var child:PPTreeNode? // p 的子节点
        if (p?.left != nil) {
            debugPrint("p.left not null")
            child = p?.left
        }
        else if (p?.right != nil) {
            debugPrint("p.right not null")
            child = p?.right
        }
        else {
            debugPrint("child is null")
            child = nil
        }
        if (pp == nil) {
            self.rootNode = child // 删除的是根节点
        }
        else if (pp?.left === p) {
            pp?.left = child
        }
        else {
            pp?.right = child
        }
        return self
    }
    // MARK:计算树的最大深度
    func maxDepth(root: PPTreeNode?) -> Int {
        guard let root = root else {
          return 0
        }
        return max(maxDepth(root: root.leftNode), maxDepth(root: root.rightNode))+1
    }
    
    // MARK:判断一颗二叉树是否为二叉查找树
    /*递归公式：
     左子树找最大值：max=isValidBST(root.left)
     右子树找最小值：min=isValidBST(root.right)
     如果max<root.value且min>root.value，那么即是二叉查找树
     */
    func isValidBST(root: PPTreeNode?) -> Bool {
      return _helper(root, nil, nil)
    }
    // 判断node.value在[min,max]范围内
    private func _helper(_ node: PPTreeNode?, _ min: Int?, _ max: Int?) -> Bool {
      guard let node = node else {
        //如果节点没有子节点，也是二叉查找树
        return true
      }
      // 所有右子节点都必须大于根节点
      if let min = min, node.value <= min {
        return false
      }
      // 所有左子节点都必须小于根节点
      if let max = max, node.value >= max {
        return false
      }
      return _helper(node.leftNode, min, node.value) && _helper(node.rightNode, node.value, max)
    }
    
    
    //MARK:PPLeetCode235 二叉搜索树的最近公共祖先（父节点）
    //题解 https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-search-tree/solution/er-cha-sou-suo-shu-de-zui-jin-gong-gong-zu-xian--2/
    //从根节点开始遍历树
    //如果节点 pp 和节点 qq 都在右子树上，那么以右孩子为根节点继续 1 的操作
    //如果节点 pp 和节点 qq 都在左子树上，那么以左孩子为根节点继续 1 的操作
    //如果条件 2 和条件 3 都不成立，这就意味着我们已经找到节 pp 和节点 qq 的 LCA 了（即root）
    func lowestCommonAncestor(root:PPTreeNode, p:PPTreeNode, q:PPTreeNode) -> PPTreeNode {
        let parentVal = root.value
        let pVal = p.value
        let qVal = q.value
        if (pVal>parentVal && qVal > parentVal) {
            if root.right != nil {
                return lowestCommonAncestor(root: root.right!, p: p, q: q)
            }
            return root
        }
        else if (pVal<parentVal && qVal < parentVal) {
            if root.left != nil {
                return lowestCommonAncestor(root: root.left!, p: p, q: q)
            }
            return root
        }
        else {
            return root
        }
    }
    
    func insert(_ num:Int) -> Void {
        let node = PPTreeNode(num)
        if (self.rootNode == nil) {
            self.rootNode = node
            return
        }
        if let parent = getPrev(num: num, find: false) {//找父节点
            if (num < parent.value) {
                parent.leftNode = node
            } else {
                parent.rightNode = node
            }
            debugPrint("insert num=\(num)")
        }
    }
    
    //获取父节点，然后插入到这个父节点左边或右边
    func getPrev(num:Int,find:Bool) -> PPTreeNode? {
//        let rootNode = self.rootNode
        var res:Array<PPTreeNode> = []
        if let newPoint = self.rootNode {
            
        var point:PPTreeNode! = newPoint
        while (true) {
            if ((point?.leftNode) != nil) {
                if (num < point.leftNode?.value ?? 0 || num < point.value) {
                    point = point.leftNode
                    continue
                }
            }

            if ((point?.rightNode) != nil) {
                if (num >= point.rightNode?.value ?? 0 || num >= point.value) {
                    //搜索时如果有多个值则缓存
                    if (find && num == point.value) {
                        res.append(point)
                    }
                    point = point.rightNode
                    continue
                }
            }
            //如果是搜索
            if (find) {
                if (point.value == num) {
                    res.append(point)
                }

                if (res.count == 0) {
                    return nil
                }

                if (res.count == 1) {
                    return res[0]
                }
                #warning("这里应该是数组res")
                return res[0]
            }
            //如果是添加 返回的是应该添加的那各节点的父节点
            return point
        }
        
        
        }
        return nil
        
    }
    
    
}




class PPTreeSolution {
    //MARK:PPLeetCode94 二叉树的中序遍历
    //https://leetcode-cn.com/problems/binary-tree-inorder-traversal/
    //图片辅助理解： https://i.loli.net/2019/11/08/EXNtZ7FOAI1mBWU.png
    //顺序：左自右，如果节点不为空，要把它添加到结果集里吗？肯定不行，得先把它加进去，迭代它的左子节点
    //迭代到当前节点为空时，也即到了左叶子节点，此时把它放入结果集
    //由图可以看出，首先要找到最左侧的叶子节点存到栈里，然后每次出栈一个节点，遍历打印该节点和右节点
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        var stack = [TreeNode]()
        var currentNode = root
        
        while !stack.isEmpty || currentNode != nil {
            debugPrint("当前node=\(String(describing: currentNode))")
            if currentNode != nil {
                stack.append(currentNode!)
                currentNode = currentNode!.left
            } else {
                let prevNode = stack.removeLast()
                res.append(prevNode.val)
                currentNode = prevNode.right
            }
        }
        
        return res
    }
    //中序遍历-颜色标记法
    //使用颜色标记节点的状态，新节点为白色，已访问的节点为灰色。
    //如果遇到的节点为白色，则将其标记为灰色，然后将其右子节点、自身、左子节点依次入栈。
    //如果遇到的节点为灰色，则将节点的值输出。
    //如要实现前序、后序遍历，只需要调整左右子节点的入栈顺序即可。
    //原帖：https://leetcode-cn.com/problems/binary-tree-inorder-traversal/solution/yan-se-biao-ji-fa-yi-chong-tong-yong-qie-jian-ming/
    func inorderTraversal_colorMark(_ root: TreeNode?) -> [Int]{
        var WHITE = 0, GRAY = 0, color = 0
        var node = root
        (WHITE, GRAY) = (0, 1)
        var res = [Int]()
        var stack = [(WHITE, root)]
        while !stack.isEmpty {
            (color, node) = stack.removeLast()
            if node == nil {
                continue
            }
            if color == WHITE {
                stack.append((WHITE, node!.right))
                stack.append((GRAY, node))
                stack.append((WHITE, node!.left))
            }
            else {
                res.append(node!.val)
            }
        }
        return res
    
    }
    func testInorderTraversal() {
        let tree = PPTree(nil)
        tree.pp_insertNodes([1,3,2])
        debugPrint(PPTreeSolution().inorderTraversal_colorMark(tree.rootNode))
    }
    
    //MARK:PPLeetCode102. 二叉树的层序遍历，每一层分组
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var res = [[Int]]()
        // 用数组来实现队列
        var queue = [TreeNode]()
        if let root = root {
            queue.append(root)
        }
        
        while queue.count > 0 {
            let size = queue.count
            var level = [Int]()
            
            for _ in 0 ..< size {
                let node = queue.removeFirst()
                level.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            //debugPrint("add level array:\(level)")
            res.append(level)
        }
        return res
        
    }

    //MARK:树的层级遍历，每一层不分组
    //思路：在队列里从左到右依次放入需要迭代的父节点、子左节点、子右节点
    //每次迭代先取出最左边的节点，如果左子节点存在，就放入结果集；如果右子节点存在，也放入结果集
    func pp_levelTraverse(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        var queue = [TreeNode]()
        var node = root
        queue.append(node!)
        while !queue.isEmpty {
            node = queue.removeFirst()
            // debugPrint("当前node=\(String(describing: node))")
            res.append(node?.val ?? -1 )
            if node?.left != nil {
                queue.append(node!.left! )
                // debugPrint("入列=\(node?.left?.val ?? 0)")
            }
            if node?.rightNode != nil {
                queue.append(node!.right! )
                // debugPrint("入列=\(node?.right?.val ?? 0)")
            }
            // debugPrint("Queue=\(queue)")
        }
        return res
        
    }
    //MARK:PPLeetCode144 树的前序遍历
    //https://leetcode-cn.com/problems/binary-tree-preorder-traversal/
    //用栈保存需要迭代的节点，res保存结果集
    //先打印这个节点，然后再打印它的左子树直到左边的叶子节点（left==nil），最后打印它的右子树
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        var stack = [TreeNode]()
        var node = root
        
        while !stack.isEmpty || node != nil {
            debugPrint("node=\(node?.val ?? -1)")
            if node != nil {
                res.append(node!.val)
                stack.append(node!)
                node = node!.left
            } else {
                node = stack.removeLast().right
            }
        }
        
        return res
    }
    
    //PPLeetCode226 翻转二叉树
    //时间复杂度：每个元素都必须访问一次，所以是O(n)
    //空间复杂度：最坏的情况下，需要存放O(h)个函数调用(h是树的高度)，所以是O(h)
    @discardableResult
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        //递归函数的终止条件，节点为空时返回
        if(root==nil) {
            return nil;
        }
        //下面三句是将当前节点的左右子树交换
        let tmp = root!.right
        root!.right = root!.left
        root!.left = tmp
        //递归交换当前节点的 左子树
        invertTree(root!.left)
        //递归交换当前节点的 右子树
        invertTree(root!.right)
        //函数返回时就表示当前这个节点，以及它的左右子树
        //都已经交换完了
        return root
    }
    func testInvertTree() {
        let tree = PPTree(nil)
        tree.pp_insertNodes([3,1,4])
        PPTreeSolution().invertTree(tree.rootNode)
    }
    //MARK:PPLeetCode236 二叉树的最近公共祖先（父节点）
    //题目：给定一个二叉树, 找到该树中两个指定节点的最近公共祖先
    //解法来自：https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/solution/c-jing-dian-di-gui-si-lu-fei-chang-hao-li-jie-shi-/
    //1.如果当前结点 root 等于 nil，则直接返回 nil
    //2.如果 root 等于 p 或者 q ，那这棵树一定返回 p 或者 q
    //3.然后递归左右子树，因为是递归，使用函数后可认为左右子树已经算出结果，用 left 和 right 表示
    //4.此时若left为空， 那最终结果只要看right; 若right为空,那最终结果只要看left
    //5.如果left和right都非空，因为只给了p和q两个结点，都非空，说明一边一个，因此root是他们的最近公共祖先
    //6. 如果left和right都为空，则返回空(其实已经包含在前面的情况中了)
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if(root == nil || root === p || root === q){ return root }
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        //        return (left == nil) ? right : ((right == nil) ? left : root)
        //方便理解：
        if(left == nil) {
            return right
        }
        if(right == nil) {
            return left
        }
        
        if(left != nil && right != nil) {// p和q在两侧
            return root
        }
        return nil // 必须有返回值
    }
    //https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/solution/c-di-gui-jie-fa-si-xing-dai-ma-by-sunshy/
    class func testLowestCommonAncestor() {
        let tree = PPTree(nil)
        //本case的树 [33,16,50,13,18,34,58,15,17,25,51,66,19,27,55]
        //https://static001.geekbang.org/resource/image/29/2c/299c615bc2e00dc32225f4d9e3490e2c.jpg
        tree.pp_insertNodes([33,16,50,13])
        tree.pp_insertNodes([18,34,58,15])
        let pNode = PPTreeNode(17)
        tree.pp_insertNode(pNode)
        tree.pp_insertNodes([25,51,66,19,27])
        let qNode = PPTreeNode(55)
        tree.pp_insertNode(qNode)
        let lowestAncestor = PPTreeSolution().lowestCommonAncestor(tree.rootNode!, pNode, qNode)
        debugPrint(lowestAncestor as Any)//二叉树的最近公共祖先
    }
}

class PPBSTSolution {
    //PPLeetCode701 二叉搜索树中的插入操作
    //https://leetcode-cn.com/problems/insert-into-a-binary-search-tree/
    //类似官方的迭代法https://leetcode-cn.com/problems/insert-into-a-binary-search-tree/solution/er-cha-sou-suo-shu-zhong-de-cha-ru-cao-zuo-by-le-2/
    @discardableResult
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else {
            return TreeNode(val)//如果root为空，那么插入的这个val就是root节点
        }
        var p = root
        //如果要插入的数据比节点的数据大，并且节点的右子树为空，就将新数据直接插到右子节点的位置；
        //如果节点的右子树不为空，就再遍历右子树的右子树，查找插入位置。比节点的数据小的同理
        //关键点：找到大小合适且为空的位置
        while (p != nil) {
            if val > p.val {
                if (p.right == nil) {
                    p.right = TreeNode(val)
                    return root
                }
                p = p.right!
            }
            else {
                if (p.left == nil) {
                    p.left = TreeNode(val)
                    return root
                }
                p = p.left!
            }
        }
        return root
    }
    
    func testInsertIntoBST() {
        let res = insertIntoBST(nil, 5)
        debugPrint(res!)
        
        let root = PPTreeNode(4)
        insertIntoBST(root, 2)
        insertIntoBST(root, 7)
        insertIntoBST(root, 1)
        insertIntoBST(root, 3)
        insertIntoBST(root, 5)
        debugPrint(PPTreeSolution().preorderTraversal(root))
    }
}
