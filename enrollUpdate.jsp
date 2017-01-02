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
				<li><a href="courses.jsp">Courses</a></li>
				<li id=home"><a id="home-text" href="enroll.jsp">Enrollment</a></li>						
			</ul>			
			</div>
		</header>
					
			<%
			Class.forName("org.postgresql.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL);
			statement = connection.createStatement();
			rs = statement.executeQuery("SELECT * FROM enroll INNER JOIN students ON enroll.student_id = students.student_id INNER JOIN courses ON enroll.course_id = courses.course_id");

			%>
			
	<div class="table">
	
<div class="table">
<h3 style="color:white;">New Enrollment Record</h3>
</div>

<form action="enrollUpdate.jsp" method="POST">

<div class="col-s-4">

<input class="button" type="submit" name="submit" value="Edit Student Record"/>
<button onclick="location.href='enroll.jsp';" class="button" type="button">Cancel</button>		


<table align="center" class="centerTable" style="margin-left: 15%" BORDER="1">
	<tr>
		<th>Student</th>
		<td><select name="sid">
		<% while(rs.next()){ %>
			<option value="<%=rs.getInt("student_id")%>"> <% out.print(rs.getString("name") + " (" + rs.getString("description") + ")"); %></option>
		<% } %>
		</select></td>
	</tr>
					

</table>


</div>

<div class="col-s-8">


<form name="stud"  class="table" action="insertEnroll.jsp" method="POST">
	<table class="centerTable" BORDER="1">
		
	<tr>
		<td>Grade: </td>
		<td><input type="radio" name="grade" value="A" size="50"/>A<input style="margin-left:10px;" type="radio" name="grade" value="B" size="50"/>B<input style="margin-left:10px;" type="radio" name="grade" value="C" size="50"/>C<input style="margin-left:10px;" type="radio" name="grade" value="D" size="50"/>D<input style="margin-left:10px;" type="radio" name="grade" value="F" size="50"/>F</td>
	</tr>		
	</table>	
</div>
</form>
	</div>

<%
int idNum;

String enroll = "UPDATE enroll SET grade=? WHERE student_id = ?";



String sid = new String();
String grade = new String();

if(request.getParameter("sid") != null){
	sid = request.getParameter("sid");
}	

if(request.getParameter("grade") != null){
	grade = request.getParameter("grade");
}

if((request.getParameter("submit") != null) &&
(request.getParameter("sid") != null) &&
(request.getParameter("grade") != null)){

int studentId = Integer.parseInt(sid);
update = connection.prepareStatement(enroll);

update.setString(1,grade);
update.setInt(2, studentId);
update.executeUpdate();

}

rs.close();

%>		

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	</body>
</html>
