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
          "image": base_url + "banner/tmg02.jpg",
          "goodsId": '001'
        },
        {
          "image": base_url + "banner/tmg02.jpg",
          "goodsId": '002'
        },
        {
          "image": base_url + "banner/tmg02.jpg",
          "goodsId": '003'
        }
      ],
      "recomment": [
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙",
          "image": base_url + "goods/photo01.jpg",
          "presentPrice": 98.88,
          "goodsId": "001",
          "oriPrice": 108.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙2",
          "image": base_url + "goods/photo02.jpg",
          "presentPrice": 23.88,
          "goodsId": "002",
          "oriPrice": 275.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙3",
          "image": base_url + "goods/photo03.jpg",
          "presentPrice": 44.88,
          "goodsId": "003",
          "oriPrice": 891.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙4",
          "image": base_url + "goods/photo04.jpg",
          "presentPrice": 98.88,
          "goodsId": "004",
          "oriPrice": 256.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙5",
          "image": base_url + "goods/photo05.jpg",
          "presentPrice": 928.88,
          "goodsId": "005",
          "oriPrice": 788.88
        },
        {
          "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙6",
          "image": base_url + "goods/photo06.jpg",
          "presentPrice": 68.88,
          "goodsId": "006",
          "oriPrice": 28.88
        }
      ],
      "floor1Pic": {
        "PICTURE_ADDRESS": base_url + "advert/tmg01.jpg",
        "TO_PLACE": "4"
      },
      "floor1": [
        {
          "image": base_url + "floor/photo01.jpg",
          "goodsId": '001'
        },
        {
          "image": base_url + "floor/photo02.jpg",
          "goodsId": '002'
        },
        {
          "image": base_url + "floor/photo03.jpg",
          "goodsId": '003'
        },
        {
          "image": base_url + "floor/photo01.jpg",
          "goodsId": '001'
        },
        {
          "image": base_url + "floor/photo02.jpg",
          "goodsId": '002'
        },
        {
          "image": base_url + "floor/photo03.jpg",
          "goodsId": '003'
        }
      ],
      "category": [
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '限时秒杀'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '断码清仓'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '全球购'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '多多果园'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '9块9特卖'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '充值中心'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '品牌特卖'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '现金签到'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '金猪赚大钱'
        },
        {
          "image": base_url + "category/timg02.jpeg",
          "goodsId": '电器城'
        }
      ]
    }
  }

  res.send(data)
})
module.exports = router