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
		//复制分享链接方法
		$scope.copyLink=function(){
			$('#input-link')[0].select(); //选择对象 
			document.execCommand("Copy");
			$('#btn-copy').html('复制成功').attr('class','btn btn-default').attr('disabled',true);
			/*setCopy($('#input-link').val());*/
		}
		//打开群组方法
		$scope.forwardGroup=function(group){
			$rootScope.openGroupName=group.name;
			if($rootScope.openGroupId==group.group_id)
			{
				$scope.$broadcast('$routeChangeSuccess');
			}
			else
				$location.path('/group/'+group.group_id);
		};
		//搜索框回车事件
		$scope.enter = function(e) {
			//console.log(e);
			if (e.charCode == 13)
			{
				console.log($scope.sContent);
				//$location.path('/group/'+$rootScope.openGroupId);
				//$location.path('/group/'+$rootScope.openGroupId+'/search/'+$rootScope.sContent);
				//$rootScope.forward('/search/'+$rootScope.sContent);
			}
		}
			//comet获取群通知
	$rootScope.cometNoti=function(){
		/*$http({
			method:'POST',
			url:'api/notification',
			data: {'rl':$rootScope.readedList}
			//params: {'rl':$rootScope.readedList}
		}).success(function(re){
			console.log(re.nl);
			$rootScope.groupList.forEach(function(value,index,array){
				for(i in re.nl){
					if(re.nl[i]['group_id']==value['group_id'])
						$rootScope.groupList[index]['num']=re.nl[i]['num'];
				}
			});
			re.nl.forEach(function(value,index,array){
				if(!in_array(value['group_id'],$rootScope.readedList))
					$rootScope.readedList.push(value['group_id']);
			});
			$rootScope.cometNoti();
		}).error(function(){
			$rootScope.cometNoti();
		});*/
		$.ajax({
			method:'POST',
			url:'api/notification',
			data: {'rl':$rootScope.readedList,'oi':$rootScope.openGroupId},
			success:function(re){
				//console.log(re.nl);
				//console.log(re);
				if(re.ni!==null)
				{
					//console.log('re.ni存在');
					if(re.ni.length!=0)
					{
						//console.log('re.ni长度不等于0');
						if(re.ni[0].group_id==$rootScope.openGroupId)
						{
							/*console.log('re.ni属于当前群组');
							console.log('打印出通知列表');
							console.log($rootScope.notiList);*/
							$rootScope.notiList=$rootScope.notiList.concat(re.ni);
							/*console.log('打印出连接后的通知列表');
							console.log($rootScope.notiList);*/
							//$rootScope.$apply();
						}
						else
						{
							tmp={'group_id':re.ni[0].group_id,'num':re.ni.length};
							re.nl.push(tmp);
						}
					}
				}
				$rootScope.groupList.forEach(function(value,index,array){
					for(i in re.nl){
						if(re.nl[i]['group_id']==value['group_id'])
							$rootScope.groupList[index]['num']=re.nl[i]['num'];
					}
				});
				$rootScope.$apply();
				//console.log($rootScope.groupList);
				re.nl.forEach(function(value,index,array){
					if(!in_array(value['group_id'],$rootScope.readedList))
						$rootScope.readedList.push(value['group_id']);
				});
				$rootScope.cometNoti();
			},
			error: function(re){
				$rootScope.cometNoti();
			}
			//params: {'rl':$rootScope.readedList}
		});
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
			//$rootScope.sContent='';
			$.post('/api/info')
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
    				$rootScope.openGroupName=$rootScope.groupList[0]['name'];
    				$rootScope.openGroupId=$rootScope.groupList[0]['group_id'];
    				$location.path('/group/'+$rootScope.groupList[0]['group_id']);
    			}
    			$rootScope.cometNoti();
    			/*Array.prototype.indexOf = function(val) {              
				    for (var i = 0; i < this.length; i++) {  
				        if (this[i] == val) return i;  
				    }  
				    return -1;  
				};  
				Array.prototype.remove = function(val) {
				    var index = this.indexOf(val);  
				    if (index > -1) {  
				        this.splice(index, 1);  
				    }  
				};*/
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
	$rootScope.readedList=[];
	//创建文件or文件夹
	$scope.createFile=function(type){
		switch(type)
		{
			case 'folder':
				newFolder=$('<tr hover="true"><td><div class="cursor-p f-l m-r-8 folder"></div><input style="width:300px" value="新建文件夹"></td></tr>');
				$('tbody').prepend(newFolder);
				newFolder.find('input')[0].select();
				newFolder.find('input').keyup(function(e){
	            	if(e.which==13)
	            	{
	            		newName=$(this).val();
	            		$http({
	            			type:'get',
	            			url: 'api/newFolder',
	            			params:{name:newName,belong:$rootScope.belong,gid:$rootScope.openGroupId}
	            		}).success(function(re){
	            			if(re.status==1)
	            			{
	            				$rootScope.fileList.unshift(re.file);
	            				$('.alert-success').html('创建成功！');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('创建失败！');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('创建失败！');
							$('.alert-success').fadeIn().fadeOut(2000);
	            		});
	            		//parent=$(this).parent();
	            		newFolder.remove();
	            		//parent.find('.file-name').show();
	            	}
	            });
				newFolder.find('input').blur(function(e){
            		newName=$(this).val();
            		$http({
            			type:'get',
            			url: 'api/newFolder',
            			params:{name:newName,belong:$rootScope.belong,gid:$rootScope.openGroupId}
            		}).success(function(re){
            			if(re.status==1)
            			{
            				$rootScope.fileList.unshift(re.file);
            				$('.alert-success').html('创建成功！');
							$('.alert-success').fadeIn().fadeOut(2000);
            			}
            			else
            			{
            				$('.alert-success').html('创建失败！');
							$('.alert-success').fadeIn().fadeOut(2000);
            			}
            		}).error(function(){
            			$('.alert-success').html('创建失败！');
						$('.alert-success').fadeIn().fadeOut(2000);
            		});
            		//parent=$(this).parent();
            		newFolder.remove();
            		//parent.find('.file-name').show();
	            });
				break;
			case 'md':
				console.log('创建Markdown');
				break;
			case 'note':
				console.log('创建note');
				break;
			case 'table':
				console.log('创建table');
				break;
			default :
				break;
		}
	};
	//单个文件右键菜单项
	$scope.dropMenuData = [
	    [{
	        text: "历史版本",
	        func: function() {
	            console.log($scope.selectedFile);
	            //console.log($(this)[0]);
	            ///$(this).css("padding", "10px");
	        }
	    }, {
	        text: "重命名",
	        func: function() {
	            $(this).find('.file-name').hide();
	            inputField=$('<input rename style="width:300px" value="'+$scope.selectedFile[0]['name']+'">');
	            $(this).find('td div:first').after(inputField);
	            inputField[0].select();
	            inputField.keyup(function(e){
	            	if(e.which==13)
	            	{
	            		newName=inputField.val();
	            		//console.log(newName);
	            		oldName=$scope.selectedFile[0]['name'];
	            		$scope.selectedFile[0]['name']=newName;
	            		$http({
	            			type:'get',
	            			url: 'api/rename',
	            			params:{fid:$scope.selectedFile[0]['fid'],name:newName}
	            		}).success(function(re){
	            			if(re.status==1)
	            			{			
	            				$('.alert-success').html('重命名成功！');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('重命名失败！');
								$('.alert-success').fadeIn().fadeOut(2000);
								$scope.selectedFile[0]['name']=oldName;
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('重命名失败！');
							$('.alert-success').fadeIn().fadeOut(2000);
							$scope.selectedFile[0]['name']=oldName;
	            		});
	            		parent=$(this).parent();
	            		$(this).remove();
	            		parent.find('.file-name').show();
	            	}
	            });
	            inputField.blur(function(e){
	            		newName=inputField.val();
	            		oldName=$scope.selectedFile[0]['name'];
	            		$scope.selectedFile[0]['name']=newName;
	            		$http({
	            			type:'get',
	            			url: 'api/rename',
	            			params:{fid:$scope.selectedFile[0]['fid'],name:newName}
	            		}).success(function(re){
	            			if(re.status==1)
	            			{			
	            				$('.alert-success').html('重命名成功！');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('重命名失败！');
								$('.alert-success').fadeIn().fadeOut(2000);
								$scope.selectedFile[0]['name']=oldName;
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('重命名失败！');
							$('.alert-success').fadeIn().fadeOut(2000);
							$scope.selectedFile[0]['name']=oldName;
	            		});        	
	            		parent=$(this).parent();
	            		$(this).remove();
	            		parent.find('.file-name').show();
	            });
	            $scope.$apply();
	        }
	     ,
	    }, {
	        text: "删除",
	        func: function() {
	            //$(this).css("background-color", "#beceeb");
	        }
	     ,
	    }, {
	        text: "下载到本地",
	        func: function() {
	        	if($scope.enableDownload($scope.selectedFile[0]))
	            	$scope.download($scope.selectedFile[0]);
	        }
	     ,
	    }, {
	        text: "分享",
	        func: function() {
	            $scope.share($scope.selectedFile[0]);
	        }
	     ,
	    },],
	];
	$scope.dropMenuDataNoShare = [
	    [{
	        text: "历史版本",
	        func: function() {
	            console.log($scope.selectedFile);
	            //console.log($(this)[0]);
	            ///$(this).css("padding", "10px");
	        }
	    }, {
	        text: "重命名",
	        func: function() {
	            $(this).find('.file-name').hide();
	            inputField=$('<input rename style="width:300px" value="'+$scope.selectedFile[0]['name']+'">');
	            $(this).find('td div:first').after(inputField);
	            inputField[0].select();
	            inputField.keyup(function(e){
	            	if(e.which==13)
	            	{
	            		newName=inputField.val();
	            		//console.log(newName);
	            		oldName=$scope.selectedFile[0]['name'];
	            		$scope.selectedFile[0]['name']=newName;
	            		$http({
	            			type:'get',
	            			url: 'api/rename',
	            			params:{fid:$scope.selectedFile[0]['fid'],name:newName}
	            		}).success(function(re){
	            			if(re.status==1)
	            			{			
	            				$('.alert-success').html('重命名成功！');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('重命名失败！');
								$('.alert-success').fadeIn().fadeOut(2000);
								$scope.selectedFile[0]['name']=oldName;
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('重命名失败！');
							$('.alert-success').fadeIn().fadeOut(2000);
							$scope.selectedFile[0]['name']=oldName;
	            		});
	            		parent=$(this).parent();
	            		$(this).remove();
	            		parent.find('.file-name').show();
	            	}
	            });
	            inputField.blur(function(e){
	            		newName=inputField.val();
	            		oldName=$scope.selectedFile[0]['name'];
	            		$scope.selectedFile[0]['name']=newName;
	            		$http({
	            			type:'get',
	            			url: 'api/rename',
	            			params:{fid:$scope.selectedFile[0]['fid'],name:newName}
	            		}).success(function(re){
	            			if(re.status==1)
	            			{			
	            				$('.alert-success').html('重命名成功！');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('重命名失败！');
								$('.alert-success').fadeIn().fadeOut(2000);
								$scope.selectedFile[0]['name']=oldName;
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('重命名失败！');
							$('.alert-success').fadeIn().fadeOut(2000);
							$scope.selectedFile[0]['name']=oldName;
	            		});        	
	            		parent=$(this).parent();
	            		$(this).remove();
	            		parent.find('.file-name').show();
	            });
	            $scope.$apply();
	        }
	     ,
	    }, {
	        text: "删除",
	        func: function() {
	            //$(this).css("background-color", "#beceeb");
	        }
	     ,
	    }, {
	        text: "下载到本地",
	        func: function() {
	        	if($scope.enableDownload($scope.selectedFile[0]))
	            	$scope.download($scope.selectedFile[0]);
	        }
	     ,
	    }, {
	        text: "取消分享",
	        func: function() {
	            $scope.unshare($scope.selectedFile[0]);
	        }
	     ,
	    }, ],
	];
	//多个右键菜单值
	$scope.dropMulMenuData = [
	    [{
	        text: "删除",
	        func: function() {
	            //$(this).css("background-color", "#beceeb");
	        }
	     ,
	    },{
	        text: "下载到本地",
	        func: function() {
	        	enableDownloadList=[];
	            $scope.selectedFile.forEach(function(value,index,array){
	            	if($scope.enableDownload(value))
	            		enableDownloadList.push(value);
	            });
	            $scope.mulDownload(enableDownloadList);
	        }
	     ,
	    }],
	    /*[{
	        text: "删除",
	        func: function() {
	            var src = $(this).attr("src");
	            window.open(src.replace("/s512", ""));    
	        }
	    }]*/
	];
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
            	//当前目录
            	$rootScope.belong='/';
            	$rootScope.groupList.forEach(function(value,index,array){
            		if(value['group_id']==$rootScope.openGroupId)
            			$rootScope.groupList[index]['num']=null;
            	});
            	$rootScope.groupInfo=re.gi;
            	$rootScope.openGroupName=re.gi[0]['name'];
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
            	$rootScope.fileList=re.fl;
            	//$rootScope.$apply();
            	/*for(i in re.ml){
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
            	}*/
            	$rootScope.notiList=re.ml;
            	$scope.loading=false;
            	//$scope.$apply();
            	//获取该群组数据完毕后设置该gid为未读
            	$rootScope.readedList.forEach(function(value,index,array){
            		if(value==$rootScope.openGroupId)
            			$rootScope.readedList.splice(index,1);
            	});
				//$rootScope.readedList.remove($rootScope.openGroupId);
            }).error(function(){
            	location.href="";
            });
	});
	//鼠标任何点击事件产生选择的file
	$scope.select=function(file){
		//console.log(keyCode);
		//console.log(event.which);
		if(event.which==1||event.which==2)
		{
			if(typeof keyCode!=='undefined')
			{
				if(keyCode==17)
					$scope.selectedFile.push(file);
				else
				{
					$scope.selectedFile=[];
					$scope.selectedFile.push(file);
				}
			}
		}
		else if(event.which==3)
		{
			if(typeof $scope.selectedFile=='undefined'||$scope.selectedFile.length==1)
			{
				$scope.selectedFile=[];
				$scope.selectedFile.push(file);
				if(file.share=='1')
					$('tbody tr').smartMenu($scope.dropMenuDataNoShare, {
			    		name: "dropShare"    
					});
				else
					$('tbody tr').smartMenu($scope.dropMenuData, {
			    		name: "drop"    
					});
			}
			else{
				$('tbody tr').smartMenu($scope.dropMulMenuData, {
			    	name: "mulDrop"    
				});				
			}
		}
		//console.log($scope.selectedFile);
		//$scope.selectedFile=file;
	}
	//检查当前file是否为选择的file
	$scope.isSelected=function(file){
		//console.log($scope.selectedFile);
		if(typeof $scope.selectedFile !== 'undefined')
		{
/*			if($scope.selectedFile.length==='undefined')
			{
				if($scope.selectedFile.fid==file.fid)
					return true;
				return false;
			}*/
			/*$scope.selectedFile.forEach(function(value,index,array){
				if(value.fid==file.fid)
				{
					//console.log(1);
					return true;
				}
			});
			return false;*/
			//if($scope.selectedFile.fid==file.fid)
			//	return true;
			//return false;
			for(i in $scope.selectedFile)
			{
				if($scope.selectedFile[i].fid==file.fid)
					return true;
			}
			return false;
		}
	}
	//打开文件或者文件夹方法
	$scope.oepnOrForward=function(file){
		console.log(file);
		delete $scope.selectedFile;
	}
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

			//右键菜单初始化			
			$('tbody tr').smartMenu($scope.dropMenuData, {
			    name: "drop"    
			});
	});
	//判断文件是否可下载
	$scope.enableDownload=function(file){
		if(in_array(file.type,$rootScope.unableDownloadList))
			return false;
		return true;
	}
	//单个文件下载方法
	$scope.download=function(file){
		downloadFrame=$('#download-frame');
        if(downloadFrame.length==0)
        {
            var downloadFrame=$('<iframe id="download-frame">');
            downloadFrame.css('display','none');
            $('body').append(downloadFrame);      
        }
        downloadFrame.attr('src','/api/download/'+file.fid);
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
	//多个文件下载方法
	$scope.mulDownload=function(fileList){
		downloadFrame=$('#download-frame');
        if(downloadFrame.length==0)
        {
            var downloadFrame=$('<iframe id="download-frame">');
            downloadFrame.css('display','none');
            $('body').append(downloadFrame);      
        }
        fid='';
        for(i in fileList)
        {
        	if(i==fileList.length-1)
        		fid+=fileList[i].fid;
        	else
        		fid+=fileList[i].fid+'|';
        }
        downloadFrame.attr('src','/api/mulDownload?fid='+fid);
	}
	//分享文件方法
	$scope.share=function(file){
		$http({
			url:'api/share',
			type:'GET',
			params: {fid:file.fid}
		}).success(function(re){
			if(re.status==1){
				file.share='1';
				$('#btn-copy').html('复制链接').attr('class','btn btn-primary').attr('disabled',false);
				$('#share-link input[type=text]').val(re.link);
				$('#share-link').modal();
			}
			else{
				$('.alert-success').html('链接生成失败！');
				$('.alert-success').fadeIn().fadeOut(2000);
			}
		}).error(function(re){
			$('.alert-success').html('链接生成失败！');
			$('.alert-success').fadeIn().fadeOut(2000);
		});
	}
	//取消分享文件方法
	$scope.unshare=function(file){
		console.log(file);
		$http({
			url:'api/unshare',
			type:'GET',
			params: {fid:file.fid}
		}).success(function(re){
			if(re.status==1){
				file.share='0';
				$('.alert-success').html('取消分享成功！');
				$('.alert-success').fadeIn().fadeOut(2000);
			}
			else{
				$('.alert-success').html('取消分享失败！');
				$('.alert-success').fadeIn().fadeOut(2000);
			}
		}).error(function(re){
			$('.alert-success').html('取消分享失败！');
			$('.alert-success').fadeIn().fadeOut(2000);
		});
	}
	
	//加星文件方法
	$scope.star=function(file){
		//console.log(file);
		//console.log($scope.fileList);
		/*$scope.fileList.forEach(function(value,index,array){
			if(file.fid==value.fid){
				console.log(file.star=='0');
				if(file.star=='1')
					$scope.fileList[index]['star']='0';
				else
					$scope.fileList[index]['star']='1';
			}
		});*/
		if(file.star=='1')
			file.star='0';
		else
			file.star='1';
		//console.log(file.star=='0');
		if(file.star=='1')
		{
			$http({
				type:'GET',
				url:'/api/addStar/'+file.fid
			}).success(function(re){
				if(re.status==1){
					$('.alert-success').html('添加星标成功！');
					$('.alert-success').fadeIn().fadeOut(2000);
				}
				else{
					$('.alert-success').html('操作失败！');
					$('.alert-success').fadeIn().fadeOut(2000);
					file.star='0';
				}
			}).error(function(re){
				$('.alert-success').html('操作失败！');
				$('.alert-success').fadeIn().fadeOut(2000);
				file.star='0';
			});
		}
		else{
			$http({
				type:'GET',
				url:'/api/delStar/'+file.fid
			}).success(function(re){
				if(re.status==1){
					$('.alert-success').html('取消星标成功！');
					$('.alert-success').fadeIn().fadeOut(2000);
				}
				else{
					$('.alert-success').html('操作失败！');
					$('.alert-success').fadeIn().fadeOut(2000);
					file.star='1';
				}
			}).error(function(re){
				$('.alert-success').html('操作失败！');
				$('.alert-success').fadeIn().fadeOut(2000);
				file.star='1';
			});
		}
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