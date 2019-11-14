<!DOCTYPE html>

<%@ page session="false" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html lang="en">

<jsp:include page="fragments/staticFiles.jsp"/>

<body>
<div class="container">
    <jsp:include page="fragments/bodyHeader.jsp"/>

    <font color="red"> <h2> Welcome to the Petclinic..</h2> </font>
    <font color="green"> <h4> Get the 1st checkup free entire this week.. </h4> </font>
    
    <spring:url value="/resources/images/pets.png" htmlEscape="true" var="petsImage"/>
    <img src="${petsImage}"/>
    
    <h6 align ="justify"> 
      <font color="black" bgcolor="right">
        <script language="javascript">
        var today = new Date();
        document.write(today);
        </script>
        <strong>
         <span id="time"></span>
        </strong>           
      </font>
    </h6>

    <jsp:include page="fragments/footer.jsp"/>

</div>
</body>

</html>
