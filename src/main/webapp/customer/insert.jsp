<%@page import="dao.CustomerDao"%>
<%@page import="vo.Customer"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 고객의 회원가입 기능을 구현하세요.
	
	// 요청 파라미터값 조회
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	
	Customer customer = new Customer();
	customer.setId(id);
	customer.setPassword(password);
	customer.setName(name);
	customer.setTel(tel);
	customer.setEmail(email);
	
	// 업무로직 수행
	CustomerDao dao = new CustomerDao();
	
	// 아이디 중복체크
	if (dao.getCustomerById(id) != null) {  // 아이디 중복 발생
		response.sendRedirect("form.jsp?err=id");
		return;
	}
	
	// 이메일 중복체크
	if (dao.getCustomerByEmail(email) != null) {  // 이메일 중복 발생
		response.sendRedirect("form.jsp?err=email");
		return;
	}
	
	
	dao.insertCustomer(customer);
	
	// 재요청URL 응답
	// 현재요청 URL - http://localhost/app3/customer/insert.jsp
	// 재요청 URL - http://localhost/app3/customer/regitered.jsp
	response.sendRedirect("registered.jsp");
%>