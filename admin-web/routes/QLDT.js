var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
res.render('QLDT', { title: 'Quản lý doanh thu' });
});

module.exports = router;
