<%@page import="org.pac4j.oidc.client.OidcClient"%>
<%@page import="org.pac4j.core.client.Clients"%>
<%@page import="org.pac4j.core.context.*"%>
<%@page import="org.pac4j.oauth.client.*"%>
<%@page import="org.pac4j.cas.client.*"%>
<%@page import="org.pac4j.saml.client.*"%>
<%@ page import="org.pac4j.http.client.indirect.FormClient" %>
<%@ page import="org.pac4j.core.profile.ProfileManager" %>
<%@ page import="org.pac4j.http.client.indirect.IndirectBasicAuthClient" %>
<%@ page import="org.pac4j.core.config.ConfigSingleton" %>
<%
	Clients client = ConfigSingleton.getConfig().getClients();
	FacebookClient fbClient = (FacebookClient) client.findClient("FacebookClient");
	TwitterClient twClient = (TwitterClient) client.findClient("TwitterClient");
	FormClient formClient = (FormClient) client.findClient("FormClient");
	IndirectBasicAuthClient baClient = (IndirectBasicAuthClient) client.findClient("IndirectBasicAuthClient");
	CasClient casClient = (CasClient) client.findClient("CasClient");
	SAML2Client saml2Client = (SAML2Client) client.findClient("SAML2Client");
	OidcClient oidcClient = (OidcClient) client.findClient("OidcClient");
	StravaClient stravaClient = (StravaClient) client.findClient("StravaClient");
	WebContext context = new J2EContext(request, response);
	ProfileManager manager = new ProfileManager(context);
%>
<h1>index</h1>
<a href="facebook/index.jsp">Protected url by Facebook: facebook/index.jsp</a> (use a real account)<br />
<a href="facebook/notprotected.jsp">Not protected page: facebook/notprotected.jsp</a> (no authentication required)<br />
<a href="facebookadmin/index.jsp">Protected url by Facebook with ROLE_ADMIN: facebookadmin/index.jsp</a> (use a real account)<br />
<a href="facebookcustom/index.jsp">Protected url by Facebook with custom authorizer (= must be a <em>HttpProfile</em> where the username starts with "jle"): facebookcustom/index.jsp</a> (login with form or basic authentication before)<br />
<a href="twitter/index.jsp">Protected url by Twitter: twitter/index.jsp</a> or <a href="twitter/index.jsp?client_name=FacebookClient">by Facebook: twitter/index.jsp?client_name=FacebookClient</a> (use a real account)<br />
<a href="form/index.jsp">Protected url by form authentication: form/index.jsp</a> (use login = pwd)<br />
<a href="basicauth/index.jsp">Protected url by indirect basic auth: basicauth/index.jsp</a> (use login = pwd)<br />
<a href="cas/index.jsp">Protected url by CAS: cas/index.jsp</a> (use login = pwd)<br />
<a href="saml2/index.jsp">Protected url by SAML2: saml2/index.jsp</a> (use testpac4j at gmail.com / Pac4jtest)<br />
<a href="oidc/index.jsp">Protected url by OpenID Connect: oidc/index.jsp</a> (use a real account)<br />
<a href="strava/index.jsp">Protected url by Strava: strava/index.jsp</a> (use a real account)<br />
<a href="protected/index.jsp">Protected url: protected/index.jsp</a> (won't start any login process)<br />
<br />
<a href="jwt.jsp">Generate a JWT token</a> (after being authenticated)<br />
<a href="/dba/index.jsp">Protected url by DirectBasicAuthClient: /dba/index.jsp</a> (POST the <em>Authorization</em> header with value: <em>Basic amxlbGV1OmpsZWxldQ==</em>) then by <a href="/dba/index.jsp">ParameterClient: /dba/index.jsp</a> (with request parameter: token=<em>jwt_generated_token</em>)<br />
<a href="/rest-jwt/index.jsp">Protected url by ParameterClient: /rest-jwt/index.jsp</a> (with request parameter: token=<em>jwt_generated_token</em>)<br />
<br />
<a href="/logout?url=/">logout</a>
<br /><br />
profile : <%=manager.get(true)%>
<br /><br />
<hr />

<a href="<%=fbClient.getRedirectAction(context, false).getLocation()%>">Authenticate with Facebook</a><br />
<a href="<%=twClient.getRedirectAction(context, false).getLocation()%>">Authenticate with Twitter</a><br />
<a href="<%=formClient.getRedirectAction(context, false).getLocation()%>">Authenticate with form</a><br />
<a href="<%=baClient.getRedirectAction(context, false).getLocation()%>">Authenticate with basic auth</a><br />
<a href="<%=casClient.getRedirectAction(context, false).getLocation()%>">Authenticate with CAS</a><br />
<a href="<%=saml2Client.getRedirectAction(context, false).getLocation()%>">Authenticate with SAML</a><br />
<a href="<%=oidcClient.getRedirectAction(context, false).getLocation()%>">Authenticate with OpenID Connect</a><br />
<a href="<%=stravaClient.getRedirectAction(context, false).getLocation()%>">Authenticate with Strava</a><br />
