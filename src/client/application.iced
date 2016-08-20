angular = require 'angular'
require 'angular-resource'
require 'angular-route'
require 'angular-animate'
require 'angular-ui-bootstrap'
require './index/index.client.module'
require './users/users.client.module'

mainApplicationModuleName = 'taskManager'

mainApplicationModule = angular.module mainApplicationModuleName,
	['ngRoute', 'ngResource', 'ngAnimate', 'ui.bootstrap', 'index', 'users']

mainApplicationModule.config ['$locationProvider', ($locationProvider) ->
	$locationProvider.hashPrefix '!'
]

if window.location.hash is '#_=_'
	window.location.hash = '#!'

angular.element(document).ready () ->
	angular.bootstrap document, [mainApplicationModuleName]