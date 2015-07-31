## What is this project?

This `j2e-pac4j-demo` project is a Java web application to test the [j2e-pac4j](https://github.com/pac4j/j2e-pac4j) library with various authentication mechanisms: Facebook, Twitter, form authentication, basic auth, CAS...

## Start & test

Build the project and launch the web app with jetty:

    cd j2-pac4j-demo
    mvn clean compile jetty:run

To test, you can call a protected url by clicking on the "Protected url by **xxx**" url, which will start the authentication process with the **xxx** provider.  
Or you can click on the "Authenticate with **xxx**" link to manually start the authentication process with the **xxx** provider.

To test the CAS support, you need to start a CAS server on port 8888. Use the following demos: [cas-overlay-demo](https://github.com/leleuj/cas-overlay-demo) or [cas-overlay-3.5.x](https://github.com/leleuj/cas-overlay-3.5.x) with the option: `-Djetty.port=8888`.
