
<%@ page import="java.sql.*" %>

<%
String connectionURL = 
"jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/fall16_adubu002?user=fall16_adubu002&password=2247356";

Connection connection = null;
PreparedStatement insert = null;
Statement statement = null;
ResultSet rs = null;
%>

<html>
	<head>
		<title></title>
		<link rel="shortcut icon" type="image/x-icon" href="img/logo2.png" />
		<link rel="shortcut icon" type="image/x-icon" href="#" />
		<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">	
		<link rel="stylesheet" type="text/css" href="css/main.css">
	</head>
	<body bgcolor="#22313f">
		<header>
			<div class="container">
			<a href="">
				<img class="brand" src="img/logo2.png">
			</a>
			<h1>
				University Records
			</h1>	
			<ul>
				<li><a  href="home1.jsp">Home</a></li>
				<li id="home"><a id="home-text"  href="students.jsp">Students</a></li>
				<li><a href="faculty.jsp">Faculty</a></li>
				<li><a href="courses.jsp">Courses</a></li>
				<li><a href="enroll.jsp">Enrollment</a></li>						
			</ul>			
			</div>
		</header>
<%
Class.forName("org.postgresql.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL);
%>


<div class="table">
<h3 style="color:white;">New Enrollment Record</h3>
</div>
<form name="stud"  class="table" action="insertEnroll.jsp" method="POST">
	<table class="centerTable" BORDER="1">
	<tr>
		<td>Student ID#: </td>
		<td><input type="text" name="sid" value="" size="50"/></td>
	</tr>
	<tr>
		<td>Course ID#: </td>
		<td><input type="text" name="cid" value="" size="50"/></td>
	</tr>
	<tr>
		<td>Grade: </td>
		<td><input type="radio" name="grade" value="A" size="50"/>A<input style="margin-left:10px;" type="radio" name="grade" value="B" size="50"/>B<input style="margin-left:10px;" type="radio" name="grade" value="C" size="50"/>C<input style="margin-left:10px;" type="radio" name="grade" value="D" size="50"/>D<input style="margin-left:10px;" type="radio" name="grade" value="F" size="50"/>F</td>
	</tr>		
	</table>
	<input class="insert" type="reset" name="clear" value="Clear"/>
	<input class="insert" type="submit" name="submit" value="submit"/>
		
</form>		


<%
int id;


String enroll = "INSERT INTO enroll (student_id, course_id, grade) VALUES (?,?,?)";

String sid = new String();
String cid = new String();
String grade = new String();

if(request.getParameter("sid") != null){
	sid = request.getParameter("sid");
}	
if(request.getParameter("cid") != null){
	cid = request.getParameter("cid");
}
if(request.getParameter("grade") != null){
	grade = request.getParameter("grade");
}

if((request.getParameter("submit") != null) &&
(request.getParameter("sid") != null) &&
(request.getParameter("cid") != null) &&
(request.getParameter("grade") != null)){

int studentId = Integer.parseInt(sid);
int courseId = Integer.parseInt(cid);
insert = connection.prepareStatement(enroll);

insert.setInt(1, studentId);					
insert.setInt(2,courseId);
insert.setString(3, grade);
insert.executeUpdate();

}

%>

</body></html>
