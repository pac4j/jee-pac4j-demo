<%@page session="false" %>
<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@ page import="org.pac4j.core.context.JEEContext" %>
<%@ page import="org.pac4j.jwt.profile.JwtGenerator" %>
<%@ page import="org.pac4j.demo.jee.Constants" %>
<%@ page import="java.util.Optional" %>
<%@ page import="org.pac4j.jwt.config.signature.SecretSignatureConfiguration" %>
<%@ page import="org.pac4j.core.profile.UserProfile" %>
<%@ page import="org.pac4j.core.context.session.JEESessionStore" %>
<h1>Generate JWT token</h1>
<a href="..">Back</a><br />
<br /><br />
<%
    JEEContext context = new JEEContext(request, response);
    ProfileManager manager = new ProfileManager(context, JEESessionStore.INSTANCE);
    Optional<UserProfile> profile = manager.getProfile();
    JwtGenerator generator = new JwtGenerator(new SecretSignatureConfiguration(Constants.JWT_SALT));
    String token = "";
    if (profile.isPresent()) {
        token = generator.generate(profile.get());
    }
%>
token: <%=token%><br />
