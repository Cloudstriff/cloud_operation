<?php
namespace app\api\model;
use think\Model;
class ViewGroupModfile extends Model
{
	public function getModFile($gid,$belong=null)
	{
		if($belong)
		{
			$where['id']=':id';
			$where['belong']=':belong';
			$bind[':id']=$gid;
			$bind[':belong']=$belong;
			return $this->where($where)->bind($bind)->select();
		}
		return $this->where('id=:id')->bind(':id',$gid)->select();
	}
}