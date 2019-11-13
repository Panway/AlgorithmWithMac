//
//  LinkTable.cpp
//  AlgorithmWithMac
//
//  Created by panwei on 2019/10/24.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

#include "LinkTable.hpp"
#include <cstdio>
#include <iostream>
#include <queue>

using namespace std;
 
template <class T>
struct TreeNode
{
    T data;
    TreeNode<T> *left;
    TreeNode<T> *right;
    TreeNode(const T &x) : data(x),
                           left(NULL),
                           right(NULL) {}
};
template <class T>
bool IsComplete(TreeNode<T> *root)
{
    //1.树为空，返回错误
    if (root == NULL)
    {
        return false;
    }
    //2.树不为空
    queue<TreeNode<T> *> q;
    q.push(root);
    while (!q.empty())
    {
        TreeNode<T> *top = q.front();
        //2.1如果该节点两个孩子都有，则直接pop
        if (top->left && top->right)
        {
            q.pop();
            q.push(top->left);
            q.push(top->right);
        }
        //2.2如果该节点左孩子为空，右孩子不为空，则一定不是完全二叉树
        if (top->left == NULL && top->right)
        {
            return false;
        }
        //2.3如果该节点左孩子不为空，右孩子为空或者该节点为叶子节点，则该节点之后的所有结点都是叶子节点
        if ((top->left && top->right == NULL) || (top->left == NULL && top->right == NULL))
        {
                        if (NULL != top->left && NULL == top->right)
                        {
                            q.push(top->left);
                        }
            q.pop(); //则该节点之后的所有结点都是叶子节点
            while (!q.empty())
            {
                top = q.front();
                if (top->left == NULL && top->right == NULL)
                {
                    q.pop();
                }
                else
                {
                    return false;
                }
            }
            return true;
        }
    }
    return true;
}
 
//满二叉树
void test11()
{
    //       1
    //   2       3
    // 4    5  6   7
    TreeNode<int> *node1 = new TreeNode<int>(1);
    TreeNode<int> *node2 = new TreeNode<int>(2);
    TreeNode<int> *node3 = new TreeNode<int>(3);
    TreeNode<int> *node4 = new TreeNode<int>(4);
    TreeNode<int> *node5 = new TreeNode<int>(5);
    TreeNode<int> *node6 = new TreeNode<int>(6);
    TreeNode<int> *node7 = new TreeNode<int>(7);
    node1->left = node2;
    node1->right = node3;
    node2->left = node4;
    node2->right = node5;
    node3->left = node6;
    node3->right = node7;
    cout << IsComplete<int>(node1) << endl;
}
 
//二叉树为空
void test22()
{
    cout << IsComplete<int>(NULL) << endl;
}
 
//3.二叉树不为空，也不是满二叉树，遇到一个结点左孩子为空，右孩子不为空
void test33()
{
    //       1
    //   2       3
    // 4    5      7
    TreeNode<int> *node1 = new TreeNode<int>(1);
    TreeNode<int> *node2 = new TreeNode<int>(2);
    TreeNode<int> *node3 = new TreeNode<int>(3);
    TreeNode<int> *node4 = new TreeNode<int>(4);
    TreeNode<int> *node5 = new TreeNode<int>(5);
    TreeNode<int> *node7 = new TreeNode<int>(7);
    node1->left = node2;
    node1->right = node3;
    node2->left = node4;
    node2->right = node5;
    node3->right = node7;
    cout << IsComplete<int>(node1) << endl;
}
 
//4.二叉树不为空，也不是满二叉树，遇到叶子节点,则该叶子节点之后的所有结点都为叶子节点
void test44()
{
    //        1
    //    2       3
    // 4    5
    TreeNode<int> *node1 = new TreeNode<int>(1);
    TreeNode<int> *node2 = new TreeNode<int>(2);
    TreeNode<int> *node3 = new TreeNode<int>(3);
    TreeNode<int> *node4 = new TreeNode<int>(4);
    TreeNode<int> *node5 = new TreeNode<int>(5);
    node1->left = node2;
    node1->right = node3;
    node2->left = node4;
    node2->right = node5;
    cout << IsComplete<int>(node1) << endl;
}
 
