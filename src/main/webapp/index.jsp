<%@page import="org.pac4j.j2e.filter.RequiresAuthenticationFilter"%>
<%@page import="org.pac4j.core.client.Clients"%>
<%@page import="org.pac4j.j2e.configuration.ClientsConfiguration"%>
<%@page import="org.pac4j.core.context.*"%>
<%@page import="org.pac4j.core.exception.*"%>
<%@page import="org.pac4j.j2e.util.UserUtils"%>
<%@page import="org.pac4j.http.client.*"%>
<%@page import="org.pac4j.oauth.client.*"%>
<%@page import="org.pac4j.cas.client.*"%>
<%
	session.setAttribute(RequiresAuthenticationFilter.ORIGINAL_REQUESTED_URL, null);
	WebContext context = new J2EContext(request, response); 
	Clients client = ClientsConfiguration.getClients();
	FacebookClient fbClient = (FacebookClient) client.findClient("FacebookClient");
	TwitterClient twClient = (TwitterClient) client.findClient("TwitterClient");
	FormClient formClient = (FormClient) client.findClient("FormClient");
	BasicAuthClient baClient = (BasicAuthClient) client.findClient("BasicAuthClient");
	CasClient casClient = (CasClient) client.findClient("CasClient");
%>
<h1>index</h1>
<a href="facebook/index.jsp">Protected url by Facebook : facebook/index.jsp</a><br />
<a href="twitter/index.jsp">Protected url by Twitter : twitter/index.jsp</a><br />
<a href="form/index.jsp">Protected url by form authentication : form/index.jsp</a><br />
<a href="basicauth/index.jsp">Protected url by basic auth : basicauth/index.jsp</a><br />
<a href="cas/index.jsp">Protected url by CAS : cas/index.jsp</a><br />
<br />
<a href="logout.jsp">logout</a>
<br /><br />
profile : <%=UserUtils.getProfile(session)%>
<br /><br />
<hr />
<%
try {
%>
<a href="<%=fbClient.getRedirectionUrl(context, false, false)%>">Authenticate with Facebook</a><br />
<a href="<%=twClient.getRedirectionUrl(context, false, false)%>">Authenticate with Twitter</a><br />
<a href="<%=formClient.getRedirectionUrl(context, false, false)%>">Authenticate with form</a><br />
<a href="<%=baClient.getRedirectionUrl(context, false, false)%>">Authenticate with basic auth</a><br />
<a href="<%=casClient.getRedirectionUrl(context, false, false)%>">Authenticate with CAS</a><br />
<%
} catch (RequiresHttpAction e) {
	// should not happen
}
%>
