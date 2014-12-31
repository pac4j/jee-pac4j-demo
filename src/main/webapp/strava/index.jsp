<%@page import="org.pac4j.j2e.util.UserUtils"%>
<h1>protected area</h1>
<a href="..">Back</a><br />
<br /><br />
profile : <%=UserUtils.getProfile(session)%><br />
