<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Add Employee</h1>
	<form action = "${pageContext.request.contextPath}/save" modelAttribute="employee">
		Enter Name: <input type="text" name="name"/><br/>
		Select Gender: <input type="radio" name="gender" value = "Male"/>Male&nbsp;
					<input type="radio" name="gender" value = "Female"/>Female&nbsp;<br/>
		Departement: 
		<select name="department">
			<option value="Support">Support</option>
			<option value="Testing">Testing</option>
			<option value="Development">Development</option>
			<option value="Business Analyst">Business Analyst</option>
		</select><br/>
		Date of Birth: <input type="text" name="dob" type = "date"/><br/>
		<hidden name = "id"/>
		<button type = "submit">Save</button>
	</form>
</body>
</html>