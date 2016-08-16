exports.render = (req, res) ->
	res.render 'index', bootstrappedUser: req.user