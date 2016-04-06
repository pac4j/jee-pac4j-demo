package org.pac4j.demo.j2e;

import org.apache.commons.lang3.StringUtils;
import org.pac4j.core.authorization.authorizer.SingleProfileAuthorizer;
import org.pac4j.core.context.WebContext;
import org.pac4j.core.profile.CommonProfile;

public class CustomAuthorizer extends SingleProfileAuthorizer<CommonProfile> {

    public boolean isProfileAuthorized(final WebContext context, final CommonProfile profile) {
        if (profile == null) {
            return false;
        }
        return StringUtils.startsWith(profile.getUsername(), "jle");
    }
}
