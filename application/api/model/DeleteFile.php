<?php
namespace app\api\model;
use think\Model;
class DeleteFile extends Model
{
	//通过msg-id查询文件的所有信息
	public function getFileInfoByMsgId($msgId)
	{
		$data=$this->field('co_file.group_id as id,file_id as fid,state')->join('co_file on co_file.id=co_delete_file.file_id')->where("msg_id=$msgId")->select();
		return $data[0];
	}
}