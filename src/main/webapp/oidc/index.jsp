<%@page session="false" %>
<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@ page import="org.pac4j.jee.context.JEEContext" %>
<%@ page import="org.pac4j.jee.context.session.JEESessionStore" %>
<h1>protected area</h1>
<a href="..">Back</a><br />
<br /><br />
<%
    JEEContext context = new JEEContext(request, response);
    ProfileManager manager = new ProfileManager(context, new JEESessionStore());
%>
profiles: <%=manager.getProfiles()%><br />
