<%@page import="helper.WebHelper"%>
<%@page import="model.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
UserBean user = WebHelper.getValidUser(session);

if (!WebHelper.isLogin(session)) {
	response.sendRedirect("../permissionError.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"
    integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="../css/common/common.css">
	<link rel="stylesheet" href="../css/common/page.css">
	<link rel="stylesheet" href="../css/main/header.css">
    <link rel="stylesheet" href="../css/main/index.css">
    <link rel="stylesheet" href="../css/main/aside.css">
    <script src="../js/bootjs/bootstrap.js"></script>
	<link rel="stylesheet" href="../css/bootcss/bootstrap.css">
    <link rel="stylesheet" href="../css/message/register.css">
    <script src="../js/message/register.js"></script>
    <script src="../js/message/index.js"></script>
</head>
<body>
	<div class="main-notice">
	    <div class="upside"></div>
	    <div class="board-content-body">
	    <table class="plus-table">
	        <tr>
	            <td>
		            <form method="post" action="registerProc.jsp" name="regFrm">
		            <table class="inner-plus-table">
		                <tr>
		                    <td class="plus-messageform-header">받는 사람</td>
		                    <td class="search-people"><input class="form-control" name="receiverId" id="receiverId" size="30" readonly
		                    	maxlength="30" placeholder="찾기 버튼을 눌러 받을 사람을 설정하세요.">
		                    	<button type="button" class ="search-message">찾기</button>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="plus-messageform-content">내 용</td>
		                    <td><textarea name="content" class="form-control" rows="15" cols="60"></textarea></td>
		                </tr>             
		                <tr>
		                    <td colspan="2"><hr></td>
		                </tr>
		                <tr>
		                    <td class="plus-messageform-footer" colspan="2">
		                    	<div class="messageform-footer-button">
		                    		<button class="btn btn-primary" type="submit">등록</button>
		                    		<button type="button" class="btn btn-secondary close-message">취소</button>
		                    	</div>
		                    </td>
		                </tr>
		            </table>
		            </form>
	            </td>
	        </tr>
	    </table>
	    </div>
	</div>
</body>
</html>