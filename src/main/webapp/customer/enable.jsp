<%@page import="vo.Customer"%>
<%@page import="dao.CustomerDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 고객의 탈퇴여부를 No로 변경해서 복구처리 시키세요.
	
	// 요청  URL - http://localhost/app3/customer/enable.jsp?id=xxx
	
	// 요청파라미터값 조회
	String id = request.getParameter("id");
	
	// 업무로직 수행 - 요청파라미터로 전달받은 아이디에 해당하는 고객정보를 조회한다.
	CustomerDao dao = new CustomerDao();
	Customer customer = dao.getCustomerById(id);
	// 고객정보에서 CUST_DISABLED의 값을 'No'로 변경한다.
	customer.setDisabled("No");	
	
	//변경된 고객정보를 테이블에 반영시킨다.
	dao.updateCustomer(customer);
	
	// 재요청URL 응답
	// 현재요청 URL - http://localhost/app3/customer/disable.jsp
	// 재요청 URL - http://localhost/app3/customer/list.jsp
	response.sendRedirect("list.jsp");
%>