package org.pac4j.demo.jee;

import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MySessionListener implements HttpSessionListener {

    private  static final Logger logger = LoggerFactory.getLogger(MySessionListener.class);

    @Override
    public void sessionCreated(final HttpSessionEvent event) {
        logger.debug("Session created");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent var1) {
        logger.debug("Session destroyed");
    }
}
