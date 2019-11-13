# Online Appointment - Petclinic

Spring PetClinic Sample Application Build Status

Deploy this sample application to Pivotal Web Services:
Push
Understanding the Spring Petclinic application with a few diagrams

See the presentation here
Running petclinic locally

Petclinic is a Spring Boot application built using Maven. You can build a jar file and run it from the command line:

git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar

You can then access petclinic here: http://localhost:8080/

petclinic-screenshot

Or you can run it from Maven directly using the Spring Boot Maven plugin. If you do this it will pick up changes that you make in the project immediately (changes to Java source files require a compile as well - most people use an IDE for this):

./mvnw spring-boot:run

In case you find a bug/suggested improvement for Spring Petclinic

Our issue tracker is available here: https://github.com/spring-projects/spring-petclinic/issues
Database configuration

In its default configuration, Petclinic uses an in-memory database (HSQLDB) which gets populated at startup with data. A similar setup is provided for MySql in case a persistent database configuration is needed. Note that whenever the database type is changed, the app needs to be run with a different profile: spring.profiles.active=mysql for MySql.

You could start MySql locally with whatever installer works for your OS, or with docker:

docker run -e MYSQL_ROOT_PASSWORD=petclinic -e MYSQL_DATABASE=petclinic -p 3306:3306 mysql:5.7.8

Further documentation is provided here.
Working with Petclinic in your IDE
Prerequisites

The following items should be installed in your system:

    Java 8 or newer.
    git command line tool (https://help.github.com/articles/set-up-git)
    Your preferred IDE
        Eclipse with the m2e plugin. Note: when m2e is available, there is an m2 icon in Help -> About dialog. If m2e is not there, just follow the install process here: https://www.eclipse.org/m2e/
        Spring Tools Suite (STS)
        IntelliJ IDEA
        VS Code

Steps:

    On the command line

git clone https://github.com/spring-projects/spring-petclinic.git

    Inside Eclipse or STS

File -> Import -> Maven -> Existing Maven project

Then either build on the command line ./mvnw generate-resources or using the Eclipse launcher (right click on project and Run As -> Maven install) to generate the css. Run the application main method by right clicking on it and choosing Run As -> Java Application.

    Inside IntelliJ IDEA

In the main menu, choose File -> Open and select the Petclinic pom.xml. Click on the Open button.

CSS files are generated from the Maven build. You can either build them on the command line ./mvnw generate-resources or right click on the spring-petclinic project then Maven -> Generates sources and Update Folders.

A run configuration named PetClinicApplication should have been created for you if you're using a recent Ultimate version. Otherwise, run the application by right clicking on the PetClinicApplication main class and choosing Run 'PetClinicApplication'.

    Navigate to Petclinic

Visit http://localhost:8080 in your browser.
Looking for something in particular?
Spring Boot Configuration 	Class or Java property files
The Main Class 	PetClinicApplication
Properties Files 	application.properties
Caching 	CacheConfiguration
Interesting Spring Petclinic branches and forks

The Spring Petclinic master branch in the main spring-projects GitHub org is the "canonical" implementation, currently based on Spring Boot and Thymeleaf. There are quite a few forks in a special GitHub org spring-petclinic. If you have a special interest in a different technology stack that could be used to implement the Pet Clinic then please join the community there.
Interaction with other open source projects

One of the best parts about working on the Spring Petclinic application is that we have the opportunity to work in direct contact with many Open Source projects. We found some bugs/suggested improvements on various topics such as Spring, Spring Data, Bean Validation and even Eclipse! In many cases, they've been fixed/implemented in just a few days. Here is a list of them:
Name 	Issue
Spring JDBC: simplify usage of NamedParameterJdbcTemplate 	SPR-10256 and SPR-10257
Bean Validation / Hibernate Validator: simplify Maven dependencies and backward compatibility 	HV-790 and HV-792
Spring Data: provide more flexibility when working with JPQL queries 	DATAJPA-292
Contributing

The issue tracker is the preferred channel for bug reports, features requests and submitting pull requests.

For pull requests, editor preferences are available in the editor config for easy use in common text editors. Read more and download plugins at https://editorconfig.org. If you have not previously done so, please fill out and submit the Contributor License Agreement.
License

The Spring PetClinic sample application is released under version 2.0 of the Apache License.