<%@page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.pac4j.core.context.JEEContext" %>
<%@ page import="org.pac4j.core.profile.ProfileManager" %>
<%@ page import="org.pac4j.core.util.Pac4jConstants" %>
<%@ page import="org.pac4j.core.context.session.JEESessionStore" %>
<%
	JEEContext context = new JEEContext(request, response);
	ProfileManager manager = new ProfileManager(context, JEESessionStore.INSTANCE);
	String sessionId = null;
	HttpSession httpSession = request.getSession(false);
	if (httpSession != null) {
		sessionId = httpSession.getId();
	}
%>
<h1>index</h1>
<a href="facebook/index.jsp">Protected url by Facebook: facebook/index.jsp</a> (use a real account)<br />
<a href="facebook/notprotected.jsp">Not protected page: facebook/notprotected.jsp</a> (no authentication required)<br />
<a href="facebookadmin/index.jsp">Protected url by Facebook with ROLE_ADMIN: facebookadmin/index.jsp</a> (use a real account)<br />
<a href="facebookcustom/index.jsp">Protected url by Facebook with custom authorizer (= must be a <em>CommonProfile</em> where the username starts with "jle"): facebookcustom/index.jsp</a> (login with form or basic authentication before with jle* username)<br />
<a href="twitter/index.jsp">Protected url by Twitter: twitter/index.jsp</a> or <a href="twitter/index.jsp?force_client=FacebookClient">by Facebook: twitter/index.jsp?force_client=FacebookClient</a> (use a real account)<br />
<a href="form/index.jsp">Protected url by form authentication: form/index.jsp</a> (use login = pwd)<br />
<a href="basicauth/index.jsp">Protected url by indirect basic auth: basicauth/index.jsp</a> (use login = pwd)<br />
<a href="cas/index.jsp">Protected url by CAS: cas/index.jsp</a> (use login = pwd)<br />
<a href="saml2/index.jsp">Protected url by SAML2: saml2/index.jsp</a> (use one of test accounts listed on IDP)<br />
<a href="oidc/index.jsp">Protected url by Google OpenID Connect: oidc/index.jsp</a> (use a real account)<br />
<a href="strava/index.jsp">Protected url by Strava: strava/index.jsp</a> (use a real account)<br />
<a href="protected/index.jsp">Protected url: protected/index.jsp</a> (won't start any login process)<br />
<br />
<a href="jwt.jsp">Generate a JWT token</a> (after being authenticated)<br />
<a href="/dba/index.jsp">Protected url by DirectBasicAuthClient: /dba/index.jsp</a> (POST the <em>Authorization</em> header with value: <em>Basic amxlbGV1OmpsZWxldQ==</em>) then by <a href="/dba/index.jsp">ParameterClient: /dba/index.jsp</a> (with request parameter: token=<em>jwt_generated_token</em>)<br />
<a href="/rest-jwt/index.jsp">Protected url by ParameterClient: /rest-jwt/index.jsp</a> (with request parameter: token=<em>jwt_generated_token</em>)<br />
<br />
<a href="forceLogin?client_name=FacebookClient">Force Facebook login</a> (even if already authenticated)<br />
<br />
<form action="post/index.jsp?data1=D1" method="POST">
	<input type="text" name="data2" value="D2" size="50" /><br />
	<input type="text" name="<%=Pac4jConstants.CSRF_TOKEN%>" value="<%=request.getAttribute(Pac4jConstants.CSRF_TOKEN)%>" size="50" /><br />
	<input type="submit" value="Post to /post/index.jsp: must be authenticated (by form login)" />
</form>
<a href="logout?url=<c:url value="/?forcepostlogouturl"/>">local logout</a>
<br /><br />
<a href="centralLogout?url=<c:url value="/?forcepostlogouturlafteridp"/>">central logout</a>
<br /><br />
profiles: <%=manager.getProfiles()%><br />
<br />
sessionId: <%=sessionId%>
