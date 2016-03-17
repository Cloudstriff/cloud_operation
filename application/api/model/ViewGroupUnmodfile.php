<?php
namespace app\api\model;
use think\Model;
class ViewGroupUnmodfile extends Model
{
	public function getUnmodFile($gid,$belong=0,$state=1)
	{
		/*if($belong)
		{*/
			$where['id']=':id';
			$where['belong']=':belong';
			$where['state']=':state';
			$bind[':id']=$gid;
			$bind[':belong']=$belong;
			$bind[':state']=1;
			return $this->field('id,fid,name,ext,type,belong,star,share,object,time,size,user_name')->where($where)->bind($bind)->select();
		//}
		/*return $this->field('id,fid,name,ext,type,belong,star,share,object,time,size,user_name')->where('id=:id')->bind(':id',$gid)->select();*/
	}
}