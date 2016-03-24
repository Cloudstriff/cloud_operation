<?php
namespace app\api\model;
use think\Model;
use common\Model\Native;
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
	//查询文件所在群组ID和belong
	public function getGroupIdAndBelong($fid)
	{
		$data=$this->field('group_id,belong')->where('id=:id')->bind(':id',$fid)->select();
		$data[0]['fid']=$fid;
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
	//查询文件所在群組和文件名、最新版本內容
	public function getGroupIdAndContent($fid)
	{
		$data=$this->field('co_mod_file.name,group_id,content')->join('__MOD_FILE__ on co_file.id=__MOD_FILE__.file_id')->where('co_file.id=:id')->bind(':id',$fid)->order('co_mod_file.id desc')->limit(0,1)->select();
		return $data[0];
	}
	//查询文件的当前版本号
	public function getFileVersion($fid)
	{
		$data=M('ModFile')->field('count(id) as version')->where("file_id=$fid")->select();
		return $data[0]['version'];
	}
	//查询文件所在群组和版本号
	public function getGroupIdAndVersion($fid)
	{
		$data=$this->field('group_id,count(co_mod_file.id) as version')->join('__MOD_FILE__ on co_file.id=__MOD_FILE__.file_id')->where('co_file.id=:id')->bind(':id',$fid)->order('co_mod_file.id desc')->limit(0,1)->select();
		return $data[0];
	}
	//查询文件详细信息方法
	public function getDetail($fid)
	{
		$data=$this->field('co_file.id as fid,group_id,co_unmod_file.name,url,user_name as uploader,co_unmod_file.time,belong,size,co_file.type')->join('__UNMOD_FILE__ on co_file.id=__UNMOD_FILE__.file_id')->join('co_user on co_unmod_file.uploader=co_user.id')->where('co_file.id=:id')->bind(':id',$fid)->select();
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
				//$data['name']=':name';
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
		$data['type']=$input->msgType;
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
				$data['content']=$input->content;
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
	//插入可编辑文件方法
	public function _addModFile($input)
	{
		//最终决定用这个
		$nativeModel=D('common/Native');
		return $nativeModel->procedureWithFlag('add_mod_file',$input);
		//$re=$nativeModel->procedure('add_mod_file',$input);
		//return $re[0];



		/*$nativeModel=D('common/Native');
		$re=$nativeModel->procedure('add_mod_file',$input);
		return $re;*/
		/*$Model = new \think\Model();
		$re=$Model->query("CALL add_mod_file(?,?,?,?,?,?,?,?,?)",[$input->msgType,$input->object,$input->name,$input->belong,$input->gid,$input->type,$input->ext,$input->content,$input->_time]);
		return $re[0];*/





		$dsn = 'mysql:dbname=cloud_operation;host=localhost';  
		$user = 'root';  
		$password = '';  
		try {  
		   $dbCon = new \PDO($dsn, $user, $password);
		   $dbCon->exec("SET NAMES 'utf8';");   
		} catch (PDOException $e) {  
		   print 'Connection failed: '.$e->getMessage();  
		   exit;  
		}  
		//$username = '123';
		//$userpsw = '123';
		 //$xp_userlogon = $dbCon ->query("exec user_logon_check '$username','$userpsw'");  
		 //mysql->call user_logon_check('$username','$userpsw');  
		 //mysql->call user_logon_check(?,?)  
		$xp_userlogon = $dbCon->prepare('CALL add_mod_file(?,?,?,?,?,?,?,?,?)');  
		$xp_userlogon->bindParam(1,$input->msgType);          
		$xp_userlogon->bindParam(2,$input->object);
		$xp_userlogon->bindParam(3,$input->name); 
		$xp_userlogon->bindParam(4,$input->belong); 
		$xp_userlogon->bindParam(5,$input->gid); 
		$xp_userlogon->bindParam(6,$input->type); 
		$xp_userlogon->bindParam(7,$input->ext); 
		$xp_userlogon->bindParam(8,$input->content); 
		$xp_userlogon->bindParam(9,$input->_time);  
		$xp_userlogon->execute();
		//$re=$xp_userlogon->fetch(\PDO::FETCH_ASSOC);
		//return $re;
		$re=$xp_userlogon->fetchAll(\PDO::FETCH_ASSOC);
		return $re[0];
		//$uCol = $xp_userlogon->columnCount();
		//$sql = "SET @msgType = '".$input->msgType."'; SET @object = $input->object; SET @name = '".$input->name."'; SET @belong = $input->belong;SET @gid =$input->gid; SET @type = '".$input->type."'; SET @ext = '".$input->ext."'; SET @content = '".$input->content."'; SET @_time=$input->_time; CALL add_mod_file(@msgType,@object,@name,@belong,@gid,@type,@ext,@content,@_time);";
		$re=$this->query($sql);
		return $re;
		if($re!==false)
			return $re;
		return false;
	}
	//回收站置文件state=0 or 1操作
	public function setState($input)
	{
		$nativeModel=D('common/Native');
		return $nativeModel->procedureWithFlag('set_file_state',$input);
		/*$re=$this->where("fid=$fid")->save("state=$state");
		if($re!==false)
			return true;
		return false;*/
	}
	//修改文件操作
	public function modifyFile($input)
	{
		$nativeModel=D('common/Native');
		return $nativeModel->procedureWithFlag('modify_file',$input);
		/*$re=$this->where("fid=$fid")->save("state=$state");
		if($re!==false)
			return true;
		return false;*/
	}
	//插入上传文件方法
	public function addUnModFile($input)
	{
		//最终决定用这个
		$nativeModel=D('common/Native');
		return $nativeModel->procedureWithFlag('add_unmod_file',$input);
	}
}
//": [ SQL语句 ] : SET @msgType = 'create';SET @object = '170801';SET @name = 'dfsfsd';SET @belong = '0';SET @gid = '170802';SET @type = 'folder';SET @ext = 'dir';SET @content = ''; CALL add_mod_file(@msgType,@object,@name,@belong,@gid,@type,@ext,@content);"