var noteCtrls = angular.module('noteCtrls', []);
//加载控制器
noteCtrls.controller('mainCtrl', ['$scope','$location','$rootScope','$routeParams','$http',function($scope,$location,$rootScope,$routeParams,$http){
		
		//搜索输入值模型	
		//$rootScope.sContent='';
		//允许创建文件列表
		$rootScope.createItemList=[];
		$rootScope.openGroupId='';
		$rootScope.direct=false;
		//方法区域
		$scope.getTime=function(){
		var date=new Date();
		return date.toLocaleDateString();
		};
		//创建群组方法
		$scope.createGroup=function(){
		$('#group-c').modal();
		};
		//创建文件方法
		$scope.createFile=function(type){
			console.log('创建文件'+type);
		};
		//返回上一个页面方法
		$scope.restore=function(){
			var urlList=location.pathname.split('/');
			urlList.pop();
			urlList.pop();
			$location.path(urlList.join('/'));
			//$location.path(document.referrer);
		}
		//群组成员、设置路由跳转方法
		$rootScope.forward=function(url){
			$location.path('/group/'+$rootScope.openGroupId+url);
		}
		//打开群组方法
		$scope.forwardGroup=function(gid){
			$location.path('/group/'+gid);
		};
		//搜索框回车事件
		$scope.enter = function(e) {
			if (e.keyCode == 13)
			{
				console.log($rootScope.sContent);
				//$location.path('/group/'+$rootScope.openGroupId);
				//$location.path('/group/'+$rootScope.openGroupId+'/search/'+$rootScope.sContent);
				//$rootScope.forward('/search/'+$rootScope.sContent);
			}
		}
		//comet方法
		$rootScope.cometMsg=function(){
			$http({
		    url: '/api/msg',
		    params:null,
			}).success(function(re){
				if(re.status==1){
					$('#icon-msg img').attr('src','/public/imgs/icon-msg-new.png');
		        	console.log('有'+re.num+'条新的群消息');
		        	$("[data-toggle='tooltip']").tooltip();
				}
		        else
		        	$rootScope.cometMsg();
			}).error(function(){
    			//出错重新进行请求
    			$rootScope.cometMsg();
    		});
		}

		//初始化加载数据方法
		$scope.load=function(){
			$rootScope.sContent='';
			$http.get('/api/info')
    		.success(function(re) {
    			//开始群消息轮询接口
    			$rootScope.cometMsg();
    			$rootScope.createItemList = re.cfl;
    			//console.log($rootScope.createItemList);
    			$rootScope.unableDownloadList = re.ud;
    			$rootScope.groupList= re.gl;
    			$rootScope.personInfo= re.pi;
    			if(location.href.substring(7,location.href.length)!=document.domain+'/')
    				$location.path(get_url_relative_path());
    			else{
    				$rootScope.openGroupId=$rootScope.groupList[0]['group_id'];
    				$location.path('/group/'+$rootScope.groupList[0]['group_id']);
    			}
    		});
		}
		//获取群消息方法
		$rootScope.readMsg=function(){
			//弹出框
			$('#read-msg').modal('toggle');
			return ;
			//http查看数据
			$http({
		    url: '/api/getMsg',
		    params:null,
			}).success(function(re){
				if(re.status==1){
					$('#icon-msg img').attr('src','/public/imgs/icon-msg.png');
					$("[data-toggle='tooltip']").tooltip('hide');
		        	console.log('re');
				}
			});
			$rootScope.longPolling();
		}
		//方法区域End
	}]);
//公共控制器
noteCtrls.controller('publicCtrl',['$scope','$location',function($scope,$location){
	//属性区域
	//搜索输入值模型
	//$scope.sContent='';
	//$scope.createItemList=[{name:'文件夹',type:'folder'},{name:'笔记',type:'note'},{name:'Markdown',type:'mark'}];
	//属性区域End
	//方法区域
	//方法区域End
}]);
//搜索版块控制器
noteCtrls.controller('searchCtrl',['$scope','$rootScope','$routeParams',function($scope,$rootScope,$routeParams){
	$rootScope.openGroupId=$routeParams.gid;
	$scope.sContent=$routeParams.sContent;
	$scope.sFinished=false;
	//执行搜索
	//sleep(5000);
	//搜索完毕
	$scope.sFinished=true;
}]);
//设置成员管理版块控制器
noteCtrls.controller('membersCtrl', ['$scope','$rootScope','$http','$location','$routeParams', function($scope,$rootScope,$http,$location,$routeParams){
	$scope.members='Angular';
	$scope.option='Hello';
	$rootScope.openGroupId=$routeParams.gid;
	}]);
//设置群组管理版块控制器
noteCtrls.controller('optionsCtrl', ['$scope','$rootScope','$http','$location','$routeParams', function($scope,$rootScope,$http,$location,$routeParams){
	$scope.members='Angular';
	$scope.option='Hello';
	$rootScope.openGroupId=$routeParams.gid;
	}]);
