<%@page session="false" %>
<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@ page import="org.pac4j.core.context.JEEContext" %>
<h1>protected area</h1>
<a href="..">Back</a><br />
<br /><br />
<%
    JEEContext context = new JEEContext(request, response);
    ProfileManager manager = new ProfileManager(context);
%>
profiles: <%=manager.getProfiles()%><br />
