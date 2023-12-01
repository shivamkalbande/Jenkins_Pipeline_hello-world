<%@page import="com.helloworld.MyCalculator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Mycalculator</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4; /* Light gray background color */
            margin: 20px;
            padding: 20px;
            text-align: center;
        }

        h1 {
            color: #333333; /* Dark gray heading color */
        }

        .result {
            margin-top: 20px;
            padding: 10px;
            background-color: #ffffff; /* White background color for results */
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <h1>Mycalculator</h1>

    <%
    MyCalculator calculator = new MyCalculator();
    int num1 = Integer.parseInt(request.getParameter("number1"));
    int num2 = Integer.parseInt(request.getParameter("number2"));
    %>

    <div class="result">
        <h2>Addition:</h2>
        <%= calculator.addition(num1, num2) %>

        <br><br>
        <h2>Subtraction:</h2>
        <%= calculator.subtraction(num1, num2) %>

        <br><br>
        <h2>Multiplication:</h2>
        <%= calculator.multiplication(num1, num2) %>

        <br><br>
        <h2>Division:</h2>
        <%= calculator.division(num1, num2) %>
    </div>
</body>
</html>
