<?php
namespace app\index\controller;
use app\common\controller\Base;
use think\Config;
class Index extends Base
{
    public function index()
    {
        $this->assign('path',C('parse_str')['__PUBLIC__']);
        return $this->fetch();
    }
    public function news()
    {
    	echo '新闻编号为：'.I('id');
    }
    public function show()
    {
    	echo '房间号为：'.I('rid');
    }
    public function group()
    {
    	/*echo '群组编号为：'.I('gid').'<br/>';
    	echo '没有群编号则默认显示第一个群组';*/
    	$this->assign('path',C('parse_str')['__PUBLIC__']);
    	return $this->fetch();
    }
    public function read()
    {
    	echo '先判断是否登陆'.'<br/>';
    	echo '群组编号为：'.I('gid').'<br/>';
    	echo '文档编号为：'.I('nid').'<br/>';
    	echo '没有群编号则默认显示第一个群组';
    }
    public function test()
    {
    	$url=U('SignIn/login');
    	$this->redirect($url);
    }
}
