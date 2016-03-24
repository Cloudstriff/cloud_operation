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
		}).when('/group/:gid/detail/:nid',{
			templateUrl: path+'/tpl/detail.html',
			controller: 'detailCtrl'
		}).when('/group/:gid/folder/:fid/detail/:nid',{
			templateUrl: path+'/tpl/detail.html',
			controller: 'detailCtrl'
		}).when('/group/:gid/text/:nid',{
			templateUrl: path+'/tpl/text.html',
			controller: 'textCtrl'
		}).when('/group/:gid/folder/:fid/text/:nid',{
			templateUrl: path+'/tpl/text.html',
			controller: 'textCtrl'
		}).when('/group/:gid/md/create',{
			templateUrl: path+'/tpl/create-md.html',
			controller: 'mdCtrl'
		}).when('/group/:gid/folder/:fid/md/create',{
			templateUrl: path+'/tpl/create-md.html',
			controller: 'mdCtrl'
		}).when('/group/:gid/md/:nid',{
			templateUrl: path+'/tpl/preview-md.html',
			controller: 'mdCtrl'
		}).when('/group/:gid/folder/:fid/md/:nid',{
			templateUrl: path+'/tpl/preview-md.html',
			controller: 'mdCtrl'
		}).otherwise({redirectTo:'/'});
		$locationProvider.html5Mode(true);//启动html5模式
	}]);
noteApp.value('groupList',{});