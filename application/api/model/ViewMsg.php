<?php
namespace app\api\model;
use think\Model;
class ViewMsg extends Model
{
	public function findMsg($uid)
	{
		$where['user_id']=':user_id';
		$bind[':user_id']=$uid;
		return $this->where($where)->bind($bind)->count('id');
	}
}