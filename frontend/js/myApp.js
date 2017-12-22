var myApp = angular.module("reportApp", ["ngRoute"]);

myApp.value('API_URL','http://localhost/projects/interview/fleetsu');

myApp.config(function($routeProvider) {
    $routeProvider
    .when("/", {
        templateUrl : "report.htm"
    })
    .when("/add", {
        templateUrl : "add.htm"
    })
	.when("/report/:deviceid", {
        templateUrl : "details.htm"
    })
    .when("/report", {
        templateUrl : "report.htm"
    });
});

// reporting controller
myApp.controller('myReport', ['$scope', '$http', 'API_URL', function($scope, $http, API_URL){
			
	$http.get(API_URL + '/backend/devices').
        then(function(response) {
			angular.forEach(response.data, function(value, key){ 
				response.data[key].last_report_on = new Date(response.data[key].last_report_on.replace(/-/g,"/"));
			});
            $scope.report_list = response.data; 		console.log($scope.report_list);	
        });
	
 }]);
 
 // reporting details
 myApp.controller('myReportDetails', ['$scope', '$http', 'API_URL', '$routeParams', function($scope, $http, API_URL, $routeParams){
	var deviceID = $routeParams.deviceid;
	$http.get(API_URL + '/backend/device-details/'+deviceID).
        then(function(response) {
			angular.forEach(response.data, function(value, key){ 
				response.data[key].last_report_on = new Date(response.data[key].last_report_on.replace(/-/g,"/"));
			});
            $scope.report_details = response.data; 			
        });
	
 }]);
 
// add controller
myApp.controller("addController", ['$scope', '$location', '$http', 'API_URL', function($scope, $location, $http, API_URL){
	$scope.device_name 	= 	null;
	$scope.device_id 	= 	null;
	$scope.last_report 	= 	null;
	
	$scope.postData = function()
	{		
		var param = {
			device_name: $scope.device_name,
			device_id: $scope.device_id,
			last_report: $scope.last_report
			};
		
		$http({
			url: API_URL +'/backend/devices',
			method: "POST",
			headers: {
				'Content-Type': 'application/json', /*or whatever type is relevant */
				'Accept': 'application/json' /* ditto */
			},
			data: param
		})
		.then(function(response) {
			// success
			$scope.ResponseData = response;
			$location.path("/report");			
		}, 
		function(response) { 
			// failed
		});
		
	};
	
	$scope.cancel = function()
	{		
		$location.path("/report");
	};	
	
}]);


var dateTimePicker = function() {
	return {
		restrict: "A",
		require: "ngModel",
		link: function (scope, element, attrs, ngModelCtrl) {
			var parent = $(element).parent();
			var dtp = parent.datetimepicker({
				format: "YYYY-MM-DD HH:mm:ss",
				showTodayButton: true
			});
			dtp.on("dp.change", function (e) {
				ngModelCtrl.$setViewValue(moment(e.date).format("YYYY-MM-DD HH:mm:ss"));
				scope.$apply();
			});
		}
	};
};

myApp.directive('dateTimePicker', dateTimePicker);