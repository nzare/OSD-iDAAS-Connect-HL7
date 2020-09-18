kafkaDir='/Users/alscott/RedHatTech/kafka_2.12-2.5.0.redhat-00003'
cd $ kafkaDir

## Operational Topics for Platform
bin/kafka-topics.sh --delete --topic opsmgmt_platformtransactions &
## HL7
## Inbound to iDAAS Platform by Message Trigger
## Facility: MCTN
## Application: MMS
bin/kafka-topics.sh --delete --topic mctn_mms_adt &

## HL7
## Facility By Application by Message Trigger
## Facility: MCTN
## Application: MMS

## HL7
## Enterprise By Application by Message Trigger
## Facility: MCTN
## Application: MMS

## HL7
## Enterprise by Message Trigger
## Application: MMS
