var noteCtrls = angular.module('noteCtrls', []);
//���ؿ�����
noteCtrls.controller('mainCtrl', ['$scope','$location','$rootScope','$routeParams','$http','groupList',function($scope,$location,$rootScope,$routeParams,$http,groupList){
		
		//��������ֵģ��	
		//$rootScope.sContent='';
		//�������ļ��б�
		$rootScope.createItemList=[];
		$rootScope.openGroupId='';
		$rootScope.direct=false;
		//��������
		$scope.getTime=function(){
		var date=new Date();
		return date.toLocaleDateString();
		};
		//����Ⱥ�鷽��
		$scope.createGroup=function(){
		$('#group-c').modal();
		};
		//������һ��ҳ�淽��
		$rootScope.restore=function(){
			var urlList=location.pathname.split('/');
			urlList.pop();
			urlList.pop();
			$location.path(urlList.join('/'));
			//$location.path(document.referrer);
		}
		//Ⱥ���Ա������·����ת����
		$rootScope.forward=function(url){
			$location.path('/group/'+$rootScope.openGroupId+url);
		}
		$rootScope.forwardTo=function(url){
			$location.path($location.path()+url);
		}
		//���Ʒ������ӷ���
		$scope.copyLink=function(){
			$('#input-link')[0].select(); //ѡ����� 
			document.execCommand("Copy");
			$('#btn-copy').html('���Ƴɹ�').attr('class','btn btn-default').attr('disabled',true);
			/*setCopy($('#input-link').val());*/
		}
		//��Ⱥ�鷽��
		$scope.forwardGroup=function(group){
			$rootScope.openGroupName=group.name;
			if($rootScope.openGroupId==group.group_id)
			{
				$location.path('/group/'+group.group_id);
				//$scope.$broadcast('$routeChangeSuccess');
			}
			else
				$location.path('/group/'+group.group_id);
		};
		//������س��¼�
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
			//comet��ȡȺ֪ͨ
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
				//console.log(re.ni);
				if(re.ni!==null)
				{
					//console.log('re.ni����');
					if(re.ni.notiItem.length!=0)
					{
						//console.log('re.ni���Ȳ�����0');
						if(re.ni.notiItem[0].group_id==$rootScope.openGroupId)
						{
							/*console.log('re.ni���ڵ�ǰȺ��');
							console.log('��ӡ��֪ͨ�б�');
							console.log($rootScope.notiList);*/
							for(i in re.ni.notiItem)
							{
								if(re.ni.notiItem[i]['type']=='create'&&re.ni.notiItem[i]['file_type']=='folder')
									re.ni.notiItem[i]['type']='create-f';
							}
							if($rootScope.notiList!=null)
								$rootScope.notiList=$rootScope.notiList.concat(re.ni.notiItem);
							else
								$rootScope.notiList=re.ni.notiItem;
							//������滻�ļ���
							if(re.ni.fileList!=null && typeof re.ni.fileList.length=='undefined')
							{
								//console.log($rootScope.fileList);
								if($rootScope.fileList!=null && typeof $rootScope.fileList.length!='undefined' && $rootScope.fileList.length>=1)
								{
									//console.log('�������ѭ��');
									for(i in $rootScope.fileList)
									{
										if($rootScope.fileList[i].fid==re.ni.fileList.fid)
										{
											//�������ͬfid����state=0���ʾ��ɾ���ļ�
											if(typeof re.ni.fileList.state!='undefined' && re.ni.fileList.state==0)
												$rootScope.fileList.splice(i,1);
											else
												$rootScope.fileList[i]=re.ni.fileList;
											break;
										}
										else if(i==$rootScope.fileList.length-1)
											$rootScope.fileList.unshift(re.ni.fileList);
									}
								}
								else
								{
									//console.log('����ѭ��2');
									$rootScope.fileList=[];
									$rootScope.fileList.push(re.ni.fileList);
								}
								//$rootScope.fileList.unshift(re.ni.fileList);
							}
							else if(re.ni.fileList!=null && typeof re.ni.fileList.length!='undefined')
							{
								if($rootScope.fileList!=null)
								{
									for(i in $rootScope.fileList)
									{
										for(j in re.ni.fileList)
										{
											if($rootScope.fileList[i].fid==re.ni.fileList[j].fid)
											{
												if(typeof re.ni.fileList[j].state!='undefined' && re.ni.fileList[j].state==0)
													$rootScope.fileList.splice(i,1);
												else
													$rootScope.fileList[i]=re.ni.fileList[j];
											}
											else if(j==re.ni.fileList.length-1)
												$rootScope.fileList.unshift(re.ni.fileList[j]);
										}
										
									}
								}
								else
								{
									$rootScope.fileList=[];
									$rootScope.fileList.concat(re.ni.fileList);
								}
							}
							/*console.log('��ӡ�����Ӻ��֪ͨ�б�');
							console.log($rootScope.notiList);*/
							//$rootScope.$apply();
						}
						else
						{
							tmp={'group_id':re.ni[0].group_id,'num':re.ni.notiItem.length};
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
		//comet����
		$rootScope.cometMsg=function(){
			$http({
		    url: '/api/msg',
		    params:null,
			}).success(function(re){
				if(re.status==1){
					$('#icon-msg img').attr('src','/public/imgs/icon-msg-new.png');
		        	console.log('��'+re.num+'���µ�Ⱥ��Ϣ');
		        	$("[data-toggle='tooltip']").tooltip();
				}
		        else
		        	$rootScope.cometMsg();
			}).error(function(){
    			//�������½�������
    			$rootScope.cometMsg();
    		});
		}

		//��ʼ���������ݷ���
		$scope.load=function(){
			//$rootScope.sContent='';
			$.post('/api/info')
    		.success(function(re) {
    			//��ʼȺ��Ϣ��ѯ�ӿ�
    			$rootScope.cometMsg();
    			$rootScope.createItemList = re.cfl;
    			//console.log($rootScope.createItemList);
    			$rootScope.unableDownloadList = re.ud;
    			$rootScope.groupList= re.gl;
    			groupList=re.gl;
    			$rootScope.personInfo= re.pi;
    			if(location.href.substring(7,location.href.length)!=document.domain+'/')
    				$location.path(get_url_relative_path());
    			else{
    				$rootScope.openGroupName=groupList[0]['name'];
    				$rootScope.openGroupId=groupList[0]['group_id'];
    				$location.path('/group/'+groupList[0]['group_id']);
    				/*$rootScope.openGroupName=$rootScope.groupList[0]['name'];
    				$rootScope.openGroupId=$rootScope.groupList[0]['group_id'];
    				$location.path('/group/'+$rootScope.groupList[0]['group_id']);*/
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
		//��ȡȺ��Ϣ����
		$rootScope.readMsg=function(){
			//������
			$('#read-msg').modal('toggle');
			return ;
			//http�鿴����
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
		//��������End
	}]);
//����������
noteCtrls.controller('publicCtrl',['$scope','$location',function($scope,$location){
	//��������
	//��������ֵģ��
	//$scope.sContent='';
	//$scope.createItemList=[{name:'�ļ���',type:'folder'},{name:'�ʼ�',type:'note'},{name:'Markdown',type:'mark'}];
	//��������End
	//��������
	//��������End
}]);
//������������
noteCtrls.controller('searchCtrl',['$scope','$rootScope','$routeParams',function($scope,$rootScope,$routeParams){
	$rootScope.openGroupId=$routeParams.gid;
	$scope.sContent=$routeParams.sContent;
	$scope.sFinished=false;
	//ִ������
	//sleep(5000);
	//�������
	$scope.sFinished=true;
}]);
//�ʼǰ�������
noteCtrls.controller('noteCtrl',['$scope','$rootScope','$routeParams','$http','$location',function($scope,$rootScope,$routeParams,$http,$location){
	$rootScope.openGroupId=$routeParams.gid;
	if(typeof $routeParams.fid!=='undefined'&&$routeParams.fid!=null)
		$rootScope.belong=$routeParams.fid;
	else
		$rootScope.belong=0;
	if($routeParams.nid!=null)
	{
		$scope.fid=$routeParams.nid;	
		$http({
			url: 'api/file',
			params: { fid: $scope.fid,t: 'mod'}
		}).success(function(re){
			$scope.file=re;
			$scope.setNoteContent($scope.file.content);
		}).error(function(re){

		});
	}
	//else
		//$rootScope.fid=0;
	$scope.temp={content:'',title:''};
	//�����ʼ�
	$scope.publish=function(){
		if($scope.temp.title==null)
		{
			bootbox.alert({  
	            buttons: {  
	               ok: {  
	                    label: 'ȷ��',  
	                }  
	            },  
	            message: '���������',  
	            callback: function() {  
	                $('.note-head .title input').focus();
	            },    
	        });
		}
		else
		{
			$scope.temp.content= $scope.findNoteContent();
			$http({
				url: 'api/newFile',
				method: 'POST',
				data: {content:$scope.temp.content,title:$scope.temp.title,belong:$rootScope.belong,gid:$rootScope.openGroupId,type:'note'}
			}).success(function(re){
				if(re.status==1)
					$rootScope.restore();
				else{
					bootbox.alert('����ʧ�ܣ�');
					$('.note-head').find('button[publish-btn]').width(60);
					$('.note-head').find('button[publish-btn]').html('<span class="glyphicon glyphicon-open"></span>&nbsp;����');
				}
			}).error(function(){
				bootbox.alert('����ʧ�ܣ�');
				$('.note-head').find('button[publish-btn]').width(60);
				$('.note-head').find('button[publish-btn]').html('<span class="glyphicon glyphicon-open"></span>&nbsp;����');
			});
		}
	}
	//����ʼ�
	$scope.save=function(){
		if($scope.file.name==null)
		{
			bootbox.alert({  
	            buttons: {  
	               ok: {  
	                    label: 'ȷ��',  
	                }  
	            },  
	            message: '���������',  
	            callback: function() {  
	                $('.note-head .title input').focus();
	            },    
	        });
		}
		else
		{
			$('.note-head').find('button[publish-btn]').html('<span class="glyphicon glyphicon-open"></span>&nbsp;���ڱ���');
			$scope.file.content=$scope.findNoteContent();
			$http({
				url:'api/modifyFile',
				data:$scope.file,
				method:'POST'
			}).success(function(re){
				if(re.status==1)
					$rootScope.restore();
				else if(re.status==2){
					bootbox.alert({  
			            buttons: {  
			               ok: {  
			                    label: '����',  
			                },
			               cancel: {
			               		label: 'ȡ��',
			               } 
			            },  
			            message: '��ǰ�༭�汾�����°汾��һ�£��Ƿ���µ����°汾��',  
			            callback: function() {  
			                //ִ�в�ѯ�ļ����ݲ����²���
			                console.log('ִ�в�ѯ�ļ����ݲ����²���');
			            },    
			        });
					$('.note-head').find('button[publish-btn]').width(60);
					$('.note-head').find('button[publish-btn]').html('<span class="glyphicon glyphicon-open"></span>&nbsp;����');
				}
				else{
					bootbox.alert('����ʧ�ܣ�');
					$('.note-head').find('button[publish-btn]').width(60);
					$('.note-head').find('button[publish-btn]').html('<span class="glyphicon glyphicon-open"></span>&nbsp;����');
				}
			}).error(function(){
				bootbox.alert('����ʧ�ܣ�');
				$('.note-head').find('button[publish-btn]').width(60);
				$('.note-head').find('button[publish-btn]').html('<span class="glyphicon glyphicon-open"></span>&nbsp;����');
			});
		}
	}
	$scope.findNoteContent=function(){
		var fr=document.getElementById("collab-editor");
		var win = fr.window || fr.contentWindow;
		return win.getContent();
		var frdoc=fr.contentDocument || iframe.contentWindow.document;
		var wrapper=frdoc.getElementById("wrapper");
		return $(wrapper).find('.note-view-wrapper').html();
	}
	$scope.setNoteContent=function(content){
		var fr=document.getElementById("collab-editor");
		var win = fr.window || fr.contentWindow;
		win.setContent(content);
		var frdoc=fr.contentDocument || iframe.contentWindow.document;
		var wrapper=frdoc.getElementById("wrapper");
		$(wrapper).find('.note-view').html(content);
	}
}]);
//���ó�Ա�����������
noteCtrls.controller('membersCtrl', ['$scope','$rootScope','$http','$location','$routeParams', function($scope,$rootScope,$http,$location,$routeParams){
	$scope.members='Angular';
	$scope.option='Hello';
	$rootScope.openGroupId=$routeParams.gid;
	}]);
//����Ⱥ������������
noteCtrls.controller('optionsCtrl', ['$scope','$rootScope','$http','$location','$routeParams', function($scope,$rootScope,$http,$location,$routeParams){
	$scope.members='Angular';
	$scope.option='Hello';
	$rootScope.openGroupId=$routeParams.gid;
	}]);
//Ⱥ�������
noteCtrls.controller('groupCtrl',['$scope','$rootScope','$http','$location','$routeParams',function($scope,$rootScope,$http,$location,$routeParams){
	
	$scope.expanded=true;
	$scope.stared=false;
	$scope.shared=false;
	$scope.trashed=false;
	$scope.openFolderId=1111;
	$scope.type='folder';
	$scope.text='text';
	$rootScope.readedList=[];
	//�ļ�Ŀ¼����
	$scope.back=function(){
		var forwarFolder=$rootScope.openFolder.belong;
		if(forwarFolder==0)
			$rootScope.restore();
		else
			$rootScope.forward('/folder/'+forwarFolder);
	}
	//�����ļ�or�ļ���
	$scope.createFile=function(type){
		switch(type)
		{
			case 'folder':
				newFolder=$('<tr hover="true"><td><div class="cursor-p f-l m-r-8 folder"></div><input style="width:300px" value="�½��ļ���"></td></tr>');
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
	            				//console.log($rootScope.fileList);
	            				//$rootScope.fileList.unshift(re.file);
	            				//console.log($rootScope.fileList);
	            				newFolder.remove();
	            				$('.alert-success').html('�����ɹ���');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				newFolder.remove();
	            				$('.alert-success').html('����ʧ�ܣ�');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            		}).error(function(){
	            			newFolder.remove();
	            			$('.alert-success').html('����ʧ�ܣ�');
							$('.alert-success').fadeIn().fadeOut(2000);
	            		});
	            		//parent=$(this).parent();
	            		
	            		//$rootScope.$apply();
	            		//$scope.$broadcast('ngRepeatFinished');
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
	            				//console.log($rootScope.fileList);
	            				//$rootScope.fileList.unshift(re.file);
	            				//console.log($rootScope.fileList); 
	            				newFolder.remove();
	            				$('.alert-success').html('�����ɹ���');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				newFolder.remove();
	            				$('.alert-success').html('����ʧ�ܣ�');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            		}).error(function(){
	            			newFolder.remove();
	            			$('.alert-success').html('����ʧ�ܣ�');
							$('.alert-success').fadeIn().fadeOut(2000);
	            		});
	            		//parent=$(this).parent();
	            		//newFolder.remove();
            		//parent.find('.file-name').show();
	            });
				break;
			case 'md':
				console.log('����Markdown');
				break;
			case 'note':
				$rootScope.forwardTo('/note/create');
				break;
			case 'table':
				console.log('����table');
				break;
			default :
				break;
		}
	};
	//�����ļ��Ҽ��˵���
	$scope.dropMenuData = [
	    [{
	        text: "��ʷ�汾",
	        func: function() {
	            console.log($scope.selectedFile);
	            //console.log($(this)[0]);
	            ///$(this).css("padding", "10px");
	        }
	    }, {
	        text: "������",
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
	            				$('.alert-success').html('�������ɹ���');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('������ʧ�ܣ�');
								$('.alert-success').fadeIn().fadeOut(2000);
								$scope.selectedFile[0]['name']=oldName;
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('������ʧ�ܣ�');
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
	            				$('.alert-success').html('�������ɹ���');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('������ʧ�ܣ�');
								$('.alert-success').fadeIn().fadeOut(2000);
								$scope.selectedFile[0]['name']=oldName;
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('������ʧ�ܣ�');
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
	        text: "ɾ��",
	        func: function() {
	        	console.log($scope.selectedFile);
	            $http({
	            	url: 'api/delete',
	            	params: {fid:$scope.selectedFile[0].fid},
	            }).success(function(re){
	            	if(re.status==1)
	            	{
	            		$('.alert-success').html('�ɹ�ɾ���ļ���');
						$('.alert-success').fadeIn().fadeOut(2000);
					}
					else
					{
						$('.alert-success').html('ɾ���ļ�ʧ�ܣ�');
						$('.alert-success').fadeIn().fadeOut(2000);
					}
	            }).error(function(re){
	            	$('.alert-success').html('ɾ���ļ�ʧ�ܣ�');
					$('.alert-success').fadeIn().fadeOut(2000);
	            });
	            //$scope.selectedFile=[];
	        }
	     ,
	    }, {
	        text: "���ص�����",
	        func: function() {
	        	if($scope.enableDownload($scope.selectedFile[0]))
	            	$scope.download($scope.selectedFile[0]);
	            //$scope.selectedFile=[];
	        }
	     ,
	    }, {
	        text: "����",
	        func: function() {
	            $scope.share($scope.selectedFile[0]);
	        }
	     ,
	    },],
	];
	$scope.dropMenuDataNoShare = [
	    [{
	        text: "��ʷ�汾",
	        func: function() {
	            console.log($scope.selectedFile);
	            //console.log($(this)[0]);
	            ///$(this).css("padding", "10px");
	        }
	    }, {
	        text: "������",
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
	            				$('.alert-success').html('�������ɹ���');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('������ʧ�ܣ�');
								$('.alert-success').fadeIn().fadeOut(2000);
								$scope.selectedFile[0]['name']=oldName;
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('������ʧ�ܣ�');
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
	            				$('.alert-success').html('�������ɹ���');
								$('.alert-success').fadeIn().fadeOut(2000);
	            			}
	            			else
	            			{
	            				$('.alert-success').html('������ʧ�ܣ�');
								$('.alert-success').fadeIn().fadeOut(2000);
								$scope.selectedFile[0]['name']=oldName;
	            			}
	            		}).error(function(){
	            			$('.alert-success').html('������ʧ�ܣ�');
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
	        text: "ɾ��",
	        func: function() {
	            $http({
	            	url: 'api/delete',
	            	params: {fid:$scope.selectedFile[0].fid},
	            }).success(function(re){
	            	if(re.status==1)
	            	{
	            		$('.alert-success').html('�ɹ�ɾ���ļ���');
						$('.alert-success').fadeIn().fadeOut(2000);
					}
					else
					{
						$('.alert-success').html('ɾ���ļ�ʧ�ܣ�');
						$('.alert-success').fadeIn().fadeOut(2000);
					}
	            }).error(function(re){
	            	$('.alert-success').html('ɾ���ļ�ʧ�ܣ�');
					$('.alert-success').fadeIn().fadeOut(2000);
	            });
	            //$scope.selectedFile=[];
	        }
	     ,
	    }, {
	        text: "���ص�����",
	        func: function() {
	        	if($scope.enableDownload($scope.selectedFile[0]))
	            	$scope.download($scope.selectedFile[0]);
	           	//$scope.selectedFile=[];
	        }
	     ,
	    }, {
	        text: "ȡ������",
	        func: function() {
	            $scope.unshare($scope.selectedFile[0]);
	        }
	     ,
	    }, ],
	];
	//����Ҽ��˵�ֵ
	$scope.dropMulMenuData = [
	    [{
	        text: "ɾ��",
	        func: function() {
	        	console.log($scope.selectedFile);
	        	var fid='';
	            for(i in $scope.selectedFile)
	            {
	            	if(i==$scope.selectedFile.length-1)
	            		fid+=$scope.selectedFile[i].fid;
	            	else
	            		fid+=$scope.selectedFile[i].fid+',';
	            }
	            $http({
	            	url: 'api/delete',
	            	params: {fid:fid},
	            }).success(function(re){
	            	if(re.status==1)
	            	{
	            		$('.alert-success').html('�ɹ�ɾ���ļ���');
						$('.alert-success').fadeIn().fadeOut(2000);
						$scope.selectedFile=[];
						$scope.$broadcast('$routeChangeSuccess');
						//console.log($scope.selectedFile);
					}
					else
					{
						$('.alert-success').html('ɾ���ļ�ʧ�ܣ�');
						$('.alert-success').fadeIn().fadeOut(2000);
						//$scope.selectedFile=null;
					}
					
	            }).error(function(re){
	            	$('.alert-success').html('ɾ���ļ�ʧ�ܣ�');
					$('.alert-success').fadeIn().fadeOut(2000);
					//$scope.selectedFile=null;
	            });
	        }
	     ,
	    },{
	        text: "���ص�����",
	        func: function() {
	        	enableDownloadList=[];
	            $scope.selectedFile.forEach(function(value,index,array){
	            	if($scope.enableDownload(value))
	            		enableDownloadList.push(value);
	            });
	            $scope.mulDownload(enableDownloadList);
	            //$scope.selectedFile=[];
	        }
	     ,
	    }],
	    /*[{
	        text: "ɾ��",
	        func: function() {
	            var src = $(this).attr("src");
	            window.open(src.replace("/s512", ""));    
	        }
	    }]*/
	];
	//���Ⱥ��ʱˢ��Ⱥ������
	$scope.$on('$routeChangeSuccess', function (){
		$scope.loading=true;
		$scope.msgLoading=false;
		//$scope.selectedFile=[];
	    $rootScope.openGroupId=$routeParams.gid;
	    if(typeof $routeParams.fid!=='undefined'&&$routeParams.fid!=null)
	    	$rootScope.belong=$routeParams.fid;
	    else
	    	$rootScope.belong=null;
	    if(typeof $rootScope.belong!=='undefined' && $rootScope.belong!=null && $rootScope.belong!='')
	    {
	    	if(typeof $rootScope.notiList!=='undefined'||$rootScope.notiList!=null)
	    	{
	    		$scope.loading=true;
	    		$scope.msgLoading=false;
	    		 $http({
	                method: 'GET',
	                url: '/api/folder',
	                params: {'fid':$rootScope.belong,'t':'single'}
	            }).success(function(re){
	            	var size=0;
	            	for(i in re.fl){
	            		size=re.fl[i]['size'];
	            		if(!size && typeof size != "undefined" && size != 0)
	            			//console.log(111);
	            			re.fl[i]['size']='----';
	            		else if(size<=1024 )
	            			re.fl[i]['size']=(size/1).toFixed(2)+'B';
	            		else if(size>1024&&size<=1024*1024)
	            			re.fl[i]['size']=(size/1024).toFixed(2)+'KB';
	            		else if(size>1024*1024&&size<1024*1024*1024)
	            			re.fl[i]['size']=(size/1024/1024).toFixed(2)+'MB';
	            		else
	            			re.fl[i]['size']=(size/1024/1024/1024).toFixed(2)+'GB';
	            	}
	            	$rootScope.fileList=re.fl;
	            	$rootScope.openFolder=re.folder;
	            	$scope.loading=false;
	            }).error(function(re){
	            });
	    	}
	    	else
	    	{
	    		$scope.msgLoading=true;
	    	//��ѯ��Ⱥ��ID���ļ���֪ͨ����
		    $http({
	                method: 'GET',
	                url: '/api/folder',
	                params: {'fid':$rootScope.belong}
	            }).success(function(re){
	            	//console.log(re);
	            	/*$rootScope.groupList.forEach(function(value,index,array){
	            		if(value['group_id']==$rootScope.openGroupId)
	            			$rootScope.groupList[index]['num']=null;
	            	});*/
	            	$rootScope.groupInfo=re.gi;
	            	$rootScope.openGroupName=re.gi[0]['name'];
	            	$rootScope.groupMember=re.mi;
	            	var size=0;
	            	for(i in re.fl){
	            		size=re.fl[i]['size'];
	            		if(!size && typeof size != "undefined" && size != 0)
	            			//console.log(111);
	            			re.fl[i]['size']='----';
	            		else if(size<=1024 )
	            			re.fl[i]['size']=(size/1).toFixed(2)+'B';
	            		else if(size>1024&&size<=1024*1024)
	            			re.fl[i]['size']=(size/1024).toFixed(2)+'KB';
	            		else if(size>1024*1024&&size<1024*1024*1024)
	            			re.fl[i]['size']=(size/1024/1024).toFixed(2)+'MB';
	            		else
	            			re.fl[i]['size']=(size/1024/1024/1024).toFixed(2)+'GB';
	            	}
	            	$rootScope.fileList=re.fl;
	            	//$scope.msgLoading=false;
	            	//$rootScope.$apply();
	            	/*for(i in re.ml){
	            		switch(re.ml[i]['type']){
	            			case 'upload': 
	            				re.ml[i]['type']='�ϴ����ļ�';
	            				break;
	            			case 'create': 
	            				re.ml[i]['type']='�������ļ�';
	            				break;
	            			case 'modify': 
	            				re.ml[i]['type']='�޸����ļ�';
	            				break;
	            			case 'send': 
	            				re.ml[i]['type']='';
	            				break;
	            			case 'delete': 
	            				re.ml[i]['type']='ɾ�����ļ�';
	            				break;
	            			case 'new': 
	            				re.ml[i]['type']='������Ⱥ��';
	            				break;
	            			default :
	            				break;
	            		}
	            	}*/
	            	for(i in re.ml)
	            	{
	            		if(re.ml[i]['type']=='create'&&re.ml[i]['file_type']=='folder')
	            			re.ml[i]['type']='create-f';
	            	}
	            	$rootScope.notiList=re.ml;
	            	$rootScope.openFolder=re.folder;
	            	$scope.loading=false;
	            	$scope.msgLoading=false;
	            	//$scope.$apply();
	            	//��ȡ��Ⱥ��������Ϻ����ø�gidΪδ��
	            	$rootScope.readedList.forEach(function(value,index,array){
	            		if(value==$rootScope.openGroupId)
	            			$rootScope.readedList.splice(index,1);
	            	});
					//$rootScope.readedList.remove($rootScope.openGroupId);
	            }).error(function(){
	            	//location.href="";
	            });
	        }
	    }
	    else
	    {
	    	$scope.msgLoading=true;
		    //��ѯ��Ⱥ��ID���ļ���֪ͨ����
		    $http({
	                method: 'GET',
	                url: '/api/group',
	                params: {'gid':$rootScope.openGroupId}
	            }).success(function(re){
	            	//console.log(re);
	            	//��ǰĿ¼
	            	$rootScope.belong=0;
	            	//���Ⱥ��ʱȥ�����ѵ���Ϣֵ
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
	            		if(!size && typeof size != "undefined" && size != 0)
	            			//console.log(111);
	            			re.fl[i]['size']='----';
	            		else if(size<=1024 )
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
	            				re.ml[i]['type']='�ϴ����ļ�';
	            				break;
	            			case 'create': 
	            				re.ml[i]['type']='�������ļ�';
	            				break;
	            			case 'modify': 
	            				re.ml[i]['type']='�޸����ļ�';
	            				break;
	            			case 'send': 
	            				re.ml[i]['type']='';
	            				break;
	            			case 'delete': 
	            				re.ml[i]['type']='ɾ�����ļ�';
	            				break;
	            			case 'new': 
	            				re.ml[i]['type']='������Ⱥ��';
	            				break;
	            			default :
	            				break;
	            		}
	            	}*/
	            	for(i in re.ml)
	            	{
	            		if(re.ml[i]['type']=='create'&&re.ml[i]['file_type']=='folder')
	            			re.ml[i]['type']='create-f';
	            	}
	            	$rootScope.notiList=re.ml;
	            	$scope.loading=false;
	            	$scope.msgLoading=false;
	            	//$scope.$apply();
	            	//��ȡ��Ⱥ��������Ϻ����ø�gidΪδ��
	            	$rootScope.readedList.forEach(function(value,index,array){
	            		if(value==$rootScope.openGroupId)
	            			$rootScope.readedList.splice(index,1);
	            	});
					//$rootScope.readedList.remove($rootScope.openGroupId);
	            }).error(function(){
	            	location.href="";
	            });
        }
	});
	//����κε���¼�����ѡ���file
	$scope.select=function(file){
		//console.log(keyCode);
		//console.log(event.which);
		console.log()
		if(event.which==1||event.which==2)
		{
			if(typeof keyCode!=='undefined')
			{
				//console.log(111);
				if(keyCode==17)
				{
					if(typeof $scope.selectedFile=='undefined')
					{
						$scope.selectedFile=[];
						$scope.selectedFile.push(file);
					}
					else
						$scope.selectedFile.push(file);
				}
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
				console.log(222);
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
				console.log(333);
				$('tbody tr').smartMenu($scope.dropMulMenuData, {
			    	name: "mulDrop"    
				});				
			}
		}
		//console.log($scope.selectedFile);
		//$scope.selectedFile=file;
	}
	//��鵱ǰfile�Ƿ�Ϊѡ���file
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
	//���ļ������ļ��з���
	$scope.oepnOrForward=function(file){
		//console.log(file);
		if(file.type=='folder')
		{
			//���ļ���
			$rootScope.openFolder=file;
			$rootScope.forward('/folder/'+file.fid);
		}
		else if(file.type=='note')
		{
			$rootScope.forwardTo('/note/'+file.fid);
		}
		else if(file.type=='md')
		{
			$rootScope.forward('/md/'+file.fid);
		}
		else if(file.type=='table')
		{
			$rootScope.forward('/table/'+file.fid);
		}
		//����Ϊ��Ԥ����office����
		else if(file.type=='office')
		{
			$rootScope.forward('/office/'+file.fid);
		}
		//pdf����
		else if(file.type=='pdf')
		{
			$rootScope.forward('/pdf/'+file.fid);
		}
		else if(file.type=='text')
		{
			$rootScope.forward('/text/'+file.fid);
		}
		else
		{
			$rootScope.forward('/detail/'+file.fid);
		}
		delete $scope.selectedFile;
	}
	//ng-repeat֮��ִ�еķ���
	$scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) {
          //��������table render��ɺ�ִ�е�js
	      /*if ($('.table').hasClass('dataTable')) 
	      {
	����	dttable = $('.table').dataTable();
	����	dttable.fnClearTable(); //���һ��table
	����	dttable.fnDestroy(); //��ԭ��ʼ���˵�datatable
			}*/
			//console.log($('.table')[0]);
          $('.table').DataTable({
          	//"bRetrieve": true,
			"bAutoWidth":true,
            "autoWidth": true,
            //"bDestroy": true,
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

			//�Ҽ��˵���ʼ��			
			$('tbody tr').smartMenu($scope.dropMenuData, {
			    name: "drop"    
			});
	});
	//�ж��ļ��Ƿ������
	$scope.enableDownload=function(file){
		if(in_array(file.type,$rootScope.unableDownloadList))
			return false;
		return true;
	}
	//�����ļ����ط���
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
	//����ļ����ط���
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
	//�����ļ�����
	$scope.share=function(file){
		$http({
			url:'api/share',
			type:'GET',
			params: {fid:file.fid}
		}).success(function(re){
			if(re.status==1){
				file.share='1';
				$('#btn-copy').html('��������').attr('class','btn btn-primary').attr('disabled',false);
				$('#share-link input[type=text]').val(re.link);
				$('#share-link').modal();
			}
			else{
				$('.alert-success').html('��������ʧ�ܣ�');
				$('.alert-success').fadeIn().fadeOut(2000);
			}
		}).error(function(re){
			$('.alert-success').html('��������ʧ�ܣ�');
			$('.alert-success').fadeIn().fadeOut(2000);
		});
	}
	//ȡ�������ļ�����
	$scope.unshare=function(file){
		console.log(file);
		$http({
			url:'api/unshare',
			type:'GET',
			params: {fid:file.fid}
		}).success(function(re){
			if(re.status==1){
				file.share='0';
				$('.alert-success').html('ȡ������ɹ���');
				$('.alert-success').fadeIn().fadeOut(2000);
			}
			else{
				$('.alert-success').html('ȡ������ʧ�ܣ�');
				$('.alert-success').fadeIn().fadeOut(2000);
			}
		}).error(function(re){
			$('.alert-success').html('ȡ������ʧ�ܣ�');
			$('.alert-success').fadeIn().fadeOut(2000);
		});
	}
	
	//�����ļ�����
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
					$('.alert-success').html('����Ǳ�ɹ���');
					$('.alert-success').fadeIn().fadeOut(2000);
				}
				else{
					$('.alert-success').html('����ʧ�ܣ�');
					$('.alert-success').fadeIn().fadeOut(2000);
					file.star='0';
				}
			}).error(function(re){
				$('.alert-success').html('����ʧ�ܣ�');
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
					$('.alert-success').html('ȡ���Ǳ�ɹ���');
					$('.alert-success').fadeIn().fadeOut(2000);
				}
				else{
					$('.alert-success').html('����ʧ�ܣ�');
					$('.alert-success').fadeIn().fadeOut(2000);
					file.star='1';
				}
			}).error(function(re){
				$('.alert-success').html('����ʧ�ܣ�');
				$('.alert-success').fadeIn().fadeOut(2000);
				file.star='1';
			});
		}
	}

	$scope.closeUploader=function(){
		$scope.uploading=false;
		$scope.uploadFiles=[];
	}
	$scope.uploadFolder=function(){
        	folderUploader=$('input[webkitdirectory]');
	        if(folderUploader.length==0)
	        {
	            var folderUploader=$('<input type="file" webkitdirectory="" style="position: absolute; top: -1000px; left: -1000px;">');
	            $('body').append(folderUploader);      
	        }
	        folderUploader.click();
	        folderUploader.change(function(){
	        	$scope.uploading=true;
		        for(var i=0; i<folderUploader[0].files.length;i++)
	        	{
	        		console.log(i);
		        	var formData=new FormData();
		        	formData.append('files',folderUploader[0].files[i]);
		        	var uploadItem=$.ajax({
				��������type: "POST",
				��������url: "api/uploadFolder",
				��������data: formData ,����//�����ϴ�������ʹ����formData ����
				��������processData : false, 
				��������//����false�Ż��Զ�������ȷ��Content-Type 
				��������contentType : false , 
				��������//async: false,
				��������//�����������õ�jQuery������ XMLHttpRequest����Ϊ������ progress �¼��󶨣�Ȼ���ٷ��ؽ���ajaxʹ��
				��������xhr: function(){
				������������var xhr = $.ajaxSettings.xhr();
				������������if(onprogress && xhr.upload) {
				����������������xhr.upload.addEventListener("progress" , onprogress, false);
				����������������return xhr;
				������������}
				��������},
						success:function(re){
							//console.log(re);
						},
						error:function(re){

						}
				����});
		        }
		        function onprogress(evt){
				����var loaded = evt.loaded;     //�Ѿ��ϴ���С��� 
					var tot = evt.total;      //�����ܴ�С 
					var per = Math.floor(100*loaded/tot);  //�Ѿ��ϴ��İٷֱ� 
					console.log(per+'%');
				}
				$(this).remove();
		    });
        }
}]);
noteCtrls.controller('uploaderCtrl',['$scope','$rootScope','$http','$location','$routeParams',function($scope,$rootScope,$http,$location,$routeParams){
	$scope.uploading=false;
	$scope.uploadFile=function(){
		fileUploader=$('input[multiple=true]');
        if(fileUploader.length==0)
        {
            var fileUploader=$('<input type="file" multiple="true" style="position: absolute; top: -1000px; left: -1000px;">');
            $('body').append(fileUploader);      
        }
        fileUploader.click();
        fileUploader.change(function(){
        	$scope.uploading=true;
        	$scope.$apply();
        	//console.log(fileUploader[0].files);
        	for(var i=0; i<fileUploader[0].files.length;i++)
        	{
	        	var formData=new FormData();
	        	formData.append('files',fileUploader[0].files[i]);
	        	var uploadItem=$.ajax({
			��������type: "POST",
			��������url: "api/uploadFile",
			��������data: formData ,����//�����ϴ�������ʹ����formData ����
			��������processData : false, 
			��������//����false�Ż��Զ�������ȷ��Content-Type 
			��������contentType : false , 
			��������//async: false,
			��������//�����������õ�jQuery������ XMLHttpRequest����Ϊ������ progress �¼��󶨣�Ȼ���ٷ��ؽ���ajaxʹ��
			��������xhr: function(){
			������������var xhr = $.ajaxSettings.xhr();
			������������if(onprogress && xhr.upload) {
			����������������xhr.upload.addEventListener("progress" , onprogress, false);
			����������������return xhr;
			������������}
			��������},
					success:function(re){
						//console.log(re);
					},
					error:function(re){

					}
			����});
        	}
        	function onprogress(evt){
			����var loaded = evt.loaded;     //�Ѿ��ϴ���С��� 
				var tot = evt.total;      //�����ܴ�С 
				var per = Math.floor(100*loaded/tot);  //�Ѿ��ϴ��İٷֱ� 
				console.log(per+'%');
			}
			$(this).remove();
        });
	}
	$scope.close=function(){
		//$scope.uploading=false;
		$('.file-uploader').hide();
	}
}]);