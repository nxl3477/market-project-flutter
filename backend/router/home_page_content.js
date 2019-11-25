const express = require('express')
const config = require('./config')
const router = express()
const base_url = `http://${config.IP}:${config.PORT}/images/`
const category_url = `http://${config.IP}:${config.PORT}/images/category`

router.post('/', (req, res) => {
  var data = {
    "code": "0",
    "message": "success",
    "data": {
      "slides": [
        {
          "image": base_url + "banner/banner-0.png",
          "goodsId": '001'
        },
        {
          "image": base_url + "banner/banner-1.png",
          "goodsId": '002'
        },
        {
          "image": base_url + "banner/banner-2.png",
          "goodsId": '003'
        },
        {
          "image": base_url + "banner/banner-3.png",
          "goodsId": '004'
        },
        {
          "image": base_url + "banner/banner-4.png",
          "goodsId": '005'
        }
      ],
      "recomment": [
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙",
          "image": base_url + "goods/goods-1.png",
          "presentPrice": 98.88,
          "goodsId": "001",
          "oriPrice": 108.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙2",
          "image": base_url + "goods/goods-1.png",
          "presentPrice": 23.88,
          "goodsId": "002",
          "oriPrice": 275.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙3",
          "image": base_url + "goods/goods-2.png",
          "presentPrice": 44.88,
          "goodsId": "003",
          "oriPrice": 891.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙4",
          "image": base_url + "goods/goods-3.png",
          "presentPrice": 98.88,
          "goodsId": "004",
          "oriPrice": 256.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙5",
          "image": base_url + "goods/goods-4.png",
          "presentPrice": 928.88,
          "goodsId": "005",
          "oriPrice": 788.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙6",
          "image": base_url + "goods/goods-5.png",
          "presentPrice": 68.88,
          "goodsId": "006",
          "oriPrice": 28.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙7",
          "image": base_url + "goods/goods-6.png",
          "presentPrice": 44.64,
          "goodsId": "004",
          "oriPrice": 123.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙8",
          "image": base_url + "goods/goods-7.png",
          "presentPrice": 85.82,
          "goodsId": "003",
          "oriPrice": 281.28
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙9",
          "image": base_url + "goods/goods-8.png",
          "presentPrice": 44.88,
          "goodsId": "003",
          "oriPrice": 74.94
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙10",
          "image": base_url + "goods/goods-9.png",
          "presentPrice": 269.21,
          "goodsId": "003",
          "oriPrice": 501.56
        },
      ],
      "floor1Pic": {
        "PICTURE_ADDRESS": base_url + "advert/tmg01.jpg",
        "TO_PLACE": "4"
      },
      "floor1": [
        {
          "image": base_url + "floor/floor-1.png",
          "goodsId": '001'
        },
        {
          "image": base_url + "floor/floor-2.png",
          "goodsId": '002'
        },
        {
          "image": base_url + "floor/floor-3.png",
          "goodsId": '003'
        },
        {
          "image": base_url + "floor/floor-4.png",
          "goodsId": '001'
        },
        {
          "image": base_url + "floor/floor-5.png",
          "goodsId": '002'
        },
        {
          "image": base_url + "floor/floor-6.png",
          "goodsId": '003'
        }
      ],
      "category": [
        {
          "image": base_url + "category/category-7.png",
          "goodsId": '运动健身'
        },
        {
          "image": base_url + "category/category-4.png",
          "goodsId": '甜品咖啡'
        },
        {
          "image": base_url + "category/category-9.png",
          "goodsId": '名宿酒店'
        },
        {
          "image": base_url + "category/category-6.png",
          "goodsId": '美容美发'
        },
        {
          "image": base_url + "category/category-2.png",
          "goodsId": '养车服务'
        },
        {
          "image": base_url + "category/category-0.png",
          "goodsId": '亲子教育'
        },
        {
          "image": base_url + "category/category-8.png",
          "goodsId": '鲜花婚庆'
        },
        {
          "image": base_url + "category/category-3.png",
          "goodsId": '水果蔬菜'
        },
        {
          "image": base_url + "category/category-1.png",
          "goodsId": '休闲娱乐'
        },
        {
          "image": base_url + "category/category-5.png",
          "goodsId": '电影演出'
        }
      ]
    }
  }

  res.send(data)
})
module.exports = router