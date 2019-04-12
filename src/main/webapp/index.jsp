<%@page language="java" contentType="text/html; utf-8" pageEncoding="utf-8" %>
<html>
<head>
    <title>Test integerat_maven</title>
    <link href="${pageContext.request.contextPath}/themes1.3.5/icon.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/themes1.3.5/default/easyui.css" type="text/css" rel="stylesheet">

    <%--引入两个js脚本库：一个jQuery的，一个easyUI自身形成的
    必须保证jQuery脚本库在上面--%>
    <script src="${pageContext.request.contextPath}/js/jquery.min1.3.5.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.easyui.min1.3.5.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN1.3.5.js" type="text/javascript"></script>
    <script>
        $(function () {
            $("#addView").dialog({
                title: "添加信息",
                height: 400,
                width: 400,
                modal: true,
                closed: true,
                buttons: "#addButton"
            })

            $("#updateView").dialog({
                title: "修改信息",
                height: 400,
                width: 400,
                modal: true,
                closed: true,
                buttons: "#updateButton"
            })

            $("#userTableView").datagrid({
                title: "学生信息展示",
                url: '${pageContext.request.contextPath}/user/selectAll',
                pagination: true,
                columns: [[
                    {checkbox: true},
                    {field: 'id', title: '编号', width: 100},
                    {field: 'name', title: '姓名', width: 100},
                    {field: 'age', title: '年龄', width: 100},
                    {
                        field: 'caozuo', title: '操作', width: 100,
                        formatter: function (value, rowDate, rowIndex) {
                            return "<a href=\"javascript:void(0)\" onclick=\"updateUser(" + rowDate.id + ")\">修改</a>"
                        }
                    }
                ]]
            })
        })

        function addUserView() {
            $("#addView").dialog("open")
        }

        function addForm() {
            $("#addForm").form("submit", {
                url: "${pageContext.request.contextPath}/user/insert",
                onSubmit: function () {
                },
                success: function (data) {
                    $("[name=name]").val('')
                    $("[name=age]").val('')
                    $("#addView").dialog("close")
                    $("#userTableView").datagrid("reload")
                }
            })
        }

        function deleteUser() {
            var selects = $("#userTableView").datagrid("getSelections")
            if (confirm("你确定要删除吗？")) {
                var ids = new Array()
                for (var i = 0; i < selects.length; i++) {
                    ids[i] = selects[i].id
                }
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/delete",
                    data: "ids=" + ids,
                    success: function (data) {
                        alert("删除成功")
                        $("#userTableView").datagrid("reload")
                    }
                })
                console.log(ids)
            }
        }

        function updateUser(id) {
            $.ajax({
                url: "${pageContext.request.contextPath}/user/selectOne",
                data: "id=" + id,
                success: function (data) {
                    console.log(data)
                    $("#updateName").val(data.user.name)
                    $("#updateAge").val(data.user.age)
                    $("#updateId").val(data.user.id)
                    $("#updateView").dialog("open")
                }
            })
        }

        function updateForm() {
            $("#updateForm").form("submit", {
                url: "${pageContext.request.contextPath}/user/update",
                onSubmit: function () {
                },
                success: function (data) {
                    $("#updateView").dialog("close")
                    $("#userTableView").datagrid("reload")
                }
            })
        }
    </script>
</head>

<body>

<div id="userView">
    <a id="deleteButtons" href="javascript:void (0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'"
       onclick="deleteUser()">删除选中</a>
    <a id="addButtons" href="javascript:void (0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'"
       onclick="addUserView()">添加</a>
    <table id="userTableView">

    </table>
</div>

<div id="addView">
    <form id="addForm">
        学生姓名：<input type="text" name="name"><br/>
        <h1></h1>
        学生年龄：<input type="text" name="age">
    </form>
</div>
<div id="addButton">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="addForm()">添加</a>
</div>

<div id="updateView">
    <form id="updateForm">
        学生姓名：<input type="text" name="name" id="updateName"><br/>
        <input type="hidden" name="id" id="updateId">
        <h1></h1>
        学生年龄：<input type="text" name="age" id="updateAge">
    </form>
</div>
<div id="updateButton">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateForm()">修改</a>
</div>
</body>

</html>