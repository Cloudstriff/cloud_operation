<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html lang="en" ng-app="noteApp">
<head>
	<base href="/" />
	<meta charset="UTF-8">
	<title>Cloud-云协作</title>
	<link rel="stylesheet" type="text/css" href="__PUBLIC__/framework/bootstrap-3.3.5-dist/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="__PUBLIC__/css/index.css">
	<link rel="stylesheet" type="text/css" href="__PUBLIC__/css/smartMenu.css">
	<!--到最后完成再把字体加载进来吧，，哎-->
	<!--<script src="https://use.typekit.net/kbf1iqt.js"></script>
	<script>try{Typekit.load({ async: true });}catch(e){}</script>-->
</head>
<body ng-controller="mainCtrl" data-ng-init="load()">
	<div class="header" >
		<div class="head-box">
			<div class="logo"><a href="#group"></a></div>
			<span class="top bot-4">
				<a class="cursor-p" data-toggle="tooltip" data-placement="bottom" title="退出">
   					<img src="__PUBLIC__/imgs/icon-logout.png">
   				</a>
   			</span>
			<span class="top bot-4">
				<a class="cursor-p c-b" id="icon-msg" ng-click="readMsg()" data-toggle="tooltip" data-placement="bottom" title="有新消息">
   					<img src="__PUBLIC__/imgs/icon-msg.png">
   				</a>
   			</span>
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
					<div ng-repeat="group in groupList" class="group-item cursor-p" ng-class="{selected:group.group_id==openGroupId}" ng-click="forwardGroup(group)">
						<span ng-bind="group.name"></span><span class="noti-warning f-r" ng-if="group.num" ng-bind="group.num"></span>
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
	<div class="modal" id="read-msg">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
					<button type="button" class="close btn-large" data-dismiss="modal">&times;<span class="sr-only">Close</span></button>
					<h4 class="modal-title">模态弹出窗标题</h4>
				</div>
				<div class="modal-body">
					<p>模态弹出窗主体内容</p>
					<p>模态弹出窗主体内容</p>
					<p>模态弹出窗主体内容</p>
					<p>模态弹出窗主体内容</p>
					<p>模态弹出窗主体内容</p>
					<p>模态弹出窗主体内容</p>
					<p>模态弹出窗主体内容</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-large" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary">保存</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>  
	<div class="modal fade" id="group-c">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
					<button type="button" class="close btn-large" data-dismiss="modal">&times;<span class="sr-only">Close</span></button>
					<h4 class="modal-title">模态弹出窗标题</h4>
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
	                </form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-large" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary">保存</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div> 
	<div class="modal" id="share-link" style="top:20%;">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
					<button type="button" class="close btn-large" data-dismiss="modal">&times;<span class="sr-only">Close</span></button>
					<h4 class="modal-title">分享链接</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" >  
						<div class="form-group">
	                        <label class="col-sm-2 control-label no-padding-right">
	                        	链接生成成功
	                        </label>
	                    </div>
	                    <div class="form-group" >
	                        <div class="col-sm-12">
	                           	<input type="text" class="form-controll" id="input-link"/><button type="button" class="btn btn-primary" id="btn-copy" ng-click="copyLink()">复制链接</button>
	                        </div>
	                    </div> 
	                </form>
				</div>
				<!-- <div class="modal-footer">
					<button type="button" class="btn btn-default btn-large" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary">复制</button>
				</div> -->
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div> 
</body>
<script type="text/javascript" src="__PUBLIC__/framework/jquery/jquery.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/framework/jquery/jquery-smartMenu-min.js"></script>
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