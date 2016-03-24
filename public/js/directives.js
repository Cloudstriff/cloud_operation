var noteDirectives = angular.module('noteDirectives', []);
//中间部分高度适应指令
noteDirectives.directive('adapt', function(){
	return {
		restrict: 'AE',
		link:function(scope,element,attr){
			element.css('height',$('.main-right').height()-59);
		}
		/*template: '<div>Hello</div>',
		replace : true*/
	}
});
//主要文件部分宽度适应指令
noteDirectives.directive('adaptWidth', function(){
	return {
		restrict: 'AE',
		link:function(scope,element,attr){
			element.css('width',element.parent().width()-$('.nav').width()-$('.msg').width()-1);
		}
		/*template: '<div>Hello</div>',
		replace : true*/
	}
});
//重命名输入框指令
noteDirectives.directive('rename', function(){
	return {
		restrict: 'AE',
		link:function(scope,element,attr){
			element.focus(function(){
				console.log(1111);
			});
		}
		/*template: '<div>Hello</div>',
		replace : true*/
	}
});
//文件列表高度适应
noteDirectives.directive('fileTableHeight', function(){
	return {
		restrict: 'A',
		link:function(scope,element,attr){
				//console.log($('.main-left').height());
				element.height($('.main-left').height()-60-53-34);
		}
		/*template: '<div>Hello</div>',
		replace : true*/
	}
});
/*//初始化加载数据指令
noteDirectives.directive('onFinishRenderFilters', function ($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element, attr) {
            if (scope.$last === true) {
                $timeout(function() {
                    scope.$emit('ngRepeatFinished');
                });
            }
        }
    };
});*/
//搜索输入框回车事件指令
noteDirectives.directive('searchEnter', function($location){
	return {
		restrict: 'AE',
		link:function($rootScope,element,attr){
			element.keydown(function(e) {  
		    // 回车键事件  
		       var keycode = window.event?e.keyCode:e.which;
		       if(keycode == 13) {
		   			//$location.path('/group/'+$rootScope.openGroupId+'/search/'+$rootScope.sContent);
		   			$rootScope.forward('/search/'+$rootScope.sContent);
		   			//console.log($rootScope.sContent);
		       }  
		   }); 
		}
	}
});
//datatable表格化指令

noteDirectives.directive('onFinishRenderFilters', function ($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element, attr) {
            if (scope.$last === true) {
                $timeout(function() {
                    scope.$emit('ngRepeatFinished');
                });
            }
        }
    };
});
noteDirectives.directive('hover',function(){
	return {
		restrict: 'AE',
		link: function(scope,element,attr){
			element.mouseover(function(){
				element.find('.btn-list').show();
			});
			element.mouseout(function(){
				element.find('.btn-list').hide();
			})
		}
	}
});
noteDirectives.directive('scroll',function(){
	$("#navbar-file").scrollspy();
	return {
		restrict: 'AE',
		link: function(scope,element,attr){
			  var $spy = $(this).scrollspy('refresh');
		}
	}
});
//让消息滚动到最新一条
noteDirectives.directive('adaptHeight',function($timeout){
	return {
		restrict: 'A',
		link: function(scope,element,attr){
			if (scope.$last === true) {
				//console.log(111);
                $timeout(function() {
                    $('.msg-list').stop().animate({
					  scrollTop: $(".msg-list")[0].scrollHeight
					}, 100);
                });
            }
		}
	}
});
//笔记编辑内容高度
noteDirectives.directive('adaptNoteHeight', function(){
	return {
		restrict: 'A',
		link:function(scope,element,attr){
				//console.log($('.main-left').height());
				element.height($('.main-left').height()-60);
		}
		/*template: '<div>Hello</div>',
		replace : true*/
	}
});
//发布按钮指令
noteDirectives.directive('publishBtn', function(){
	return {
		restrict: 'A',
		link:function(scope,element,attr){
				//console.log($('.main-left').height());
				element.click(function(){
					element.width('75');
					element.html('<span class="glyphicon glyphicon-open"></span>&nbsp;正在发布');
				});
		}
		/*template: '<div>Hello</div>',
		replace : true*/
	}
});
//上传文件进度条指令
noteDirectives.directive('status', function(){
	return {
		restrict: 'A',
		link:function(scope,element,attr){
				//console.log($('.main-left').height());
				//element.change(function(){
					//element.width(element.attr('value')/element.attr('max')+'%');
				//});
		}
		/*template: '<div>Hello</div>',
		replace : true*/
	}
});
/*noteDirectives.directive('noteDirectives_2', ['$scope', function($scope){
	
}])*/