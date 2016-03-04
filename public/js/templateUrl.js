var noteApp=angular.module('noteApp', []);
noteApp.directive('hello',function() {
	return {
		restrict: 'AE',
		templateUrl:'hello.html',
		replace:true;
	}
	// body...
})