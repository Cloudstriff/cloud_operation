<?php
namespace app\api\model;
use think\Model;
class ViewGroupMember extends Model
{
	public function getMemberInfo($gid)
	{
		return $this->field('account,user_name,sex,avatar_url,role')->where('id=:id')->bind(':id',$gid)->select();
	}
}