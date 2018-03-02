<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="renderer" content="webkit">

  <title>大美登录</title>
  <meta name="keywords" content="大美,OA">
  <meta name="description" content="大美OA系统登录">

  <link rel="stylesheet" href="${ctx}/static/core/css/lib.css">
  <link rel="stylesheet" href="${ctx}/static/core/css/style.css">
</head>

<body class="gray-bg">
<div id=loginCont class="middle-box text-center loginscreen  animated fadeInDown" style="width:400px">
	    <div style="margin: 20px 0px">
	      <img src="static/core/img/logo.png">
	    </div>
	    </br>
		<h3><img src="static/core/img/success.png" style="margin-top: -14px;">&nbsp;&nbsp;您已成功退出系统  <a href="/index">重新登录</a></h3>
</div>
</body>
</html>
