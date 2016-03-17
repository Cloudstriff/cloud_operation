var noteApp = angular.module('noteApp', ['ngRoute','ngAnimate','noteCtrls','noteDirectives','noteFilters']); //如果分离出来，则必须设置app的依赖对象，控制器，服务那些
noteApp.config(['$routeProvider', '$locationProvider',function($routeProvider,$locationProvider) {
		$routeProvider.when('/',{
			//templateUrl: path+'/tpl/home.html',
			//controller: 'mainCtrl'
		}).when('/group/:gid/setting/members',{
			templateUrl: path+'/tpl/members.html',
			controller: 'membersCtrl'
		}).when('/group/:gid/setting/options',{
			templateUrl: path+'/tpl/options.html',
			controller: 'optionsCtrl'
		}).when('/group/:gid/search/:sContent',{
			templateUrl: path+'/tpl/search.html',
			controller: 'searchCtrl'
		}).when('/group/:gid',{
			templateUrl: path+'/tpl/group.html',
			controller: 'groupCtrl'
		}).when('/group/:gid/note/create',{
			templateUrl: path+'/tpl/create-note.html',
			controller: 'noteCtrl'
		}).when('/group/:gid/folder/:fid/note/create',{
			templateUrl: path+'/tpl/create-note.html',
			controller: 'noteCtrl'
		}).when('/group/:gid/folder/:fid/note/:nid',{
			templateUrl: path+'/tpl/edit-note.html',
			controller: 'noteCtrl'
		}).when('/group/:gid/note/:nid',{
			templateUrl: path+'/tpl/edit-note.html',
			controller: 'noteCtrl'
		}).when('/group/:gid/folder/:fid',{
			templateUrl: path+'/tpl/folder.html',
			controller: 'groupCtrl'
		}).otherwise({redirectTo:'/'});
		$locationProvider.html5Mode(true);//启动html5模式
	}]);