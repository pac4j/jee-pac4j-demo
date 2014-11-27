<%@page import="com.fasterxml.jackson.core.JsonGenerator"%>
<%@page import="com.fasterxml.jackson.core.JsonFactory"%>
<%@page import="org.pac4j.core.context.HttpConstants"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%
JsonFactory factory = new JsonFactory();
factory.disable(JsonGenerator.Feature.AUTO_CLOSE_TARGET);
ObjectMapper mapper = new ObjectMapper(factory);
mapper.writeValue(out, request.getAttribute(HttpConstants.USER_PROFILE));
%>
