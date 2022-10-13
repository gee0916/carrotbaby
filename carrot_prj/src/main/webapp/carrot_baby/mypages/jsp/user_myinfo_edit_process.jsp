<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="userDAO.MyInfoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://211.63.89.148/jsp_prj/common/css/main_v1_220901.css"/>
<style type="text/css">

</style>
<!-- jQuery google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap Css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- Bootstrap Js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

<script type="text/javascript">

</script>
</head>
<body>
<% //POST 방식 요청 한글 처리
request.setCharacterEncoding("UTF-8");
%>

<!-- parameter 받을 VO 생성 -->
<jsp:useBean id="miVO" class="userVO.MyInfoVO"></jsp:useBean>

<!-- 이미지 -->
<%
//1.업로드 경로 얻기
File uploadDir = new File("C:/Users/user/git/carrot_prj/carrot_prj/src/main/webapp/carrot_baby/user_profile_upload");
//2.업로드할 파일 크기를 연산
//5MByte까지의 파일을 업로드
int maxSize=1024*1024*5;
//3.업로드 : MultipartRequest를 생성하면 파일이 업로드 된다.
MultipartRequest mr = new MultipartRequest(request, uploadDir.getAbsolutePath(), maxSize,"UTF-8", new DefaultFileRenamePolicy()); 
//4. file control 처리
//원본 파일명
String originalName=mr.getOriginalFileName("upfile");
//변경된 파일명
String reName=mr.getFilesystemName("upfile");

boolean flag=false;
File temp=new File(uploadDir.getAbsolutePath()+"/"+reName);
int checkSize=1024*1024*5;
if(temp.length()> checkSize) {
	flag=false;
	temp.delete();
}
//이름
String name=mr.getParameter("name");
System.out.println(name);
//닉네임
String nick=mr.getParameter("nick");
System.out.println(nick);
//아이디
String id=mr.getParameter("id");
System.out.println(id);
//생년월일
String birth=mr.getParameter("birth");
System.out.println(birth);
//휴대폰번호
String phone_num=mr.getParameter("phone_num");
System.out.println(phone_num);
//sms 수신동의
String sms_chk=mr.getParameter("sms_chk");
//sms 수신동의 체크하지 않았을 때 sms_chk가 'N'으로 설정되도록.
if(sms_chk==null){
	sms_chk="N";
}
System.out.println(sms_chk);
//이메일
String email=mr.getParameter("email");
System.out.println(email);
//이메일 수신동의
String email_chk=mr.getParameter("email_chk");
//이메일 수신동의 체크하지 않았을 때 email_chk가 'N'으로 설정되도록.
if(email_chk==null){
	email_chk="N";
}
System.out.println(email_chk);
//주소
String addr1=mr.getParameter("addr1");
System.out.println(addr1);
//상세주소
String addr2=mr.getParameter("addr2");
System.out.println(addr2);
//우편번호
String zipcode=mr.getParameter("zipcode");
System.out.println(zipcode);
%>


<!-- VO의 setter method(property) 호출 -->
<!-- enctype을 "multipart/form-data"로 선언하고 submit한 데이터들은 request객체가 아닌 MultipartRequest객체로 불러와야 한다. -->
<jsp:setProperty property="img" name="miVO" value="<%= reName %>"/>
<jsp:setProperty property="name" name="miVO" value="<%= name %>"/>
<jsp:setProperty property="nick" name="miVO" value="<%= nick %>"/>
<jsp:setProperty property="phone_num" name="miVO" value="<%= id %>"/>
<jsp:setProperty property="sms_chk" name="miVO" value="<%= sms_chk %>"/>
<jsp:setProperty property="email" name="miVO" value="<%= email %>"/>
<jsp:setProperty property="email_chk" name="miVO" value="<%= email_chk %>"/>
<jsp:setProperty property="zipcode" name="miVO" value="<%= zipcode %>"/>
<jsp:setProperty property="addr1" name="miVO" value="<%= addr1 %>"/>
<jsp:setProperty property="addr2" name="miVO" value="<%= addr2 %>"/>
<jsp:setProperty property="id" name="miVO" value="${id }"/>

<%
//입력된 정보를 업데이트 
MyInfoDAO miDAO = MyInfoDAO.getInstance();
out.println(miVO);
int result = miDAO.updateInfo(miVO);

//다른 추가 정보를 입력하지 않더라도 창이 뜨도록 함.
if(result>-1){%>
	<script type="text/javascript">
		alert("정보가 수정되었습니다.")
		location.href="user_myinfo_edit.jsp";
	</script>
<% } %>
</body>
</html>