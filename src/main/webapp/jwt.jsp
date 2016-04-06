<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@ page import="org.pac4j.core.context.J2EContext" %>
<%@ page import="org.pac4j.jwt.profile.JwtGenerator" %>
<%@ page import="org.pac4j.demo.j2e.Constants" %>
<%@ page import="java.util.Optional" %>
<%@ page import="org.pac4j.core.profile.CommonProfile" %>
<h1>Generate JWT token</h1>
<a href="..">Back</a><br />
<br /><br />
<%
    J2EContext context = new J2EContext(request, response);
    ProfileManager manager = new ProfileManager(context);
    Optional<CommonProfile> profile = manager.get(true);
    JwtGenerator generator = new JwtGenerator(Constants.JWT_SALT);
    String token = "";
    if (profile.isPresent()) {
        token = generator.generate(profile.get());
    }
%>
token: <%=token%><br />