//群组控制器
noteCtrls.controller('groupCtrl',['$scope','$rootScope','$http','$location','$routeParams',function($scope,$rootScope,$http,$location,$routeParams){
	
	$scope.expanded=true;
	$scope.stared=false;
	$scope.shared=false;
	$scope.trashed=false;
	$scope.openFolderId=1111;
	$scope.type='folder';
	$scope.text='text';
	//comet获取群通知
	$rootScope.cometNoti=function(){
		console.log(1);
		$http({
			method:'GET',
			url:'api/notification/'+$routeParams.gid
		}).success(function(re){
			if(re.ni['group_id']==$rootScope.openGroupId){
				/*for(i in $scope.notiList){
					if($scope.notiList[i]['id']==re.ni['id'])
						break;
					else
						if(i==$scope.notiList.length-1)
							$scope.notiList.push(re.ni);
				}*/
				/*$scope.notiList.forEach(function(v,k,arr){
					if(v==re.ni['id'])
						break;
					else
						if(k==arr.length-1)
							$scope.notiList.push(re.ni);
				});*/
				$scope.notiList.forEach(function(value, index, array){
					if(value==re.ni['id'])
						return;
					else
						if(index==array.length-1)
							$scope.notiList.push(re.ni);
				});
			}
			else
			{
				//把group_id和num取出来，存进gnl中
				
			}
			console.log(re.nl);
			$rootScope.cometNoti();
		}).error(function(){
			$rootScope.cometNoti();
		});
	}
	//点击群组时刷新群组数据
	$scope.$on('$routeChangeSuccess', function (){
		$scope.loading=true;
	    $rootScope.openGroupId=$routeParams.gid;
	    //查询该群组ID的文件和通知数据
	    $http({
                method: 'GET',
                url: '/api/group',
                params: {'gid':$rootScope.openGroupId}
            }).success(function(re){
            	//console.log(re);
            	$rootScope.groupInfo=re.gi;
            	$rootScope.groupMember=re.mi;
            	var size=0;
            	for(i in re.fl){
            		size=re.fl[i]['size'];
            		if(size<=1024)
            			re.fl[i]['size']=(size/1).toFixed(2)+'B';
            		else if(size>1024&&size<=1024*1024)
            			re.fl[i]['size']=(size/1024).toFixed(2)+'KB';
            		else if(size>1024*1024&&size<1024*1024*1024)
            			re.fl[i]['size']=(size/1024/1024).toFixed(2)+'MB';
            		else
            			re.fl[i]['size']=(size/1024/1024/1024).toFixed(2)+'GB';
            	}
            	$scope.fileList=re.fl;
            	for(i in re.ml){
            		switch(re.ml[i]['type']){
            			case 'upload': 
            				re.ml[i]['type']='上传了文件';
            				break;
            			case 'create': 
            				re.ml[i]['type']='创建了文件';
            				break;
            			case 'modify': 
            				re.ml[i]['type']='修改了文件';
            				break;
            			case 'send': 
            				re.ml[i]['type']='';
            				break;
            			case 'delete': 
            				re.ml[i]['type']='删除了文件';
            				break;
            			case 'new': 
            				re.ml[i]['type']='创建了群组';
            				break;
            			default :
            				break;
            		}
            	}
            	$scope.notiList=re.ml;
            	$scope.loading=false;
            	$rootScope.cometNoti();
            }).error(function(){
            	location.href="";
            });
	});
	//ng-repeat之后执行的方法
	$scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) {
          //下面是在table render完成后执行的js
          $('.table').DataTable({
			"bAutoWidth":true,
            "autoWidth": true,
            /*"columns": [
                {"width": "40%"},
                {"width": "15%"},
                {"width": "20%"},
                {"width": "15%"},
                {"width": "10%"},
            ],*/
            /*"columnDefs": [{
                "orderable": false,
                "targets": [0,2]
            }],*/
            /*"aoColumnDefs": [
			  { "sWidth": "35%", "aTargets": [0]},
			  { "sWidth": "18%", "aTargets": [1]},
			  { "sWidth": "22%", "aTargets": [2]},
			  { "sWidth": "15%", "aTargets": [3]},
			  { "sWidth": "10%", "aTargets": [4]}, 
			  ],*/
            /*"aaSorting": [[2, 'dsc']],*/
            "aaSorting": [[ 2, "desc" ]] , 
            "bPaginate": false,
            "bLengthChange": false,
            "bInfo": false,
            "bFilter":false,
            "sScrollY": $('.main-left').height()-60-53-34,
            //"bScrollInfinite" : false,
           // "bScrollAutoCss": false
        	});
			$('.table').width('100%');
			$('.dataTables_scrollHeadInner').width('100%');
			$('.dataTables_scrollHead').width('100%');
			$('.dataTables_scrollBody').width('100%');
			$('table').width('100%').css('margin-bottom','0px');
			$('table th').each(function(index){
				/*if(index==0)
					$(this).width('19.5%');
				else if(index==1)
					$(this).width('1%');
				else if(index==2)
					$(this).width('6%');
				else if(index==3)
					$(this).width('-2%');
				else
					$(this).width('-3.5%');*/
				if(index==0)
					$(this).width('20.5%');
			});
	});
	//判断文件是否可下载
	$scope.enableDownload=function(file){
		if(in_array(file.type,$rootScope.unableDownloadList))
			return false;
		return true;
	}
	//下载文件方法
	$scope.download=function(){
		downloadFrame=$('#download-frame');
        if(downloadFrame.length==0)
        {
            var downloadFrame=$('<iframe id="download-frame">');
            downloadFrame.css('display','none');
            $('body').append(downloadFrame);      
        }
        downloadFrame.attr('src','/api/download/170800');
        /*if($('#download-frame').length==0)
        {
        	var myframe=$('<iframe id="download-frame">');
        	myframe.attr('src','/api/download/170800');
       		myframe.css('display','none');
        	$('body').append(myframe);
        }
        else
        {	
        	var myframe=$('<iframe id="download-frame">');
        	myframe.attr('src','/api/download/170800');
        }*/
	}
	//group方法在页面生成时判断用户是否为该群组内用户
	/*$scope.load=function(){
		$http.get('/api/info')
		.success(function(re) {
			$rootScope.createItemList = re.cfl;
			$rootScope.groupList= re.gl;
			console.log($rootScope.groupList);
		});*/
}])