<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 URL - http://localhost/app3/board/detail.jsp?no=xxx
	
	// 요청 파라미터 조회
	int no = Integer.parseInt(request.getParameter("no"));

	//업무로직 수행 - 요청파라미터로 전달받은 게시글번호에 해당하는 게시글 상세정보 조회하기
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(no);
	
	// 요청파라미터로 전달받은 수정된 게시글정보를 Board객체에 저장해서 값을 덮어쓰기
	// 게시글정보의 조회수를 1증가
	board.setReadCnt(board.getReadCnt()+1);
	// 조회수가 변경된 게시글 정보를 테이블에 반영
	boardDao.updateBoard(board);
	// detail.jsp?no=xxx를 재요청
	response.sendRedirect("detail.jsp?no=" +no);
	
	// 세션에서 로그인된 사용자 정보 조회하기
	String loginId = (String) session.getAttribute("loginId");
%>