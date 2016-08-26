module.exports = function(app) {
  return app.all('/api/*', function(req, res) {
    return res.send(404);
  });
};
