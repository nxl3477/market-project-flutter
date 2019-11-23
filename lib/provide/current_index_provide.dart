import 'package:flutter/material.dart';

// 切换底部导航栏
class CurrentIndexProvide with ChangeNotifier {
  // 当前索引
  int currentIndex = 0;
  // 提供改变索引的方法
  changeIndex(int newIndex) {
    currentIndex = newIndex;
    // 通知所有的监听者， 也就是被 Provide 包裹的组件
    notifyListeners();
  }
}