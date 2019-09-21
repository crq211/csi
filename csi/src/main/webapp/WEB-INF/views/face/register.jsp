<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/8/23
  Time: 9:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<html>
<head>
    <title>Title</title>
    <link href="face/faceStyle.css" rel="stylesheet">
    <script>
        $(document).ready(function() {
            //粒子背景特效
            $('body').particleground({
                dotColor: '#5cbdaa',
                lineColor: '#5cbdaa'
            });
            //验证码
            createCode();
            //测试提交，对接程序删除即可
            //$(".submit_btn").click(function(){
            // localhost.href="index.jsp";
            //});
        });
    </script>

    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        body {
            height: 100vh;
            background-position: center;
            overflow: hidden;
        }

        h1 {
            color: #fff;
            text-align: center;
            font-weight: 100;
            margin-top: 40px;
        }

        #media {
            width: 100%;
            height: 250px;
            margin: 10px auto 0;
            border-radius: 30px;
            overflow: hidden;
            /*opacity: 0.7px;*/
        }


        #canvas {
            display: none;
        }
        body {
            height: 100%;
            background: #213838;
            overflow: hidden;
        }

        canvas {
            z-index: -1;
            position: absolute;
        }
    </style>
</head>
<body>
<dl class="admin_login">
    <dt>
        <strong>CSI员工之家</strong><em></em> <strong>请把你的脸放摄像头面前</strong>
    </dt>
    <div id="media">
        <video id="video" width="100%" height="300" autoplay></video>
        <canvas id="canvas" width="530" height="300"></canvas>
    </div>
    <dd>
        <input type="button" onClick="query()" value="立即注册"
               class="submit_btn" />
    </dd>

</dl>
<script type="text/javascript" src="js/alert.js"></script>
<script>
    var video = document.getElementById("video"); //获取video标签
    var context = canvas.getContext("2d");
    var con  ={
        //同时请求不带任何参数的音频和视频
        audio:false,
        video:true,
        video:{
            width:1980,
            height:1324,
        }
    };

    //导航 获取用户媒体对象
    navigator.mediaDevices.getUserMedia(con)
        .then(function(stream){
            try{
                video.src = window.URL.createObjectURL(stream);
            }catch(e){
                video.srcObject=stream;
            }
            video.onloadmetadate = function(e){
                video.play();

            }
        });

    function query(){
        //把流媒体数据画到convas画布上去
        context.drawImage(video,0,0,530,300);
        var base = getBase64();
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/faceRegister",
            data:{"base":base},
            dataType: "json",
            success:function(json){
                $.MsgBox.Alert("消息",json.message);
                setTimeout("javascript:location.href='${pageContext.request.contextPath}/home'", 2000);
            }
        });
    }
    function getBase64() {
        var imgSrc = document.getElementById("canvas").toDataURL(
            "image/png");

        return imgSrc.split("base64,")[1];

    }
</script>
</body>
</html>
