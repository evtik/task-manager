require('angular').module('users').controller 'LoginController',
	['$scope', '$location', 'Identity', 'Authentication',
		($scope, $location, Identity, Authentication) ->
			$scope.identity = Identity

			$scope.signin = (username, password) ->
				Authentication.authenticateUser(username, password).then (success) ->
					$location.path '/'

			$scope.signout = () ->
				Authentication.logoutUser().then () ->
					$scope.username = ""
					$scope.password = ""
					$location.path '/'
	]