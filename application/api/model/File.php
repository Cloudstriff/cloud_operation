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

}