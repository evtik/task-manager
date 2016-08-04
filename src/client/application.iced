angular = require 'angular'
require 'angular-route'
require 'angular-animate'
require './index/index.client.module'

mainApplicationModuleName = 'taskManager'

mainApplicationModule = angular.module mainApplicationModuleName,
	['ngRoute', 'ngAnimate', 'index']

mainApplicationModule.config ['$locationProvider', ($locationProvider) ->
	$locationProvider.hashPrefix '!'
]

angular.element(document).ready () ->
	angular.bootstrap document, [mainApplicationModuleName]