<%@ page language="java" import="fudandb.*" %>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title> Welcome | BookStore of Liang </title>
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css" id="bootstrap-css" />
    <link rel="stylesheet" type="text/css" href="./css/login.css" />
    <script src="./js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min.js" type="text/javascript"></script>
</head>

<body style="background: #eee url('resource/login_bg.png') repeat scroll 0% 0%">
	
	<div class="container">
	   <div class="login-container">
            <div id="output"></div>
            <div class="avatar" style="background-image: url('resource/login_man.jpeg')"></div>
        </div>
    </div>
    <%
		Cookie[] cookies = request.getCookies();
        String cookiename="";
        if (cookies != null) {
        	for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				
				if (cookie.getName().equals("loginname")) {
					cookiename = cookie.getValue();
					break;
				}
			}
		}
		
		if (!cookiename.equals("") ) {
    %>
    	<script type="text/javascript">
			var name = <%= "'" + cookiename + "'" %>;
			$("#output").addClass("alert alert-success animated fadeInUp").html("Welcome Back " + "<span style='text-transform:uppercase'>" + name + "</span>");
        	$("#output").removeClass(' alert-danger');
        	
        	var date = new Date();
        	var expiresMin = 60;
        	date.setTime(date.getTime()+expiresMin*60*1000);
        	document.cookie = "expires="+date.toGMTString();
        	document.cookie = "loginname=" + name;
        	function jmp() {
        		location.href = "home.jsp";
			}
			setTimeout("jmp()", 1500);
		</script>
    <% } else { 
		fudandb.Connector con = new Connector();
		fudandb.Customer customers = new Customer();
		String loginname = (String)request.getParameter("loginname");
		String password = (String)request.getParameter("password");
		if (loginname == null || password == null) {
	%>
		<script type="text/javascript">alert("Illegal EMPTY Loginname or Password !!");</script>
		<script type="text/javascript">location.href = "index.html";</script>
	<%
		} else {
			Boolean match = customers.loginCustomer(loginname, password, con.stmt);
			if (match) {
	%>
			<script type="text/javascript">
				var name = <%= "'" + loginname + "'" %>;
				$("#output").addClass("alert alert-success animated fadeInUp").html("Welcome Back " + "<span style='text-transform:uppercase'>" + name + "</span>");
	        	$("#output").removeClass(' alert-danger');
	        	
	        	var date = new Date();
	        	var expiresMin = 60;
	        	date.setTime(date.getTime()+expiresMin*60*1000);
	        	document.cookie = "expires="+date.toGMTString();
	        	document.cookie = "loginname=" + name;
	        	function jmp() {
	        		location.href = "home.jsp";
				}
				setTimeout("jmp()", 3000);
			</script>
	<% 
			} else { %>
			<script type="text/javascript">alert("Wrong Loginname or Password !!");</script>
			<script type="text/javascript">location.href = "index.html";</script>
	<% 		} 
		}
		con.closeConnection();
	}
	%>
	
</body>
</html>