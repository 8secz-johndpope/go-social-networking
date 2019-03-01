package messaging

import (
	"log"
	"time"

	"github.com/streadway/amqp"
)

func buildChannel(conn *amqp.Connection) *amqp.Channel {
	if conn == nil {
		return nil
	}
		
	chn, err := conn.Channel()

	if err != nil {
		return nil
	}

	return chn
}

// ReliableChannelBuilder method is used for building
// a channel. This method performs retry every 5 
// seconds if the connection cannot be established 
func ReliableChannelBuilder(conn *amqp.Connection) *amqp.Channel {
	for {
		chn := buildChannel(conn)

		if chn == nil {
			log.Println("Write daemon cannot open a channel. Retrying in 5 seconds....")
			time.Sleep(5 * time.Second)
		} else {
			return chn
		}
	}
}