<!--
Assignment: Studentenforum
Name: Jan Malchert, Bernhard Koll
-->
<%@ page import="de.dhbw.StudentForum.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

    DAO dao = new DAO();
    int postingId = 0;
    DateFormat formatter = new SimpleDateFormat("dd. MMMM, HH:mm 'Uhr'");


    try {
        postingId = Integer.parseInt(request.getParameter("postingid"));
    } catch(Exception e) { }
    Posting posting = dao.getPostingById(postingId);
    User author = dao.getUserById( posting.getUserId() );
    Date date = posting.getWhenPosted();
    String text = posting.getMessage();
%>
<c:set var="posting" value="<%=posting%>"/>
<c:set var="author" value="<%=author%>"/>
<c:set var="date" value="<%=date%>"/>
<c:set var="text" value="<%=text%>"/>

<span class="author"><%=author.getFirstname()%> <%=author.getLastname()%></span>
&bull;
<span class="date"><%=formatter.format(date)%></span>
<p class="posting">
   <c:out value="${text}"/>
  <div class="attachment">
			<c:forEach var="attachment" items="${dao.getAttachmentsByPostingId(postingId)}">	
			  <a href="<c:url value="/attachment/${attachment.getAttachmentFilename()}"/>"/>
				  <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/101389-200.png" width="30" height="30">
				  <span>${attachment.getAttachmentFilename()}</span>
			  </a>
			</c:forEach>		    
		</div>
</p>
