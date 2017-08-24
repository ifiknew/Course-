<%@ page import="org.springframework.web.context.annotation.RequestScope" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.zhsite.model.Course" %>
<%@ page import="cn.zhsite.model.state.CourseState" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/3/15
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class='no-js' lang='en'>
<head>
    <meta charset='utf-8'>
    <meta content='IE=edge,chrome=1' http-equiv='X-UA-Compatible'>
    <title>Dashboard</title>
    <meta content='lab2023' name='author'>
    <meta content='' name='description'>
    <meta content='' name='keywords'>
    <link href="/assets/css/application-default.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/plugin/font-awesome.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/theme.css" rel="stylesheet" type="text/css" />
    <link href="/assets/image/favicon.ico" rel="icon" type="image/ico" />
    <style type="text/css">
    </style>
</head>
<body class='main page'>
<!-- Navbar -->
<div class='navbar navbar-default' id='navbar' >
    <a class='navbar-brand' href='#' style="padding: 5px 10px">
        <i class='icon-beer'></i>
        Course+
    </a>
    <ul class='nav navbar-nav pull-right'>
        <li class='dropdown user'>
            <a class='dropdown-toggle' data-toggle='dropdown' href='#'  style="padding: 5px 10px">
                <i class='icon-user'></i>
                <strong>John DOE</strong>
                <b class='caret'></b>
            </a>
            <ul class='dropdown-menu'>
                <li>
                    <a href="/home/logout.do">注销登录</a>
                </li>
            </ul>
        </li>
    </ul>
</div>
<div id='wrapper' style="top: 50px">
    <!-- Sidebar -->
    <section id='sidebar'>
        <i class='icon-align-justify icon-large' id='toggle'></i>
        <ul id='dock'>
            <li class='launcher'>
                <i class='icon-dashboard'></i>
                <a href="/college/home">机构主页</a>
            </li>
            <li class='launcher active'>
                <i class='icon-table'></i>
                <a href="/college/course">课程管理</a>
            </li>
            <li class='launcher'>
                <i class='icon-cloud'></i>
                <a href='/college/payment'>财务记录</a>
            </li>
        </ul>
        <div data-toggle='tooltip' id='beaker' title='Made by lab2023'></div>
    </section>
    <!-- Tools -->
    <section id='tools'>
        <ul class='breadcrumb' id='breadcrumb'>
            <li class='title'>Course+</li>
            <li class="active"><a href="#">课程管理</a></li>
        </ul>
        <div id='toolbar'>
            <a class="btn bg-primary" href="/college/registerCourse">开设课程</a>
        </div>
    </section>
    <!-- Content -->
    <div id='content'>
        <%List<Course> courseList = (List<Course>) request.getAttribute("courseList");%>
        <%if(courseList.isEmpty()){%>
        <div class="whole-page">
            您没有开设任何课程。
        </div>
        <%}else{%>
        <table class='table'>
            <thead>
            <tr>
                <th>课程编号</th>
                <th>课程名称</th>
                <th>任课教师</th>
                <th>限制人数</th>
                <th>课程价格</th>
                <th>开课时间</th>
                <th>结课时间</th>
                <th>课程状态</th>
                <th class='actions'></th>
            </tr>
            </thead>
            <tbody>
        <%for(Course course:courseList) {
            request.setAttribute("course",course);
            String disable = "disabled";
            String enable = "";
            String[][] matrix = {
                    {disable,disable,disable,disable},
                    {disable,enable,enable,enable},
                    {enable,enable,enable,enable},
                    {disable,enable,disable,disable},
                    {disable,enable,disable,disable}
            };
            int index = course.getState().ordinal();
            request.setAttribute("op1",matrix[index][0]);
            request.setAttribute("op2",matrix[index][1]);
            request.setAttribute("op3",matrix[index][2]);
            request.setAttribute("op4",matrix[index][3]);
        %>
            <tr class=''>
                <td>${course.id}</td>
                <td>${course.name}</td>
                <td>${course.teacher}</td>
                <td>${course.limitNum}</td>
                <td>${course.money}</td>
                <td>${course.fromDate}</td>
                <td>${course.toDate}</td>
                <td>${course.state.chinese}</td>
                <td class='action'>
                    <a class='btn btn-info ${op1}' data-toggle='tooltip' href='/college/course/modify/${course.id}' title='编辑课程'>
                        <i class='icon-edit'></i>
                    </a>
                    <a class='btn btn-info ${op2}' data-toggle='tooltip' href='/college/course/students/${course.id}' title='学生管理'>
                        <i class='icon-pencil'></i>
                    </a>
                    <a class='btn btn-primary ${op3}' data-toggle='tooltip' href='/college/course/${course.id}/member' title='学员登记'>
                        <i class='icon-plus-sign-alt'></i>
                    </a>
                    <a class='btn btn-primary ${op4}' data-toggle='tooltip' href='/college/course/${course.id}/student' title='普通登记'>
                        <i class='icon-plus'></i>
                    </a>
                </td>
            </tr>


        <%}%>
            </tbody>
            </table>
        <%}%>
    </div>
</div>
<!-- Footer -->
<!-- Javascripts -->
<script src="/assets/js/plugin/jquery.min.js" type="text/javascript"></script>
<script src="/assets/js/plugin/jquery-ui.min.js" type="text/javascript"></script>
<script src="/assets/js/plugin/modernizr.js" type="text/javascript"></script>
<script src="/assets/js/application-default.js" type="text/javascript"></script>

</body>
</html>
