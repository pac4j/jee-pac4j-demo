<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@ page import="org.pac4j.core.context.J2EContext" %>
<h1>Not protected page</h1>
<a href="..">Back</a><br />
<br /><br />
<%
    J2EContext context = new J2EContext(request, response);
    ProfileManager manager = new ProfileManager(context);
%>
profiles: <%=manager.getAll(true)%><br />
