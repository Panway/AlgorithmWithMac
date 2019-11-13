//
//  CPPAdapter.cpp
//  AlgorithmWithMac
//
//  Created by panwei on 2019/10/24.
//  Copyright © 2019 WeirdPan. All rights reserved.
//
// C/C++: 如何相互调用 http://www.veryitman.com/2018/02/12/C-C-%E5%A6%82%E4%BD%95%E7%9B%B8%E4%BA%92%E8%B0%83%E7%94%A8/
#include <stdio.h>
#include "LinkTable.hpp"

#ifdef __cplusplus
extern "C" {
#endif
    
    void main_linkTable1(int cmd) {
        //调用 CPPFile 中的方法
        main_linkTable();
    }
    
#ifdef __cplusplus
}
#endif
