package org.leleuj.config;

import org.pac4j.cas.client.CasClient;
import org.pac4j.core.client.Clients;
import org.pac4j.http.client.BasicAuthClient;
import org.pac4j.http.client.FormClient;
import org.pac4j.http.credentials.SimpleTestUsernamePasswordAuthenticator;
import org.pac4j.j2e.configuration.ClientsFactory;
import org.pac4j.oauth.client.FacebookClient;
import org.pac4j.oauth.client.TwitterClient;
import org.pac4j.saml.client.Saml2Client;

public class MyClientsFactory implements ClientsFactory {

    @Override
    public Clients build() {
        final Saml2Client saml2Client = new Saml2Client();
        saml2Client.setKeystorePath("resource:samlKeystore.jks");
        saml2Client.setKeystorePassword("pac4j-demo-passwd");
        saml2Client.setPrivateKeyPassword("pac4j-demo-passwd");
        saml2Client.setIdpMetadataPath("resource:testshib-providers.xml");

        final FacebookClient facebookClient = new FacebookClient("145278422258960", "be21409ba8f39b5dae2a7de525484da8");
        final TwitterClient twitterClient = new TwitterClient("CoxUiYwQOSFDReZYdjigBA",
                "2kAzunH5Btc4gRSaMr7D7MkyoJ5u1VzbOOzE8rBofs");
        // HTTP
        final FormClient formClient = new FormClient("http://localhost:8080/theForm.jsp",
                new SimpleTestUsernamePasswordAuthenticator());
        final BasicAuthClient basicAuthClient = new BasicAuthClient(new SimpleTestUsernamePasswordAuthenticator());

        // CAS
        final CasClient casClient = new CasClient();
        // casClient.setGateway(true);
        casClient.setCasLoginUrl("https://freeuse1.casinthecloud.com/leleujgithub/login");
        casClient.setCasPrefixUrl("https://freeuse1.casinthecloud.com/leleujgithub/p3");

        final Clients clients = new Clients("http://localhost:8080/callback", saml2Client, facebookClient,
                twitterClient, formClient, basicAuthClient, casClient);
        return clients;
    }
}
