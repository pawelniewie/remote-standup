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
])
.directive('validateTime', function() {
    return {
        // restrict to an attribute type.
        restrict: 'A',

        // element must have ng-model attribute.
        require: 'ngModel',

        // scope = the parent scope
        // elem = the element the directive is on
        // attr = a dictionary of attributes on the element
        // ctrl = the controller for ngModel.
        link: function(scope, elem, attr, ctrl) {
            var regex = new RegExp('[0-9]{1,2}:[0-9]{1,2}');

            ctrl.$parsers.unshift(function(value) {
                var valid = regex.test(value);
                ctrl.$setValidity('validateTime', valid);
                return valid ? value : undefined;
            });

            ctrl.$formatters.unshift(function(value) {
                ctrl.$setValidity('validateTime', regex.test(value));
                return value;
            });
        }
    };
})
.controller('SettingsCtrl', ['$scope', '$http', function($scope, $http) {
	$scope.loading = false;
	$scope.timezones = _.map(moment.tz.zones(), function(tz) { return tz.displayName; }).sort();

	$scope.settings = {};
	$scope.settings.members = [ 'test@test.pl' ];
	$scope.settings.timezone = $().get_timezone();
	$scope.settings.remind_on = '1-5';

	$scope.memberKeyDown = function($event) {
		if ($event.keyCode == 13) {
			$event.preventDefault();
			$scope.addMember();
		}
	}

	$scope.addMember = function() {
		if ($scope.member) {
			if ($scope.settings.members.indexOf($scope.member) == -1) {
				$scope.settings.members.push($scope.member);
			}
			$scope.member = '';
		}
	}

	$scope.removeMember = function(member) {
		var idx = $scope.settings.members.indexOf(member);
		if (idx > -1) {
			$scope.settings.members.splice(idx, 1);
		}
	}

	$scope.saveSettings = function() {
		$scope.loading = true;
		$http.put('/settings', {settings: $scope.settings})
			.then(function(data) {
				$scope.settings = data;
			})
			.finally(function() {
				$scope.loading = false;
			});
	}
}]);

