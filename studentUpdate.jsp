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
			rs = statement.executeQuery("SELECT * FROM students");

			%>
			
	<div class="table">
	
<form action="studentUpdate.jsp" method="POST">

<div class="col-s-2">

<input class="button" type="submit" name="submit" value="Edit Student Record"/>
<button onclick="location.href='students.jsp';" class="button" type="button">Cancel</button>		


<table align="center" class="centerTable" BORDER="1">
	<tr>
		<th>Students</th>
		<td><select name="sid">
		<% while(rs.next()){ %>
			<option value="<%=rs.getInt("student_id")%>"> <% out.print(rs.getString("name")); %></option>
		<% } %>
		</select></td>
	</tr>
					

</table>


</div>

<div class="col-s-10">


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
		<td><input type="radio" name="level" value="ugrad" size="50"/>Undergraduate<input type="radio" name="level" value="grad" size="50"/>Graduate</td>
	</tr>
	</table>
</div>
</form>
	</div>

	

<%
int idNum;

String student = "UPDATE students SET name=?, date_of_birth=?, address=?, email=?, level=? WHERE student_id = ?";

String num = new String();
String lastName = new String();
String firstName = new String();
String fullName = new String();
String addr = new String();
String birth = new String();
String mail = new String();
String gl = new String();

if(request.getParameter("sid") != null){
	num = request.getParameter("sid");
}
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
(request.getParameter("sid") != null)){

idNum = Integer.parseInt(num);
update = connection.prepareStatement(student);

update.setString(1,fullName);
update.setString(2, birth);
update.setString(3, addr);
update.setString(4, mail);
update.setString(5, gl);
update.setInt(6, idNum);					
update.executeUpdate();

}

rs.close();

%>		

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	</body>
</html>
