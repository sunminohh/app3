<%@page import="vo.Board"%>
<%@page import="dao.BoardDao"%>
<%@page import="vo.Comment"%>
<%@page import="dao.CommentDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% 
	/*
	요청 URL 
		localhost/app3/board/deleteComment.jsp?no=게시글번호&cno=커멘트번호
	*/
	
	//요청 파라미터값 조회하기
	int boardNo = Integer.parseInt(request.getParameter("no"));
	int commentNo = Integer.parseInt(request.getParameter("cno"));
	
	// 세션에서 로그인한 사용자 정보 조회하기
	String loginId = (String) session.getAttribute("loginId");
	
	if (loginId == null){
		response.sendRedirect("../loginform.jsp?err=req&job" +URLEncoder.encode("커멘트삭제", "utf-8"));
		return;
	}
	
	// 커멘트의 작성아이디와 로그인 아이디가 일치하는지 체크
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.getCommentByNo(commentNo);
	if (!loginId.equals(comment.getCustomer().getId())) {
		response.sendRedirect("detail.jsp?no=" + boardNo + "&err=id");
		return;
	}
	
	// 커멘트정보 삭제
	commentDao.deleteCommentByNo(commentNo);
	
	// 글번호로 게시글 정보 조회
	BoardDao boardDao = new BoardDao();
	Board board = boardDao.getBoardByNo(boardNo);
	// 게시글의 댓글 개수를 감소시켜
	board.setCommentCnt(board.getCommentCnt()-1);
	// 게시글 정보를 update
	boardDao.updateBoard(board);
	
	// detail.jsp?no=boardNo를 재요청하는 URL을 응답으로 보낸다.
	response.sendRedirect("detail.jsp?no=" +boardNo);
%>














