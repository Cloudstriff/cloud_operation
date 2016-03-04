var noteServices = angular.module('noteServices', []);
//提供http请求服务
noteServices.factory('publicService', ['$http','$scope',
    function($http,$scope) {
        /*var doRequest = function(method,url,data,params) {
            return $http({
                method: method,
                url: url,
                params: params,
                data: data,
            });
        }*/
        var doRequest = function() {
        	if (!arguments[0]) {
		　　     return false;
		　　}
		　　var oArgs   = arguments[0]
		　　arg0    = oArgs.arg0 || "",
		　　arg1    = oArgs.arg1 || "",
		　　arg2    = oArgs.arg2 || 0,
		　　arg3    = oArgs.arg3 || [],
		　　arg4    = oArgs.arg4 || false;
            return $http({
                method: oArgs.method || "",
                url: oArgs.url || "",
                params: oArgs.params || "",
                data: oArgs.data || "",
            });
        }
        return {
        	//获取除用户信息、用户群组及组员信息外的当前群组所有数据服务，包括：各群组通知列表数据，各群组文件/文件夹列表数据
            // 接口url:api/group------该接口可接受群组ID参数，也可不用参数，eg:api/group  or  api/group?gid=172882
            getInfo: function() {
                return doRequest({method:'get',url:'/api/info'});
            }
        };
    }
]);
noteServices.factory('Data', ['$http', function($http){
	if(Data==null)
    {
        $http.get('api/info')
        .success(function(re){
            Data=re;
        })
    }
    return Data;
}])