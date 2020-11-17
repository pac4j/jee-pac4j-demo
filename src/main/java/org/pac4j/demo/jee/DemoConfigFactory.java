package org.pac4j.demo.jee;

import org.pac4j.cas.client.CasClient;
import org.pac4j.cas.client.CasProxyReceptor;
import org.pac4j.cas.config.CasConfiguration;
import org.pac4j.core.authorization.authorizer.IsAnonymousAuthorizer;
import org.pac4j.core.authorization.authorizer.IsAuthenticatedAuthorizer;
import org.pac4j.core.authorization.authorizer.RequireAnyRoleAuthorizer;
import org.pac4j.core.client.Clients;
import org.pac4j.core.client.direct.AnonymousClient;
import org.pac4j.core.config.Config;
import org.pac4j.core.config.ConfigFactory;
import org.pac4j.core.logout.handler.DefaultLogoutHandler;

import org.pac4j.core.matching.matcher.PathMatcher;
import org.pac4j.http.client.direct.DirectBasicAuthClient;
import org.pac4j.http.client.direct.ParameterClient;
import org.pac4j.http.client.indirect.FormClient;
import org.pac4j.http.client.indirect.IndirectBasicAuthClient;
import org.pac4j.http.credentials.authenticator.test.SimpleTestUsernamePasswordAuthenticator;
import org.pac4j.jwt.config.signature.SecretSignatureConfiguration;
import org.pac4j.jwt.config.signature.SignatureConfiguration;
import org.pac4j.jwt.credentials.authenticator.JwtAuthenticator;
import org.pac4j.oauth.client.FacebookClient;
import org.pac4j.oauth.client.StravaClient;
import org.pac4j.oauth.client.TwitterClient;
import org.pac4j.oidc.client.GoogleOidcClient;
import org.pac4j.oidc.config.OidcConfiguration;
import org.pac4j.saml.client.SAML2Client;
import org.pac4j.saml.config.SAML2Configuration;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class DemoConfigFactory implements ConfigFactory {

    @Override
    public Config build(final Object... parameters) {
        final OidcConfiguration oidcConfiguration = new OidcConfiguration();
        oidcConfiguration.setClientId("167480702619-8e1lo80dnu8bpk3k0lvvj27noin97vu9.apps.googleusercontent.com");
        oidcConfiguration.setSecret("MhMme_Ik6IH2JMnAT6MFIfee");
        oidcConfiguration.setUseNonce(true);
        //oidcClient.setPreferredJwsAlgorithm(JWSAlgorithm.RS256);
        oidcConfiguration.addCustomParam("prompt", "consent");
        final GoogleOidcClient oidcClient = new GoogleOidcClient(oidcConfiguration);
        oidcClient.setAuthorizationGenerator((ctx, profile) -> { profile.addRole("ROLE_ADMIN"); return Optional.of(profile); });

        final SAML2Configuration cfg = new SAML2Configuration("resource:samlKeystore.jks",
                                                "pac4j-demo-passwd",
                                                "pac4j-demo-passwd",
                                                "resource:samltest-providers.xml");
        cfg.setMaximumAuthenticationLifetime(3600);
        cfg.setServiceProviderEntityId("http://localhost:8080/callback?client_name=SAML2Client");
        cfg.setServiceProviderMetadataPath(new File("sp-metadata.xml").getAbsolutePath());
        final SAML2Client saml2Client = new SAML2Client(cfg);

        final FacebookClient facebookClient = new FacebookClient("145278422258960", "be21409ba8f39b5dae2a7de525484da8");
        final TwitterClient twitterClient = new TwitterClient("CoxUiYwQOSFDReZYdjigBA", "2kAzunH5Btc4gRSaMr7D7MkyoJ5u1VzbOOzE8rBofs");
        // HTTP
        final FormClient formClient = new FormClient("http://localhost:8080/loginForm.jsp", new SimpleTestUsernamePasswordAuthenticator());
        final IndirectBasicAuthClient indirectBasicAuthClient = new IndirectBasicAuthClient(new SimpleTestUsernamePasswordAuthenticator());

        // CAS
        final CasConfiguration configuration = new CasConfiguration("https://casserverpac4j.herokuapp.com/login");
        //final CasConfiguration configuration = new CasConfiguration("http://localhost:8888/cas/login");
        final DefaultLogoutHandler defaultCasLogoutHandler = new DefaultLogoutHandler();
        defaultCasLogoutHandler.setDestroySession(true);
        configuration.setLogoutHandler(defaultCasLogoutHandler);
        final CasProxyReceptor casProxy = new CasProxyReceptor();
        //configuration.setProxyReceptor(casProxy);
        final CasClient casClient = new CasClient(configuration);

        /*final DirectCasClient casClient = new DirectCasClient(configuration);
        casClient.setName("CasClient");*/

        // Strava
        final StravaClient stravaClient = new StravaClient();
        stravaClient.setApprovalPrompt("auto");
        // client_id
        stravaClient.setKey("3945");
        // client_secret
        stravaClient.setSecret("f03df80582396cddfbe0b895a726bac27c8cf739");
        stravaClient.setScope("view_private");

        // REST authent with JWT for a token passed in the url as the token parameter
        final List<SignatureConfiguration> signatures = new ArrayList<>();
        signatures.add(new SecretSignatureConfiguration(Constants.JWT_SALT));
        ParameterClient parameterClient = new ParameterClient("token", new JwtAuthenticator(signatures));
        parameterClient.setSupportGetRequest(true);
        parameterClient.setSupportPostRequest(false);

        // basic auth
        final DirectBasicAuthClient directBasicAuthClient = new DirectBasicAuthClient(new SimpleTestUsernamePasswordAuthenticator());
        /*final DirectDigestAuthClient directBasicAuthClient = new DirectDigestAuthClient((credentials, context) -> {
            final CommonProfile profile = new CommonProfile();
            final DigestCredentials digestCredentials = (DigestCredentials) credentials;
            profile.setId(digestCredentials.getToken());
            profile.addAttribute(Pac4jConstants.USERNAME, digestCredentials.getUsername());
            credentials.setUserProfile(profile);
        });
        directBasicAuthClient.setName("DirectBasicAuthClient");*/

        final Clients clients = new Clients("http://localhost:8080/callback", oidcClient, saml2Client, facebookClient,
                twitterClient, formClient, indirectBasicAuthClient, casClient, stravaClient, parameterClient,
                directBasicAuthClient, new AnonymousClient(), casProxy);

        final Config config = new Config(clients);
        config.addAuthorizer("admin", new RequireAnyRoleAuthorizer("ROLE_ADMIN"));
        config.addAuthorizer("custom", new CustomAuthorizer());
        config.addAuthorizer("mustBeAnon", new IsAnonymousAuthorizer("/?mustBeAnon"));
        config.addAuthorizer("mustBeAuth", new IsAuthenticatedAuthorizer("/?mustBeAuth"));
        config.addMatcher("excludedPath", new PathMatcher().excludeRegex("^/facebook/notprotected\\.jsp$"));
        return config;
    }
}
