<?php
namespace app\api\model;
use think\Model;
class Msg extends Model
{
	public function findNotiByGid($gid)
	{
		
	}
	public function getGroupMsg($gid)
	{
		$re=D('common/Native')->procedure('get_group_msg',$gid);
		return $re;
		/*$dsn = 'mysql:dbname=cloud_operation;host=localhost';  
        $user = 'root';  
        $password = '';  
        try {  
           $dbCon = new \PDO($dsn, $user, $password);
           $dbCon->exec("SET NAMES 'utf8';");   
        } catch (PDOException $e) {  
           print 'Connection failed: '.$e->getMessage();  
           exit;  
        }  
        $xp_userlogon = $dbCon->prepare('CALL get_group_msg(?)');  
        $xp_userlogon->bindParam(1,$gid);          
        $xp_userlogon->execute();
        $result=[];
        $i=1;
        do
        {
        	$rowSet=$xp_userlogon->fetchAll(\PDO::FETCH_ASSOC);
        	if($rowSet)
        	{
        		$result[]=$rowSet;
        		$i++;
        	}      	
        }while($xp_userlogon->nextRowSet());
        return $result;*/
	}
}