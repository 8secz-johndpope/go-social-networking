#!/bin/sh

# Create Rabbitmq user
( sleep 30 ; \
rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASS 2>/dev/null ; \
sleep 10 ; \
rabbitmqctl set_user_tags $RABBITMQ_USER administrator ; \
sleep 10 ; \
rabbitmqctl set_permissions -p / $RABBITMQ_USER  ".*" ".*" ".*" ; \
echo "*** User '$RABBITMQ_USER' with password '$RABBITMQ_PASS' completed. ***" ; \
echo "*** Log in the WebUI at port 15672 (example: http:/localhost:15672) ***") &

# $@ is used to pass arguments to the rabbitmq-server command.
# For example if you use it like this: docker run -d rabbitmq arg1 arg2,
# it will be as you run in the container rabbitmq-server arg1 arg2
rabbitmq-server $@