package org.pac4j.j2e.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.pac4j.core.util.CommonHelper;
import org.pac4j.j2e.configuration.ClientsConfiguration;
import org.pac4j.saml.client.Saml2Client;

/**
 * This filter prints the SP metadata.
 * 
 * @author Michael Remond
 */
public class Saml2MetadataFilter extends ClientsConfigFilter {

    private String clientName;

    @Override
    public void init(final FilterConfig filterConfig) throws ServletException {
        super.init(filterConfig);
        this.clientName = filterConfig.getInitParameter("clientName");
        CommonHelper.assertNotBlank("clientName", this.clientName);
    }

    @Override
    protected void internalFilter(final HttpServletRequest request, final HttpServletResponse response,
            final FilterChain chain) throws IOException, ServletException {

        Saml2Client client = (Saml2Client) ClientsConfiguration.getClients().findClient(this.clientName);
        client.init();
        response.getWriter().write(client.printClientMetadata());
        response.getWriter().flush();
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
