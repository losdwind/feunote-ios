export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "feunote": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "HostedUIDomain": "string",
            "OAuthMetadata": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string"
        }
    },
    "storage": {
        "s3feunotestorage7ba87085": {
            "BucketName": "string",
            "Region": "string"
        }
    },
    "api": {
        "feunote": {
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    },
    "geo": {
        "feunotemapsoutheast": {
            "Name": "string",
            "Style": "string",
            "Region": "string",
            "Arn": "string"
        }
    },
    "function": {
        "LambdaFunctionMQTTTracker": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    }
}