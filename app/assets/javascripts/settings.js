//= require underscore/underscore.js
//= require angular
//= require angular-resource
//= require angular-ui-bootstrap-tpls
//= require angular-underscore/angular-underscore.js
//= require angular-filters/dist/angular-filters.min.js
//= require detect_timezone
//= require jquery.detect_timezone
angular.module('remotestandup.settings', [
	'angular-underscore',
	'ui.bootstrap'
]).controller('SettingsCtrl', ['$scope', function($scope) {
	$scope.timezone = $().get_timezone();
}]);