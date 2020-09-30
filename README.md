# OSD-iDAAS-Connect-HL7
Specific repository for Open Source Days 2020

# Background and Reason for this Work
In healthcare for decades systems have been decoupled and in most cases healthcare providers DO NOT have everything in one central system. So, lets talk through a scenario and make sure everyone has some background on whats involved in healthcare to move data between systems. <br/>

Because of this need in the 1980's a standard was created to help healthcare integrate systems. HL7 is one of the standards bodies that manages specifications in healthcare, their focus is the clinical care side of the industry and they only handle specific billing related transactions as part of supporting the clinical services they support. For more details on all the specifications they manage in healthcare, please feel to visit the <a href="https://www.hl7.org/" target="_blank">HL7 Web Site</a>. HL7 is a very legacy based standards specific to the way communications occur. HL7 v2 communication involves a client-server based communication model known as MLLP (Minimal Lower Layer Protocol), the expectation is that the server is running one hundred percent of the time to receive transactions. As part of its communication it requires that every transaction is specifically acknowledged or negatively acknowledged during processing. Finally, healthcare systems and integrations typically involve a FIFO based messaging pattern, every message must be processed in order.

## Healthcare Integration Scenario
Here is a case (Covid) that explains the healthcare experience of a patient and relates it to how HL7 enables systems to work together:<br/>
A patient comes into the ER complaining of a cough and having a fever for several days. They also state their breathing has become labored over the last few hours. <br/> 
1. Patient walks into ER and get triaged by Nurse. When the curse does this triage an admission (ADT) message is created to take patient information. This assigns him ready to receive care and also enables both the clinical and financial systems. The patient information can be changed or updaated easily and as these changes occur updated transactions and sent and routed to ALL relevant systems near real time. <br/>
2. Doctor see patient and orders some lab tests and chest x-ray. The doctor's places an Order and an (ORM) message is created specific to this information and send and routed to all clinical and financial systems.<br/>
3. When the lab or radiology resources completes the Order the systems will generate a Result (ORU) message and it will be updated with various information: the resource that draws the blood, the resource that reads the X-Ray and so forth. As the results come in from the chest X-rays and blood tests the ORU messages are updated with all the relevant information.
4. The doctor wants to schedule the patient for ANY services, the system will then create a Schedule (SCH) message to ensure the appropriate services are booked.

# Reporting New Issues/Bugs
Please feel free to use the Issues tab to report any new issues and associate them to the label #bug

# Setup
This platform does require Kafka to run. To simplify the process we have built in a scripts directory and all the needed scripts to enable users. We have also included the needed files within this repository, to limit external downloads. The scripts are done from the perspective of the user leveraging a Mac and setting it up within the home directory and able to start everything from it simply. 

## Java
This platform is developed using Java and requires JDK 1.8 to run properly. You can find setup instructions for your operating system <a href="https://docs.oracle.com/javase/8/docs/technotes/guides/install/install_overview.html" target="_blank">here</a>. We are not taking a position on OpenJDK or Oracle's JDK as both have been leveraged, we just included the link to Oracle's JDK.

## Java IDE ??
We have had many developers leverage Java IDEs like IntelliJ ans various Eclipse implementations. Most of the resources leveraging this (and the mentors) have been leveraging the Community Edition of IntelliJ. There are also some editors such as Visual Studio Code that have java support which have been leveraged. 

## Kafka 
In order to see data flowing to kafa there are several tools, we leverage <a href="https://www.kafkatool.com/" target="_blank">Kafka Tools</a>. You can download the tool from this site and follow ANY setup instructions.

## Directories within Solution
This solution contains three supporting directories. The intent of these artifacts to enable resources to work locally: 

platform-addons: needed software to run locally. This currently contains amq-streams-1.5 (which is the upstream of Kafka 2.5)
platform-scripts: support running kafka, creating/listing and deleting topics needed for this solution and also building and packaging the solution as well. All the scripts are named to describe their capabilities 
platform-testdata: sample transactions to leverage for using the platform.

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
