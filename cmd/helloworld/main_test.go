package main

import (
	"bytes"
	"os"
	"testing"

	log "github.com/sirupsen/logrus"
	"gotest.tools/v3/assert"
	is "gotest.tools/v3/assert/cmp"
)

func TestMain_sayHello(t *testing.T) {
	type checkFunc func(*testing.T, string)
	check := func(fns ...checkFunc) []checkFunc { return fns }

	hasMessage := func(want string) checkFunc {
		return func(t *testing.T, msg string) {
			assert.Equal(t, msg, want)
		}
	}

	tests := []struct {
		name     string
		envKey   string
		envValue string
		checks   []checkFunc
	}{
		{
			name: "env variable for name not exist",
			checks: check(
				hasMessage("Hello World!!!"),
			),
		},
		{
			name:     "env variable for name exist",
			envKey:   "YOUR_NAME",
			envValue: "Bob",
			checks: check(
				hasMessage("Hello Bob!!!"),
			),
		},
		{
			name:     "env variable for name is empty",
			envKey:   "YOUR_NAME",
			envValue: "",
			checks: check(
				hasMessage("Hello World!!!"),
			),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			os.Setenv(tt.envKey, tt.envValue)

			msg := sayHello()

			os.Unsetenv(tt.envKey)

			for _, check := range tt.checks {
				check(t, msg)
			}
		})
	}
}

func TestMain_main(t *testing.T) {
	out := &bytes.Buffer{}
	log.SetOutput(out)

	main()

	assert.Assert(t, is.Contains(out.String(), "Hello World!!!"))
}
