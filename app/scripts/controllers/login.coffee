'use strict'
###*
Login Controller - Handles the login.html view for authenticating a user.
###
angular.module('angularCmsApp').controller 'LoginCtrl', ($scope, $rootScope, $cookieStore, cmsAuthService, cmsNotify, cmsSessionService) ->

	#Setup initial model
	$scope.user =
		email: null
		password: null
		remember: false

	#$scope.user = Parse.User.current() if Parse.User.current()

	###*
		login - This functionality should be moved into the session service that handles
		setting the session and changing the location of the page.
	###
	$scope.login = (u) ->
		cmsAuthService.login(u)

	###
	Login Method to set the session.
	@param {Object} user - A user model containing username and password

	$scope._login = (u) ->
		console.log(u)
		Parse.User.logIn u.username, u.password,
			success: (user) ->
				console.log user
				$scope.$apply(()->
					#Set user session
					session =
						user: user.attributes
						authorized: true

					console.log('save sessin', session)
					#Set user cookie
					$cookieStore.put('App.session', session) if u.remember
					$rootScope.App.session = session
					#Change location
					$rootScope.App.location.path('/dashboard')
				)
			error: (user, error) ->
				$scope.$apply(()->
					$scope.error = error;
				)
	###

	$scope.logout = (user) ->
		cmsAuthService.logout(user)


	#Controller name
	$scope.name = 'login'
