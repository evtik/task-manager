require('angular').module('users').controller 'LoginController',
	['$scope', '$location', 'Identity', 'Authentication', 'growl',
		($scope, $location, Identity, Authentication, growl) ->
			$scope.identity = Identity

			$scope.signin = (username, password) ->
				Authentication.authenticateUser(username, password).then (success) ->
					if success
						growl.success 'Successfully logged in!'
						$location.path '/'
					else
						growl.error 'Wrong username or password!'

			$scope.signout = () ->
				Authentication.logoutUser().then () ->
					growl.success 'You have logged out!'
					$scope.username = ""
					$scope.password = ""
					$location.path '/'
	]