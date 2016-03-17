<?php
namespace app\api\model;
use think\Model;
class Share extends Model
{
	//获取文件的分享链接，成功返回链接地址，失败返回false
	public function getShareToken($fid)
	{
		$where['fid']=':fid';
		$where['share']=':share';
		$bind[':fid']=$fid;
		$bind[':share']=1;
		$data=$this->field('token')->join('__FILE__ on __FILE__.id = __SHARE__.fid')->where($where)->bind($bind)->select();
		if(!empty($data[0]['token']))
			return $data[0]['token'];
		return false;
	}
	//设置文件分享链接
	public function setShareToken($fid,$uid)
	{
		//开始事务，先更新file表share属性之后再插入share表
		//$this->startTrans();

		//$data['share']=':share';
		$data['share']=1;
		$bind[':id']=$fid;
		//$bind[':share']=1;
		//$re=$this->fetchSql(true)->table('co_file')->where('id=:id')->bind($bind)->save($data);
		$re=M('file')->where('id=:id')->bind($bind)->save($data);
		//return $re;
		unset($bind);
		$bind=null;
		$data=null;

		if($re===false)
		{
			//$this->rollback();
			return false;
		}
		else
		{
			$data['fid']=':fid';
			$data['uid']=':uid';			
			$data['token']=':token';
			$data['time']=':time';
			$bind[':fid']=$fid;
			$bind[':uid']=$uid;
			$key=$fid.$uid.time();
			$bind[':token']=password_hash($key,PASSWORD_DEFAULT);
			$bind[':time']=time();
			$re=$this->data($data)->bind($bind)->add();
			//return $_re;
			//$re=$this->fetchSql(true)->bind($bind)->add($data);
			if($re!==false)
			{
				//$this->commit();
				return $bind[':token'];
			}
			else
			{
				//$this->rollback();
				return false;
			}
		}
	}
	//取消文件分享方法
	public function unshare($fid,$uid)
	{
		$where['fid']=':fid';
		$where['uid']=':uid';
		$bind[':fid']=$fid;
		$bind[':uid']=$uid;
		$re=$this->where($where)->bind($bind)->delete();
		if($re!==false)
		{
			$re=M('file')->where('id=:id')->bind(':id',$fid)->save(array('share'=>0));
			if($re!==false)
				return true;
			else
				return false;
		}
		return false;
	}
}