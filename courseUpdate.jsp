<%@ page import="java.sql.*" %>

<%
String connectionURL=
"jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/fall16_adubu002?user=fall16_adubu002&password=2247356";

Connection connection = null;
Statement statement = null;
PreparedStatement update = null;
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
	<body bgcolor="22313f">
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
				<li><a href="students.jsp">Students</a></li>
				<li><a href="faculty.jsp">Faculty</a></li>
				<li id="home"><a id="home-text" href="courses.jsp">Courses</a></li>
				<li><a href="enroll.jsp">Enrollment</a></li>						
			</ul>			
			</div>
		</header>
					
			<%
			Class.forName("org.postgresql.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL);
			statement = connection.createStatement();
			rs = statement.executeQuery("SELECT * FROM courses");

			%>
			
	<div class="table">
	
<form action="courseUpdate.jsp" method="POST">

<div class="col-s-3">

<input class="button" type="submit" name="submit" value="Edit Student Record"/>
<button onclick="location.href='students.jsp';" class="button" type="button">Cancel</button>		


<table class="centerTable" style="margin-left: 60px"  BORDER="1">
	<tr>
		<th>Courses</th>
		<td><select name="sid">
		<% while(rs.next()){ %>
			<option value="<%=rs.getInt("course_id")%>"> <% out.print(rs.getString("description")); %></option>
		<% } %>
		</select></td>
	</tr>
					

</table>


</div>

<div class="col-s-9">
	
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

</div>
</form>
	</div>

	

<%


String course = "UPDATE courses SET description=?, level=?, instructor=?, semester=? WHERE course_id=?";

String sid = new String();
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
if(request.getParameter("sid") != null){
	sid = request.getParameter("sid");
}

time = semester + " " + year;

if((request.getParameter("submit") != null) &&
(request.getParameter("year") != null) &&
(request.getParameter("sem") != null) &&
(request.getParameter("iid") != null) &&
(request.getParameter("sid") != null) &&
(request.getParameter("desc") != null) &&
(request.getParameter("level") != null)){


update = connection.prepareStatement(course);


int courseId = Integer.parseInt(sid);
int facultyId = Integer.parseInt(iid);

update.setString(1, name);					
update.setString(2,gl);
update.setInt(3, facultyId);
update.setString(4, time);
update.setInt(5, courseId);
update.executeUpdate();

	
}

rs.close();

%>		

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	</body>
</html>
