const express = require('express')
const path = require('path')
const app = express()
app.use(express.static(path.resolve(__dirname, "public")))
app.use('/getHomePageContent', require('./router/home_page_content'))
app.use('/getHotGoods', require('./router/hotgoods'))

app.use(function (req, res, next) {
  const proxy = req.query.proxy
  if( proxy ) {
    req.header.cookie = req.header.cookie + `__proxy_${proxy}`;
  }
  next()
})


const port = process.env.PORT || 3000
app.listen(port)