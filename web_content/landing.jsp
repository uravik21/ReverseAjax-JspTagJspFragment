<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <title>Reverse Ajax and Jsp Fragments Jsp Tag Demo</title>
	<%@ include file="landing_resources.jspf" %>	
</head>
<body>
	<br/>
    <div id="maindiv">
    	<h1>Reverse Ajax and Jsp Fragments Jsp Tag Demo</h1>
    	<h4>Please enter name of the long running task and sample time that may take to execute the task</h4>
    	<h4>If you enter greater than 6000 (sec) for time then you task will be completed in single request, which server updates you when it is completed</h4>
    	<h4>If you enter less than 6000 (sec) for time then you task will be completed in two consequtive requests, then there will be two request to get the status of task</h4>
    	<br/>
    	<lable>Enter Task Name: </lable>
		<input type="text" name="taskName" id="taskName" value="My Async Task"/></br>
    	<label>Task Time: </lable>
    	<input type="text" name="taskTime" id="taskTime" value="2000"></br>
		<button id="start">Start</button><br/><br/>
	    <div id="taskComplete"/>
    </div>       
</body>
</html>
