<%@ page import="java.sql.*" %>

<%
String connectionURL=
"jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/fall16_adubu002?user=fall16_adubu002&password=2247356";

Connection connection = null;
Statement statement = null;
PreparedStatement delete = null;
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
			rs = statement.executeQuery("SELECT * FROM faculties");

			%>
			
	<div class="table">
	
<form name="del" action="deleteFaculty.jsp" method="POST">

<div class="col-s-2">

<input class="button" type="submit" name="submit" value="Delete"/>
<button onclick="location.href='faculty.jsp';" class="button" type="button">Cancel</button>		

</div>



<div class="col-s-10">

<table class="centerTable" BORDER="1">
	<tr>
		<th>Select One</th>
		<th>Faculty Name</th>
	</tr>
					
<% while (rs.next()){  %>
		<tr>
		<td><input type="radio" name="sid" value="<%= rs.getInt("faculty_id") %>"/></td>
		<td><% out.println(rs.getString("name")); %></td>
		</tr>
	<% } %>

</table>

</div>
</form>
	</div>

	

<%

String faculty = "DELETE FROM faculties WHERE faculty_id = ?";
int studInt;
String sid = new String();

if(request.getParameter("sid") != null){
	sid = request.getParameter("sid");
}


if((request.getParameter("submit") != null) &&
(request.getParameter("sid") != null)){

studInt = Integer.parseInt(sid);
delete = connection.prepareStatement(faculty);
delete.setInt(1, studInt);
delete.executeUpdate();

}
rs.close();

%>		

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	</body>
</html>
