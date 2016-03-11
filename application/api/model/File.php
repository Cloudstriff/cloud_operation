<?php
namespace app\api\model;
use think\Model;
class File extends Model
{
	//判断文件或文件夹所在群组ID和文件名
	public function getGroupIdAndName($fid)
	{
		$data=$this->field('group_id,name')->where('id=:id')->bind(':id',$fid)->select();
		return $data[0];
	}
	//判断文件所在群组和文件名、url地址
	public function getGroupIdAndUrl($fid)
	{
		$data=$this->field('co_unmod_file.name,group_id,url')->join('__UNMOD_FILE__ on co_file.id=__UNMOD_FILE__.file_id')->where('co_file.id=:id')->bind(':id',$fid)->select();
		return $data[0];
	}
	//判断多个文件所在群组和文件名、url
	public function getGroupIdAndUrls($fidList)
	{
		$where['co_file.id']=array('in',$fidList);
		//$where['co_file.id']=array('in',':id');
		//$bind[':id']=$fidList;
		$data=$this->field('co_unmod_file.name,group_id,url')->join('__UNMOD_FILE__ on co_file.id=__UNMOD_FILE__.file_id')->where($where)->bind($bind)->select();
		return $data;
	}
	//判断文件所在群组和文件名、url地址以及文件类型
	public function getGroupIdTypeUrl($fid)
	{
		$data=$this->field('co_unmod_file.name,type,group_id,url')->join('__UNMOD_FILE__ on co_file.id=__UNMOD_FILE__.file_id')->where('co_file.id=:id')->bind(':id',$fid)->select();
		return $data[0];
	}
	//判斷文件所在群組和文件名、最新版本內容
	public function getGroupIdAndContent($fid)
	{
		$data=$this->field('co_unmod_file.name,group_id,content')->join('__MOD_FILE__ on co_file.id=__MOD_FILE__.file_id')->where('co_file.id=:id')->bind(':id',$fid)->order('co_mode_file.id desc')->limit(0,1)->select();
		return $data[0];
	}
	//文件加星方法
	public function addStar($fid)
	{
		$re=$this->where('id=:id')->bind(':id',$fid)->setField('star',1);
		if($re)
			return true;
		return false;
	}
	//文件去星方法
	public function delStar($fid)
	{
		$re=$this->where('id=:id')->bind(':id',$fid)->setField('star',0);
		if($re)
			return true;
		return false;
	}
	//获取文件所在群组ID
	public function getGroupId($fid)
	{
		$data=$this->field('group_id')->where('id=:id')->bind(':id',$fid)->select();
		return $data[0]['group_id'];
	}
	//文件重命名方法
	public function rename($fid,$name)
	{
		$data=$this->field('type')->where('id=:id')->bind(':id',$fid)->select();
		if($data[0]['type'])
		{
			//属于可编辑文件类型的文件改名
			if(in_array($data[0]['type'],['note','table','md','folder']))
			{
				$data['name']=$name;
				$where['file_id']=':file_id';
				$bind[':file_id']=$fid;
				$re=M('modFile')->field('max(id) as id')->where($where)->bind($bind)->select();
				//return $re[0]['id'];
				if($re[0]['id'])
				{
					$where['id']=':id';
					$bind[':id']=$re[0]['id'];
					$re=M('modFile')->where($where)->bind($bind)->save($data);
					if($re!==false)
						return true;
					return false;
				}
				return false;
			}
			else
			{
				$where['file_id']=':file_id';
				#$data['name']=':name';
				$data['name']=$name;
				$bind[':file_id']=intval($fid);
				//$bind[':name']=$name;
				$re=M('unmodFile')->where($where)->bind($bind)->save($data);
				if($re!==false)
					return true;
				return false;
			}
		}
		return false;
	}
	//插入新文件
	public function addModFile($input)
	{
		//1.插入msg表
		//2.插入file表
		//3.插入modfile表
		//4.批量插入dispatch表
		$data['type']='create';
		$data['group_id']=$input->gid;
		$data['time']=time();
		$msgId=M('Msg')->add($data);
		if($msgId!==false)
		{
			$data=null;
			$data['name']=$input->name;
			$data['type']=$input->type;
			$data['ext']=$input->ext;
			$data['group_id']=$input->gid;
			$data['belong']=$input->belong;
			$fid=$this->add($data);
			if($fid!==false)
			{
				$data=null;
				$data['file_id']=$fid;
				$data['name']=$input->name;
				$data['msg_id']=$msgId;
				$data['object']=$input->object;
				$data['time']=time();
				$re=M('modFile')->add($data);
				if($re!==false)
				{
					$data=null;
					//查询该群组内有多少人
					$uidList=D('Member')->getGroupUidList($input->gid);
					if($uidList)
					{
						$dataList=[];
						foreach ($uidList as $key => $value) 
						{
							$dataList[]=array('msg_id'=>$msgId,'user_id'=>$value['user_id']);								
						}
						$re=M('Dispatch')->addAll($dataList);
						if($re!==false)
						{
							//全部执行成功，再查询
						}
					}
				}
				return false;
			}
			return false;
		}
		return false;
	}
}