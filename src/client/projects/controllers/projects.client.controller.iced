require('angular').module('projects').controller 'ProjectsController',
	['$scope', '$routeParams', 'Projects', 'Identity',
		($scope, $routeParams, Projects, Identity) ->
			$scope.identity = Identity
			# $scope.create = () ->
			# 	project = new Projects

			$scope.find = () ->
				$scope.projects = Projects.query userId: @identity.user._id

			$scope.find()
		]