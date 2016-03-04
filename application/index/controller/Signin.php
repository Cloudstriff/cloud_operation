<?php
namespace app\index\controller;
use think\Controller;
use app\common\behavior\User;
class Signin extends Controller{
	private $user;
	private $userModel;
	public function __construct()
	{
		parent::__construct();
		$this->userModel=D('index/User');
	}
	public function login()
	{
		if(IS_POST)
		{
			echo I('redirect');
		}
		echo '登陆界面';
	}
	public function doLogin()
	{
		/*$group=[123,456,789];
		$role=[$group[0]=>0,$group[1]=>1,$group[2]=>2];
		$user=['username'=>'Cloud','id'=>1100,'role'=>$role,'group'=>$group];*/
		$account='chenjiongwendao@qq.com';
		$pass='wap181';
		if($re=$this->userModel->login($account,$pass))
		{
			$groupList=[];
			$this->user=new User($re);
			$group=D('api/Member')->getGroupList($this->user->id);
			$this->user->group=$group;
			foreach ($group as $k => $v) 
			{
				$groupList[]=$v['group_id'];
			}
			$this->user->groupList=$groupList;
		}
		else
			echo '用户名或密码错误';
		print_r($_SESSION);
	}
	public function doLogOut()
	{
		User::clearUserSession();
	}
	//加密方法
	public function encrypt($pass='wap181')
	{
		return password_hash($pass,PASSWORD_DEFAULT);
	}
}