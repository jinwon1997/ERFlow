<!-- unitRegister.jsp -->
<!-- 
	@author 권명승 & 장진원
	@version 1.0.2
	@see
 -->
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="model.UserBean"%>
<%@page import="helper.WebHelper"%>
<jsp:useBean id="permissionCon" class="controller.PermissionController"/>
<%
final String PROGRAM_CODE = "8A4364846CD2FC493883860129E7B91E800820F895EDC9DDEDE4CC10E8389BC2";

if (!WebHelper.isLogin(session) || !permissionCon.hasProgramPermission(session, PROGRAM_CODE)) {
	response.sendRedirect("../permissionError.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>설비 리스트 페이지</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script> <!-- datepicker -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> <!-- datepicker -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="../css/bootcss/bootstrap.css">
<link rel="stylesheet" href="../css/jquery-ui.css">
<link rel="stylesheet" href="../css/common/common.css">
<link rel="stylesheet" href="../css/main/unitRegister.css">
<script src="../js/bootjs/bootstrap.js"></script>
<script src="../js/admin/admin.js"></script>
<script src="../js/main/unitRegister.js"></script>
<script src="../js/datepicker.js"></script>

</head>
<body>

	<div class="unit-register-form">
		<form action="unitRegisterProc.jsp" method="post" name="unitFrm">
			<div class="form-group">
				<label for="equipmentId">장비ID</label> <input type="text"
					id="equipmentId" name="equipmentId">
			</div>
			<div class="form-group">
				<label for="userId">관리자ID</label>
				<input type="text" id="userId" name="userId">
				<button type="button" class="btn btn-light find-user">관리자 선택</button>
			</div>
			<div class="form-group">
				<label for="documentId">문서ID</label>
				<input type="text" id="documentId" name="documentId" class="documentId" readonly>
				<button type="button" class="btn btn-light find-document">문서 선택</button>
			</div>
			<div class="form-group">
				<label for="equipmentName">장비명</label> <input type="text"
					id="equipmentName" name="equipmentName">
			</div>
			<div class="form-group">
				<input type="text" id="datepicker" name="manufactureDate">
			</div>
			<button type="submit">제출</button>
		</form>
	</div>
</body>
</html>