import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/provide/current_index_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/index.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'member_page.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(KString.homeTitle) // 首页
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.category),
        title: Text(KString.categoryTitle) // 分类
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text(KString.shoppingCartTitle) // 购物车
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text(KString.memberTitle) // 会员中心
    )
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
//    初始化一下屏幕适配插件，不需要太关心其实现, 只需要在跟组件做一次实力话就可以了
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(
//      构造器
      builder: (context, child, val) {
//        取得当前索引状态值
        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;

        
//       返回布局相关内容
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 235, 243, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
//              可以获取到索引值
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies
          ),
        );
      },
    );
  }
}