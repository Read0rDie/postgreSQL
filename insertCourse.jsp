
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
statement = connection.createStatement();
rs = statement.executeQuery("SELECT FROM courses");
int count = 1;
while(rs.next()){
	count++;
}
%>


<div class="table">
<h3 style="color:white;">New Course Record</h3>
</div>
<form name="stud"  class="table" action="insertCourse.jsp" method="POST">
	<table class="centerTable" BORDER="1">
	<tr>
		<td>Course Description:  </td>
		<td><input type="text" name="desc" value="" size="50"/></td>
	</tr>
	<tr>
		<td>Grade Level: </td>
		<td><input type="radio" name="level" value="ugrad" size="50"/>Undergraduate<input style="margin-left:30px;" type="radio" name="level" value="grad" size="50"/>Graduate</td>
	</tr>		
	<tr>
		<td>Instructor ID#: </td>
		<td><input type="text" name="iid" value="" size="50"/></td>
	</tr>
	<tr>
		<td>Year: </td>
		<td><input type="text" name="year" value="" size="50"/></td>
	</tr>
	<tr>
		<td>Semester: </td>
		<td><input type="radio" name="sem" value="Spring" size="50"/>Spring<input style="margin-left:30px;" type="radio" name="sem" value="Fall" size="50"/>Fall</td>
	</tr>
	</table>
	<input class="insert" type="reset" name="clear" value="Clear"/>
	<input class="insert" type="submit" name="submit" value="submit"/>
		
</form>		


<%

String course = "INSERT INTO courses (course_id, description, level, instructor, semester) VALUES (?,?,?,?,?)";

String year = new String();
String semester = new String();
String time = new String();
String iid = new String();
String name = new String();
String gl = new String();


if(request.getParameter("year") != null){
	year = request.getParameter("year");
}	
if(request.getParameter("sem") != null){
	semester = request.getParameter("sem");
}
if(request.getParameter("iid") != null){
	iid = request.getParameter("iid");
}
if(request.getParameter("desc") != null){
	name = request.getParameter("desc");
}
if(request.getParameter("level") != null){
	gl = request.getParameter("level");
}

time = semester + " " + year;

if((request.getParameter("submit") != null) &&
(request.getParameter("year") != null) &&
(request.getParameter("sem") != null) &&
(request.getParameter("iid") != null) &&
(request.getParameter("desc") != null) &&
(request.getParameter("level") != null)){


insert = connection.prepareStatement(course);
int courseId = count;
int facultyId = Integer.parseInt(iid);

insert.setInt(1, courseId);					
insert.setString(2,name);
insert.setString(3, gl);
insert.setInt(4, facultyId);
insert.setString(5, time);
insert.executeUpdate();

}

%>

</body></html>
