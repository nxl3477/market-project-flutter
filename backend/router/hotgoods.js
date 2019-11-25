const express = require('express')
const config = require('./config')
const router = express()
const base_url = `http://${config.IP}:${config.PORT}/images/`

router.post('/', (req, res) => {
  
  var hotGoods = {
    "code": "0",
    "message": "success",
    "data": [
      {
        "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙",
        "image": base_url + "goods/goods-1.png",
        "presentPrice": 98.88,
        "goodsId": "001",
        "oriPrice": 108.88
      },
      {
        "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙2",
        "image": base_url + "goods/goods-2.png",
        "presentPrice": 23.88,
        "goodsId": "002",
        "oriPrice": 275.88
      },
      {
        "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙3",
        "image": base_url + "goods/goods-3.png",
        "presentPrice": 44.88,
        "goodsId": "003",
        "oriPrice": 891.88
      },
      {
        "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙4",
        "image": base_url + "goods/goods-4.png",
        "presentPrice": 98.88,
        "goodsId": "004",
        "oriPrice": 256.88
      },
      {
        "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙5",
        "image": base_url + "goods/goods-5.png",
        "presentPrice": 928.88,
        "goodsId": "005",
        "oriPrice": 788.88
      },
      {
        "name": "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙6",
        "image": base_url + "goods/goods-6.png",
        "presentPrice": 68.88,
        "goodsId": "006",
        "oriPrice": 28.88
      }
    ]
  }

  res.send(hotGoods)
})
module.exports = router