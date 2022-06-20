# Service Bus Messaging

Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics (in a namespace). Service Bus is used to decouple applications and services from each other, providing the following benefits:

- Load-balancing work across competing workers
- Safely routing and transferring data and control across service and application boundaries
- Coordinating transactional work that requires a high-degree of reliability

Comparison of Azure Messaging Services:

---
| Service	| Purpose | Type  | When to use |
|-----------|---------|-------|-------------|
| Event Grid | Reactive programming | Event distribution (discrete) | React to status changes |
| Event Hubs | Big data pipeline | Event streaming (series) | Telemetry and distributed data streaming |
| Service Bus | High-value enterprise messaging | Message | Order processing and financial transactions |

## Service Bus Queues

Service Bus queues support a brokered messaging communication model. When using queues, components of a distributed application do not communicate directly with each other; instead they exchange messages via a queue, which acts as an intermediary (broker). A message producer (sender) hands off a message to the queue and then continues its processing. Asynchronously, a message consumer (receiver) pulls the message from the queue and processes it. The producer does not have to wait for a reply from the consumer in order to continue to process and send further messages. Queues offer First In, First Out (FIFO) message delivery to one or more competing consumers. That is, messages are typically received and processed by the receivers in the order in which they were added to the queue, and each message is received and processed by only one message consumer.

![image info](https://docs.microsoft.com/en-us/azure/includes/media/howto-service-bus-queues/sb-queues-08.png)

## Service Bus topics and subscriptions

Service Bus topics and subscriptions support a publish/subscribe messaging communication model. When using topics and subscriptions, components of a distributed application do not communicate directly with each other; instead they exchange messages via a topic, which acts as an intermediary.

![image info](https://docs.microsoft.com/en-us/azure/service-bus-messaging/media/service-bus-java-how-to-use-topics-subscriptions/sb-topics-01.png)

In contrast with Service Bus queues, in which each message is processed by a single consumer, topics and subscriptions provide a one-to-many form of communication, using a publish/subscribe pattern. It is possible to register multiple subscriptions to a topic. When a message is sent to a topic, it is then made available to each subscription to handle/process independently. A subscription to a topic resembles a virtual queue that receives copies of the messages that were sent to the topic. You can optionally register filter rules for a topic on a per-subscription basis, which allows you to filter or restrict which messages to a topic are received by which topic subscriptions.

Service Bus topics and subscriptions enable you to scale to process a large number of messages across a large number of users and applications.

## Challenge 1

This challenge involves creating a Service Bus namespace and queue, configuring an Azure Function to send messages to the Queue and receive Messages from the queue

1. Create a Service Bus Queue

    [Creating a Namespace and Queue](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quickstart-cli)

1. Send messages to the Queue

    [Use Azure Functions to send a Service Bus Queue Message](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus-output)

1. Receive messages to the Queue

    [Use Azure Functions to receive a Service Bus Queue Message](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus-output)

## Challenge 2

1. Create Service Bus Topic and Subscription

    [Create Service Bus Topic and Subscription](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-tutorial-topics-subscriptions-cli)

1. Publish and Subscribe for Messages

    [Service Bus to Logic Apps](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-to-event-grid-integration-example)

## References

- [What is Service Bus](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)
- [Doc: Service Bus .NET Samples](https://docs.microsoft.com/en-us/samples/azure/azure-sdk-for-net/azuremessagingservicebus-samples/)
- [Doc: Service Bus JavaScript Samples](https://docs.microsoft.com/en-us/samples/azure/azure-sdk-for-js/service-bus-javascript/)
- [GitHub: Azure SDK for .NET Service Bus Samples](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/servicebus/Azure.Messaging.ServiceBus)
- [GitHub: Service Bus .NET Samples](https://github.com/Azure/azure-service-bus/tree/master/samples/DotNet/Microsoft.Azure.ServiceBus)
- [GitHub: Service Bus JavaScript Samples](https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/servicebus/service-bus/samples/v7/javascript)
- [Reference Architecture: Enterprise integration using message broker and events](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/enterprise-integration/queues-events)
- [Reference Architecture: Asynchronous messaging options](https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/messaging)
- [Reference Architecture: Priority Queue pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/priority-queue)
