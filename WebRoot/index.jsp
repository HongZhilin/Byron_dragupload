<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
   <!--  <meta http-equiv="Access-Control-Allow-Origin" content="*"> -->
    <!--声明当前页面的编码集：charset=gbk,gb2312(中文编码)，utf-8(国际编码)-->
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="Keywords" content="关键词，关键字">
    <meta name="Description" content="This is my page">

    <title>Java开发H5带进度条拖拽式文件上传系统--Byron</title>

    <style type="text/css">
    	*{margin:0; padding: 0;}	/* 全局样式设置 */
    	 
    	 body{font-size:12px; font-family:"微软雅黑"; color:#666; background: url("images/bg.jpg"); background-size: cover;}
         .header{padding: 50px;}
         h1{text-shadow: 3px 5px 6px #111; font-size:30px; text-align: center; color: #3E7B65;}
    	 
    	 /* dropbox start */
         #dropbox{width:900px;min-height: 300px; border-radius:3px;position: relative; margin:30px auto 90px; overflow: hidden;
		    padding-bottom: 40px;border: 1px solid pink;box-shadow:0 0 4px rgba(0,0,0,0.3) inset,0 -3px 2px rgba(0,0,0,0.1);}
		#dropbox .message{font-size: 14px; color:red; text-align: center; padding-top:120px; display: block;}
		#dropbox .message i{color:#ccc; font-size:12px;}
		#dropbox:before{ border-radius:3px 3px 0 0;}
		
		/* Image Preview */
		#dropbox .preview{ width:250px; height: 210px; float:left; margin: 50px 0 0 38px; position: relative; text-align: center;}
		#dropbox .preview img{width: 244px;height:180px; border:3px solid #fff;display: block;box-shadow:0 0 2px #000;}
		#dropbox .imageHolder{display: inline-block;position:relative;}
		#dropbox .uploaded{position: absolute; top:0; left:0; height:100%; width:100%;background: url('images/done.png') no-repeat center center rgba(255,255,255,0.5);display: none;}
		#dropbox .preview.done .uploaded{display: block;}
		
		/* Progress Bars */
		#dropbox .progressHolder{ position: absolute; background-color:#252f38; height:12px; width:100%; left:0; bottom: 0; box-shadow:0 0 2px #000;}
		#dropbox .progress{ background-color:#2586d0; position: absolute; height:100%;left:0; width:0;box-shadow: 0 0 1px rgba(255, 255, 255, 0.4) inset;
			-moz-transition:0.25s; -webkit-transition:0.25s; -o-transition:0.25s; transition:0.25s;}
		#dropbox .preview.done .progress{width:100% !important; }/*触发done样式时宽度为100% （最高优先级） */
		/* dropbox end */
    </style>
  </head>

  <body>
  	<div class="header">
        <h1>Java开发H5带进度条拖拽式文件上传系统</h1>
    </div>
        <div id="dropbox">
            <span class="message">Drop images here to upload. <br/><i>(they will only be visible to you)</i></span>
            <!-- <div class="preview">
                <img src="images/img1.jpg" />
                <span class="imgHolder"></span>
                <div class="progressHolder">
                    <div class="progress"></div>
                </div>
            </div> -->
            
           <!--  <div class="preview done">
			    <span class="imageHolder">
			        <img src="" />
			        <span class="uploaded"></span>
			    </span>
			    <div class="progressHolder">
			        <div class="progress"></div>
			    </div>
			</div> -->
            
         </div>    
        
		
		<!-- 引入js官方类库 -->
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery.filedrop.js"></script>
        <script type="text/javascript">
        	//触发a链接点击事件
            $(function (){
            	 var dropbox = $("#dropbox"),	//获取dropbox
                 message = $(".message", dropbox);

	             dropbox.filedrop({
	                 paramname:'pic',
	                 maxfiles: 5,	//拖拽的文件数最大为5个
	                 maxfilesize: 2,//MB
	                 url: 'FileUploadServlet',	//后台处理程序的路径
	                 uploadFinished:function(i,file,response){
	                     $.data(file).addClass("done");
	                 },
	                 error: function(err, file) { //错误信息提示
	                     switch(err) {
	                         case 'BrowserNotSupported':
	                             showMessage('Your browser does not support HTML5 file uploads!');
	                             break;
	                         case 'TooManyFiles':
	                             alert('Too many files! Please select 5 at most!');
	                             break;
	                         case 'FileTooLarge':
	                             alert(file.name+' is too large! Please upload files up to 2MB!');
	                             break;
	                         default:
	                             break;
	                     }
	                 },
	                 // Called before each upload is started
	                 // 文件上传之前的处理
	                 beforeEach: function(file){
	                     if(!file.type.match(/^image\//)){
	                         alert('Only images are allowed!');
	                         return false;
	                     }
	                 },
	                 // 开始上传时
	                 uploadStarted:function(i, file, len){
	                     createImage(file);
	                 },
	                 // 上传进度更新时
	                 progressUpdated: function(i, file, progress) {
	                     $.data(file).find(".progress").width(progress);
	                 }
	             });
	             
	             var template = "...";
	             
	             function createImage(file){
	                 // ... see above ...
	             }
	             function showMessage(msg){
	                 message.html(msg);
	             }
	            //预览图片的模板
	            var template = "<div class='preview'>"+
	                "			    <span class='imageHolder'>"+
	                "			        <img />"+
	                "			        <span class='uploaded'></span>"+
	                "			    </span>"+
	                "			    <div class='progressHolder'>"+
	                "			        <div class='progress'></div>"+
	                "			    </div>"+
	                "			</div>";
	                
                //插入预览图片（函数）	
            	function createImage(file){
            	    var preview = $(template),	//转成jquery对象
            	        image = $("img", preview);//从preview对象中找到img标签

            	    //FileReader
            	    var reader = new FileReader();//读取一张图片，js里面内置对象

            	    image.width = 100;
            	    image.height = 100;

            	    reader.onload = function(e){	//数据读取完成时触发事件
            	        image.attr("src",e.target.result); //base64编码，把图片文件转成base64编码，减少http请求
            	    };
            	    reader.readAsDataURL(file);	//转成data格式的url
            	    message.hide();	//隐藏提示消息
            	    preview.appendTo(dropbox);

            	    // Associating a preview container
            	    // with the file, using jQuery's $.data():
            	    $.data(file,preview);	//附加数据
            	}
            });
        </script>
  </body>
</html>