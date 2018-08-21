package main

import (
	"log"
	"os"
)

func main() {
	log.Printf("Hello %s!!!", os.Getenv("YOUR_NAME"))
}
