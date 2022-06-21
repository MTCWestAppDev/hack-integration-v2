# Event Grid

Event Grid is a highly scalable, serverless event broker that you can use to integrate applications using events. Events are delivered by Event Grid to subscriber destinations such as applications, Azure services, or any endpoint to which Event Grid has network access. The source of those events can be other applications, SaaS services and Azure services.

With Event Grid you connect solutions using event-driven architectures. An event-driven architecture uses events to communicate occurrences in system state changes, for example, to other applications or services. You can use filters to route specific events to different endpoints, multicast to multiple endpoints, and make sure your events are reliably delivered.

![image info](https://docs.microsoft.com/en-us/azure/event-grid/media/overview/functional-model-big.png){height:1%;}

## Challenge 1

This challenge involves creating a Event Grid namespace and configuring an Azure Logic App to receive messages

1. [Handle Service Bus Events with Event Grid and Logic Apps](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-to-event-grid-integration-example?toc=%2Fazure%2Fevent-grid%2Ftoc.json)

## Challenge 2

This challenge involves creating a Event Grid namespace and configuring an Azure Function to receive messages

1. [Handle Service Bus Events with Event Grid and Functions](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-to-event-grid-integration-example?toc=%2Fazure%2Fevent-grid%2Ftoc.json)