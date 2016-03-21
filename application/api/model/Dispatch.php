<?php
namespace app\api\model;
use think\Model;
class Dispatch extends Model
{
	public function setReaded($msgIdList,$uid)
	{
		$where['user_id']=$uid;
		$where['msg_id']=array('in',$msgIdList);
		$where['read']=0;						
		//$bind[':msg_id']=$msgId;
		//$bind[':user_id']=$uid;
		$data['read']=1;
		$this->where($where)->save($data);
	}
}