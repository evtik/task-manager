angular = require 'angular'

angular.module('taskManager')
	.directive 'onlyLettersAndDigits', () ->
		restrict: 'A'
		require: 'ngModel'
		link: (scope, el, attrs, ctrl) ->
			ctrl.$validators.onlyLettersAndDigits = (modelValue, viewValue) ->

				# This is needed for cases when a user at first
				# inputs some non-letter chars and then clears
				# the input, in this case model is supposed to
				# be 'valid' since empty model is handled with
				# the built-in 'required' directive. Without
				# this line a message 'should only contain letters'
				# will be shown too
				if ctrl.$isEmpty modelValue
					return on

				if /^[a-zа-я0-9]+$/i.test viewValue
					return on

				return off