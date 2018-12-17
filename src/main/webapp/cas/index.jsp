<%@page import="org.pac4j.core.profile.ProfileManager"%>
<%@ page import="org.pac4j.core.context.JEEContext" %>
<%@ page import="org.pac4j.core.profile.CommonProfile" %>
<%@ page import="java.util.Optional" %>
<%@ page import="org.pac4j.cas.profile.CasProxyProfile" %>
<h1>protected area</h1>
<a href="..">Back</a><br />
<br /><br />
<%
    JEEContext context = new JEEContext(request, response);
    ProfileManager manager = new ProfileManager(context);
    Optional<CommonProfile> optProfile = manager.get(true);
    String pt = null;
    if (optProfile.isPresent()) {
        CommonProfile profile = optProfile.get();
        if (profile instanceof CasProxyProfile) {
            CasProxyProfile casProxyProfile = (CasProxyProfile) profile;
            pt = casProxyProfile.getProxyTicketFor("http://test");
        }
    }
%>
profiles: <%=manager.getAll(true)%><br />
proxy ticket: <%=pt%>
