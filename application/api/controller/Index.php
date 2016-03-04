<?php
namespace app\api\controller;
use app\common\controller\Base;
//use app\api\model\MemberModel;
class Index extends Base
{
    private $memberModel;
    private $groupModel;
    private $fileModel;
    private $groupModfileView;
    private $groupUnModfileView;
    private $groupNotiView;
    private $dispatchModel;
    private $msgCometView;
    private $notiCometView;
    private $groupNotiSendmsgView;
    private $groupNotiCreateGroupView;
    public function __construct()
    {
        parent::__construct();
        $this->memberModel=D('api/Member');
        $this->groupModel=D('api/Group');
        $this->fileModel=D('api/File');
        $this->groupModfileView=D('api/ViewGroupModfile');
        $this->groupUnModfileView=D('api/ViewGroupUnmodfile');
        $this->groupNotiView=D('api/ViewGroupNoti');
        $this->dispatchModel=D('api/Dispatch');
        $this->msgCometView=D('api/ViewMsgComet');
        $this->notiCometView=D('api/ViewNotiComet');
        $this->groupNotiSendmsgView=D('api/ViewGroupNotiSendmsg');
        $this->groupNotiCreateGroupView=D('api/ViewGroupNotiCreateGroup');

    }
    //获取服务器端API列表
    public function api()
    {
    	$apiList=get_class_methods(__CLASS__);
    	$this->ajaxReturn($this->getMethods(__CLASS__,'public'));
    }
    //获取用户当前的简单数据：如个人信息、群组列表、可新建的文件列表、群组成员列表、群组信息
    public function info()
    {
        header('Content-type:text/html;charset=utf8');
        if(S('cFileList')==null)
        {
            S('cFileList',[0=>['name'=>'文件夹','type'=>'folder'],1=>['name'=>'笔记','type'=>'note'],2=>['name'=>'Markdown','type'=>'md'],3=>['name'=>'表格','type'=>'table']]);
        }
        if(S('msgType')==null)
        {
            //S('msgType',[])
        }
        //从session中获取用户群组信息和角色
        $groupList=$this->user->group;
        //从session中获取用户个人信息
        $userInfo=$this->user->getUserInfo();
        $userInfo['avatar_url']=$this->encryptAvatar($userInfo['avatar_url']);
        /* cfl:可创建文件列表  gl:用户群组列表   pi:用户个人信息  ud:不可下载文件类型*/
        return ['cfl'=>S('cFileList'),'gl'=>$groupList,'pi'=>$userInfo,'ud'=>['note','table']];
    }
    //获取群组数据方法,包括群组文件列表数据、群组通知列表数据
    public function group()
    {
    	//判断是否有权限
    	$gid=I('get.gid');
        if($gid)
        {
            if(in_array($gid,$this->user->groupList))
            {
                $modFileList=$this->groupModfileView->getModFile($gid);
                $unModFileList=$this->groupUnModfileView->getUnmodFile($gid);
                $memberInfo=D('api/ViewGroupMember')->getMemberInfo($gid);
                $groupInfo=$this->groupModel->getGroupInfo($gid);
                foreach ($memberInfo as $k => $v) {
                    $memberInfo[$k]['avatar_url']=$this->encryptAvatar($v['avatar_url']);
                }
                $temp=[];
                foreach ($modFileList as $k => $v) 
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
                //最终文件列表
                $unModFileList=$this->divSort($temp,$unModFileList);
                //查找该群组的通知，并将获取到的通知的msg-id和user-id作为where条件将dispatch表关于该用户的目前所获取的通知标识置为1
                $msgList=$this->groupNotiView->getGroupMsg($gid);
                $_msgList=$this->groupNotiSendmsgView->getGroupMsg($gid);
                $_msgList1=$this->groupNotiCreateGroupView->getGroupMsg($gid);
                //print_r($_msgList1);
                //$this->divSortWithfield($_msgList1,$msgList,'id');
                $msgList=$this->divSortWithfield($_msgList,$msgList,'id');
                
                $msgList=array_merge($msgList,$_msgList1);
                //将avatar修改url，并将该用户该群组下的dispatch表标识设为1
                foreach ($msgList as $k => $v)
                {
                    $msgList[$k]['avatar_url']=$this->encryptAvatar($v['avatar_url']);
                    $this->dispatchModel->setReaded($v['id'],$this->user->id);
                }
                return ['gi'=>$groupInfo,'mi'=>$memberInfo,'fl'=>$unModFileList,'ml'=>$msgList];
                //break;
            }
        }
    }
    //获取文件夹下的文件列表方法
    public function folder()
    {
    	$folderId=I('get.fid/s');
        if($folderId)
        {
            $fileInfo=$this->fileModel->getGroupIdAndName($folderId);
            if(in_array($fileInfo['group_id'],$this->user->groupList))
            {                
                $belongFileList1=$this->groupModfileView->getModFile($fileInfo['group_id'],$fileInfo['name']);
                $belongFileList2=$this->groupUnmodfileView->getUnmodFile($fileInfo['group_id'],$fileInfo['name']);
                return $this->divSort($belongFileList1,$belongFileList2);
            }
        }
    }
    //群组通知推送接口
    public function notification()
    {
        $gid=I('gid');
        if($gid)
        {
            //返回两个数据，一个是当前群组的通知数据，直接插入到dom后面
            //一个是其他群组的消息数量，都是key---value组合，key为gid
            if(in_array($gid,$this->user->groupList))
            {
                ini_set("max_execution_time", "0");
                session_write_close();
                while (true) 
                {
                    //1.查找这个gid的通知数据
                    //2.查找这个用户其他gid的通知数量
                    #return ni:noti-item, nl:group-new-noti-num-list
                    $numList=$this->notiCometView->findNoti($this->user->id,$gid);
                    $notiItem=$this->notiCometView->findNotiByGid($uid,$gid);
                    if($numList)
                    {                       
                        return ['nl'=>$numList,'ni'=>];
                        break;
                    }
                    usleep(1000000);
                }
            }
        }
    }
    //群消息推送接口
    public function msg()
    {
        //查找该用户是否有未读群消息，若有直接返回true，若没有，则继续循环
        ini_set("max_execution_time", "0");
        session_write_close();
        $count=0;
        while (true) 
        {
            $num=$this->msgCometView->findMsg($this->user->id);
            if($num>=1)
            {
                //$this->ajaxReturn(['status'=>1]);
                $this->ajaxReturn(array('status'=>1,'num'=>$num));
                break;
            }
            //$count++;
            //if($count>=3)
                //break;
            usleep(1000000);
        }
    }
    //获取群消息接口，并置dispatch为1
    public function getMsg()
    {
        //1、从view中获取群消息内容
        //2、通过user_id和msg_id置dispatch表为1
    }
    //获取.note .table .md等可編輯文件數據方法
    public function file()
    {
        $fid=I('fid');
        $type=I('t');
        //$type='unmod';
        if($fid&&$type)
        {
            if($type=='mod')
            {
                $fileInfo=$this->fileModel->getGroupIdAndContent($fid);
                if($fileInfo['group_id']!=false)
                {
                    if(in_array($fileInfo['group_id'],$this->user->groupList))
                    {
                        return ['fid'=>$fid,'name'=>$fileInfo['name'],'content'=>$fileInfo['content']];
                    }
                }
            }
            else
            {
                //不可編輯文件中判斷是否為office之類的可在線預覽內容的文件
                $fileInfo=$this->fileModel->getGroupIdTypeUrl($fid);
                if($fileInfo['group_id']!=false)
                {
                    if(in_array($fileInfo['group_id'],$this->user->groupList))
                    {
                        //通过url读取office之类文件的内容,并返回
                        //这里必须去查看一下office在线预览的接口
                        switch ($fileInfo['type']) {
                            case 'office':
                                # code...
                                break;
                            case 'text':
                                C('default_return_type','text/plain');
                                header("Content-Type: text/plain; charset=utf-8");
                                $text = file_get_contents($fileInfo['url'],true);
                                //读取的txt文件为gbk格式，必须转化成utf-8才能配合header头部格式正常显示
                                $text=iconv("gb2312","utf-8",$text);
                                echo $text;
                                exit(0);                               
                                break;
                            case 'pdf':
                                # code...
                                break;
                            default:
                                # code...
                                break;
                        }
                    }
                }
            }
        }
    }
    //下载文件方法
    public function download()
    {
        C('default_return_type','text/html');
        $fid=I('fid');
        if($fid)
        {
            $fileInfo=$this->fileModel->getGroupIdAndUrl($fid);
            print_r($fileInfo);
            if(in_array($fileInfo['group_id'],$this->user->groupList))
            {
                echo '111';
                header("Content-type:text/html;charset=utf-8");
                $fileName=$fileInfo['name'];
                //用以解决中文不能显示出来的问题 
                $fileName=iconv("utf-8","gb2312",$fileName); 
                $fileSubPath=str_replace("//","/",$_SERVER['DOCUMENT_ROOT'].$fileInfo['url']);
                $filePath=$fileSubPath;
                if(!file_exists($filePath))
                { 
                    echo "下载错误！文件不存在"; 
                    return ; 
                } 
                $fp=fopen($filePath,"r");
                $fileSize=filesize($filePath);
                Header("Content-type: application/octet-stream"); 
                Header("Accept-Ranges: bytes");
                Header("Accept-Length:".$fileSize); 
                Header("Content-Disposition: attachment; filename=".$fileName);
                $buffer=1024; 
                $fileCount=0; 
                //向浏览器返回数据 
                while(!feof($fp) && $fileCount<$fileSize)
                { 
                    $file_con=fread($fp,$buffer); 
                    $file_count+=$buffer; 
                    echo $file_con; 
                } 
                fclose($fp);
            }
        }
    }
    //获取真实图片文件URL
    public function image()
    {
        $cipher=I('get.img','strip_tags/s');
        $imgUrl=$this->rc4Decode($cipher);
        $img = file_get_contents($imgUrl,true);
        header("Content-Type: image/jpeg;text/html; charset=utf-8");
        echo $img;
        exit(0);
    }
    //对用户头像地址进行加密
    private function encryptAvatar($url)
    {
        return U('Index/image','img='.base64_encode($this->rc4Encode($url)));
    }
    /*//json格式返回数据方法
    protected function ajaxReturn($array)
    {
    	//$array格式：['data'=>array(),'code'=>111,'msg'=>'成功']
    	echo json_encode($array);
    }*/
    //二分法对可变文件和不可变文件进行归并排序
    private function divSort($temp,$unModFileList)
    {
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
                        if($unModFileList[$low]['time']>$v['time'])
                            array_splice($unModFileList,$low+1,0,[$low+1=>$v]);
                        else
                            array_splice($unModFileList,$low,0,[$low=>$v]);
                    }
                    else
                    {
                        if($unModFileList[0]['time']>$v['time'])
                            //$unModFileList[]=$v;
                            array_splice($unModFileList,1,0,[1=>$v]);
                        else
                            //array_unshift($unModFileList,$v);
                            array_splice($unModFileList,0,0,[0=>$v]);
                    }
                    break;
                }
                $mid=floor(($top+$low)/2);
                if($unModFileList[$mid]['time']<$v['time'])
                    $top=$mid;
                    //$low=$mid+1;
                else
                    $low=$mid+1;
            }
        }
        return $unModFileList;
    }
    //按field值从小到大排序
    private function divSortWithfield($temp,$unModFileList,$field)
    {
        if(count($temp)==0)
            return $unModFileList;
        if(count($unModFileList)==0)
            return $unModFileList;
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
    //获取开放API列表方法
    protected function getMethods($classname,$access=null)
    {
        $class = new \ReflectionClass($classname);
        $methods = $class->getMethods();
        $returnArr = array();
        foreach($methods as $value){
            if($value->class == $classname){
                if($access != null){
                    $methodAccess = new \ReflectionMethod($classname,$value->name);
                    switch($access){
                        case 'public':
                            if($methodAccess->isPublic())
                            {
                            	$method=['name'=>$value->name,'url'=>U('/').'api/'.$value->name];
                            	$returnArr[] = $method;
                            }
                            break;
                        case 'protected':
                            if($methodAccess->isProtected())$returnArr[$value->name] = 'protected';
                            break;
                        case 'private':
                            if($methodAccess->isPrivate())$returnArr[$value->name] = 'private';
                            break;
                        case 'final':
                            if($methodAccess->isFinal())$returnArr[$value->name] = 'final';
                            break;
                    }
                }else{
                    array_push($returnArr,$value->name);
                }                
            }
        }
        return $returnArr;
    }
}
