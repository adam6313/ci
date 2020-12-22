package usecase

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCI(t *testing.T) {
	err := CI()

	assert.NoError(t, err)
}
