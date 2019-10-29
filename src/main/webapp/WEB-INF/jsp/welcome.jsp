<!DOCTYPE html>

<%@ page session="false" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html lang="en">

<jsp:include page="fragments/staticFiles.jsp"/>

<body>
<div class="container">
    <jsp:include page="fragments/bodyHeader.jsp"/>
    
    <h4 align ="center">&nbsp &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
 &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp
&nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp
&nbsp &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
 &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp
&nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp
 &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp 
&nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp  &nbsp &nbsp &nbsp
&emsp &emsp &emsp
<marquee behavior="scroll" bgcolor="white" loop="-1" width="30%">
   <i>
      <font color="black">
        Today's date is : <script language="javascript">
        var today = new Date();
        document.write(today);
        </script>
        <strong>
         <span id="time"></span>
        </strong>           
      </font>
   </i>
</marquee> 
</h4>
    <h2> Welcome to the Petclinic </h2>
    <spring:url value="/resources/images/pets.png" htmlEscape="true" var="petsImage"/>
    <img src="${petsImage}"/>

    <jsp:include page="fragments/footer.jsp"/>

</div>
</body>

</html>
