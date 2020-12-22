package usecase

import (
	"github.com/axolotlteam/thunder/config"
	"github.com/axolotlteam/thunder/db/mgo"
)

// CI -
func CI() error {
	if err := mgo.Con(config.Database{
		Host:       "localhost:27017",
		User:       "",
		Password:   "",
		Database:   "test",
		ReplicaSet: "",
		SSL:        false,
	}); err != nil {
		return err
	}

	_, err := mgo.M()
	if err != nil {
		return err
	}

	return nil
}
