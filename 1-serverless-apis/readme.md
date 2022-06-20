# Serverless APIs with Azure Functions

Integration basics with Logic Apps and Functions.

## Azure Logic Apps

When you build workflows using Azure Logic Apps, you can use connectors to help you quickly and easily access data, events, and resources in other apps, services, systems, protocols, and platforms - often without writing any code.  A connector provides prebuilt operations that you can use as steps in your workflows.  Azure Logic Apps provide hundreds of connectors that you can use.  If no connector is available for the resource that you want to access, you can use the generic HTTP operation to communicate with the service, or you can create a custom connector.

## Azure Functions

This service provides a simplified way to write and run pieces of code or functions in the cloud. You can write only the code you need for the current problem, without setting up a complete app or the required infrastructure, which makes development faster and more productive. Use your chosen development language, such as C#, Java, JavaScript, PowerShell, Python, and TypeScript. You're billed only for the duration when your code runs, and Azure scales as necessary.

## Challenge 1

1. Create an HTTP triggered Function with the following configuration:

    * **Verb**: POST

    * **Input**: The `message` parameter value as a query parameter or in the request body

    * **Result**: "The program name for your program id {the id passed into the function} is Program A"

    > Note, parameter names are case sensitive.

1. Verify the Function is working correctly, then deploy to Azure.

## Challenge 2

1. Create an HTTP triggered Logic App (When a HTTP request is received) with the following configuration:

    * **Verb**: POST

    * **Payload**:

        ```JSON
        {
            "message": "test message"
        }
        ```

## Challenge 3

1. Add an action to the Logic App action to call the Azure Function, passing the example payload to the `message` parameter. The response should include the message.

## Azure Functions Reference

* [Introduction to Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-overview)

