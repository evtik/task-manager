require('angular').module('users').controller 'UsersController',
	['$scope', '$routeParams', '$location', 'Users', 'Identity', 'growl',
		($scope, $routeParams, $location, Users, Identity, growl) ->

			$scope.create = () ->
				# $scope.$broadcast 'show-errors-check-validity'

				return if $scope.userForm.$invalid

				user = new Users
					firstName: @firstName
					lastName: @lastName
					userName: @userName
					password: @password
					confirmPassword: @confirmPassword

				user.$save (response) ->
					Identity.user = user
					# $location.path 'users/' + response._id
					growl.success 'User has been successfully created'
					$location.path '/'
				, (errorResponse) ->
						$scope.error = errorResponse

			$scope.find = () ->
				$scope.users = Users.query()

			$scope.findOne = () ->
				$scope.user = Users.get userId: $routeParams.userId

			$scope.update = () ->
				$scope.user.$update () ->
					$location.path 'users/' + $scope.user._id
				, (errorResponse) ->
					$scope.error = errorResponse.data.message

			$scope.delete = (user) ->
				if user
					user.$remove () ->
						for u, i in $scope.users
							if u is user
								$scope.users.splice i, 1
				else
					$scope.user.$remove () ->
						$location.path 'users/'
	]