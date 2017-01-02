<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>

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
				<li id="home"><a id="home-text" href="students.jsp">Students</a></li>
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
rs = statement.executeQuery("SELECT FROM students");
int count = 1;
while(rs.next()){
	count++;
}
%>


<div class="table">
<h3 style="color:white;">New Student Record</h3>
</div>
<form name="stud"  class="table" action="insertStudent.jsp" method="POST">
	<table class="centerTable" BORDER="1">
	<tr>
		<td>First Name: </td>
		<td><input type="text" name="first" value="" size="50"/></td>
	</tr>
	<tr>
		<td>Last Name: </td>
		<td><input type="text" name="last" value="" size="50"/></td>
	</tr>
	<tr>
		<td>D.O.B. (mm/dd/yyyy)</td>
		<td><input type="text" name="dob" value="" size="50"/></td>
	</tr>		
	<tr>
		<td>Address: </td>
		<td><input type="text" name="address" value="" size="50"/></td>
	</tr>
	<tr>
		<td>Email: </td>
		<td><input type="text" name="email" value="" size="50"/></td>
	</tr>
	<tr>
		<td>Grade Level: </td>
		<td><input type="radio" name="level" value="Instr" size="50"/>Undergraduate<input type="radio" name="level" value="Prof" size="50"/>Graduate</td>
	</tr>
	</table>
	<input class="insert" type="reset" name="clear" value="Clear"/>
	<input class="insert" type="submit" name="submit" value="submit"/>
		
</form>		


<%
int id;


String student = "INSERT INTO students (student_id, name, date_of_birth, address, email, level) VALUES (?,?,?,?,?,?)";

String lastName = new String();
String firstName = new String();
String fullName = new String();
String addr = new String();
String birth = new String();
String mail = new String();
String gl = new String();


if(request.getParameter("first") != null){
	firstName = request.getParameter("first");
}	
if(request.getParameter("last") != null){
	lastName = request.getParameter("last");
}
if(request.getParameter("address") != null){
	addr = request.getParameter("address");
}
if(request.getParameter("dob") != null){
	birth = request.getParameter("dob");
}
if(request.getParameter("email") != null){
	mail = request.getParameter("email");
}
if(request.getParameter("level") != null){
	gl = request.getParameter("level");
}

fullName = firstName + " " + lastName;

if((request.getParameter("submit") != null) &&
(request.getParameter("first") != null) &&
(request.getParameter("last") != null) &&
(request.getParameter("dob") != null) &&
(request.getParameter("address") != null) &&
(request.getParameter("level") != null) &&
(request.getParameter("level") != null)){

id = count;
insert = connection.prepareStatement(student);


insert.setInt(1, id);					
insert.setString(2,fullName);
insert.setString(3, birth);
insert.setString(4, addr);
insert.setString(5, mail);
insert.setString(6, gl);
insert.executeUpdate();

}
rs.close();
%>

</body></html>
