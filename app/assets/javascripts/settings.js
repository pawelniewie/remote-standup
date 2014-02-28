//= require underscore/underscore.js
//= require angular
//= require angular-resource
//= require angular-ui-bootstrap-tpls
//= require angular-underscore/angular-underscore.js
//= require angular-filters/dist/angular-filters.min.js
//= require detect_timezone
//= require jquery.detect_timezone
//= require moment
//= require moment-timezone/moment-timezone
//= require ./moment-timezone-data.js
angular.module('remotestandup.settings', [
	'angular-underscore',
	'ui.bootstrap'
]).controller('SettingsCtrl', ['$scope', function($scope) {
	$scope.members = [ 'test@test.pl' ];
	$scope.timezone = $().get_timezone();
	$scope.remind_on = '1-5';
	$scope.timezones = _.map(moment.tz.zones(), function(tz) { return tz.displayName; }).sort();

	$scope.memberKeyUp = function($event) {
		if ($event.keyCode == 13) {
			$scope.addMember();
		}
	}

	$scope.addMember = function() {
		if ($scope.member) {
			if ($scope.members.indexOf($scope.member) == -1) {
				$scope.members.push($scope.member);
			}
			$scope.member = '';
		}
	}

	$scope.removeMember = function(member) {
		var idx = $scope.members.indexOf(member);
		if (idx > -1) {
			$scope.members.splice(idx, 1);
		}
	}
}]);
