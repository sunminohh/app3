<%@page import="vo.Board"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dao.BoardDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	//요청 URL - localhost/app3/board/delete.jsp?
	
	// 요청파라미터값 조회
	int no = Integer.parseInt(request.getParameter("no"));

	// 세션에서 로그인한 사용자 정보 조회하기
	String loginId = (String) session.getAttribute("loginId");
	
	if (loginId == null){
		response.sendRedirect("../loginform.jsp?err=req&job" +URLEncoder.encode("커멘트삭제", "utf-8"));
		return;
	}
	
	//업무로직 수행 - 요청파라미터로 전달받은 게시글번호에 해당하는 게시글정보를 삭제하기
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(no);
	
	if (!board.getCustomer().getId().equals(loginId)){
		response.sendRedirect("detail.jsp?no=" + no +"&err=id&job="+URLEncoder.encode("댓글삭제", "utf-8"));
		return;
	}
	
	board.setDeleted("Y");
	boardDao.updateBoard(board);
	
	// 재요청 URL 응답보내기
	response.sendRedirect("list.jsp");
%>