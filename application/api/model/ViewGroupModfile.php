<?php
namespace app\api\model;
use think\Model;
class ViewGroupModfile extends Model
{
	public function getModFile($gid,$belong=0,$state=1)
	{
/*		if($belong)
		{*/
			$where['id']=':id';
			$where['belong']=':belong';
			$where['state']=':state';
			$bind[':id']=$gid;
			$bind[':belong']=$belong;
			$bind[':state']=1;
			return $this->field('id,fid,name,ext,type,belong,star,share,object,time,size,user_name')->where($where)->bind($bind)->order('time desc')->select();
		/*}
		return $this->field('id,fid,name,ext,type,belong,star,share,object,time,size,user_name')->where('id=:id')->bind(':id',$gid)->select();*/
	}
}