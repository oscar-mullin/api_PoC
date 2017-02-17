# api_PoC

Proof of concept for the **Spigit INC.** API Framework using Rest-Client, Cucumber and Ruby.

## Environment Setup

#### Ruby 2.3.3
1. Download Ruby 2.3.3 from [RubyInstaller.org](http://rubyinstaller.org/downloads/) web page
2. Install Ruby checking all the checkboxes on every step.

#### DevKit 4.7.2
1. Download DevKit 4.7.2 from [RubyInstaller.org](http://rubyinstaller.org/downloads/) web page
2. Install DevKit following below steps:

 - Create a directory named 'Devkit' to install the DevKit artifacts into
 - Double click on the self-extracting executable (SFX)
 - From DevKit folder open a cmd console and execute below commands:

            ruby dk.rb init
            ruby dk.rb install

#### Required Gems
In order to install all necessary gems for this project, you should install bundle and install all files form Gemfile, follow below steps to complete this process:

 - Install Bundle and necessary gems, open a command console and navigate to **test_specs** folder and execute below commands
 
        gem install bundler
        bundle install

#### Java Development Kit
1. Download Java SE Development Kit 8 from [oracle.com](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) web page
2. Run the downloaded installer (e.g., "jdk-8u{xx}-windows-x64.exe"), which installs both the JDK and JRE. By default, the JDK will be installed in directory "C:\Program Files\Java\jdk1.8.0_xx", where xx denotes the upgrade number; and JRE in "C:\Program Files\Java\jre1.8.0_xx".
3. Accept the defaults and follow the screen instructions to install JDK and JRE.
4. Include **"<JAVA_HOME>\bin"** bin directory to the Environment Variables, where **<JAVA_HOME>** denotes the JDK installed directory

## Usage

In order to execute any command you should open a command console, navigate to **test_specs** folder and execute one of below commands:

- Execute a feature on a **single thread**:

        bundle exec cucumber features/[FeatureName].feature
        e.g.:
        bundle exec cucumber features/APITest.feature

- Execute a feature on a **parallel thread**:

        bundle exec parallel_cucumber -n 2 features/[FeatureName].feature --group-by scenarios
        e.g.:
        bundle exec parallel_cucumber -n 2 features/APITest.feature --group-by scenarios

## Reporting

In order to generate the reports you should open a command console, navigate to **test_specs** folder and execute below command:

        ruby -r "./features/support/lib/HTMLReportGenerator.rb" -e "HTMLReportGenerator.generateReport"
                
If everything is fine, you should find the report on *test_specs/output/API Test Report.html*

## Contributing

 1. Create your branch:

 `git checkout -b my-branch`
 2. Commit your changes:

 `git commit -m 'Add some feature'`
 3. Push to the branch:

 `git push origin my-branch`
 4. Submit a *pull request* to `development` branch 

See more on: *Documents/SpigitAuto Git.jpg*

## changelog

- 02/17/2017 - Walter Ramirez - First Version