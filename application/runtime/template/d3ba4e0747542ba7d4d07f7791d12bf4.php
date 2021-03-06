<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html lang="en" ng-app="noteApp">
<head>
	<base href="/" />
	<meta charset="UTF-8">
	<title>Cloud-云协作</title>
	<link rel="stylesheet" type="text/css" href="__PUBLIC__/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="__PUBLIC__/css/index.css">
	<!--到最后完成再把字体加载进来吧，，哎-->
	<!--<script src="https://use.typekit.net/kbf1iqt.js"></script>
	<script>try{Typekit.load({ async: true });}catch(e){}</script>-->
</head>
<body ng-controller="mainCtrl" data-ng-init="load()">
	<div class="header" >
		<div class="head-box">
			<div class="logo"><a href="#group"></a></div>
			<span class="top bot-4"><a href="#logout"><img src="__PUBLIC__/imgs/icon-logout.png"></a></span>
			<span class="top bot-4"><a href="#logout"><img src="__PUBLIC__/imgs/icon-msg.png"></a></span>
			<span class="top cursor-d" ng-bind="getTime()"></span>
		</div>
	</div>
	<div class="main">
		<div class="main-left"  onLoad="init()">
			<div class="left-top">
				<div class="top-box-avatar">
					<a href="#"><img ng-src="{{personInfo.avatar_url}}" width="96px" height="96px"></a>
				</div><br/><br/><br/><br/><br/><br/><br/><br/>
				<div class="top-box-name x-t-hidden cursor-d" ng-bind="personInfo.user_name"></div>
				<div class="top-box-menu cursor-p" data-toggle="dropdown">
					<img src="__PUBLIC__/imgs/icon-test.png">
				</div>
				<ul class="dropdown-menu dropdown-menu-right" role="menu">
				      <li><a href="#">个人信息</a></li>
				      <li><a href="#">查看我的笔记</a></li>
				      <li><a href="#">意见反馈</a></li>
				</ul>	
			</div>
			<div class="left-cent" id="navbar-example">
				<div class="group-add-join btn-group">
					<span class="box cursor-p"  data-toggle="dropdown">
					<img src="__PUBLIC__/imgs/icon-group.png" class="m-b-6"/>
					<span>创建/加入</span>
					<img src="__PUBLIC__/imgs/icon-group-sign.png" />
					</span>		
					<ul class="dropdown-menu dropdown-menu-left" role="menu">
				      <li><a class="cursor-p" style="color:#40bfd8" ng-click="createGroup()">创建群</a></li>
				      <li><a class="cursor-p" style="color:#40bfd8" ng-click="joinGroup()">加入群</a></li>
				    </ul>			
				</div>
				<div class="group-list" data-spy="scroll" data-target="#navbar-example" data-offset="0" >
					<div ng-repeat="group in groupList" class="group-item cursor-p" ng-class="{selected:group.group_id==openGroupId}" ng-click="forwardGroup(group.group_id)">
						<span ng-bind="group.name"></span><div style=""></div>			
					</div>
				</div>
			</div>
			<div class="left-bot">
				<div class="bot-chat cursor-p">私聊</div>
			</div>
		</div>
		<div class="main-right"  ng-view>			
		</div> 
	</div>
	<div class="modal fade" id="group-c">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	                <h4 class="modal-title">新建群</h4>
	            </div>
	            <div class="modal-body">
	                <form class="form-horizontal" >  
	                    <div class="form-group" >
	                        <label class="col-sm-3 control-label no-padding-right">
	                         	群名称 
	                        </label>
	                        <div class="col-sm-9">
	                           	<input type="text" class="form-controll" /> 
	                        </div>
	                    </div> 
	                    <div class="form-group" >
	                        <label class="col-sm-3 control-label no-padding-right">
	                         	群简介 <br/>
								（选填）
	                        </label>
	                        <div class="col-sm-9">
	                           	<textarea class="form-controll" max-input-length="60"></textarea>
	                        </div>
	                    </div>                     
	                    <div class="form-group">
	                        <label class="col-sm-3 control-label no-padding-right">
	                        	加群验证
	                        </label>
	                        <div class="col-sm-9">
	                            
	                        </div>
	                    </div>  
	                    <div class="form-group">
	                        <div class="col-sm-3">
	                        </div>
	                        <div class="col-sm-9">
	                            <input type="button" class="btn btn-success" name="add" value="确定" />
	                        </div>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
	</div> 
</body>
<script type="text/javascript" src="__PUBLIC__/framework/jquery/jquery.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/framework/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/framework/bootstrap/bootbox.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/framework/jquery/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/framework/angular-1.3.14/angular.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/framework/angular-1.3.14/angular-route.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/framework/angular-1.3.14/angular-animate.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/js/function.js"></script>
<script type="text/javascript">
	var path='<?php echo $path; ?>';
	$('.group-list').css('height',$(window).height()-$('.header').height()-$('.left-bot').height()-$('.left-top').height()-$('.group-add-join').height()-2);
	$('.msg-list').height($('.nav').height()-140);
	$('.main-right').css('width',$(window).width()-$('.main-left').width());
	$('.main-right').css('height',$('.main-left').height());
	$('.main-r-center').css('height',$('.main-left').height()-59);
	$('.dataTables_scrollBody').height('400');
	/*$(window).change(function(){
		$('.group-list').css('height',$(this).height()-$('.header').height()-$('.left-bot').height()-$('.left-top').height()-$('.group-add-join').height()-3);
	});*/

</script>
<script type="text/javascript" src="__PUBLIC__/js/app.js"></script>
<script type="text/javascript" src="__PUBLIC__/js/controllers.js"></script>
<script type="text/javascript" src="__PUBLIC__/js/filters.js"></script>
<script type="text/javascript" src="__PUBLIC__/js/directives.js"></script>
</html>