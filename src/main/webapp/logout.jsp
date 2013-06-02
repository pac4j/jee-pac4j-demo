<%@page import="org.pac4j.j2e.util.UserUtils"%>
<%
	UserUtils.logout(request);
	response.sendRedirect("/index.jsp");
%>
