package org.pac4j.demo.j2e.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.pac4j.core.config.ConfigSingleton;
import org.pac4j.core.context.J2EContext;
import org.pac4j.core.context.Pac4jConstants;
import org.pac4j.core.util.CommonHelper;
import org.pac4j.j2e.filter.AbstractConfigFilter;
import org.pac4j.saml.client.SAML2Client;

/**
 * This filter prints the SP metadata.
 * 
 * @author Michael Remond
 */
public class Saml2MetadataFilter extends AbstractConfigFilter {

    private String clientName;

    @Override
    public void init(final FilterConfig filterConfig) throws ServletException {
        this.clientName = filterConfig.getInitParameter(Pac4jConstants.CLIENT_NAME);
        CommonHelper.assertNotBlank(Pac4jConstants.CLIENT_NAME, this.clientName);
    }

    @Override
    protected void internalFilter(final HttpServletRequest request, final HttpServletResponse response,
            final FilterChain chain) throws IOException, ServletException {

        SAML2Client client = (SAML2Client) ConfigSingleton.getConfig().getClients().findClient(this.clientName);
        final J2EContext context = new J2EContext(request, response);
        client.init(context);
        response.getWriter().write(client.getServiceProviderMetadataResolver().getMetadata());
        response.getWriter().flush();
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
