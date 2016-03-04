var noteFilters = angular.module('noteFilters', []);
//搜索输入值转换格式过滤器，转换为url可识别字符
noteFilters.filter('s_c_tf', ['$scope', function($scope){
	return function(input){
                    return decodeURI(input)
                   // return out;
                }
}]);