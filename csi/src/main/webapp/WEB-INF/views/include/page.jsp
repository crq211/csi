<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/26
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        function build_pages_nav(result, functions, ele) {
            $(ele).empty();             //置空
            var ul = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            //添加首页和前一页
            ul.append(firstPageLi).append(prePageLi);
            //增加click事件
            firstPageLi.click(function () {
                functions(1);
            });
            prePageLi.click(function () {
                functions(result.data.page.pageNum - 1);
            });
            //没有上一页，使其不可点击
            if (result.data.page.hasPreviousPage == false) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }
            //[1,2,3,4,5]
            $.each(result.data.page.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if (item == result.data.page.pageNum) {
                    numLi.addClass("active");           //增加选中样式
                }
                //跳转函数
                numLi.click(function () {
                    functions(item);
                });
                //添加循环页
                ul.append(numLi);
            });
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
            //添加下一页和末页
            ul.append(nextPageLi).append(lastPageLi);
            //增加click事件
            nextPageLi.click(function () {
                functions(result.data.page.pageNum + 1)
            });
            lastPageLi.click(function () {
                functions(result.data.page.pages);
            });
            //如果没下一页，使其不可点击
            if (result.data.page.hasNextPage == false) {
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }
            //把ul加入到nav
            var navEle = $("<nav></nav>").append(ul);
            //把nav加入到div中
            navEle.appendTo(ele);
        }

        function build_pages_jump(ele, btn) {
            $(ele).empty();
            $(ele).append("跳转到第").append(" ")
                .append("<input type='text' class='jumpSet' style='width: 30px' />")
                .append(" ").append("页").append(" ")
                .append($("<button></button>").append("确定").addClass(btn));
        }

        function build_pages_info(result, ele) {
            $(ele).empty();
            $(ele).append("总共 " + result.data.page.total + " 条记录，" +
                "当前显示" + result.data.page.startRow + "-" + result.data.page.endRow + "条记录");
            totalPage = result.data.page.pages;
            curPage = result.data.page.pageNum;
        }

    </script>
</head>
</html>
