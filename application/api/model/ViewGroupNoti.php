<?php
namespace app\api\model;
use think\Model;
class ViewGroupNoti extends Model
{
	public function getGroupMsg($gid)
	{
		return $this->where('group_id=:group_id')->bind(':group_id',$gid)->order('id asc')->select();
	}
}