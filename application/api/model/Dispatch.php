<?php
namespace app\api\model;
use think\Model;
class Dispatch extends Model
{
	public function setReaded($msgId,$uid)
	{
		$where['msg_id']=':msg_id';
		$where['user_id']=':user_id';
		$bind[':msg_id']=$msgId;
		$bind[':user_id']=$uid;
		$data['read']=1;
		$this->where($where)->bind($bind)->save($data);
	}
}