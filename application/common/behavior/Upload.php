<?php

class Upload
{
    private $config=[];
    private $msg;
    public function __construct($config)
    {
        $this->$config=$config;
    }
    public function uploadOne($file)
    {
        if($this->config['exts'])
        {
            if(!strstr($this->config['exts'],$file['type']))
            {
                $this->msg='上传文件类型不合法';
                return false;
            }
        }
        if($this->config['maxSize'])
        {
            if($file['size']>$this->config['maxSize'])
            {
                $this->msg='上传文件太大';
                return false;
            }
        }
        
        if ($file["size"] < 20000)
        {
            if ($file["error"] > 0)
            {
            echo "Return Code: " . $file["error"] . "<br />";
            }
            else
            {
            echo "Upload: " . $file["name"] . "<br />";
            echo "Type: " . $file["type"] . "<br />";
            echo "Size: " . ($file["size"] / 1024) . " Kb<br />";
            echo "Temp $file: " . $file["tmp_name"] . "<br />";

            if ($file_exists("upload/" . $file["name"]))
              {
              echo $file["name"] . " already exists. ";
              }
            else
              {
              move_uploaded_$file($file["tmp_name"],
              "upload/" . $file["name"]);
              echo "Stored in: " . "upload/" . $file["name"];
              }
            }
        }
        else
        {
        echo "Invalid $file";
        }
    }
    public function getError()
    {
        return $this->msg;
    }
}