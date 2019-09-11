package com.java.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import net.sf.json.JSONObject;

@Controller
public class HomeController {
	
	@Autowired
	SqlSession session;
	
	@RequestMapping("/main")
	public String main(HttpServletRequest req) {
		List<WriteBean> list = session.selectList("test.select");
		req.setAttribute("list", list);
		return "home";
	}
	
	@RequestMapping("/")
	public String loginMain() {
		return "login";
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public void login(HttpServletResponse res) {
		try {
			String url="https://kauth.kakao.com/oauth/authorize?";
			url += "client_id=4495df76b551265db038d72cd7db5f1d&redirect_uri=";
			url += URLEncoder.encode("http://gdj16.gudi.kr:20004/back", "UTF-8") +"&response_type=code";
			res.sendRedirect(url);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/back")
	public String back(HttpServletRequest req, HttpServletResponse res) {
		try {
			String code = req.getParameter("code");
			String url = "https://kauth.kakao.com/oauth/token?";
			url += "client_id=4495df76b551265db038d72cd7db5f1d&redirect_uri=";
			url += URLEncoder.encode("http://gdj16.gudi.kr:20004/back", "UTF-8");
			url += "&code=" + code;
			url += "&grant_type=authorization_code";
			
			HashMap<String, Object> resultMap = HttpUtil.getUrl(url);
			System.out.println(resultMap);
			
			String userUrl = "https://kapi.kakao.com/v2/user/me";
			userUrl += "?access_token=" + resultMap.get("access_token");
			
			resultMap = HttpUtil.getUrl(userUrl);
			System.out.println(resultMap);
			
			JSONObject result = JSONObject.fromObject(resultMap.get("properties"));
			String nickname = result.get("nickname").toString();
			String id = resultMap.get("id").toString();
			LoginInfoBean log = new LoginInfoBean();
			log.setId(id);
			log.setNickname(nickname);
			
			System.out.println(nickname);
			HttpSession httpsession = req.getSession();
			httpsession.setAttribute("nickname", nickname);
			
			session.insert("test.loginInfo", log);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "redirect:/main";
	}
	
	//insert 로그인없이 insert 방지
	@RequestMapping("/insert")
	public String insult(HttpServletResponse res, HttpSession hs) {
		String nickname = (String) hs.getAttribute("nickname");
		
		if(nickname == null) {
			try {
				res.setContentType("text/html; charset=UTF-8");
				PrintWriter out;
				out = res.getWriter();
				out.println("<script>alert('로그인 해주세요. (로그인창으로 넘어갑니다.)'); location.href='/';</script>");
				out.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return "insert";
	}
	
	//insert
	@RequestMapping(value="/input", method = RequestMethod.POST)
	public String input(HttpServletRequest req, HttpSession hs, @RequestParam("file") MultipartFile[] files,
			HttpServletResponse res) {
		String nickname = (String) hs.getAttribute("nickname");
		String title = req.getParameter("title");
		String comment = req.getParameter("comment");
		
		System.out.println(req.getParameter("title")+comment+nickname);
		
		WriteBean wb = new WriteBean();
		wb.setTitle(title);
		wb.setComment(comment);
		wb.setNickname(nickname);
		session.insert("test.insert", wb);
		return "redirect:/main";
	}
	
	@RequestMapping("/contents/{no}")
	public String contents(@PathVariable("no") int no, HttpServletRequest req) {
		List<WriteBean> wb = session.selectList("test.contents", no);
		req.setAttribute("wb", wb);
		return "/contents";
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest req) {
		String no = req.getParameter("contentNo");
		session.update("test.delete", no);
		return "redirect:/main";
	}
	
	@RequestMapping("/updateMove")
	public String updateMove(HttpServletRequest req, HttpSession hs, HttpServletResponse res) {
		int no = Integer.parseInt(req.getParameter("contentNo"));
		String nickname = (String) hs.getAttribute("nickname");
		String originalNick = session.selectOne("test.updateAth", no);
		List<WriteBean> wb = session.selectList("test.contents", no);
		req.setAttribute("wb", wb);
		
		return "/insert";
	}
	
	@RequestMapping("/update")
	public String update(HttpServletRequest req) {
		System.out.println("업데이트");
		String title = req.getParameter("title");
		String comment = req.getParameter("comment");
		int urlNo = Integer.parseInt(req.getParameter("urlNo"));
		
		System.out.println(urlNo);
		
		WriteBean wb = new WriteBean();
		wb.setTitle(title);
		wb.setComment(comment);
		wb.setNo(urlNo);
		
		System.out.println(title+comment);
		
		session.update("test.update", wb);
		
		return "redirect:/contents/" + urlNo;
	}
}
