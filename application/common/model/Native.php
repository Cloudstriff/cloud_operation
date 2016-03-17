<?php
namespace app\common\model;
use think\Model;
class Native
{
	protected $dsn;
	protected $user;
	protected $password;
	protected static $dbCon;
	public function __construct()
	{
		/*$this->dsn=C('dsn');
		$this->user=C('user');
		$this->password=C('password');*/
		$this->dsn='mysql:dbname=cloud_operation;host=localhost';
		$this->user='root';
		$this->password='';
		try 
		{  
		    if(self::$dbCon==null)
		    {
		   		self::$dbCon = new \PDO($this->dsn, $this->user, $this->password);
		   		self::$dbCon->exec("SET NAMES 'utf8';"); 
		    }  
		} catch (PDOException $e) 
		{  
		   		return 'Connection failed: '.$e->getMessage();  
		   		//exit;  
		}  
	}
	public function procedure($proName,$input)
	{
		//$this->getInstance();
		/*$dsn = 'mysql:dbname=cloud_operation;host=localhost';  
		$user = 'root';  
		$password = '';  
		try {
		   $dbCon = new \PDO($dsn, $user, $password);
		   $dbCon->exec("SET NAMES 'utf8';");   
		} catch (PDOException $e) {  
		   return 'Connection failed: '.$e->getMessage();  
		   exit;  
		} */ 
		//$username = '123';
		//$userpsw = '123';
		 //$xp_userlogon = $dbCon ->query("exec user_logon_check '$username','$userpsw'");  
		 //mysql->call user_logon_check('$username','$userpsw');  
		 //mysql->call user_logon_check(?,?)
		if(is_object($input))
			$input=json_decode(json_encode($input),true);
		if(is_array($input))
		{
			$num=count($input);
			$xp_userlogon = self::$dbCon->prepare("CALL $proName(".str_repeat("?,",$num-1)."?)");
			$count=1;
			foreach ($input as $key => $value) 
			{
				$xp_userlogon->bindParam($count,$input[$key]);
				$count++;
			}
		}
		else
		{
			$xp_userlogon = self::$dbCon->prepare("CALL $proName(?)");
			$xp_userlogon->bindParam(1,$input);
		}
		//$xp_userlogon = $dbCon->prepare("CALL $proName(?,?,?,?,?,?,?,?,?)");  
		/*$xp_userlogon->bindParam(1,$input['msgType']);          
		$xp_userlogon->bindParam(2,$input['object']);
		$xp_userlogon->bindParam(3,$input['name']); 
		$xp_userlogon->bindParam(4,$input['belong']); 
		$xp_userlogon->bindParam(5,$input['gid']); 
		$xp_userlogon->bindParam(6,$input['type']); 
		$xp_userlogon->bindParam(7,$input['ext']); 
		$xp_userlogon->bindParam(8,$input['content']); 
		$xp_userlogon->bindParam(9,$input['_time']);  */
		$xp_userlogon->execute();
		//$re=$xp_userlogon->fetch(\PDO::FETCH_ASSOC);
		//return $re;
		$result=[];
		do{
			$re=$xp_userlogon->fetchAll(\PDO::FETCH_ASSOC);
			if($re)
				$result[]=$re;
		}while ($xp_userlogon->nextRowSet());
		if(count($result)==1)
			return $result;
		else
			return $result;
	}
	public function procedureWithFlag($proName,$input)
	{
		//$this->getInstance();
		/*$dsn = 'mysql:dbname=cloud_operation;host=localhost';  
		$user = 'root';  
		$password = '';  
		try {
		   $dbCon = new \PDO($dsn, $user, $password);
		   $dbCon->exec("SET NAMES 'utf8';");   
		} catch (PDOException $e) {  
		   return 'Connection failed: '.$e->getMessage();  
		   exit;  
		} */ 
		//$username = '123';
		//$userpsw = '123';
		 //$xp_userlogon = $dbCon ->query("exec user_logon_check '$username','$userpsw'");  
		 //mysql->call user_logon_check('$username','$userpsw');  
		 //mysql->call user_logon_check(?,?)
		if(is_object($input))
			$input=json_decode(json_encode($input),true);
		$count=1;
		if(is_array($input))
		{
			$num=count($input);
			$xp_userlogon = self::$dbCon->prepare("CALL $proName(".str_repeat("?,",$num-1)."?,@flag)");
			foreach ($input as $key => $value) 
			{
				$xp_userlogon->bindParam($count,$input[$key]);
				$count++;
			}
		}
		else
		{
			$xp_userlogon = self::$dbCon->prepare("CALL $proName(?,@flag)");
			$xp_userlogon->bindParam(1,$input);
		}
		//$xp_userlogon = $dbCon->prepare("CALL $proName(?,?,?,?,?,?,?,?,?)");  
		/*$xp_userlogon->bindParam(1,$input['msgType']);          
		$xp_userlogon->bindParam(2,$input['object']);
		$xp_userlogon->bindParam(3,$input['name']); 
		$xp_userlogon->bindParam(4,$input['belong']); 
		$xp_userlogon->bindParam(5,$input['gid']); 
		$xp_userlogon->bindParam(6,$input['type']); 
		$xp_userlogon->bindParam(7,$input['ext']); 
		$xp_userlogon->bindParam(8,$input['content']); 
		$xp_userlogon->bindParam(9,$input['_time']);  */
		if($xp_userlogon->execute())
		{
			$re=self::$dbCon->query('select @flag')->fetchAll(\PDO::FETCH_ASSOC);
			return $re[0]['@flag'];
		}
	}
}
//": [ SQL语句 ] : SET @msgType = 'create';SET @object = '170801';SET @name = 'dfsfsd';SET @belong = '0';SET @gid = '170802';SET @type = 'folder';SET @ext = 'dir';SET @content = ''; CALL add_mod_file(@msgType,@object,@name,@belong,@gid,@type,@ext,@content);"