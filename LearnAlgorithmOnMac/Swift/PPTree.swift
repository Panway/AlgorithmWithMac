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
class PPTreeNode: NSObject {
    var value = 0
    var leftNode:PPTreeNode?
    var rightNode:PPTreeNode?

    /// 兼容其他人写的代码
    open var left: PPTreeNode? {
        get { return leftNode }
        set { leftNode = newValue }
    }
    open var right: PPTreeNode? {
        get { return rightNode }
        set { rightNode = newValue }
    }
    open var val: Int {
        get { return value }
        set { value = newValue }
    }
    
    init(_ value:Int) {
        self.value = value
    }
    override var description : String {
//        return "\(self.leftNode?.value ?? 0)-(\(self.value))-\(self.rightNode?.value ?? 0)  <\(Unmanaged.passUnretained(self).toOpaque())>"
        return "\(self.leftNode?.value ?? 0)-(\(self.value))-\(self.rightNode?.value ?? 0)"
    }
}

class PPSearchTreeNode: PPTreeNode {
    
}
open class PPTree {
    var rootNode:PPTreeNode?
    init(rootNode:PPTreeNode?) {
        self.rootNode = rootNode
    }
    //MARK:PPLeetCode236 二叉树的最近公共祖先（父节点）
    //解法来自：https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/solution/c-di-gui-jie-fa-si-xing-dai-ma-by-sunshy/
    //    在左、右子树中分别查找是否包含p或q：
    //    如果以下两种情况（左子树包含p，右子树包含q/左子树包含q，右子树包含p），那么此时的根节点就是最近公共祖先
    //    如果左子树包含p和q，那么到root->left中继续查找，最近公共祖先在左子树里面
    //    如果右子树包含p和q，那么到root->right中继续查找，最近公共祖先在右子树里面
    func lowestCommonAncestorOfTree(root:PPTreeNode?, p:PPTreeNode, q:PPTreeNode) -> PPTreeNode? {
        if(root == nil || root == p || root == q){ return root }
        let left = lowestCommonAncestorOfTree(root: root?.left, p: p, q: q);
        let right = lowestCommonAncestorOfTree(root: root?.right, p: p, q: q);
        return (left == nil) ? right : ((right == nil) ? left : root);
    }
}

// MARK:🍀二叉搜索树🍀
open class PPSearchTree: PPTree {
    
//    init(rootNode:PPSearchTreeNode?) {
//        self.rootNode = rootNode
//    }
    // MARK: 插入值等于num的节点
    func pp_insertNode(_ num:Int) {
        let node = PPSearchTreeNode(num)
        return pp_insertNode(node)
    }
    func pp_insertNode(_ node:PPSearchTreeNode) {
//        let node = PPSearchTreeNode(num)
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
        else if (pp?.left == p) {
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
    
    // MARK:前序遍历(用栈实现,先打印这个节点，然后再打印它的左子树，最后打印它的右子树)
    func preorderTraversal(root: PPTreeNode?) -> [Int] {
        var res = [Int]()
        var stack = [PPTreeNode]()
        var node = root
        
        while !stack.isEmpty || node != nil {
            print("node=\(node?.value ?? -1)")
            if node != nil {
                res.append(node!.value)
                stack.append(node!)
                node = node!.leftNode
            } else {
                node = stack.removeLast().rightNode
            }
        }
        
        return res
    }
    //MARK:中序遍历
    //图片辅助理解： https://i.loli.net/2019/11/08/EXNtZ7FOAI1mBWU.png
    //由图可以看出，首先要找到最左侧的叶子节点存到栈里，然后每次出栈一个节点，遍历打印该节点和右节点
    func inorderTraversal(root: PPTreeNode?) -> [Int] {
        var res = [Int]()
        var stack = [PPTreeNode]()
        var node = root
        
//        if ((node?.leftNode) != nil) {
//            node = node?.leftNode
//            var leftA:Array<Int> = inorderTraversal(root: node?.leftNode)
//            leftA.append(node!.value)
//            return leftA
//        }
//            
//        if ((node?.rightNode) != nil) {
//            return inorderTraversal(root: node?.rightNode)
//        }
//        inorderTraversal(root: node?.leftNode)
//        inorderTraversal(root: node?.leftNode)
        while !stack.isEmpty || node != nil {
            print("当前node=\(String(describing: node))")
            if node != nil {
                stack.append(node!)
                node = node!.leftNode
            } else {
                node = stack.removeLast()
                res.append(node?.value ?? -1 )
                node = node?.rightNode
            }
        }
        
        return res
    }
    
    //MARK:树的层级遍历，每一层不分组
    //解法：从左到右打印，可使用队列，依次放入父节点、子左节点、子右节点
    func pp_levelTraverse(root: PPTreeNode?) -> [Int] {
        var res = [Int]()
        var queue = [PPTreeNode]()
        var node = root
        queue.append(node!)
        while !queue.isEmpty {
            node = queue.removeFirst()
            print("当前node=\(String(describing: node))")
            res.append(node?.value ?? -1 )
            if node?.leftNode != nil {
                queue.append(node!.leftNode! )
                print("入列=\(node?.leftNode?.value ?? 0)")
            }
            if node?.rightNode != nil {
                queue.append(node!.rightNode! )
                print("入列=\(node?.rightNode?.value ?? 0)")
            }
//            print("Queue=\(queue)")
        }
        return res

    }
    //MARK:树的层级遍历，每一层分组
    func levelOrder(root: PPTreeNode?) -> [[Int]] {
        var res = [[Int]]()
        // 用数组来实现队列
        var queue = [PPTreeNode]()
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
            print("add level array:\(level)")
            res.append(level)
        }
        return res
        
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
        let node = PPSearchTreeNode(num)
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
            print("insert num=\(num)")
        }
    }
    func pp_insertNodes(_ nodes:[Int]) {
        for node in nodes {
            pp_insertNode(node)
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
