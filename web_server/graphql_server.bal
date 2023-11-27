import ballerina/http;
import ballerina/graphql;

final http:Client sClient = check new (url = "http://localhost:9093");

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    }
}
service /sales on new graphql:Listener(9091) {
    resource function get orders() returns Order[]|error {
        DesktopResponse[] res = check sClient->/sales/orders;
        return from DesktopResponse r in res select convertResponse(r);
    }

    resource function get getOrder(string id) returns Order|error {
        DesktopResponse res = check sClient->/orders/[id];
        return convertResponse(res);
    }
}
