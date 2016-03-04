<?php 
namespace app\common\behavior;
class User{
	private $id;
	private $account;
	private $user_name;
	private $sex;
	private $avatar_url;
	private $group=[];
	private $groupList=[];
	public function __construct($userParams=[])
	{
		//虽然PHP没有重载构造函数，但可以利用参数判断实现
		$_SESSION['user']=empty($userParams)?$_SESSION['user']:$userParams;
		/*
			eg: 传递的参数数组为 ['id'=>1111,'username'=>'Cloud','group'=>[123,456,789],'role'=>[123=>1,456=>2,789=>0]];
				group列表为：$group=[123,456,789],而role列表为$role=[$group[0]=>1,$group[1]=>2,$group[2]=>0];
				$this->user=new User(['id'=>1111,'username'=>'Cloud'],'group'=>$group,'role'=>$role);
				只需在登录的时候利用构造函数赋值一次，其他时候使用均为
		 */
	}
	public function __get($paramName)
	{
		if(isset($_SESSION['user'][$paramName]))
		{
			return $_SESSION['user'][$paramName];
		}
		else
		{
			return false;
		}
	}
	public function __set($paramName, $value)
	{
		$_SESSION['user'][$paramName]=$value;
	}
	public function getUserInfo()
	{
		$userInfo=$_SESSION['user'];
		unset($userInfo['group']);
		return $userInfo;
	}
	public static function clearUserSession()
	{
		unset($_SESSION['user']);
	}
}