module.exports = function(app) {
  var index;
  index = require('../controllers/index.server.controller');
  return app.get('/', index.render);
};
