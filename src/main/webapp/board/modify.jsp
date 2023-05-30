<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="org.apache.catalina.ant.jmx.JMXAccessorQueryTask"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 파라미터값 조회
	int no = Integer.parseInt(request.getParameter("no"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 요청파라미터로 전달받은 상품번호로 데이터베이스에서 상품정보 조회
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(no);
	
	// 요청파라미터로 전달받은 수정된 상품정보를 Board객체에 저장해서 값을 덮어쓰기
	board.setTitle(title);
	board.setContent(content);
	
	// 수정된 정보가 포함된 Board객체를 전달해서 데이터베이스에 반영시키기
	boardDao.updateBoard(board);
	
	// 재요청URL 응답
	response.sendRedirect("detail.jsp?no=" +no);
%>