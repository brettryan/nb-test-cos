<%@ page pageEncoding="UTF-8" session="true" contentType="text/html" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Test for NetBeans IDE CoS for Resources</title>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

    <link rel="stylesheet" src="<c:url value="/static/css/main.css"/>">
  </head>

  <body>

    <div class="container">

      <div class="page-header">
        <h1>NetBeans IDE CoS for Resources Test</h1>
        <p class="lead">
          CoS (Compile On Save) is a feature of the <a href="http://netbeans.org">NetBeans IDE</a>
          which will compile classes and copy resources to the compilation
          directory so a full rebuild is not required.
        </p>
      </div>

      <h3>The Problem?</h3>
      <p>
        <a href="http://netbeans.org">NetBeans IDE</a>'s CoS feature does not work for Maven based projects when
        resource filters are applied within the projects <samp>pom.xml</samp>
        file. This document outlines out to reproduce this problem for the
        purpose of resolving <a href="https://netbeans.org/bugzilla/show_bug.cgi?id=236047">bug 236047</a>.
      </p>

      <p>
        The cause is when your projects <samp>pom.xml</samp> file contains a
        resource processor which causes <a href="http://netbeans.org">NetBeans IDE</a> to stop copying modified
        resources.
      </p>

      <pre><code>&lt;resources&gt;
  &lt;resource&gt;
    &lt;directory&gt;src/main/resources&lt;/directory&gt;
    &lt;filtering&gt;true&lt;/filtering&gt;
    &lt;includes&gt;
      &lt;include&gt;**/*.properties&lt;/include&gt;
    &lt;/includes&gt;
  &lt;/resource&gt;
  &lt;resource&gt;
    &lt;directory&gt;src/main/resources&lt;/directory&gt;
    &lt;filtering&gt;false&lt;/filtering&gt;
    &lt;excludes&gt;
      &lt;exclude&gt;**/*.properties&lt;/exclude&gt;
    &lt;/excludes&gt;
  &lt;/resource&gt;
&lt;/resources&gt;</code></pre>

      <h3>Instructions</h3>

      <p>
        Follow these instructions to reproduce the issue that has been outlined
        above.
      </p>

      <p>
        In order to demonstrate the CoS feature is working, ensure that the
        <samp>&lt;resources&gt;</samp> section of the <samp>pom.xml</samp> file
        is commented out (default). Now with the project running and CoS turned
        on for the project, edit the file <samp>src/main/resources/test.txt</samp>
        and reload this page. Observe the following block will represent the
        contents of the file.
      </p>

      <div class="panel panel-info">
        <div class="panel-heading">Contents of <samp>src/main/resources/test.txt</samp></div>
        <div class="panel-body">
          <pre><code>${fileContent}</code></pre>
        </div>
      </div>

      <p>
        Now clean the project and uncomment the <samp>&lt;resources&gt;</samp>
        section within the <samp>pom.xml</samp> file. Re-run the project and
        notice that now when you save the file <a href="http://netbeans.org">NetBeans IDE</a> will not copy the
        modified file to the compiled target. Observe also that this file is of
        an extension <samp>.txt</samp> which means it is excluded within the
        resource processing rules of the maven pom.
      </p>
    </div>

    <script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  </body>

</html>
