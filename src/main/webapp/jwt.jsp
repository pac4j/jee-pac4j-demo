<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@ page import="org.pac4j.core.context.J2EContext" %>
<%@ page import="org.pac4j.core.profile.UserProfile" %>
<%@ page import="org.pac4j.jwt.profile.JwtGenerator" %>
<%@ page import="org.pac4j.demo.j2e.config.Constants" %>
<h1>Generate JWT token</h1>
<a href="..">Back</a><br />
<br /><br />
<%
    J2EContext context = new J2EContext(request, response);
    ProfileManager manager = new ProfileManager(context);
    UserProfile profile = manager.get(true);
    JwtGenerator generator = new JwtGenerator(Constants.JWT_SALT);
    String token = "";
    if (profile != null) {
        token = generator.generate(profile);
    }
%>
token: <%=token%><br />
