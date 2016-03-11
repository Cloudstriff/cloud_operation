function sleep(numberMillis) {
var now = new Date();
var exitTime = now.getTime() + numberMillis;
while (true) {
now = new Date();
if (now.getTime() > exitTime)
return;
}
}
function in_array(stringToSearch, arrayToSearch) {
 for (s = 0; s < arrayToSearch.length; s++) {
  thisEntry = arrayToSearch[s].toString();
  if (thisEntry == stringToSearch) {
   return true;
  }
 }
 return false;
}
function longPolling() {               
$.ajax({
    url: '/api/msg',
    data:null,
    //timeout: 5000000,
    async: true,  
    error: function (XMLHttpRequest, textStatus, errorThrown) {
        //$("#state").append("[state: " + textStatus + ", error: " + errorThrown + " ]<br/>");
        if (textStatus == "timeout") { // 请求超时
                longPolling(); // 递归调用
            
            // 其他错误，如网络错误等
            } else { 
                longPolling();
            }
        },
    success: function (re) {
        //$("#state").append("[state: " + textStatus + ", data: { " + data + "} ]<br/>");
        if(re.status==1)
        	console.log('有新的群消息');
        else
        	longPolling();
    }
});
}
function get_url_relative_path()
　　{
　　　　var url = document.location.toString();
　　　　var arrUrl = url.split("//");

　　　　var start = arrUrl[1].indexOf("/");
　　　　var relUrl = arrUrl[1].substring(start);//stop省略，截取从start开始到结尾的所有字符

　　　　if(relUrl.indexOf("?") != -1){
　　　　　　relUrl = relUrl.split("?")[0];
　　　　}
　　　　return relUrl;
　　}
function setCopy(_sTxt){  
    try{  
        if(window.clipboardData) {  
            window.clipboardData.setData("Text", _sTxt);  
        } else if(window.netscape) {  
            netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');  
            var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);  
            if(!clip) return;  
            var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);  
            if(!trans) return;  
            trans.addDataFlavor('text/unicode');  
            var str = new Object();  
            var len = new Object();  
            var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);  
            var copytext = _sTxt;  
            str.data = copytext;  
            trans.setTransferData("text/unicode", str, copytext.length*2);  
            var clipid = Components.interfaces.nsIClipboard;  
            if (!clip) return false;  
            clip.setData(trans, null, clipid.kGlobalClipboard);  
        }  
    }catch(e){}  
}
var keyCode=0; 
function keyDown() { 
   keyCode= event.keyCode;
   //var key = String.fromCharCode(event.keyCode) 
   //console.log(value);
  }
function keyUp() { 
   keyCode= 0;
   //var key = String.fromCharCode(event.keyCode) 
   //console.log(value);
  }
document.onkeydown = keyDown;
document.onkeyup = keyUp;