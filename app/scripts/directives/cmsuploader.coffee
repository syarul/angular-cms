###*
@ngdoc directive
@name angularCmsApp.directive:cmsUploader
@element div
@function
@description
	This is an example uploader.
###
'use strict'
angular.module('angularCmsApp').directive 'cmsUploader', ->
	scope:
		ngModel: '='
	template: '''
	      <div class="uploader">
	        <div class="uploader-dropzone">
	          <h4>Drop files here</h4>
	          <p>
	            <span>or</span>
	          </p>
	          <button id="uploader-btn" class="btn btn-default">Select files</button>
	          <input id="uploader-input" type="file" name="files[]" multiple />
	        </div>
	      </div>
	  '''
	restrict: 'E'
	replace: true
	transclude: false
	require: '^?ngModel'
	link: postLink = ($scope, $element, $attrs, ngModel) ->

		Uploader = () ->
			@files = []
			@inputEl = document.getElementById('uploader-input')
			@input = $element.find('#uploader-input')

			#Hide default file input
			@input.hide()

			#Listen for click and open file dialog
			$element.find('button').bind('click', (e) =>
				@input.trigger('click')
			)

			#Listen for file selection change and upload each file
			@inputEl.addEventListener('change', (e) =>
				@files = @inputEl.files
				@uploadFile(file) for file in @files
			)

			#Upload each file
			@uploadFile = (file) ->
				form = new FormData()
				form.append('files[]', file)

				xhr = new XMLHttpRequest()
				xhr.onload = () ->
					console.log('Upload complete')

				xhr.open('POST', $attrs.action, true)
				xhr.send(form)

				console.log('Upload ', file)


			#Add result to table list / progress




		#Initialize Uploader
		new Uploader()