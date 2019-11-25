import 'package:flutter/material.dart';
import 'package:flutter_shop/service/http_service.dart';
import '../config/index.dart';
// 上拉和下啦刷新
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
class HomePage extends StatefulWidget {

  _HomePageState createState() => _HomePageState();
}


//AutomaticKeepAliveClientMixin 可以解决切页后weiget组件会刷新的问题
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

//  火爆专区的分页页码
  int page = 1;
//  火爆专区数据
  List<Map> hotGoodsList = [];

//  继承 AutomaticKeepAliveClientMixin 需要重写 wantKeepAlive
  @override
  bool get wantKeepAlive => true;

//  给easyrfresh 添加的 key 作用类似于 react diff 算法的作用
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

//  为了验证  AutomaticKeepAliveClientMixin 是否成功让weiget避免重复刷新， 我们重写initState 来打印信息
  @override
  void initState() {
    super.initState();
    print('首页刷新了...');
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      appBar: AppBar(title: Text(KString.homeTitle)),
      body: FutureBuilder(
        future: request('homePageContent', formData: null),
        builder: (context, snapshot) {
          if( snapshot.hasData ) {
//            解析json
            var data = json.decode(snapshot.data.toString());
//            从接口返回的json中提取数据
            List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 轮播图
            List<Map> navigatorList = (data['data']['category'] as List).cast(); // 分类
            List<Map> recommendList = (data['data']['recomment'] as List).cast(); // 商品推荐
            List<Map> floor = (data['data']['floor1'] as List).cast(); // 底部商品推荐
            Map floorPic = data['data']['floor1Pic']; // 广告
            print('-------=================-----------');
            print(navigatorList);

//            需要用 easyRefresh 包裹需要上拉下拉的组件
            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: KColor.refreshTextColor,
                moreInfoColor: KColor.refreshTextColor,
                showMore: true,
                noMoreText: '',
                moreInfo: KString.loading, // 加载中。。。
                loadReadyText: KString.loadReadyText,
              ),
              child: ListView(children: <Widget>[
                SwiperDiy(
                  swiperDataList: swiperDataList
                ),
                TopNavigator(
                    navigatorList: navigatorList
                ),
                RecommendUI(
                  recommendList: recommendList,
                ),
                FloorPic(
                    floorPic: floorPic
                ),
                Floor(
                  floor: floor
                ),
                _hotGoods()
              ]),
              loadMore: () async {
                print('开始加载更多');
                this._getHotGoods();
              },
            );
          }else {
            return Container(
              child: Text('加载中...'),
            );
          }
        }
      )
    );
  }


  void _getHotGoods() {
    var formPage = { 'page': page };
    request('getHotGoods', formData: formPage).then((res) {
      var data = json.decode(res.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
//      虽然写不写 this. 都是一样的， 但我觉得为了更容易阅读还是加上比较好
//      设置火爆专区数据列表
      this.setState(() {
        this.hotGoodsList.addAll(newGoodsList);
        this.page++;
      });

      print(data);
    });
  }
//  火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5, color: KColor.defaultBorderColor)
      )
    ),
    child: Text(
        KString.hotGoodsTitle,
        style: TextStyle(color: KColor.homeSubTitleTextColor)
    ),
  );


//  火爆专区子项
  Widget _wrapList() {
    if( hotGoodsList.length != 0 ) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return new InkWell(
          onTap: () {
            
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                    val['image'],
                    width: ScreenUtil().setWidth(375),
                    height: ScreenUtil().setHeight(200),
                    fit: BoxFit.cover
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: ScreenUtil().setSp(26))
                ),
                Row(
                  children: <Widget>[
                    Text('¥${val['presentPrice']}', style: TextStyle( color: KColor.presentPriceTextColor) ),
                    Text('¥${val['presentPrice']}', style: TextStyle( color: KColor.oriPriceTextColor))
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else {
      return Text('暂无数据');
    }
  }

//  火爆专区组合， 负责拼接各个组件
  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          this._wrapList()
        ],
      ),
    );
  }
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

//  构造方法
  SwiperDiy({Key key, this.swiperDataList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
//      控制宽高
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
//      传入Swiper组件
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
//          InkWell 是点击交互组件
          return new InkWell(
            onTap: () {
              print('Hello world${index}');
            },
            child: Image.network("${ swiperDataList[index]['image'] }", fit: BoxFit.cover)
          );
        },
//        轮播图片数量
        itemCount: swiperDataList.length,
//        分页指示器
        pagination: SwiperPagination(),
//        自动播放
        autoplay: true,
      ),
    );
  }
}

// 首页分类导航组件
class TopNavigator extends StatelessWidget {

  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);


