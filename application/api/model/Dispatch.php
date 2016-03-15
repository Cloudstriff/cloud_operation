<?php
namespace app\api\model;
use think\Model;
class Dispatch extends Model
{
	public function setReaded($msgId,$uid)
	{
		$where['read']=0;
		$where['msg_id']=$msgId;
		$where['user_id']=$uid;		
		//$bind[':msg_id']=$msgId;
		//$bind[':user_id']=$uid;
		$data['read']=1;
		$this->where($where)->save($data);
	}
}