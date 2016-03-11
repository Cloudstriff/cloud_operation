<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
// $Id$

return [
    '__pattern__' => [
        'name' => '\w+',
    ],
    '[hello]'     => [
        ':id'   => ['index/hello', ['method' => 'get'], ['id' => '\d+']],
        ':name' => ['index/hello', ['method' => 'post']],
    ],
    /*'news/:id$'   => 'index/Index/news',
    'group/:gid$' => 'index/Index/group',
    'group/:gid/note/:nid' => 'index/Index/read',*/
    'group/:gid/setting/members' => 'index/Index/index',
    'group/:gid/setting/options' => 'index/Index/index',
    //':rid$'      => 'index/Index/show', //可使用正则表达式，匹配以rid结尾
    //API路由规则
    'api/group/:gid$' => 'api/Index/group',
    'api/folder/:fid$' => 'api/Index/folder',
    'api/download/:fid$' => 'api/Index/download',
    'api/addStar/:fid$'  => 'api/Index/addStar',
    'api/delStar/:fid$'  => 'api/Index/delStar',
    'api/file/:fid/:t' => 'api/Index/file',
    'api/notification/:gid$' => 'api/Index/notification',
    'api/:method$' => 'api/Index/:method',
    'share'  => 'share/Index/index', 
    //'api/image/img/:img' => 'api/Index/image:img',
    //其他路由规则
    'setting/:method$' => 'index/Index/index',
    'group/:gid' => 'index/Index/index',
];