//  为每个分类写一个小组件
  Widget _gridViewItemUI( BuildContext context, item, index) {
    return InkWell(
      onTap: () {
//      跳转到分类页面
        print('hello');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['goodsId'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//   只保留十条数据
    if( navigatorList.length > 10 ) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    print(navigatorList);
    var tempIndex = -1;
    return Container(
      color: Colors.white,
//      只有上方间隙
      margin: EdgeInsets.only(top: 10.0),
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
//      网格布局
      child: GridView.count(
//        禁止滚动
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(4.0),
//        五列
        crossAxisCount: 5,
        children: navigatorList.map((item) {
          tempIndex++;
          return _gridViewItemUI(context, item, tempIndex);
        }).toList()
      ),
    );
  }
}




// 商品推荐
class RecommendUI extends StatelessWidget {

  final List recommendList;

  RecommendUI({Key key, this.recommendList}) : super(key: key);

//  推荐商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
//      内边距
      padding: EdgeInsets.fromLTRB(10, 2.0, 0, 5.0),
//      装饰器
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: KColor.defaultBorderColor)
        ),
      ),
      child: Text(
        KString.recommendText, // 商品推荐
        style: TextStyle(color: KColor.homeSubTitleTextColor),
      ),
    );
  }

//  商品推荐列表
  Widget _recommedList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
//        将列表改为水平方向， 因为默认的列表为纵向
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: ( context, index ) {
          return _item(index, context);
        },

      ),
    );
  }

//  单个商品展示
  Widget _item(index, context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        width: ScreenUtil().setWidth(280),
//        内编剧
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: KColor.defaultBorderColor)
          )
        ),
        child: Column(
          children: <Widget>[
//            防止溢出
            Expanded(
              child: Image.network(recommendList[index]['image'], fit: BoxFit.cover),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                  '¥${recommendList[index]['presentPrice']}',
                  style: TextStyle(
                      color: KColor.primaryColor
                  )
              ),
            )
            ,
            Text(
              '¥${recommendList[index]['oriPrice']}',
              style: KFont.oriPriceStyle
            )
          ]
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
//    Container 相当于div, 所以使用的比较频繁
    return Container(
      margin: EdgeInsets.only(top: 10.0),
//      Column 用于列布局
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList(context)
        ],
      ),
    );
  }
}




// 商品推荐中间的广告
class FloorPic extends StatelessWidget {

  final Map floorPic;

  FloorPic({Key key, this.floorPic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: InkWell(
        child: Image.network(
          floorPic['PICTURE_ADDRESS'],
          fit: BoxFit.cover,
        ),
        onTap: () {

        },
      ),
    );
  }
}


// 商品推荐下层
class Floor extends StatelessWidget {

  final List floor;

  Floor({Key key, this.floor}) : super(key: key);

  void jumpDetail(context, String goodId) {
//    跳转到商品详情
  }


  @override
  Widget build(BuildContext context) {
//    取出宽度
    double width = ScreenUtil.getInstance().width;
    return Container(
//      行布局
      child: Row(
        children: <Widget>[
//          Expanded 防止溢出
          Expanded(
//            垂直布局 左侧商品
            child: Column(
              children: <Widget>[
//                左上角大图商品
                Container(
                  padding: EdgeInsets.only(top: 4, right: 1),
                  height: ScreenUtil().setHeight(400),
                  child: InkWell(
                    child: Image.network(
                      floor[0]['image'],
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(400),
                    ),
                    onTap: () {
                      this.jumpDetail(context, floor[0]['goodsId']);
                    },
                  ),
                ),
//                左下角商品
                Container(
                  padding: EdgeInsets.only(top: 1, right: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    child: Image.network(
                      floor[1]['image'],
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(200),
                    ),
                    onTap: () {
                      this.jumpDetail(context, floor[1]['goodsId']);
                    },
                  ),
                )
              ],
            )
          ),
//          右侧商品
          Expanded(
            child: Column(
              children: <Widget>[
                // 右上图
                Container(
                  padding: EdgeInsets.only(top: 4),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    child: Image.network(
                      floor[1]['image'],
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(200),
                    ),
                    onTap: () {
                      this.jumpDetail(context, floor[1]['goodsId']);
                    },
                  ),
                ),
                // 右中图
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    child: Image.network(
                      floor[3]['image'],
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(200)
                    ),
                    onTap: () {
                      this.jumpDetail(context, floor[3]['goodsId']);
                    },
                  ),
                ),
                // 右下图
                Container(
                  padding: EdgeInsets.only(top: 1, left: 1),
                  height: ScreenUtil().setHeight(200),
                  child: InkWell(
                    child: Image.network(
                      floor[4]['image'],
                      fit: BoxFit.fill,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(200)
                    ),
                    onTap: () {
                      this.jumpDetail(context, floor[4]['goodsId']);
                    },
                  ),
                )
              ],
            ),
          )
        ],
//        根据空间 等间距布局
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}