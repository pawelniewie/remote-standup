//= require underscore/underscore.js
//= require angular
//= require angular-animate
//= require angular-ui-bootstrap-tpls
//= require angular-underscore/angular-underscore.js
//= require angular-filters/dist/angular-filters.min.js
//= require detect_timezone
//= require jquery.detect_timezone
//= require moment
//= require moment-timezone/moment-timezone
//= require ./moment-timezone-data.js
angular.module('remotestandup.settings', [
	'ngAnimate',
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
.factory('settings', function() {
	return angular.element('form[name="settingsForm"]').data('settings');
})
.controller('SettingsCtrl', ['$scope', '$http', 'settings', function($scope, $http, settings) {
	$scope.loading = false;
	$scope.timezones = _.map(moment.tz.zones(), function(tz) { return tz.displayName; }).sort();

	$scope.settings = settings || {};

	if (!$scope.settings.timezone || $scope.settings.timezone == '') {
		$scope.settings.timezone = $().get_timezone();
	}

	if (!$scope.settings.remind_on) {
		$scope.settings.remind_on = '1-5';
	}

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
		var settings = angular.copy($scope.settings);
		if (settings.reminder_at) {
			var dc = settings.reminder_at.indexOf(':');
			if (dc != -1) {
				settings.reminder_at_h = +settings.reminder_at.substring(0, dc);
				settings.reminder_at_m = +settings.reminder_at.substring(dc + 1);
				delete settings.reminder_at;
			}
		}

		$http.put('/settings.json', {settings: settings})
			.then(function(data) {
				$scope.saved = true;
				setTimeout(function() {
					$scope.$apply(function() {
						$scope.saved = false;
					})
				}, 1500);
			})
			.finally(function() {
				$scope.loading = false;
			});
	}
}]);

