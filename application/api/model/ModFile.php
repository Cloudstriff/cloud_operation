<?php
namespace app\api\model;
use think\Model;
class ModFile extends Model
{
	//通过msg-id查询文件的所有信息
	public function getFileInfoByMsgId($msgId)
	{
		$data=$this->field('group_id as id,file_id as fid,co_file.type,share,star,belong,ext,length(content) as size,object,time,co_mod_file.name,user_name')->join('co_file on co_file.id=co_mod_file.file_id')->join('co_user on object=co_user.id')->where("msg_id=$msgId")->order('co_mod_file.id desc')->limit(1)->select();
		return $data[0];
	}
}