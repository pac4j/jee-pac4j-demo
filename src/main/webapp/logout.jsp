<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@page import="org.pac4j.core.context.J2EContext"%>
<%
	J2EContext context = new J2EContext(request, response);
	ProfileManager manager = new ProfileManager(context);
	manager.logout();
	response.sendRedirect("/index.jsp");
%>
