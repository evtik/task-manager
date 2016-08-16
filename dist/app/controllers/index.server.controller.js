exports.render = function(req, res) {
  return res.render('index', {
    bootstrappedUser: req.user
  });
};
