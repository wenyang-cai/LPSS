# LPSS
====

Library Path Search System(LPSS) Project. It is a JSP project. The objective is to search the shortest path for collecting books in a library. It is a student AI project in University of Liverpool.

====

## Quick Guide

### Steps

### Use in different ways

* Use in Eclipse

Just import the whole /LPSS folder as a Java EE project into Eclipse

* Use as tomcat webapps (not in Eclipse)

If you are not using Eclipse, in /LPSS, you can 
1. move the 'classes' folder (LPSS/build/classes) to LPSS/WebContent/WEB-INF/
2. move the 'WebContent' folder (LPSS/WebContent) to your Tomcat home path, under /webapps folder (TomcatHOME/webapps/)
3. in TomcatHOME/webapps/, rename the 'WebContent' folder as 'LPSS')
4. Then (after setting mysql, importing the sql file, and start tomcat server) you can visit [http://localhost:8080/LPSS](http://localhost:8080/LPSS)

