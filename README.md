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