//4.二叉树不为空，也不是满二叉树，遇到左孩子不为空，右孩子为空的结点，则该节点之后的所有结点都为叶子节点
void test55()
{
    //        1
    //    2       3
    // 4    5   6
    TreeNode<int> *node1 = new TreeNode<int>(1);
    TreeNode<int> *node2 = new TreeNode<int>(2);
    TreeNode<int> *node3 = new TreeNode<int>(3);
    TreeNode<int> *node4 = new TreeNode<int>(4);
    TreeNode<int> *node5 = new TreeNode<int>(5);
    TreeNode<int> *node6 = new TreeNode<int>(6);
    node1->left = node2;
    node1->right = node3;
    node2->left = node4;
    node2->right = node5;
    node3->left = node6;
    cout << IsComplete<int>(node1) << endl;
}







// 参数:
//        numbers:     一个整数数组
//        length:      数组的长度
//        duplication: (输出) 数组中的一个重复的数字
// 返回值:
//        true  - 输入有效，并且数组中存在重复的数字
//        false - 输入无效，或者数组中没有重复的数字
bool duplicate(int numbers[], int length, int* duplication)
{
    if(numbers == nullptr || length <= 0)
        return false;

    for(int i = 0; i < length; ++i)
    {
        if(numbers[i] < 0 || numbers[i] > length - 1)
            return false;
    }

    for(int i = 0; i < length; ++i)
    {
        while(numbers[i] != i)
        {
            if(numbers[i] == numbers[numbers[i]])
            {
                *duplication = numbers[i];
                return true;
            }

            // 交换numbers[i]和numbers[numbers[i]]
            int temp = numbers[i];
            numbers[i] = numbers[temp];
            numbers[temp] = temp;
        }
    }

    return false;
}

// ====================测试代码====================
bool contains(int array[], int length, int number)
{
    for(int i = 0; i < length; ++i)
    {
        if(array[i] == number)
            return true;
    }

    return false;
}

void test(char* testName, int numbers[], int lengthNumbers, int expected[], int expectedExpected, bool validArgument)
{
    printf("%s begins: ", testName);

    int duplication;
    bool validInput = duplicate(numbers, lengthNumbers, &duplication);

    if(validArgument == validInput)
    {
        if(validArgument)
        {
            if(contains(expected, expectedExpected, duplication))
                printf("Passed.\n");
            else
                printf("FAILED.\n");
        }
        else
            printf("Passed.\n");
    }
    else
        printf("FAILED.\n");
}

// 重复的数字是数组中最小的数字
void test1()
{
    int numbers[] = { 2, 1, 3, 1, 4 };
    int duplications[] = { 1 };
    test((char*)"Test1", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), true);
}

// 重复的数字是数组中最大的数字
void test2()
{
    int numbers[] = { 2, 4, 3, 1, 4 };
    int duplications[] = { 4 };
    test((char*)"Test2", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), true);
}

// 数组中存在多个重复的数字
void test3()
{
    int numbers[] = { 2, 4, 2, 1, 4 };
    int duplications[] = { 2, 4 };
    test((char*)"Test3", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), true);
}

// 没有重复的数字
void test4()
{
    int numbers[] = { 2, 1, 3, 0, 4 };
    int duplications[] = { -1 }; // not in use in the test function
    test((char*)"Test4", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), false);
}

// 没有重复的数字
void test5()
{
    int numbers[] = { 2, 1, 3, 5, 4 };
    int duplications[] = { -1 }; // not in use in the test function
    test((char*)"Test5", numbers, sizeof(numbers) / sizeof(int), duplications, sizeof(duplications) / sizeof(int), false);
}

// 无效的输入
void test6()
{
    int* numbers = nullptr;
    int duplications[] = { -1 }; // not in use in the test function
    test((char*)"Test6", numbers, 0, duplications, sizeof(duplications) / sizeof(int), false);
}

int main_linkTable()
{
    test1();
    test2();
    test3();
    test4();
    test5();
    test6();
    return 1;
}
