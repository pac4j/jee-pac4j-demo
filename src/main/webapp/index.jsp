<%@page import="org.pac4j.oidc.client.OidcClient"%>
<%@page import="org.pac4j.j2e.filter.RequiresAuthenticationFilter"%>
<%@page import="org.pac4j.core.client.Clients"%>
<%@page import="org.pac4j.j2e.configuration.ClientsConfiguration"%>
<%@page import="org.pac4j.core.context.*"%>
<%@page import="org.pac4j.core.exception.*"%>
<%@page import="org.pac4j.j2e.util.UserUtils"%>
<%@page import="org.pac4j.http.client.*"%>
<%@page import="org.pac4j.oauth.client.*"%>
<%@page import="org.pac4j.cas.client.*"%>
<%@page import="org.pac4j.saml.client.*"%>
<%
	session.setAttribute(HttpConstants.REQUESTED_URL, null);
	WebContext context = new J2EContext(request, response); 
	Clients client = ClientsConfiguration.getClients();
	FacebookClient fbClient = (FacebookClient) client.findClient("FacebookClient");
	TwitterClient twClient = (TwitterClient) client.findClient("TwitterClient");
	FormClient formClient = (FormClient) client.findClient("FormClient");
	BasicAuthClient baClient = (BasicAuthClient) client.findClient("BasicAuthClient");
	CasClient casClient = (CasClient) client.findClient("CasClient");
	Saml2Client saml2Client = (Saml2Client) client.findClient("Saml2Client");
	OidcClient oidcClient = (OidcClient) client.findClient("OidcClient"); 
%>
<h1>index</h1>
<a href="facebook/index.jsp">Protected url by Facebook : facebook/index.jsp</a><br />
<a href="twitter/index.jsp">Protected url by Twitter : twitter/index.jsp</a><br />
<a href="form/index.jsp">Protected url by form authentication : form/index.jsp</a><br />
<a href="basicauth/index.jsp">Protected url by basic auth : basicauth/index.jsp</a><br />
<a href="cas/index.jsp">Protected url by CAS : cas/index.jsp</a><br />
<a href="saml2/index.jsp">Protected url by SAML2 : saml2/index.jsp</a><br />
<br />
<a href="rest-basicauth/user.jsp">REST WS protected by basic auth : rest-basicauth/user.jsp</a><br />
<br />
<a href="logout.jsp">logout</a>
<br /><br />
profile : <%=UserUtils.getProfile(session)%>
<br /><br />
<hr />

<a href="<%=fbClient.getRedirectAction(context, false).getLocation()%>">Authenticate with Facebook</a><br />
<a href="<%=twClient.getRedirectAction(context, false).getLocation()%>">Authenticate with Twitter</a><br />
<a href="<%=formClient.getRedirectAction(context, false).getLocation()%>">Authenticate with form</a><br />
<a href="<%=baClient.getRedirectAction(context, false).getLocation()%>">Authenticate with basic auth</a><br />
<a href="<%=casClient.getRedirectAction(context, false).getLocation()%>">Authenticate with CAS</a><br />
<a href="<%=saml2Client.getRedirectAction(context, false).getLocation()%>">Authenticate with SAML</a><br />
<a href="<%=oidcClient.getRedirectAction(context, false).getLocation()%>">Authenticate with OpenID Connect</a><br />
