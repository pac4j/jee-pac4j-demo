package org.leleuj.config;

import org.pac4j.cas.client.CasClient;
import org.pac4j.core.client.Clients;
import org.pac4j.http.client.BasicAuthClient;
import org.pac4j.http.client.FormClient;
import org.pac4j.http.credentials.SimpleTestUsernamePasswordAuthenticator;
import org.pac4j.j2e.configuration.ClientsFactory;
import org.pac4j.oauth.client.FacebookClient;
import org.pac4j.oauth.client.TwitterClient;
import org.pac4j.openid.client.MyOpenIdClient;

public class MyClientsFactory implements ClientsFactory {
    
    @Override
    public Clients build() {
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
        casClient.setCasLoginUrl("http://localhost:8888/cas/login");
        
        // OpenID
        final MyOpenIdClient myOpenIdClient = new MyOpenIdClient();
        
        final Clients clients = new Clients("http://localhost:8080/callback", facebookClient, twitterClient,
                                            formClient, basicAuthClient, casClient, myOpenIdClient);
        return clients;
    }
}
