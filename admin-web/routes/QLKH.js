var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
res.render('QLKH', { title: 'Quản lý khách hàng' });
});

module.exports = router;
