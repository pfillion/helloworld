package main

import (
	"fmt"
	"log"
	"os"
)

func main() {
	log.Print(sayHello())
}

func sayHello() string {
	var name string
	if name = os.Getenv("YOUR_NAME"); name == "" {
		name = "World"
	}
	return fmt.Sprintf("Hello %s!!!", name)
}
