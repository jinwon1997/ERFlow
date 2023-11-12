<!-- companyRegister.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="helper.WebHelper"%>
<%@page import="model.UserBean"%>
<jsp:useBean id="permissionCon" class="controller.PermissionController"/>
<%
final String IN_PROGRAM_CODE = "4F6B21882D7C310CC96B01D478A381D0DCF410B574B7185E6EA449173834A561";
final String OUT_PROGRAM_CODE = "90739BBD5C68921E8D32D44EAB220654A1C51710FDE97F6639DD0CFCBB91E2DB";

UserBean user = WebHelper.getValidUser(session);

if (!WebHelper.isLogin(session)) {
	response.sendRedirect("../permissionError.jsp");
	return;
}
String bankCode = request.getParameter("bankCode");
String bankName = request.getParameter("bankName");

String paramFlag = request.getParameter("flag");
String programId = "";

if (paramFlag != null && !paramFlag.trim().equals("")) {
	switch (paramFlag) {
		case "0":
			programId = OUT_PROGRAM_CODE;
			break;
		case "1":
			programId = IN_PROGRAM_CODE;
			break;
	}
}
int flag = 2;

if (!WebHelper.isLogin(session) && programId.equals("")) {
	flag = 2;
} else if (permissionCon.hasProgramPermission(session, programId)) {
	switch (programId) {
		case OUT_PROGRAM_CODE:
			flag = 0;
			break;
		case IN_PROGRAM_CODE:
			flag = 1;
			break;
	}
}
if (flag == 2) {
	response.sendRedirect("../permissionError.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>협력업체 추가 페이지</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"
	integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="../css/bootcss/bootstrap.css">
<link rel="stylesheet" href="../css/common/common.css">
<link rel="stylesheet" href="../css/main/aside.css">
<link rel="stylesheet" href="../css/main/header.css">
<link rel="stylesheet" href="../css/main/companyRegister.css">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../js/bootjs/bootstrap.js"></script>
<script src="../js/admin/location.js"></script>
<script src="../js/main/index.js"></script>
<script src="../js/main/companyRegister.js"></script>
</head>
<body>
	<%@ include file="/indexHeader.jsp"%>
	<div class="content-wrap">
		<%@ include file="/indexSide.jsp"%>
		<!-- 여기가 본문 페이지 -->
		<div class="company-insert-wrap">
			<div class="right-align">
				<span class="menu-name">사용자 > <%=(flag == 0 ? "영업" : "구매")%> > 협력업체 추가</span>
			</div>
			<div class="company-insert">
				<div class="company-form">
					<form action="companyRegisterProc.jsp" method="post">
						<div class="form-group">
							<label for="companyName">회사명</label> <input type="text"
								id="companyName" name="companyName" placeholder="회사명">
							<input type="hidden" name="status" value="<%=flag%>">
							<input type="text" value="<%=flag == 0 ? "상청" : "하청"%>" readonly>
						</div>
						<div class="form-group">
							<label for="input4">회사 주소:</label> <input type="text"
								id="sample6_postcode" placeholder="우편번호" name="postalCode">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목">
							<input type="button" class="btn_execDaumPostcode" value="우편 찾기">
							<input type="text" id="sample6_address" placeholder="도로명 주소"
								name="address1"><br> <input type="text"
								id="sample6_detailAddress" placeholder="상세주소" name="address2">
						</div>

						<div class="form-group">
							<label for="companyPhone">업체 전화번호</label> <input type="text"
								id="companyPhone" name="companyPhone" placeholder="업체 전화 번호">
						</div>
						<div class="form-group">
							<label for="businessNumber">사업자 등록번호</label> <input type="text"
								id="businessNumber" name="businessNumber" placeholder="사업자 등록번호">
						</div>
						<div class="form-group">
							<label for="workCode">업체 종목 선택</label> <input type="text"
								id="workCode" name="workCode" placeholder="업체코드" readonly>
							<input type="text" id="workName" name="workName"
								placeholder="업체명" readonly> <input type="button"
								id="find-work" value="업체 찾기">
						</div>
						<div class="form-group">
							<label for="bankCode">은행 선택</label> <input type="text"
								id="bankCode" name="bankCode" placeholder="은행 코드" readonly>
							<input type="text" id="bankName" name="bankName"
								placeholder="은행명" readonly> <input type="button"
								id="find-bank" value="은행 찾기">
						</div>
						<div class="form-group">
							<label for="bankAccount">은행 계좌번호</label> <input type="text"
								id="bankAccount" name="bankAccount" placeholder="계좌 번호">
						</div>
						<div class="form-group text-center">
							<button type="submit" class="form-Register-btn">제출</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
