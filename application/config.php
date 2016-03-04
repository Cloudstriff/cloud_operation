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
    //RC4秘钥
    'rc4_key'=>'dhskeslolcf@swdj#djQ_4r82',
    //'url_model' =>2,
    'url_route_on' => true,
    'response_exit'=>false,
    /*'log'          => [
        'type'             => 'trace', // 支持 socket trace file
        // 以下为socket类型配置
        'host'             => '111.202.76.133',
        //日志强制记录到配置的client_id
        'force_client_ids' => [],
        //限制允许读取日志的client_id
        'allow_client_ids' => [],
    ],*/
    'parse_str'=>[
    '__PUBLIC__'=>'/public',
    '__ROOT__' => '/',
    ],
    'URL_HTML_SUFFIX'       =>  '',  // URL伪静态后缀设置
    'URL_DENY_SUFFIX'       =>  'ico|png|gif|jpg', // URL禁止访问的后缀设置
    'db_bind_param'    =>    true,
    'DB_BIND_PARAM'    =>    true,
    //'default_return_type'=>'json' //默认的数据输出格式
];
