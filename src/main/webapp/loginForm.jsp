<%@page session="false" %>
<%@page import="org.pac4j.core.config.*"%>
<%@ page import="org.pac4j.http.client.indirect.FormClient" %>
<%@ page import="org.pac4j.demo.jee.DemoConfigFactory" %>
<%
	FormClient formClient = (FormClient) DemoConfigFactory.CONFIG_INSTANCE.getClients().findClient("FormClient").get();
%>
<form action="<%=formClient.getCallbackUrl()%>?client_name=FormClient" method="POST">
	<input type="text" name="username" value="" />
	<p />
	<input type="password" name="password" value="" />
	<p />
	<input type="submit" name="submit" value="Submit" />
</form>
