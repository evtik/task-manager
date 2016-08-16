require('angular').module 'users'
.config ['$routeProvider', ($routeProvider) ->
	$routeProvider
	.when '/signup',
		templateUrl: 'users/views/signup.client.view.html'
		controller: 'UsersController'
	.when '/users',
		templateUrl: 'users/views/list-users.client.view.html'
		controller: 'UsersController'
	.when '/users/:userId',
		templateUrl: 'users/views/view-user.client.view.html'
		controller: 'UsersController'
	.when '/users/:userId/edit',
		templateUrl: 'users/views/edit-user.client.view.html'
		controller: 'UsersController'
	.otherwise redirectTo: '/'
]