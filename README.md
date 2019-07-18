## Welcome to the Design Tests wiki!

This project contains experiments with design tests using DesignWizard API. This project contains scripts and programs for running design tests for a set of systems that use Hibernate/JPA and it been selected from github.

Our main objective is demonstrating the possibilities of the DesignWizard tool for the verification of architectural rules.

So, we have written design tests for domain model rules (design rules for persistent classes) that are described on documentation of the Hibernate Framework (See in https://docs.jboss.org/hibernate/orm/5.0/userGuide/en-US/html/ch02.html) and on the JPA Specification. The rules used in the articles are general and must be followed by all the projects.

This set of Hibernate architectural rules is described in the documentation for all versions of the framework, including the latest new releases. Below is the documentation section where the rules are described.

Na versão 5.0 ou anteriores do Hibernate, as regras são descritas na seção 2.1. POJO Domain Models:

* https://docs.jboss.org/hibernate/orm/5.0/userguide/en-US/html/ch02.html

Da versão 5.1 à 6.0 do Hibernate as regras são descritas na seção 2.5.1. POJO Models:

* https://docs.jboss.org/hibernate/orm/5.1/userguide/html_single/Hibernate_User_Guide.html#entity-pojo
* https://docs.jboss.org/hibernate/orm/5.4/userguide/html_single/Hibernate_User_Guide.html#domain-model 
* https://docs.jboss.org/hibernate/orm/6.0/userguide/html_single/Hibernate_User_Guide.html#domain-model


### Continuos Integration with [Travis](https://travis-ci.org)

[![Build Status](https://travis-ci.org/tacianosilva/designtestminer.svg)](https://travis-ci.org/tacianosilva/designtestminer)

### Instructions to Eclipse users

This project is deployed as an Eclipse project with Maven. In order to import
*DesignTests* properly, consider the following steps:

1. Clone the project from the official GitHub repository
2. On *Eclipse*, install Git.
3. On *Eclipse*, install Maven.
2. On *Eclipse*, import a Java project of the cloned
folder. *Eclipse* will understand the configuration on the existing project.

### Instructions to Maven users

The API GXL doesn't distributed in the maven repositories and it needs to be
installed in local repository. The maven commando for install:

mvn install:install-file -Dfile=gxl.jar -DgroupId=net.sourceforge.gxl -DartifactId=gxl -Dversion=0.92 -Dpackaging=jar

Download GXL:  http://gxl.sourceforge.net/
