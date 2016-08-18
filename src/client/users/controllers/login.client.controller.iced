require('angular').module('users').controller 'LoginController',
	['$scope', '$location', 'Identity', 'Authentication',
		($scope, $location, Identity, Authentication) ->
			$scope.identity = Identity

			$scope.signin = (username, password) ->
				Authentication.authenticateUser username, password

			$scope.signout = () ->
				Authentication.logoutUser().then () ->
					$scope.identity = null
	]