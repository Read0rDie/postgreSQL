<%@ page import="java.sql.*" %>

<%Class.forName("org.postgresql.Driver").newInstance();%>

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

<%!
public class Results {
	
String connectionURL = 
"jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/fall16_adubu002?user=fall16_adubu002&password=2247356";

	Connection connection = null;
	PreparedStatement select = null;
	ResultSet rs = null;

	public Results(){
		try{
			connection = DriverManager.getConnection(connectionURL);
			select = connection.prepareStatement(
			"SELECT * FROM students WHERE name LIKE ?");

		}catch(SQLException e){
			e.printStackTrace();
		}

	}


	public ResultSet getResult(String name){
		try{
			select.setString(1, "%" + name + "%");
			rs = select.executeQuery();

		}catch(SQLException e){
			e.printStackTrace();
		}
		return rs;

	}
}
%>
<%
	String query = new String();
	
	if(request.getParameter("search") != null){
		query = request.getParameter("search");
	}
	
	Results result = new Results();
	ResultSet searchResults = result.getResult(query);


%>

<h2 style="margin-top:60px; margin-bottom:60px; margin-left:150px; color:white" >Search Results</h2>
<table class="centerTable" border="1"> 
	<tbody>
		<tr>		
			<td>Student ID #</td>		
			<td>Name</td>		
			<td>D.O.B.</td>		
			<td>Address</td>		
			<td><Email</td>		
			<td>Grade Level</td>		
		</tr>
		<% while(searchResults.next()) { %>
		<tr>		
			<td><% out.print(searchResults.getInt("student_id")); %></td>		
			<td><% out.print(searchResults.getString("name")); %></td>		
			<td><% out.print(searchResults.getString("date_of_birth")); %></td>		
			<td><% out.print(searchResults.getString("address")); %></td>		
			<td><% out.print(searchResults.getString("email")); %></td>		
			<td><% out.print(searchResults.getString("level")); %></td>		
		</tr>

		<% } %>
	</tbody>
</table>

</body></html>
