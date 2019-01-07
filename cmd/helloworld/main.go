package main

import (
	"fmt"
	"os"

	log "github.com/sirupsen/logrus"
)

func main() {
	log.Println(sayHello())
}

func sayHello() string {
	var name string
	if name = os.Getenv("YOUR_NAME"); name == "" {
		name = "World"
	}
	return fmt.Sprintf("Hello %s!!!", name)
}
