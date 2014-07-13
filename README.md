# LPSS
====

Library Path Search System(LPSS) Project. It is a JSP project. The objective is to search the shortest path for collecting books in a library. It is a student AI project in University of Liverpool.

====

## Quick Guide

For the full installation guide in Chinese (中文说明), check [http://www.jiazhewang.com/blogs-cn/?p=76](http://www.jiazhewang.com/blogs-cn/?p=76)

### Steps

1. Install and set Tomcat
2. Install and set MySQL
    *import the database file (/databaseFile/library.sql) using the database name 'lpss'
3. (optional) Settings in Eclipse
4. Some changes before testing
    *change the database username and password String in /LPSS/src/classes/util/MySQLConnection.java 

### Use in different ways

#### Use in Eclipse

Just import the whole /LPSS folder as a Java EE project into Eclipse

#### Use as tomcat webapps (not in Eclipse)

If you are not using Eclipse, in /LPSS, you can 
1. First of all, set tomcat and mysql, import sql file. Then CHANGE THE PASSWORD string in /LPSS/src/classes/util/MySQLConnection.java , after that, COMPLIE THE JAVA FILES! (you can just use javac)
2. move the 'classes' folder (LPSS/build/classes) to LPSS/WebContent/WEB-INF/
3. move the 'WebContent' folder (LPSS/WebContent) to your Tomcat home path, under /webapps folder (TomcatHOME/webapps/)
4. in TomcatHOME/webapps/, rename the 'WebContent' folder as 'LPSS')
5. Then (after setting mysql, importing the sql file, and start tomcat server) you can visit [http://localhost:8080/LPSS](http://localhost:8080/LPSS)

