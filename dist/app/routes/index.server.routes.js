module.exports = function(app) {
  var index;
  index = require('../controllers/index.server.controller');
  app.all('/api/*', function(req, res) {
    return res.redirect('/');
  });
  return app.get('/', index.render);
};
