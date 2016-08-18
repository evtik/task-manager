require('angular').module('users').factory 'Authentication',
	['$http', 'Identity', 'Users', '$q',
		($http, Identity, Users, $q) ->

			authenticateUser: (username, password) ->
				dfd = `$q.defer()`

				$http.post '/login',
					username: username
					password: password
				.then (response) ->
					console.log response
					if response.status is 200
						user = new Users
						angular.extend user, response.data.user
						Identity.user = user
						dfd.resolve on
					else
						dfd.resolve off

				return dfd.promise

			logoutUser: () ->
				dfd = `$q.defer()`

				$http.post '/logout', logout: on
				.then () ->
					Identity.user = undefined
					dfd.resolve()

				dfd.promise
	]