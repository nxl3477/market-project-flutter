import 'package:flutter/material.dart';
import './provide/current_index_provide.dart';
import 'package:provide/provide.dart';
// 导入配置文件的字符串
import './config/index.dart';
import './pages/index_page.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
//  实力化一个providers
  var providers = Providers();

  // .. 级联调用符
  providers
//  添加provider<泛型>.方法
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

//  因该是用provider 包裹根节点的操作
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
          title: KString.mainTitle, // Flutter 服装商城
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: KColor.primaryColor
          ),
          home: IndexPage()
      )
    );
  }
}
