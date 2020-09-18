# OSD-iDAAS-Connect-HL7
Specific repository for Open Source Days 2020

# Reporting New Issues/Bugs
Please feel free to use the Issues tab to report any new issues and associate them to the label #bug

# Setup
This platform does require Kafka to run. To simplify the process we have built in a scripts directory and all the needed scripts to enable users. We have also included the needed files within this repository, to limit external downloads. The scripts are done from the perspective of the user leveraging a Mac and setting it up within the home directory and able to start everything from it simply. 

This solution contains three supporting directories. The intent of these artifacts to enable resources to work locally: 

platform-addons: needed software to run locally. This currently contains amq-streams-1.5 (which is the upstream of Kafka 2.5)
platform-scripts: support running kafka, creating/listing and deleting topics needed for this solution and also building and packaging the solution as well. All the scripts are named to describe their capabilities 
platform-testdata: sample transactions to leverage for using the platform.

In order to see data flowing to kafa there are several tools, we leverage <a href="https://www.kafkatool.com/" target="_blank">Kafka Tools</a>. You can download the tool from this site and follow ANY setup instructions.

# Scenario: Integration 
This repository follows a very common general facility based implementation. The implementation
is of a facility, we have named MCTN for an application we have named MMS. This implementation 
specifically defines one HL7 socket server endpoint per datatype mentioned above.

## Integration Data Flow Steps
 
1. The HL7 client (external to this application) will connect to the specifically defined HL7
Server socket (one socket per datatype) and typically stay connected.
2. The HL7 client will send a single HL7 based transaction to the HL7 server.
3. iDAAS Connect HL7 will do the following actions:<br/>
    a. Receive the HL7 message. Internally, it will audit the data it received to 
    a specifically defined topic.<br/>
    b. The HL7 message will then be processed to a specifically defined topic for this implementation. There is a 
    specific topic pattern -  for the facility and application each data type has a specific topic define for it.
    For example: MCTN_MMS_ADT, MCTN_MMS_ORM, etc. <br/>
    c. An acknowledgement will then be sent back to the hl7 client (this tells the client he can send the next message,
    if the client does not get this in a timely manner it will resend the same message again until he receives an ACK).<br/>
    d. The acknowledgement is also sent to the auditing topic location.<br/>
    
# Builds
This section will cover both local and automated builds.

## Local Builds
Within the code base you can find the local build commands in the /platform-scripts directory
1.  Run the build-solution.sh script
It will run the maven commands to build and then package up the solution. The package will use the usual settings
in the pom.xml file. It pulls the version and concatenates the version to the output jar it builds.
Additionally, there is a copy statement to remove any specific version, so it outputs idaas-connect-hl7.jar
