<%@page import="vo.Customer"%>
<%@page import="dao.CustomerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 고객의 삭제 기능을 구현하세요.
	
	// 요청  URL - http://localhost/app3/customer/delete.jsp?id=xxx
	
	// 요청파라미터값 조회
	String id = request.getParameter("id");

	// 업무로직 수행 - 요청파라미터로 전달받은 고객아이디에 해당하는 고객정보를 삭제하기
	CustomerDao dao = new CustomerDao();
	
	Customer customer = dao.getCustomerById(id); 
	if ("No".equals(customer.getDisabled())) {  // 사용중인 고객인지 체크
		response.sendRedirect("detail.jsp?id="+id+"&err=fail");
		return;
	}
	
	dao.deleteCustomerById(id);
	
	// 재요청 URL 응답보내기
	response.sendRedirect("list.jsp");
%>