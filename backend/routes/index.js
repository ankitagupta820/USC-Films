let express = require('express');
let router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.send('About Page');
  //res.send('index', { title: 'MovieMania' });
});

/* GET home router . */
router.get('/homesecond', function(req, res, next) {
  res.send('About Page');
});


module.exports = router;
