<?php
namespace app\api\model;
use think\Model;
class ViewGroupUnmodfile extends Model
{
	public function getUnmodFile($gid,$belong=0)
	{
		if($belong)
		{
			$where['id']=':id';
			$where['belong']=':belong';
			$bind[':id']=$gid;
			$bind[':belong']=$belong;
			return $this->field('id,fid,name,ext,type,belong,star,share,object,time,size,user_name')->where($where)->bind($bind)->select();
		}
		return $this->field('id,fid,name,ext,type,belong,star,share,object,time,size,user_name')->where('id=:id')->bind(':id',$gid)->select();
	}
}