* [Supported languages in Azure Functions](https://docs.microsoft.com/azure/azure-functions/supported-languages)

### Local Development with VS Code, Ubuntu (wsl), and Node.js

* [QuickStart: Create a JavaScript function in Azure using Visual Studio Code](https://docs.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-node)

* [Develop JavaScript Functions with Visual Studio Code](https://docs.microsoft.com/en-us/azure/azure-functions/functions-develop-vs-code?tabs=nodejs)

* [Work with Azure Functions Core Tools on Linux](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux)

* [Strategies for testing JavaScript in VS Code](https://docs.microsoft.com/en-us/azure/azure-functions/functions-test-a-function#javascript-in-vs-code)

### Local Development with Visual Studio

* [QuickStart: Create your first C# function in Azure using Visual Studio](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-your-first-function-visual-studio)

* [Develop Azure Functions using Visual Studio](https://docs.microsoft.com/en-us/azure/azure-functions/functions-develop-vs)

* [Work with Azure Functions Core Tools on Windows](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=windows)

* [Strategies for testing C# in Visual Studio](https://docs.microsoft.com/en-us/azure/azure-functions/functions-test-a-function#c-in-visual-studio)

## Logic Apps

* [Introduction to Logic Apps](https://docs.microsoft.com/azure/logic-apps/logic-apps-overview)  

* [Connectors Overview](https://docs.microsoft.com/en-us/azure/connectors/apis-list)  

* [QuickStart: Create and manage logic app workflow definitions with multi-tenant Azure Logic Apps and Visual Studio Code](https://docs.microsoft.com/en-us/azure/logic-apps/quickstart-create-logic-apps-visual-studio-code)  

* [QuickStart: Create automated integration workflows with multi-tenant Azure Logic Apps and Visual Studio](https://docs.microsoft.com/en-us/azure/logic-apps/quickstart-create-logic-apps-with-visual-studio)

* [Logic Apps Call, trigger, or nest workflows with HTTP endpoints in Logic Apps](https://docs.microsoft.com/azure/logic-apps/logic-apps-http-endpoint)

## Example Code

### Query the Local Function from PowerShell

Verify the local port number is correct

```PowerShell
$message = "test message query $(Get-Date)"
$uri = 'http://localhost:7273/api/GetMessageQuery'+"?message=$message"
Invoke-WebRequest -Uri $uri -Method POST

$uri = 'http://localhost:7273/api/GetMessageBody'
$message = "test message body $(Get-Date)"
$body = @{"message" = $message} | ConvertTo-Json
Invoke-WebRequest -Uri $uri -Method POST -Body $body
```

### JavaScript Function

```JavaScript
module.exports = async function (context, req) {
    context.log('JavaScript HTTP trigger function processed a request.');

    const message = (req.query.message || (req.body && req.body.message));
    const responseMessage = message
        ? "The program name for your program id {" + message + "} is Program A."
        : "Please provide a message on the query string!";

    context.res = {
        // status: 200, /* Defaults to 200 */
        body: responseMessage
    };
}
```

### C# Function with Request Body

```CSharp
public static class GetMessageBody {
    [FunctionName("GetMessageBody")]
    public static async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "post", Route = null)] HttpRequest req,
        ILogger log) {
        log.LogInformation("C# HTTP trigger function processed a request.");

        string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
        dynamic data = JsonConvert.DeserializeObject(requestBody);
        string message = data?.message;
        log.LogInformation("message value: " + message);

        string responseMessage = string.IsNullOrEmpty(message)
            ? "This HTTP triggered function executed successfully. Pass a message in message body!"
            : $"The message, {message}.";
        log.LogInformation("responseMessage: " + responseMessage);

        return new OkObjectResult(responseMessage);
    }
}
```

### C# Function with Query Parameter

```CSharp
public static class GetMessageQuery {
    [FunctionName("GetMessageQuery")]
    public static async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "post", Route = null)] HttpRequest req,
        ILogger log) {
        log.LogInformation("C# HTTP trigger function processed a request.");

        string message = req.Query["message"];
        log.LogInformation("message query: " + message);

        string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
        dynamic data = JsonConvert.DeserializeObject(requestBody);
        message = message ?? data?.message;
        log.LogInformation("message value: " + message);

        string responseMessage = string.IsNullOrEmpty(message)
            ? "This HTTP triggered function executed successfully. Pass a message in the query string!"
            : $"The message, {message}.";
        log.LogInformation("responseMessage: " + responseMessage);

        return new OkObjectResult(responseMessage);
    }
}
```

### Logic App for Query Parameter Function

```JSON
{
    "definition": {
        "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
        "actions": {
            "GetMessageQuery": {
                "inputs": {
                    "function": {
                        "id": "/subscriptions/0aef800c-dacc-40c8-aad0-47207100f1da/resourceGroups/hack-usw3-api/providers/Microsoft.Web/sites/hack-feedback-api/functions/GetMessageQuery"
                    },
                    "method": "POST",
                    "queries": {
                        "message": "@triggerBody()?['message']"
                    }
                },
                "runAfter": {},
                "type": "Function"
            },
            "Response": {
                "inputs": {
                    "body": "@body('GetMessageQuery')",
                    "statusCode": 200
                },
                "kind": "Http",
                "runAfter": {
                    "GetMessageQuery": [
                        "Succeeded"
                    ]
                },
                "type": "Response"
            }
        },
        "contentVersion": "1.0.0.0",
        "outputs": {},
        "parameters": {},
        "triggers": {
            "manual": {
                "inputs": {
                    "method": "POST",
                    "schema": {
                        "properties": {
                            "message": {
                                "type": "string"
                            }
                        },
                        "type": "object"
                    }
                },
                "kind": "Http",
                "type": "Request"
            }
        }
    },
    "parameters": {}
}
```

### Logic App for Request Body Function

```JSON
{
    "definition": {
        "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
        "actions": {
            "GetMessageBody": {
                "inputs": {
                    "body": {
                        "message": "@triggerBody()?['message']"
                    },
                    "function": {
                        "id": "/subscriptions/0aef800c-dacc-40c8-aad0-47207100f1da/resourceGroups/hack-usw3-api/providers/Microsoft.Web/sites/hack-feedback-api/functions/GetMessageBody"
                    },
                    "method": "POST"
                },
                "runAfter": {},
                "type": "Function"
            },
            "Response": {
                "inputs": {
                    "body": "@body('GetMessageBody')",
                    "statusCode": 200
                },
                "kind": "Http",
                "runAfter": {
                    "GetMessageBody": [
                        "Succeeded"
                    ]
                },
                "type": "Response"
            }
        },
        "contentVersion": "1.0.0.0",
        "outputs": {},
        "parameters": {},
        "triggers": {
            "manual": {
                "inputs": {
                    "method": "POST",
                    "schema": {
                        "properties": {
                            "message": {
                                "type": "integer"
                            }
                        },
                        "type": "object"
                    }
                },
                "kind": "Http",
                "type": "Request"
            }
        }
    },
    "parameters": {}
}
```