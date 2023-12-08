<%@page session="false" %>
<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@ page import="org.pac4j.jee.context.JEEContext" %>
<%@ page import="java.util.Optional" %>
<%@ page import="org.pac4j.cas.profile.CasProxyProfile" %>
<%@ page import="org.pac4j.core.profile.UserProfile" %>
<%@ page import="org.pac4j.jee.context.session.JEESessionStore" %>
<h1>protected area</h1>
<a href="..">Back</a><br />
<br /><br />
<%
    JEEContext context = new JEEContext(request, response);
    ProfileManager manager = new ProfileManager(context, new JEESessionStore());
    Optional<UserProfile> optProfile = manager.getProfile();
    String pt = null;
    if (optProfile.isPresent()) {
        UserProfile profile = optProfile.get();
        if (profile instanceof CasProxyProfile) {
            CasProxyProfile casProxyProfile = (CasProxyProfile) profile;
            pt = casProxyProfile.getProxyTicketFor("http://test");
        }
    }
%>
profiles: <%=manager.getProfiles()%><br />
proxy ticket: <%=pt%>
