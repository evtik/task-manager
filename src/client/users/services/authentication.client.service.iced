require('angular').module('users').factory 'Authentication', [ '$window', ($window) ->
	@user = $window.bootstrappedUserObject

	user: @user
]