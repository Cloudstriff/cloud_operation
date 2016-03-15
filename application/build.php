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
    // 生成运行时目录
    '__dir__'  => ['runtime/cache', 'runtime/log', 'runtime/temp'],
    '__file__' => ['tags.php'],

    // 定义index模块的自动生成
    'index'    => [
        '__file__'   => ['config.php'],
        '__dir__'    => ['behavior', 'controller', 'model', 'view'],
        'controller' => ['Index','Signin','Setting','Test'],
        'model'      => [],
        'view'       => ['index/index','signin/login','setting/members','setting/options'],
    ],
    // 定义api模块的自动生成
    'api'    => [
        '__file__'   => ['config.php'],
        '__dir__'    => ['behavior', 'controller', 'model', 'view'],
        'controller' => ['Index'],
        'model'      => [],
        'view'       => ['index/index'],
    ],
    // 定义common模块的自动生成
    'common'  => [
        '__file__'   => ['config.php'],
        '__dir__'    => ['behavior', 'controller'],
        'controller' => ['Base'],
        'model'      => ['native'],
    ],
    'share'    => [
        '__file__'   => ['tags.php'],
        '__dir__'    => ['behavior', 'controller', 'model', 'view'],
        'controller' => ['Index', ],
        'model'      => [],
        'view'       => ['index/index'],
    ],
    'download'    => [
        '__file__'   => ['tags.php'],
        '__dir__'    => ['behavior', 'controller', 'model', 'view'],
        'controller' => ['Index', ],
        'model'      => [],
        'view'       => ['index/index'],
    ],
    // 。。。 其他更多的模块定义
];
