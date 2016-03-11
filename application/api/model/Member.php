<?php
namespace app\api\model;
use think\Model;
class Member extends Model
{
	//use \traits\model\adv;
    //use \traits\model\auto;
    /*public function _initialize()
    {
        // 自动验证规则
        $this->validate = array(
            array('name', '/^[a-zA-Z]\w{0,39}$/', '文档标识不合法', self::VALUE_VALIDATE, 'regex', self::MODEL_BOTH),
            array('name', '', '标识已经存在', self::VALUE_VALIDATE,'unique'),
            array('title', 'require', '标题不能为空', self::MUST_VALIDATE, 'regex', self::MODEL_BOTH),
            array('title', '1,80', '标题长度不能超过80个字符', self::MUST_VALIDATE, 'length', self::MODEL_BOTH),
            array('description', '1,140', '简介长度不能超过140个字符', self::VALUE_VALIDATE, 'length', self::MODEL_BOTH),
            array('cate_id', 'require', '分类不能为空', self::MUST_VALIDATE , 'regex', self::MODEL_INSERT),
            array('cate_id', 'require', '分类不能为空', self::EXISTS_VALIDATE , 'regex', self::MODEL_UPDATE),
    		);
    //自动完成规则 
        $this->auto = array(
            array('uid', 'is_login', self::MODEL_INSERT, 'function'),
            array('title', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
            array('content', 'base_encode', self::MODEL_BOTH, 'callback'),
            array('description', 'htmlspecialchars', self::MODEL_BOTH, 'function'),
            array('link_id', 'getLink', self::MODEL_BOTH, 'callback'),
            array('view', 0, self::MODEL_INSERT, 'string'),
            array('comment', 0, self::MODEL_INSERT, 'string'),
            array('create_time', 'getCreateTime', self::MODEL_BOTH,'callback'),
            array('update_time', NOW_TIME, self::MODEL_BOTH, 'string'),
            array('status', '1', self::MODEL_INSERT, 'string'),
        	);

	}*/
	public function getGroupList($uid)
	{
		return $this->field('group_id,name,role')->join('__GROUP__ on __MEMBER__.group_id=__GROUP__.id')->where('user_id=:user_id')->bind(':user_id',$uid)->select();
	}
    //查询群组内成员ID
    public function getGroupUidList($gid)
    {
        return $this->field('user_id')->where('group_id=:group_id')->bind(':group_id',$gid)->select();
    }
}