<!-- userRegisterProc.jsp -->
<%@page import="helper.WebHelper"%>
<%@page import="model.UnitBean"%>
<%@page import="java.util.HashMap"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="permissionCon" class="controller.PermissionController" />
<jsp:useBean id="companyCon" class="controller.CompanyController" />
<jsp:useBean id="company" class="model.CompanyBean" />
<%
if (!WebHelper.isLogin(session)) {
	response.sendRedirect("../permissionError.jsp");
	return;
}
final HashMap<String, String> parameters = new HashMap<>();
final String[] keys = new String[] { 
		"companyName", "status", "postalCode", "address1", "address2", "companyPhone",
		"businessNumber", "workCode", "bankCode", "bankAccount"};
String message = "등록에 성공했습니다.";
String nextPage = "companyList.jsp";

boolean result = true;

for (String key : keys) {
	String value = request.getParameter(key);

	if (value == null) {
		result = false;
		break;
	}
	value = value.trim();
	parameters.put(key, value.equals("") ? null : value);
}
if (result) {
	company.setName(parameters.get("companyName"));
	company.setPostalCode(parameters.get("postalCode"));
	company.setAddress1(parameters.get("address1"));
	company.setAddress2(parameters.get("address2"));
	company.setPhone(parameters.get("companyPhone"));
	company.setBusinessCode(parameters.get("businessNumber"));
	company.setField(parameters.get("workCode"));
	company.setBankCode(parameters.get("bankCode"));
	company.setBankAccount(parameters.get("bankAccount"));
	company.setSubcontract(Integer.parseInt(parameters.get("status")));

	result = companyCon.addCompany(session, company);
}

if (!result) {
	message = "등록에 실패했습니다.";
}
%>
<body>
	<script type="text/javascript">
		alert('<%=message%>');
		location.href = '<%=nextPage%>?flag=<%=parameters.get("status")%>';
	</script>
</body>