<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/leftmenu.jsp" %>

<script>
	alert('${msg}');
	
	if('${value}' == 'myPageUpdateSuccess') location.replace('${cpath}/common/myPage')
	if('${value}' == 'myPageUpdateFail') location.replace('history.go(-1)')
</script>

<%@ include file="../layout/footer.jsp" %>