#/bin/bash

# verify subscription
az account show
az account list -o table
az account set -s <subscription GUID>
az account set -s $(<az_subscription.env)

# list locations
az account list-locations -o table

# set variables
AZ_SERVICEBUS_RG='hack-usw3-servicebus'
AZ_SERVICEBUS_LOCATION='westus3'
AZ_SERVICEBUS_NAMESPACE='hack-usw3-sb-ns1'
AZ_SERVICEBUS_QUEUE='sbq-test'
AZ_SERVICEBUS_TOPIC='sbt-test'
AZ_SERVICEBUS_SUB1='sbt-testsub1'
AZ_SERVICEBUS_SUB1_FILTER='sbt-testsub1-filter'
AZ_SERVICEBUS_SUB1_QUERY="storeId IN ('store1','store2','store3')"
AZ_SERVICEBUS_SUB2='sbt-testsub2'
AZ_SERVICEBUS_SUB2_FILTER='sbt-testsub2-filter'
AZ_SERVICEBUS_SUB2_QUERY="storeId NOT IN ('store1','store2','store3')"

# create resource group
az group create --name $AZ_SERVICEBUS_RG --location $AZ_SERVICEBUS_LOCATION

# register Microsoft.ServiceBus resource provider
az provider register -n Microsoft.ServiceBus
az provider show -n Microsoft.ServiceBus -o table

#
# CHALLENGE 1
# create a Service Bus messaging namespace
az servicebus namespace create --resource-group $AZ_SERVICEBUS_RG --name $AZ_SERVICEBUS_NAMESPACE --location $AZ_SERVICEBUS_LOCATION

# create a queue in the namespace you created in the previous step
az servicebus queue create --resource-group $AZ_SERVICEBUS_RG --namespace-name $AZ_SERVICEBUS_NAMESPACE --name $AZ_SERVICEBUS_QUEUE

# get the primary connection string for the namespace
az servicebus namespace authorization-rule keys list --resource-group $AZ_SERVICEBUS_RG --namespace-name $AZ_SERVICEBUS_NAMESPACE --name RootManageSharedAccessKey --query primaryConnectionString --output tsv

AZ_SERVICEBUS_ENDPOINT=$(az servicebus namespace authorization-rule keys list --resource-group $AZ_SERVICEBUS_RG --namespace-name $AZ_SERVICEBUS_NAMESPACE --name RootManageSharedAccessKey --query primaryConnectionString --output tsv)

echo $AZ_SERVICEBUS_ENDPOINT

#
# CHALLENGE 2
# create a topic in the namespace you created in the previous step
az servicebus topic create --resource-group $AZ_SERVICEBUS_RG  --namespace-name $AZ_SERVICEBUS_NAMESPACE --name $AZ_SERVICEBUS_TOPIC

# create the first subscription to the topic
az servicebus topic subscription create --resource-group $AZ_SERVICEBUS_RG --namespace-name $AZ_SERVICEBUS_NAMESPACE --topic-name $AZ_SERVICEBUS_TOPIC --name $AZ_SERVICEBUS_SUB1

# create the second subscription to the topic
az servicebus topic subscription create --resource-group $AZ_SERVICEBUS_RG --namespace-name $AZ_SERVICEBUS_NAMESPACE --topic-name $AZ_SERVICEBUS_TOPIC --name $AZ_SERVICEBUS_SUB2

# create a filter on the first subscription with a filter using custom properties
az servicebus topic subscription rule create \
    --resource-group $AZ_SERVICEBUS_RG \
    --namespace-name $AZ_SERVICEBUS_NAMESPACE \
    --topic-name $AZ_SERVICEBUS_TOPIC \
    --subscription-name $AZ_SERVICEBUS_SUB1 \
    --name $AZ_SERVICEBUS_SUB1_FILTER \
    --filter-sql-expression "$AZ_SERVICEBUS_SUB1_QUERY"

# create a filter on the second subscription with a filter using custom properties
az servicebus topic subscription rule create \
    --resource-group $AZ_SERVICEBUS_RG \
    --namespace-name $AZ_SERVICEBUS_NAMESPACE \
    --topic-name $AZ_SERVICEBUS_TOPIC \
    --subscription-name $AZ_SERVICEBUS_SUB2 \
    --name $AZ_SERVICEBUS_SUB2_FILTER \
    --filter-sql-expression "$AZ_SERVICEBUS_SUB2_QUERY"