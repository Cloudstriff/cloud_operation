<?php
namespace app\api\model;
use think\Model;
class ViewNotiComet extends Model
{
	public function findNoti($uid,$gidList)
	{
		$where['user_id']=':user_id';
		//$where['group_id']=array('neq',':group_id', );
		$bind[':user_id']=$uid;
		//$bind[':group_id']=$gid;
		if(is_array($gidList))
		{
			foreach ($gidList as $k => $v) 
			{
				if($k==count($gidList)-1)
					$notIn.=$v;
				else
					$notIn.=$v.',';
			}
		}
		else if($gidList)
			$notIn.=$gidList;
		if($notIn)
			$where['group_id']=array('not in',$notIn);
		return $this->field('count(id) as num,group_id')->where($where)->bind($bind)->group('group_id')->select();
	}
	public function findNotiByGid($uid,$gid)
	{
		$where['user_id']=':user_id';
		$where['group_id']=':group_id';
		$bind[':user_id']=$uid;
		$bind[':group_id']=$gid;
		//查询当前打开群是否有新通知
		$re=$this->field('msg_id,code')->where($where)->bind($bind)->select();
		//return $re;
		if($re)
		{
			//create、modify、upload类型操作都要查询对应的修改文件
			$fileMsgIdList=[];
			//查询noti表的msg-id-list
			$notiIdList=[];
			$notiDeleteIdList=[];
			$notiSendIdList=[];
			$notiCreateIdList=[];
			foreach ($re as $k => $v) 
			{
				switch ($v['code']) {
					case 'new':
						array_push($notiCreateIdList,$v['msg_id']);
						break;
					case 'send':
						array_push($notiSendIdList,$v['msg_id']);
						break;
					case 'delete':
						$temp=['type'=>$v['code'],'id'=>$v['msg_id']];
						array_push($fileMsgIdList,$temp);
						array_push($notiDeleteIdList,$v['msg_id']);
						break;
					default:
						$temp=['type'=>$v['code'],'id'=>$v['msg_id']];
						array_push($fileMsgIdList,$temp);
						//$fileMsgIdList[$v['code']]=$v['msg_id'];
						array_push($notiIdList,$v['msg_id']);
						//return ['fm'=>$fileMsgIdList,'nd'=>$notiIdList];
						break;
				}
			}
			//return $notiCreateIdList;
			//执行查询
			$where=null;
			$bind=null;
			$re1=[];
			if(!empty($notiIdList))
			{
				$idList='';
				if(count($notiIdList)>1)
				{
					foreach ($notiIdList as $k => $v) 
					{
						if($k==count($notiIdList)-1)
							$idList.=$v;
						else
							$idList.=$v.',';
					}
					$where['id']=array('in',$idList);
				}
				else
				{
					$where['id']=$notiIdList[0];
				}
				$re1=M('ViewGroupNoti')->fetchSql(false)->field('*')->where($where)->select();
			}
			//return ['arrayId'=>$notiIdList,'re'=>$fileMsgIdList];
			if(!empty($notiDeleteIdList))
			{
				$idList='';
				if(count($notiDeleteIdList)>1)
				{
					foreach ($notiDeleteIdList as $k => $v) 
					{
						if($k==count($notiDeleteIdList)-1)
							$idList.=$v;
						else
							$idList.=$v.',';
					}
					$where['id']=array('in',$idList);
				}
				else
				{
					$where['id']=$notiDeleteIdList[0];
				}
				$re4=M('ViewGroupNotiDelfile')->field('*')->where($where)->select();
			}
			if(!empty($notiSendIdList))
			{
				$idList='';
				if(count($notiSendIdList)>1)
				{
					foreach ($notiSendIdList as $k => $v) 
					{
						if($k==count($notiSendIdList)-1)
							$idList.=$v;
						else
							$idList.=$v.',';
					}
					$where['id']=array('in',$idList);
				}
				else
				{
					$where['id']=$notiSendIdList[0];
				}
				$re2=M('ViewGroupNotiSendmsg')->field('*')->where($where)->select();
			}
			if(!empty($notiCreateIdList))
			{
				$idList='';
				if(count($notiCreateIdList)>1)
				{
					foreach ($notiCreateIdList as $k => $v) 
					{
						if($k==count($notiCreateIdList)-1)
							$idList.=$v;
						else
							$idList.=$v.',';
					}
					$where['id']=array('in',$idList);
				}
				else
				{
					$where['id']=$notiCreateIdList[0];
				}
				$re3=M('ViewGroupNotiCreateGroup')->field('*')->where($where)->select();
			}
			//return $re2;
			//合并排序查询结果
			$re1=$this->divSortWithfield($re2,$re1,'id');
			$re1=$this->divSortWithfield($re1,$re4,'id');
			//return $re1;  
			if($re3!==null)             
            	$re=array_merge($re1,$re3);
            else
            	$re=$re1;
        	//查询对应的文件信息
        	$fileList=[];//存储文件信息的数组
        	foreach ($fileMsgIdList as $k => $v) 
        	{
        		switch ($v['type']) 
        		{
        			case 'create':
        				//查询file和modfile表获取文件信息，limit=1，order by id desc
        				$file=D('api/ModFile')->getFileInfoByMsgId($v['id']);
        				array_push($fileList,$file);
        				break;
        			case 'upload':
        				//查询file和unmodfile表和file表获取文件信息
        				$file=D('api/UnmodFile')->getFileInfoByMsgId($v['id']);
        				array_push($fileList,$file);
        				//$fileList[]=$file;
        				break;
        			case 'modify':
        				//查询file和modfile表获取文件信息，limit=1，order by id desc
        				$file=D('api/ModFile')->getFileInfoByMsgId($v['id']);
        				array_push($fileList,$file);
        				break;
        			case 'delete':
        				//查询delete_file表获取文件信息
        				$file=D('api/DeleteFile')->getFileInfoByMsgId($v['id']);
        				array_push($fileList,$file);
        				break;
        			default:
        				# code...
        				break;
        		}
        	}
        	if(count($fileList)>1)
        	{
        		//去除重复项
    			$temp=[];
                foreach ($fileList as $k => $v) 
                {
                    if($k!=0)
                    {
                        foreach ($temp as $kk => $vv) 
                        {
                            if($vv['fid']!=$v['fid']&&$kk==count($temp)-1)
                                $temp[]=$v;
                        }
                    }
                    else
                        $temp[]=$v;
                }
        		//反向排序
        		//krsort($temp);
        		$fileList=$temp;
        	}
        	else
        		$fileList=$fileList[0];
            return ['notiItem'=>$re,'fileList'=>$fileList];
		}
	}
	//按field值从小到大排序
    private function divSortWithfield($temp,$unModFileList,$field)
    {
    	//return $temp;
        if($temp==null||count($temp)==0)
            return $unModFileList;
        if($unModFileList===null||count($unModFileList)==0)
            return $temp;
        foreach ($temp as $k => $v) 
        {
            $low=0;
            $top=count($unModFileList)-1;
            $mid=0;
            while ($low<=$top) 
            {
                if($low==$top)
                {
                    if($low!=0)
                    {
                        if($unModFileList[$low][$field]<$v[$field])
                            array_splice($unModFileList,$low+1,0,[$low+1=>$v]);
                        else
                            array_splice($unModFileList,$low,0,[$low=>$v]);
                    }
                    else
                    {
                        if($unModFileList[0][$field]<$v[$field])
                            //$unModFileList[]=$v;
                            array_splice($unModFileList,1,0,[1=>$v]);
                        else
                            //array_unshift($unModFileList,$v);
                            array_splice($unModFileList,0,0,[0=>$v]);
                    }
                    break;
                }
                $mid=floor(($top+$low)/2);
                if($unModFileList[$mid][$field]>$v[$field])
                    $top=$mid;
                    //$low=$mid+1;
                else
                    $low=$mid+1;
            }
        }
        return $unModFileList;
    }
	/*public function findNotiByGid($uid,$gid)
	{
		$where['user_id']=':user_id';
		$where['group_id']=':group_id';
		$bind[':user_id']=$uid;
		$bind[':group_id']=$gid;
		$notiList=$this->field('msg_id,code')->where($where)->bind($bind)->select();
		if(!empty($notiList))
		{
			foreach ($notiList as $k => $v) 
			{
				//if(in_array($v['type'],))
			}
		}
		return $noti
	}*/
}