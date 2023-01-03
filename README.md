# ![image](https://user-images.githubusercontent.com/57352037/155895117-523cfb9e-d895-47bf-a962-2bcdda49ad66.png) iOS swift Plugin

Official shurjoPay iOS swift plugin for merchants or service providers to connect with [**_shurjoPay_**](https://shurjopay.com.bd) Payment Gateway ``` v1.1.0 ``` developed and maintained by [_**ShurjoMukhi Limited**_](https://shurjomukhi.com.bd).

This plugin can be used with iOS swift application.
Also it makes easy for developers to integrate with shurjoPay ``` v1.1.0 ``` with calling three methods only:

1. **makePayment**: create and send payment request
1. **onSuccess**: successfully payment completed at shurjoPay
1. **onFailed**: failed payment in shurjoPay

Also reduces many of the things that you had to do manually:

- Handles http request and errors.
- JSON serialization and deserialization.
- Authentication during initiating and verifying of payments.
## Audience
This document is intended for the technical personnel of merchants and service providers who wants to integrate our online payment gateway using iOS swift plugin provided by _**shurjoMukhi Limited**_.
## How to use this shurjoPay plugin
To integrate the shurjoPay Payment Gateway in your iOS swift project do the following tasks sequentially.
#### Step 1: Add dependency into your iOS swift project
**Pod**

1. Close the Xcode project
1. Open the terminal
1. cd /your project path
1. ``` pod init ```
1. ``` pod "ShurjoPaySDKV2", '~> 1.1.0 ```
1. ``` pod install ```
1. Open "your project.xcworkspace" file

#### Step 2: After that, you can initiate payment request to shurjoPay using below code example.
 ```swift
	// Initialize shurjopay
	import ShurjopaySdk

	// Prepare payment request to initiate payment
    let requestData = RequestData(
        username:           "username",
        password:           "password",
        prefix:             "prefix",
        currency:           "currency",
        amount:             0,
        orderId:            "orderId",
        discountAmount:     0,
        discPercent:        0,
        customerName:       "customerName",
        customerPhone:      "customerPhone",
        customerEmail:      "customerEmail",
        customerAddress:    "customerAddress",
        customerCity:       "customerCity",
        customerState:      "customerState",
        customerPostcode:   "customerPostcode",
        customerCountry:    "customerCountry",
        returnUrl:          "returnUrl",
        cancelUrl:          "cancelUrl",
        clientIp:           "clientIp",
        value1:             "value1",
        value2:             "value2",
        value3:             "value3",
        value4:             "value4"
    )

	// Calls first method to initiate a payment
	shurjopaySdk = ShurjopaySdk(onSuccess: onSuccess, onFailed: onFailed)
 ```
- Returns [_POJO_](https://github.com/shurjopay-plugins/sp-plugin-java/blob/main/src/main/java/com/shurjomukhi/model/PaymentRes.java) corresponding this [_JSON_](https://github.com/shurjopay-plugins/sp-plugin-spring/blob/main/src/test/resources/sample-msg/payment-res.json)

#### Step 4: Payment verification can be done after each transaction with shurjopay transaction id.
- Call verify method
 ```java
	shurjopay.verifyPayment(:=spTxnId)
 ```
- Returns [_POJO_](https://github.com/shurjopay-plugins/sp-plugin-java/blob/develop/src/main/java/com/shurjomukhi/model/VerifiedPayment.java) corresponding this [_JSON_](https://github.com/shurjopay-plugins/sp-plugin-spring/blob/develop/src/test/resources/sample-msg/verification-res.json)
# Want to see shurjoPay in action?
Run the JUnit test to see shurjopay plugin in action. These tests will run on selenium browser and will provide the complete experience. Just download source and run the command ```mvnw.cmd test``` in Windows and ```./mvnw test``` in Linux from plugin root path.
## References
1. [Spring example application](https://github.com/shurjopay-plugins/sp-plugin-usage-examples/tree/main/spring-app-spring-plugin) showing usage of the spring plugin.
2. [Sample applications and projects](https://github.com/shurjopay-plugins/sp-plugin-usage-examples) in many different languages and frameworks showing shurjopay integration.
3. [shurjoPay Postman site](https://documenter.getpostman.com/view/6335853/U16dS8ig) illustrating the request and response flow using the sandbox system.
4. [shurjopay Plugins](https://github.com/shurjopay-plugins) home page on github
## License
This code is under the [MIT open source License](https://github.com/shurjopay-plugins/sp-plugin-spring/blob/develop/LICENSE).
#### Please [contact](https://shurjopay.com.bd/#contacts) with shurjoPay team for more detail!
<hr>
Copyright ©️2022 Shurjomukhi Limited.

# ShurjoPaySDK V2

### Open and run shurjoPay SDK V2 project
- Open Xcode
- Go to "Example" directory
- Open "ShurjoPaySDKV2.xcworkspace" in Xcode
- Select device in Xcode
- Click "run" button in Xcode

## Authors
- [Rz Rasel](https://github.com/rzrasel)
