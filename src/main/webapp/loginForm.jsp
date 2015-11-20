<%@page import="org.pac4j.core.config.*"%>
<%@ page import="org.pac4j.http.client.indirect.FormClient" %>
<%@ page import="org.pac4j.core.context.J2EContext" %>
<%
	J2EContext context = new J2EContext(request, response);
	FormClient formClient = (FormClient) ConfigSingleton.getConfig().getClients().findClient(context, "FormClient");
%>
<form action="<%=formClient.getCallbackUrl()%>" method="POST">
	<input type="text" name="username" value="" />
	<p />
	<input type="password" name="password" value="" />
	<p />
	<input type="submit" name="submit" value="Submit" />
</form>
