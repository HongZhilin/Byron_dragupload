package cn.edu.zjut;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet
public class FileUploadServlet extends HttpServlet {

	/*public FileUploadServlet() {
		super();
	}*/

	private static final long serialVersionUID = 1L;

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doGet(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//设置编码格式
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		try {
			//获取服务器
//			String uploadPath = request.getServletContext().getRealPath("/")+"upload/";
			String uploadPath = request.getServletContext().getRealPath("/upload");
			boolean isMuti = ServletFileUpload.isMultipartContent(request);
			
			if(isMuti){
				//获得文件上传处理工厂
				FileItemFactory factory = new DiskFileItemFactory();
				//创建容器文件处理类
				ServletFileUpload upload = new ServletFileUpload(factory);
				//解析上传文件,得到上传文件集合
				List<FileItem> files = upload.parseRequest(request);
				
				for(FileItem item : files){
					//得到文件名字
					String fileName = item.getName();
					if(fileName!=null){
						File saveFile = new File(uploadPath+"/"+fileName);
						item.write(saveFile); //写入到指定的路径
					}
				}
				response.getWriter().print("{\"aa\":123}");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
