<?php
namespace app\api\model;
use think\Model;
class UnmodFile extends Model
{
	//通过msg-id查询文件的所有信息
	public function getFileInfoByMsgId($msgId)
	{
		$data=$this->field('group_id as id,file_id as fid,co_file.type,share,star,belong,ext,size,uploader as object,time,co_unmod_file.name,user_name')->join('co_file on co_file.id=co_unmod_file.file_id')->join('co_user on uploader=co_user.id')->where("msg_id=$msgId")->select();
		return $data[0];
	}
}