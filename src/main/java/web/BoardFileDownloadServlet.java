package web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import org.apache.tomcat.util.http.fileupload.IOUtils;

import dao.BoardDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vo.Board;

/*
 * 요청 URL - http://localhost/app3/board/downlaod?no=게시글번호
 */
@WebServlet(urlPatterns = "/board/download")
public class BoardFileDownloadServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 요청 파라미터 조회
		int boardNo = Integer.parseInt(request.getParameter("no"));
		
		// 게시글 정보 조회
		BoardDao boardDao = new BoardDao();
		Board board = boardDao.getBoardByNo(boardNo);
		
		// 첨부파일 이름 조회
		String filename = board.getFilename();
		
		File file = new File("c:\\workspace\\files", filename);
		if (file.exists()) {
			
			String originalFilename = board.getOriginalFilename();
			// 응답메세지의 헤더부에 다운로드되는 파일에 대한 정보를 설정하기
			response.setContentType("application/octet-stream");  // octet-stream: 바이너리데이터의 기본타입
			response.setHeader("Content-Disposition", "attachment; filename=" +URLEncoder.encode(originalFilename, "utf-8"));
			
			// 다운로드할 파일을 읽어오는 스트림 생성
			InputStream in = new FileInputStream(file);
			// 브라우저와 연결된 출력 스트림 획득
			OutputStream out = response.getOutputStream();
			// 스트림 복사하기
			IOUtils.copy(in, out);
		}
		
		
	}
}













