<%@page import="org.pac4j.core.config.*"%>
<%@ page import="org.pac4j.http.client.indirect.FormClient" %>
<%
	FormClient formClient = (FormClient) ConfigSingleton.getConfig().getClients().findClient("FormClient");
%>
<form action="<%=formClient.getCallbackUrl()%>?client_name=FormClient" method="POST">
	<input type="text" name="username" value="" />
	<p />
	<input type="password" name="password" value="" />
	<p />
	<input type="submit" name="submit" value="Submit" />
</form>
