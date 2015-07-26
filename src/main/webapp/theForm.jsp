<%@page import="org.pac4j.j2e.configuration.ClientsConfiguration"%>
<%@ page import="org.pac4j.http.client.indirect.FormClient" %>
<%
	FormClient formClient = (FormClient) ClientsConfiguration.getClients().findClient("FormClient");
%>
<form action="<%=formClient.getCallbackUrl()%>" method="POST">
	<input type="text" name="username" value="" />
	<p />
	<input type="password" name="password" value="" />
	<p />
	<input type="submit" name="submit" value="Submit" />
</form>
